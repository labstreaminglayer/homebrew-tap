class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl/archive/refs/tags/v1.17.1.tar.gz"
  sha256 "d397f943be164f587bc9139427ea54173f28ac1b5505044ae11fd9977442e5be"
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
