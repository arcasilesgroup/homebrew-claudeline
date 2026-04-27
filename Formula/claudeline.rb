class Claudeline < Formula
  desc "Cross-platform statusline for Claude Code"
  homepage "https://github.com/arcasilesgroup/claudeline"
  version "0.2.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-arm64"
      sha256 "1004450893da48f1e342bb6994ef748aadd8020e1acc2810192f690a17f91a86"
    end
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-x64"
      sha256 "aa64a2699de8d8d8a37d2fc1e6a63de0226ea65e8491db210c1fcc92e37bf04a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-x64"
      sha256 "62981f424642a8592403f689dfe776f522908703bc19909f6b2e4fde6f02a98f"
    end
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-arm64"
      sha256 "c21e17f19b3ffe6ef57343e49c3e3b552f67ea6cd3ebb500644352ded8774e51"
    end
  end

  def install
    bin.install Dir["claudeline-*"].first => "claudeline"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claudeline --version")
  end
end
