class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  version "0.5.5"
  license "Apache-2.0"

  # One dependency-free multi-call binary (it links only OS system libraries; rustls, SQLite, and
  # the ONNX runtime are statically bundled). Installed once and symlinked, so the CLI, MCP server,
  # and daemon share a single copy instead of three. No Rust toolchain, no build.
  on_macos do
    on_arm do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.5/artesian-0.5.5-aarch64-apple-darwin.tar.gz"
      sha256 "94c8279f37e17f570f2c2501d6e4c02bb3555842c274e6ae0ce2eefbf25066e1"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.5/artesian-0.5.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8a091b74824dba9c0d92e4b0233a381a3135c5f85211dbe06ca5186d59cbc935"
    end
  end

  def install
    bin.install "artesian"
    # The MCP server and the daemon are the same binary, dispatched by invocation name.
    bin.install_symlink "artesian" => "artesian-mcp"
    bin.install_symlink "artesian" => "artesiand"
  end

  test do
    assert_match "loop", shell_output("#{bin}/artesian --help")
  end
end
