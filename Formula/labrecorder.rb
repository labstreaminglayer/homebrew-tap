class Labrecorder < Formula
  desc "Application for streaming one or more LSL streams to disk in XDF file format"
  homepage "https://github.com/labstreaminglayer/App-LabRecorder"
  url "https://github.com/labstreaminglayer/App-LabRecorder/archive/refs/tags/v1.17.1.tar.gz"
  sha256 "ef2f95e60be60494138a323e2aa566c5dea9bd6eac4ff889f921e0a155e64222"
  license "MIT"
  head "https://github.com/labstreaminglayer/App-LabRecorder.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  depends_on "lsl"
  depends_on "qtbase"

  def install
    args = %w[
      -DLSL_BUNDLE_DEPENDENCIES=OFF
      -DLSL_FETCH_IF_MISSING=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Upstream installs everything at the prefix root on macOS
    if OS.mac?
      bin.install prefix/"LabRecorderCLI"
      rm prefix/"libxdfwriter.a"
      bin.write_exec_script prefix/"LabRecorder.app/Contents/MacOS/LabRecorder"
    end
  end

  def caveats
    on_macos do
      <<~EOS
        LabRecorder.app is installed to:
          #{opt_prefix}/LabRecorder.app
        Launch it with `LabRecorder` or link it into /Applications with:
          ln -s #{opt_prefix}/LabRecorder.app /Applications/LabRecorder.app
      EOS
    end
  end

  test do
    assert_match "Usage", shell_output("#{bin}/LabRecorderCLI -h", 1)
  end
end
