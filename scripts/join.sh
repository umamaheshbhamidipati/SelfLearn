#!/usr/bin/env bash
# Join clips in order into one video.
# Fast path: stream copy (no re-encode) when all clips share codec/size/fps (Flow downloads usually do).
# Falls back to a re-encode (slow on this laptop) if the copy fails or --reencode is given.
# Usage: scripts/join.sh out.mp4 clip1.mp4 clip2.mp4 ...   (or: scripts/join.sh out.mp4 dir/*.mp4)
set -euo pipefail

reencode=0
[[ "${1:-}" == "--reencode" ]] && { reencode=1; shift; }
out="${1:?usage: scripts/join.sh [--reencode] out.mp4 clip1.mp4 clip2.mp4 ...}"; shift
(( $# >= 2 )) || { echo "need at least 2 clips" >&2; exit 1; }

list="$(mktemp --suffix=.txt)"; trap 'rm -f "$list"' EXIT
for c in "$@"; do printf "file '%s'\n" "$(realpath "$c")" >> "$list"; done

if (( ! reencode )) && ffmpeg -hide_banner -loglevel error -y -f concat -safe 0 -i "$list" -c copy -movflags +faststart "$out"; then
  echo "Joined (stream copy): $out"; exit 0
fi

echo "Stream copy not possible; re-encoding (slow)..." >&2
n=$#; inputs=(); filt=""
for ((i=0; i<n; i++)); do
  inputs+=(-i "${@:i+1:1}")
  filt+="[$i:v]scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1,fps=24[v$i];"
  filt+="[$i:a]aresample=48000[a$i];"
done
for ((i=0; i<n; i++)); do filt+="[v$i][a$i]"; done
filt+="concat=n=$n:v=1:a=1[v][a]"
nice -n 10 ffmpeg -hide_banner -loglevel warning -stats -y "${inputs[@]}" -filter_complex "$filt" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 20 -c:a aac -b:a 192k -movflags +faststart "$out"
echo "Joined (re-encoded): $out"
