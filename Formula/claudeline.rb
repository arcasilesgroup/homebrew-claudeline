class Claudeline < Formula
  desc "Cross-platform statusline for Claude Code"
  homepage "https://github.com/arcasilesgroup/claudeline"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-arm64"
      sha256 "0042b1b25dbe2e0b3f87a895dc23e2123e0f7dfe65ea2a2d02992abc4c544199"
    end
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-x64"
      sha256 "cfb9c5d3ff5c75e0701a14e13c50bc52cf87057b1db1892e9224d394e17a0b89"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-x64"
      sha256 "78f8f5ec389d62593546164ff2ff94235a57a0afc0305f7a7725a9ea095e7720"
    end
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-arm64"
      sha256 "b5c792da1361bb7e2d015aaca14609c2ae61f91ce4452406f67c56dedaebf5c3"
    end
  end

  def install
    bin.install Dir["claudeline-*"].first => "claudeline"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claudeline --version")
  end
end
