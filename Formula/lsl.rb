class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl/archive/refs/tags/v1.18.0.b4.tar.gz"
  version "1.18.0.b4"
  sha256 "68da7ff3b220281f1d7d924ffe3d44c036c6a71e5dac9848aaaaca4ff6dc9673"
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
    args = %w[
      -DLSL_FRAMEWORK=OFF
      -DLSL_UNIXFOLDERS=ON
      -DLSL_FETCH_PUGIXML=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
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
  end
end
