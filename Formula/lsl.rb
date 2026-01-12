class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl/archive/refs/tags/v1.17.4.tar.gz"
  sha256 "43720576b6a568923a68de8f37e894c0e583ff07ed219d3f5121a3a45f009c7b"
  license "MIT"
  head "https://github.com/sccn/liblsl.git", branch: "main"

  depends_on "cmake" => :build

  def install
    args = %W[
      -DLSL_FRAMEWORK=ON
      -DCMAKE_INSTALL_FRAMEWORK_DIR=#{frameworks}
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
  end

  test do
    system bin/"lslver"
  end
end
