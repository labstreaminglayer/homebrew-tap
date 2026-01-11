class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl/archive/refs/tags/v1.17.3.tar.gz"
  sha256 "b163463d886a08382a76a9b7e4a1286d170de219dd276687b8a6c2f9b664be95"
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
