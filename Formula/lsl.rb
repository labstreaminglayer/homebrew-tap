class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl/archive/refs/tags/v1.17.7.tar.gz"
  sha256 "19604fb1b30c753457e8bf1430341d84012834c0cf8d2ca921e8151d31220df9"
  license "MIT"
  head "https://github.com/sccn/liblsl.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "pugixml"

  def install
    args = %W[
      -DLSL_FRAMEWORK=ON
      -DCMAKE_INSTALL_FRAMEWORK_DIR=#{frameworks}
      -DLSL_FETCH_PUGIXML=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
  end

  test do
    system bin/"lslver"
  end
end
