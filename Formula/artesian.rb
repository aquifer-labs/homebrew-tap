class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  version "0.5.3"
  license "Apache-2.0"

  # One dependency-free multi-call binary (it links only OS system libraries; rustls, SQLite, and
  # the ONNX runtime are statically bundled). Installed once and symlinked, so the CLI, MCP server,
  # and daemon share a single copy instead of three. No Rust toolchain, no build.
  on_macos do
    on_arm do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.3/artesian-0.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "fb207a7cc92ca320b4f6ccced065e72bf4ca3c779270372d0ba34976f0691f35"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.3/artesian-0.5.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ae9b411aeada7995a4ed40cd0f6510a0ab1d7b78beb424eb98897700817dcbd"
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
