class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  version "0.1.1"
  license "Apache-2.0"

  # Pre-built, dependency-free binaries: they link only OS system libraries (rustls, SQLite, and
  # the ONNX runtime are statically bundled), so there is no Rust toolchain to build and nothing
  # else to install. x86_64 macOS and Linux are produced by the release workflow.
  on_macos do
    on_arm do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.1.1/artesian-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "3ea978e416896ac3b8ba38f2976e17d044a021e1847bc7b0753a08e64b6eddf4"
    end
  end

  def install
    bin.install "artesian", "artesian-mcp", "artesiand"
  end

  test do
    assert_match "loop", shell_output("#{bin}/artesian --help")
  end
end
