#!/usr/bin/env bash
# Print cut timestamps (seconds) of a video, e.g. a reference reel. Lower threshold = more cuts found.
# Usage: shot_detect.sh <video> [threshold=0.25]
set -e
source "$(dirname "$0")/_ff.sh"
V="$1"; T="${2:-0.25}"
[ -f "$V" ] || { echo "usage: shot_detect.sh <video> [threshold]" >&2; exit 1; }
"$FF" -i "$V" 2>&1 | grep -E "Duration|Stream" || true
echo "cuts at:"
"$FF" -hide_banner -i "$V" -vf "select='gt(scene,$T)',showinfo" -an -f null - 2>&1 \
  | grep -oE "pts_time:[0-9.]+" | cut -d: -f2 | tr '\n' ' '
echo
