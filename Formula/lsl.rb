# https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb
class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl", using: :git
  version "1.14.1b9"
  sha256 "4de0d9726f00430b0f7bda38c44fb40d09461e9aec38fb17b00640f996a2f784"  # openssl dgst -sha256 <file>
  license "MIT"
  revision 0

  head "https://github.com/sccn/liblsl.git"

  # To make a bottle:
  # 1 - `brew install --build-bottle lsl`
  # 2 - `brew bottle --root-url="https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.14" --no-rebuild lsl`
  # 3 - Upload produced bottle to GH release page above. If there's a double-dash in the filename then you have to remove that first.
  # 4 - Copy the printed information into this block. git add and push this updated formula.
  bottle do
    root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.14"
    sha256 cellar: :any, big_sur: "9e3f0222d5a586ee2d79c20dcc604e239a783dc340407cd71fdaa2b5b5256211"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
  end

  test do
    system "false"
  end
end
