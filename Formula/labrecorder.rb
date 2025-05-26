class Labrecorder < Formula
  desc "Application for streaming one or more LSL streams to disk in XDF file format"
  homepage "https://github.com/labstreaminglayer/App-LabRecorder"
  url "https://github.com/labstreaminglayer/App-LabRecorder", using: :git
  version "1.16.5"
  sha256 "9e6e4f4673115668e72f743cdaa724d595f6160c8957ac2b59af7819b71bd82a"
  license "MIT"
  revision 9

  head "https://github.com/labstreaminglayer/App-LabRecorder.git"

  # bottle do
  #   root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.14"
  #   sha256 cellar: :any, big_sur: "0e4082670b09cd11c3da7855d1a4baa2ccf5cf5bfcd6c2db0d87abffd5c82204"
  # end

  depends_on "cmake" => :build
  depends_on "lsl"
  depends_on "qt"

  def install
    # system "echo", ENV['HOMEBREW_FORMULA_PREFIX']
    system "cmake", "-S", ".", "-B", "build", "-DLSL_DEPLOYAPPLIBS=OFF", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
  end

  test do
    system "false"
  end
end
