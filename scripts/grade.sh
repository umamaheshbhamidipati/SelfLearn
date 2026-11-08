#!/usr/bin/env bash
# Cinematic "festival" grade: glow (bloom) around lights, a little extra contrast and saturation,
# soft vignette, fine film grain. No colour shift: footage from Flow/Nano Banana is already
# teal-and-gold, and the old teal/orange colorbalance turned it purple (2026-11-08).
# Re-encodes (slow-ish here).
# Usage: scripts/grade.sh in.mp4 out.mp4 [strength 0.0-1.0, default 1.0]
#        scripts/grade.sh --frame in.mp4 out.png [time_s]   (grade one frame, for previews)
set -euo pipefail

grade_chain() {
  local s="${1:-1.0}"
  echo "format=gbrp,split[a][b];[b]curves=all='0/0 0.55/0 1/1',gblur=sigma=16[g];[a][g]blend=all_mode=screen:all_opacity=$(awk -v s=$s 'BEGIN{printf "%.2f",0.35*s}'),\
eq=contrast=$(awk -v s=$s 'BEGIN{printf "%.3f",1+0.08*s}'):saturation=$(awk -v s=$s 'BEGIN{printf "%.3f",1+0.08*s}'):gamma=0.98,\
vignette=angle=PI/5,noise=alls=$(awk -v s=$s 'BEGIN{printf "%d",4*s}'):allf=t,format=yuv420p"
}

if [[ "${1:-}" == "--frame" ]]; then
  in="$2"; out="$3"; t="${4:-1}"
  ffmpeg -hide_banner -loglevel error -y -ss "$t" -i "$in" -frames:v 1 -vf "$(grade_chain 1.0)" "$out"
  exit 0
fi
in="${1:?usage: scripts/grade.sh in.mp4 out.mp4 [strength]}"; out="${2:?missing out.mp4}"; s="${3:-1.0}"
nice -n 10 ffmpeg -hide_banner -loglevel warning -stats -y -i "$in" -vf "$(grade_chain "$s")" \
  -c:v libx264 -preset veryfast -crf 18 -c:a copy -movflags +faststart "$out"
echo "Graded: $out"
