class Claudeline < Formula
  desc "Cross-platform statusline for Claude Code"
  homepage "https://github.com/arcasilesgroup/claudeline"
  version "0.2.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-arm64"
      sha256 "357cc59c2f8dcee0ed02471f2814a964949ff85b8f089e30fcb3c8873e9aceb8"
    end
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-x64"
      sha256 "93e2422ff36c83a2b11c74b7b9fb32df4c7891be9eb47efb34dac007ad24b9bd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-x64"
      sha256 "f4e2b89829cc506951a86dd31e1da559ad1d11c9eebd8d4b148f20066ffadf66"
    end
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-arm64"
      sha256 "db75186c656dcb305fbb2608c2574ab4bcb4c12d29b994d6f68f77cba2e0e9c5"
    end
  end

  def install
    bin.install Dir["claudeline-*"].first => "claudeline"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claudeline --version")
  end
end
