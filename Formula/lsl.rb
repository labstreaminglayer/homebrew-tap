# https://github.com/syhw/homebrew/blob/master/Library/Contributions/example-formula.rb
class Lsl < Formula
  desc "Library for multi-modal time-synched data transmission over the network"
  homepage "https://labstreaminglayer.readthedocs.io/"
  url "https://github.com/sccn/liblsl", using: :git
  version "1.15.0"
  sha256 "7b0c927fba9875c2eb930e5347a339f0aef750291e94045c3f8dbc6e5112d4a5"
  license "MIT"
  revision 0
  # NOTE: use `openssl dgst -sha256 <targ.gz file downloaded from release>` to get sha256

  head "https://github.com/sccn/liblsl.git"

  # To make a bottle:
  # 1 - `brew install --build-bottle lsl`
  # 2 - `brew bottle --root-url="https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.15.0" lsl`
  # 3 - Upload produced bottle to GH release page above. If there's a double-dash in the filename
  #     then you have to remove that first.
  # 4 - Copy the printed information into this block. git add and push this updated formula.
  bottle do
    root_url "https://github.com/labstreaminglayer/homebrew-tap/releases/download/v1.15.0"
    sha256 cellar: :any, big_sur: "bcbb98b75da8a609eb865a1813135e6290d0f06e22ecfa60a4935f7712c9453d"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build", "--target", "install", "--config", "Release", "-j"
  end

  test do
    system bin/"lslver"
  end
end
