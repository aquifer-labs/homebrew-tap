class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  version "0.1.3"
  license "Apache-2.0"

  # One dependency-free multi-call binary (it links only OS system libraries; rustls, SQLite, and
  # the ONNX runtime are statically bundled). Installed once and symlinked, so the CLI, MCP server,
  # and daemon share a single copy instead of three. No Rust toolchain, no build.
  on_macos do
    on_arm do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.1.3/artesian-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "a94a3c848fdce2853484758ec01c6d4ea4b8fe5e51da4af07dccbce6b8d3b8ff"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.1.3/artesian-0.1.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "80cd467e520f2a8ee1fafe2b8efe35b17bf0e72e3e900f4c6c888061d8c29579"
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
