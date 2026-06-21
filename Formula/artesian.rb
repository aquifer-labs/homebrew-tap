class Artesian < Formula
  desc "Memory control plane for AI agent loops"
  homepage "https://github.com/aquifer-labs/artesian"
  url "https://github.com/aquifer-labs/artesian/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "b80cc64dd6b34d60765dc105f4dbf789ce0a3e4ff6475d433ccee75ddcb7ffbf"
  license "Apache-2.0"
  head "https://github.com/aquifer-labs/artesian.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--features", "qdrant,llm",
           "--path", "crates/artesian-cli", "--root", prefix
    # artesian-mcp also gets the http transport for shared/networked memory.
    system "cargo", "install", "--locked", "--features", "qdrant,llm,http",
           "--path", "crates/artesian-mcp", "--root", prefix
  end

  test do
    assert_match "loop", shell_output("#{bin}/artesian --help")
  end
end
