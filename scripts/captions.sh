#!/usr/bin/env bash
# Burn subtitles (.srt) into the video. Re-encodes, so it is slow on this laptop.
# Converts the .srt to ASS and renders with libass COMPLEX shaping: needed for Telugu/Hindi
# conjuncts (e.g. స్తా, క్షీ, ర్భ). The plain `subtitles` filter mis-shapes them (tested 2026-11-05).
# Usage: scripts/captions.sh in.mp4 subs.srt out.mp4 [font-size, default 18] [font, default "Noto Sans Telugu"]
set -euo pipefail

in="${1:?usage: scripts/captions.sh in.mp4 subs.srt out.mp4 [size] [font]}"
srt="${2:?missing subs.srt}"; out="${3:?missing out.mp4}"; size="${4:-18}"; font="${5:-Noto Sans Telugu}"

tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
cp "$srt" "$tmp/s.srt"
ffmpeg -hide_banner -loglevel error -y -i "$tmp/s.srt" "$tmp/s.ass"

# Style: white bold text, black outline, centred near the bottom. ASS colours are &HAABBGGRR.
# Fields: Name,Fontname,Fontsize,Primary,Secondary,Outline,Back,Bold,Italic,Underline,StrikeOut,
#         ScaleX,ScaleY,Spacing,Angle,BorderStyle,Outline,Shadow,Alignment,MarginL,MarginR,MarginV,Encoding
sed -i "s/^Style: Default,.*/Style: Default,$font,$size,\&H00FFFFFF,\&H00FFFFFF,\&H00000000,\&H80000000,-1,0,0,0,100,100,0,0,1,2,0,2,20,20,40,1/" "$tmp/s.ass"

nice -n 10 ffmpeg -hide_banner -loglevel warning -stats -y -i "$in" \
  -vf "ass=$tmp/s.ass:shaping=complex" \
  -c:v libx264 -preset veryfast -crf 20 -c:a copy -movflags +faststart "$out"
echo "Captions burned: $out"
