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

  bottle do
    root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/lsl-1.18.0.b4"
    sha256 cellar: :any, arm64_tahoe:   "a2276c85e706e95b6b9b14e53142db8d58142e5e02acd60aeb3f58b99bd8f6e7"
    sha256 cellar: :any, arm64_sequoia: "14c6c747da42fb3344d2b3daefbae8b732f49913d05f03be768c4a9d4938ebf8"
    sha256 cellar: :any, x86_64_linux:  "4b9c94aa88542ddb94ecb43ec9276b69e12810273c5f8b7b0d3ac9d43ad73fda"
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
