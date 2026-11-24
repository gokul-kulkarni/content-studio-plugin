#!/usr/bin/env bash
# Rasterize an archify SVG export to PNG with headless Chrome/Chromium.
#
# Usage:
#   svg-to-png.sh <input.svg> <output.png> [FRAME]
#
#   FRAME (optional) — fit the diagram into a fixed canvas, padded with the
#   diagram's own background colour. Either WxH in CSS px or a preset:
#     section  1600x900   (16:9 inline image for Substack / Medium)
#     slide    1080x1350  (4:5 LinkedIn carousel slide)
#     square   1080x1080  (1:1)
#   Without FRAME the PNG keeps the diagram's intrinsic size.
#
# Env:
#   SCALE       device scale factor (default 2 → crisp on retina / in PDFs)
#   CHROME_BIN  path to Chrome/Chromium if it isn't found automatically
set -euo pipefail

die() { echo "svg-to-png: $*" >&2; exit 1; }

[ $# -ge 2 ] || die "usage: svg-to-png.sh <input.svg> <output.png> [section|slide|square|WxH]"
IN="$1"; OUT="$2"; FRAME="${3:-}"
SCALE="${SCALE:-2}"

[ -f "$IN" ] || die "input not found: $IN"
case "$OUT" in *.png) ;; *) die "output must end in .png: $OUT" ;; esac

find_chrome() {
  if [ -n "${CHROME_BIN:-}" ]; then echo "$CHROME_BIN"; return; fi
  local c
  for c in \
    "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
    "/Applications/Chromium.app/Contents/MacOS/Chromium"; do
    [ -x "$c" ] && { echo "$c"; return; }
  done
  for c in google-chrome google-chrome-stable chromium chromium-browser; do
    command -v "$c" >/dev/null 2>&1 && { command -v "$c"; return; }
  done
  return 1
}
CHROME="$(find_chrome)" || die "Chrome/Chromium not found (set CHROME_BIN)"

abs() { (cd "$(dirname "$1")" && echo "$(pwd)/$(basename "$1")"); }
IN_ABS="$(abs "$IN")"
mkdir -p "$(dirname "$OUT")"
OUT_ABS="$(abs "$OUT")"

# Intrinsic size from the SVG viewBox.
VB="$(grep -o 'viewBox="[^"]*"' "$IN" | head -1 | sed 's/viewBox="//; s/"$//')"
[ -n "$VB" ] || die "no viewBox in $IN"
SVG_W="$(echo "$VB" | awk '{printf "%d", $3}')"
SVG_H="$(echo "$VB" | awk '{printf "%d", $4}')"

case "$FRAME" in
  "")      W="$SVG_W"; H="$SVG_H" ;;
  section) W=1600; H=900 ;;
  slide)   W=1080; H=1350 ;;
  square)  W=1080; H=1080 ;;
  *x*)     W="${FRAME%x*}"; H="${FRAME#*x}" ;;
  *)       die "unknown FRAME: $FRAME" ;;
esac
[[ "$W" =~ ^[0-9]+$ && "$H" =~ ^[0-9]+$ ]] || die "bad frame size: ${W}x${H}"

TARGET="file://$IN_ABS"
TMP=""
cleanup() { [ -n "$TMP" ] && rm -rf "$TMP"; return 0; }
trap cleanup EXIT

if [ -n "$FRAME" ]; then
  # Pad with archify's baked background so the frame looks seamless.
  BG="$(grep -o 'class="archify-bake-background"[^>]*fill="#[0-9a-fA-F]*"' "$IN" | head -1 | grep -o '#[0-9a-fA-F]*' || true)"
  BG="${BG:-#ffffff}"
  TMP="$(mktemp -d)"
  cat > "$TMP/frame.html" <<HTML
<!doctype html><html><head><meta charset="utf-8"><style>
html,body{margin:0;width:${W}px;height:${H}px;background:${BG};}
body{display:flex;align-items:center;justify-content:center;}
img{max-width:92%;max-height:92%;object-fit:contain;}
</style></head><body><img src="file://${IN_ABS}"></body></html>
HTML
  TARGET="file://$TMP/frame.html"
fi

"$CHROME" --headless=new --disable-gpu --hide-scrollbars --allow-file-access-from-files \
  --force-device-scale-factor="$SCALE" --window-size="$W,$H" \
  --screenshot="$OUT_ABS" "$TARGET" >/dev/null 2>&1 || die "Chrome screenshot failed"

[ -s "$OUT_ABS" ] || die "no PNG produced"
echo "$OUT_ABS (${W}x${H} @${SCALE}x)"
