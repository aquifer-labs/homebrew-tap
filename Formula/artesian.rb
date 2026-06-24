class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  version "0.5.1"
  license "Apache-2.0"

  # One dependency-free multi-call binary (it links only OS system libraries; rustls, SQLite, and
  # the ONNX runtime are statically bundled). Installed once and symlinked, so the CLI, MCP server,
  # and daemon share a single copy instead of three. No Rust toolchain, no build.
  on_macos do
    on_arm do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.1/artesian-0.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "fa58adc808c45cf48181028af3a0ea4193d1f3c7ececd1963a0b6e99b56bdbde"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.1/artesian-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "72f34314f972f9280d32e2c699af7a2685840e61c10d09f85b3666f833dbe2cc"
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
