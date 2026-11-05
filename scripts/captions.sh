#!/usr/bin/env bash
# Burn subtitles (.srt) into the video. Re-encodes, so it is slow on this laptop.
# Uses Noto Sans, which also covers Hindi/Telugu text if the .srt is in those scripts.
# Usage: scripts/captions.sh in.mp4 subs.srt out.mp4 [font-size, default 18]
set -euo pipefail

in="${1:?usage: scripts/captions.sh in.mp4 subs.srt out.mp4 [size]}"
srt="${2:?missing subs.srt}"; out="${3:?missing out.mp4}"; size="${4:-18}"

# subtitles filter needs the path escaped; copy to a simple temp name to avoid quoting trouble.
tmp="$(mktemp --suffix=.srt)"; trap 'rm -f "$tmp"' EXIT; cp "$srt" "$tmp"
style="FontName=Noto Sans,FontSize=$size,PrimaryColour=&H00FFFFFF,OutlineColour=&H00000000,BorderStyle=1,Outline=2,Shadow=0,MarginV=40,Bold=1"

nice -n 10 ffmpeg -hide_banner -loglevel warning -stats -y -i "$in" \
  -vf "subtitles=$tmp:force_style='$style'" \
  -c:v libx264 -preset veryfast -crf 20 -c:a copy -movflags +faststart "$out"
echo "Captions burned: $out"
