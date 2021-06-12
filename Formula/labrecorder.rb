class Labrecorder < Formula
  desc "Application for streaming one or more LSL streams to disk in XDF file format"
  homepage "https://github.com/labstreaminglayer/App-LabRecorder"
  url "https://github.com/labstreaminglayer/App-LabRecorder/archive/refs/tags/v1.14.2.tar.gz"
  sha256 "7fafde37dffca24170909aff01b28a410232bfcd8727a0ca58c23fe18e4946af"
  license "MIT"

  head "https://github.com/labstreaminglayer/App-LabRecorder.git"

  bottle do
    root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.14"
    sha256 cellar: :any, big_sur: "0e4082670b09cd11c3da7855d1a4baa2ccf5cf5bfcd6c2db0d87abffd5c82204"
  end

  depends_on "cmake" => :build
  depends_on "lsl"
  depends_on "qt"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DLSL_DEPLOYAPPLIBS=OFF", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
  end

  test do
    system "false"
  end
end
