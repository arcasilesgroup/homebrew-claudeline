class Claudeline < Formula
  desc "Cross-platform statusline for Claude Code"
  homepage "https://github.com/arcasilesgroup/claudeline"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-arm64"
      sha256 "f2742bcd58c05ff96eb9b83e512d204a1743390394e6e917afe0ba0435451e08"
    end
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-x64"
      sha256 "121d78be36f75e5d7c5a35648dae08f9a9f32c0a449b5736ab0fb9eab88b47c1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-x64"
      sha256 "4d4b716dcde13218a39b785212528c1bcb39007cfc2237f36565de8ced7e75e7"
    end
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-arm64"
      sha256 "6c3368f0ef13b705d28687f37b3eacad6c6e89a95588947cd94f4b8cdd177b55"
    end
  end

  def install
    bin.install Dir["claudeline-*"].first => "claudeline"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claudeline --version")
  end
end
