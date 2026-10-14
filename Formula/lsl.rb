class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl/archive/refs/tags/v1.18.0.b6.tar.gz"
  version "1.18.0.b6"
  sha256 "7d539bf2021353ecc95396e88a4c702747b34c339586628e566081850486043c"
  license "MIT"
  head "https://github.com/sccn/liblsl.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :test
  depends_on "pugixml"

  def install
    # On macOS, install lsl.framework (in Frameworks/). liblsl also installs lib/liblsl.dylib,
    # the headers in include/, lib/cmake/lsl and lsl.pc pointing into it, so -llsl, pkg-config
    # and find_package(LSL) work as with a plain dylib.
    args = %W[
      -DLSL_FRAMEWORK=#{OS.mac? ? "ON" : "OFF"}
      -DLSL_UNIXFOLDERS=ON
      -DLSL_FETCH_PUGIXML=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Programs linked against the earlier plain-dylib layout (1.18.0.b3/b4) load liblsl.2.dylib.
    lib.install_symlink "liblsl.dylib" => "liblsl.2.dylib" if OS.mac?
  end

  test do
    (testpath/"test.c").write <<~C
      #include <lsl_c.h>
      #include <stdio.h>
      int main(void) {
        printf("%d\\n", lsl_library_version());
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-llsl", "-o", "test"
    assert_equal "118", shell_output("./test").strip
    assert_match "118", shell_output("#{bin}/lslver")
    system "pkg-config", "--exists", "lsl"
    return unless OS.mac?

    # The framework itself, as Xcode and -framework users see it
    (testpath/"fw.c").write <<~C
      #include <lsl/lsl_c.h>
      #include <stdio.h>
      int main(void) {
        printf("%d\\n", lsl_library_version());
        return 0;
      }
    C
    system ENV.cc, "fw.c", "-F#{frameworks}", "-framework", "lsl", "-o", "fw"
    assert_equal "118", shell_output("./fw").strip
    assert_path_exists lib/"liblsl.2.dylib"
  end
end
