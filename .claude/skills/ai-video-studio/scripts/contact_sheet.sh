#!/usr/bin/env bash
# Contact sheet: N evenly spaced frames from a video, side by side, for Claude to review.
# Usage: contact_sheet.sh <video> <out.jpg> [frames=6] [width=240]
set -e
source "$(dirname "$0")/_ff.sh"
V="$1"; OUT="$2"; N="${3:-6}"; W="${4:-240}"
[ -f "$V" ] || { echo "usage: contact_sheet.sh <video> <out.jpg> [frames] [width]" >&2; exit 1; }
DUR=$("$FF" -i "$V" 2>&1 | grep -oE "Duration: [0-9:.]+" | awk -F'[: ]' '{print $3*3600+$4*60+$5}')
COLS=$N; ROWS=1
if [ "$N" -gt 8 ]; then COLS=8; ROWS=$(( (N + 7) / 8 )); fi
"$FF" -v error -y -i "$V" -vf "fps=$N/$DUR,scale=$W:-2,tile=${COLS}x${ROWS}" -frames:v 1 "$OUT"
echo "duration=${DUR}s frames=$N -> $OUT"
