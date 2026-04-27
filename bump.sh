#!/usr/bin/env bash
# Regenerates Formula/claudeline.rb for the given release version.
#
# Usage: ./bump.sh <version, e.g. 0.2.0>
#
# Downloads each release asset from
# https://github.com/arcasilesgroup/claudeline/releases/download/v<version>/<asset>,
# computes its SHA-256, and writes a fresh Formula/claudeline.rb from a
# heredoc template. The committed formula is a snapshot maintained by this
# script -- do not hand-edit it for routine version bumps.
set -euo pipefail

ver="${1:-}"
if [ -z "$ver" ]; then
  echo "usage: $0 <version, e.g. 0.2.0>" >&2
  exit 1
fi
ver="${ver#v}"

repo_root="$(cd "$(dirname "$0")" && pwd)"
formula="$repo_root/Formula/claudeline.rb"
mkdir -p "$repo_root/Formula"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

assets=(
  claudeline-darwin-arm64
  claudeline-darwin-x64
  claudeline-linux-x64
  claudeline-linux-arm64
)

declare -A SHA
for asset in "${assets[@]}"; do
  url="https://github.com/arcasilesgroup/claudeline/releases/download/v${ver}/${asset}"
  echo "Fetching $asset..." >&2
  curl -fsSL -o "$tmp/$asset" "$url"
  if command -v shasum >/dev/null 2>&1; then
    SHA[$asset]=$(shasum -a 256 "$tmp/$asset" | awk '{print $1}')
  else
    SHA[$asset]=$(sha256sum "$tmp/$asset" | awk '{print $1}')
  fi
done

cat > "$formula" <<EOF
class Claudeline < Formula
  desc "Cross-platform statusline for Claude Code"
  homepage "https://github.com/arcasilesgroup/claudeline"
  version "${ver}"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-arm64"
      sha256 "${SHA[claudeline-darwin-arm64]}"
    end
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-darwin-x64"
      sha256 "${SHA[claudeline-darwin-x64]}"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-x64"
      sha256 "${SHA[claudeline-linux-x64]}"
    end
    on_arm do
      url "https://github.com/arcasilesgroup/claudeline/releases/download/v#{version}/claudeline-linux-arm64"
      sha256 "${SHA[claudeline-linux-arm64]}"
    end
  end

  def install
    bin.install Dir["claudeline-*"].first => "claudeline"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claudeline --version")
  end
end
EOF

echo "Wrote $formula for version ${ver}." >&2
echo "Next: git add Formula/claudeline.rb && git commit -m 'claudeline ${ver}' && git push" >&2
