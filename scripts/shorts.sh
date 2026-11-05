#!/usr/bin/env bash
# Make a 9:16 (1080x1920) YouTube Short from a 16:9 video.
#   --mode blur  (default) whole frame centred over a blurred, zoomed copy of itself
#   --mode crop  centre crop (fills the screen, cuts the sides)
# Trims to 60 s by default (YouTube Shorts can be up to 3 min; change with --max).
# Usage: scripts/shorts.sh in.mp4 out.mp4 [--mode blur|crop] [--max 60]
set -euo pipefail

in="${1:?usage: scripts/shorts.sh in.mp4 out.mp4 [--mode blur|crop] [--max 60]}"
out="${2:?missing out.mp4}"; shift 2
mode="blur"; max="60"
while (( $# )); do
  case "$1" in
    --mode) mode="$2"; shift 2 ;;
    --max) max="$2"; shift 2 ;;
    *) echo "unknown option $1" >&2; exit 1 ;;
  esac
done

case "$mode" in
  crop) vf="scale=-2:1920,crop=1080:1920,setsar=1" ;;
  blur) vf="split[a][b];[a]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,boxblur=20:2[bg];[b]scale=1080:-2[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2,setsar=1" ;;
  *) echo "--mode must be blur or crop" >&2; exit 1 ;;
esac

nice -n 10 ffmpeg -hide_banner -loglevel warning -stats -y -i "$in" -t "$max" \
  -filter_complex "[0:v]$vf[v]" -map "[v]" -map 0:a? \
  -c:v libx264 -preset veryfast -crf 21 -c:a aac -b:a 160k -movflags +faststart "$out"
echo "Short made: $out"
