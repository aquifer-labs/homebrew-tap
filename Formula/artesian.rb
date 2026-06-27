class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  version "0.5.4"
  license "Apache-2.0"

  # One dependency-free multi-call binary (it links only OS system libraries; rustls, SQLite, and
  # the ONNX runtime are statically bundled). Installed once and symlinked, so the CLI, MCP server,
  # and daemon share a single copy instead of three. No Rust toolchain, no build.
  on_macos do
    on_arm do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.4/artesian-0.5.4-aarch64-apple-darwin.tar.gz"
      sha256 "a6595281186c2929ba58188af7a66fb4a16787972c47c07c97aee1f876c181c2"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/aquifer-labs/artesian/releases/download/v0.5.4/artesian-0.5.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ba2997576cd9772564067a1d45c87d926044f72edc3c1d79de30968349d9e772"
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
