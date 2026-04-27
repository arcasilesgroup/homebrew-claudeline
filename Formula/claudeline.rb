class Claudeline < Formula
  desc "Cross-platform statusline for Claude Code"
  homepage "https://github.com/arcasilesgroup/claudeline"
  version "0.2.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-arm64"
      sha256 "8b41143b081c3f4f78bb77a8e7a91a688533c8a784d3ddc14a553c108066d495"
    end
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-x64"
      sha256 "ded224a1a6ef377059d4513bc6b1073d714206393616b81714df0e906bcfcf82"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-x64"
      sha256 "bc124341c837fb2bfdaebcacd910b2247c23009e0afc3d7a169b61766ed734f0"
    end
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-arm64"
      sha256 "7dea704210ad27e001b5cc21ef63b09881732262b9cb943bf1e83790f990c6b7"
    end
  end

  def install
    bin.install Dir["claudeline-*"].first => "claudeline"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claudeline --version")
  end
end
