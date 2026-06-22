class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  version "0.2.0"
  license "Apache-2.0"

  # One dependency-free multi-call binary (it links only OS system libraries; rustls, SQLite, and
  # the ONNX runtime are statically bundled). Installed once and symlinked, so the CLI, MCP server,
  # and daemon share a single copy instead of three. No Rust toolchain, no build.
  on_macos do
    on_arm do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.2.0/artesian-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "ac6d4006c07710aacd29ee9beafab48a56d547fc0231dfeecb667adf187a9d3d"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.2.0/artesian-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "10fd04bb9f8157a39fb4eeb080f70b839f1b7b3281c76e3bc75de11ec87165e0"
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
