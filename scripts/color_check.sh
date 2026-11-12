#!/usr/bin/env bash
# Numeric warm/orange cast check (no AI). Usage: scripts/color_check.sh image-or-video [more files...]
# Prints average R/G/B of the whole frame and of the centre 50 % (where the subject is) and flags WARM when R/B is high.
# Calibrated 12 Nov 2026 on Samudra Manthan stills: orange refs R/B 1.8-2.3; neutral stills 0.8-1.4. Threshold 1.5 (whole) / 1.6 (centre).
set -euo pipefail
for f in "$@"; do
  px(){ ffmpeg -v error -ss "${3:-0}" -i "$f" -vf "$1,scale=1:1:flags=area" -frames:v 1 -f rawvideo -pix_fmt rgb24 - | od -An -tu1 | awk '{printf "%d %d %d %.2f\n", $1,$2,$3,$1/($3+1)}'; }
  read -r r g b rb < <(px "null" ); read -r cr cg cb crb < <(px "crop=iw/2:ih/2")
  flag=OK; awk -v a="$rb" -v c="$crb" 'BEGIN{exit !(a>1.5||c>1.6)}' && flag=WARM
  printf '%-5s whole R/G/B=%3d/%3d/%3d R/B=%s | centre R/B=%s  %s\n' "$flag" "$r" "$g" "$b" "$rb" "$crb" "$f"
done
