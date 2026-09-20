class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl/archive/refs/tags/v1.18.0.b3.tar.gz"
  version "1.18.0.b3"
  sha256 "5f5f7eda155090ef2ccc88422d52d96ee4b92bf5697bd1374332702cf887e3e1"
  license "MIT"
  head "https://github.com/sccn/liblsl.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/lsl-1.18.0.b3"
    rebuild 1
    sha256 cellar: :any, arm64_tahoe:   "f8e8c42d8b4b941a79ae9b0490d4924d26fa2853c7cfcb17736a99d08860a054"
    sha256 cellar: :any, arm64_sequoia: "937875495d7a27a43204c76a29a85bdd198db6a7a9e14e8e27eea632d75bd1aa"
    sha256 cellar: :any, x86_64_linux:  "dbfa3a4ccf81849926388ab67bc1c1dd72767cfdd987bf0185d34c228ce85db8"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :test
  depends_on "pugixml"

  def install
    # Release tarballs have no git metadata to derive the version from
    args = %W[
      -DLSL_VERSION_OVERRIDE=#{version}
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
