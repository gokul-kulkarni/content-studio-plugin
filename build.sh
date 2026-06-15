#!/usr/bin/env bash
# Build the installable .plugin package from this folder.
# Usage: ./build.sh   (run from the plugin root)
set -euo pipefail

cd "$(dirname "$0")"

NAME="$(python3 -c 'import json;print(json.load(open(".claude-plugin/plugin.json"))["name"])')"
OUT="${NAME}.plugin"

# Validate the manifest first (no-op if the claude CLI isn't installed).
if command -v claude >/dev/null 2>&1; then
  claude plugin validate .claude-plugin/plugin.json
fi

# Package only the plugin tree at the archive root. Stored (-0), no junk.
rm -f "$OUT"
zip -r -0 -X "$OUT" .claude-plugin skills -x "*.DS_Store" >/dev/null

echo "Built $OUT"
