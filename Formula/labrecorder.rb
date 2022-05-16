class Labrecorder < Formula
  desc "Application for streaming one or more LSL streams to disk in XDF file format"
  homepage "https://github.com/labstreaminglayer/App-LabRecorder"
  url "https://github.com/labstreaminglayer/App-LabRecorder", using: :git
  version "1.16.1"
  sha256 "f4b4f5eaf0623e3366c54af927f52274d24607dc111abff7911b3c83c4366ec9"
  license "MIT"
  revision 7

  head "https://github.com/labstreaminglayer/App-LabRecorder.git"

  # bottle do
  #   root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.14"
  #   sha256 cellar: :any, big_sur: "0e4082670b09cd11c3da7855d1a4baa2ccf5cf5bfcd6c2db0d87abffd5c82204"
  # end

  depends_on "cmake" => :build
  depends_on "lsl"
  depends_on "qt"

  def install
    system "echo", ENV['HOMEBREW_FORMULA_PREFIX']
    system "cmake", "-S", ".", "-B", "build", "-DLSL_DEPLOYAPPLIBS=OFF", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
    # Next line required because macdeployqt does not bundle loader_path dependencies: https://bugreports.qt.io/browse/QTBUG-100686
    system "cp", "-L", "/opt/homebrew/opt/brotli/lib/libbrotlicommon.1.dylib", ENV['HOMEBREW_FORMULA_PREFIX']"/LabRecorder/LabRecorder.app/Contents/Frameworks"
  end

  test do
    system "false"
  end
end
