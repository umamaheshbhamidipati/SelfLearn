#!/usr/bin/env bash
# Cinematic "festival" grade: teal shadows, warm gold highlights, glow (bloom) around lights,
# extra contrast and saturation, soft vignette, fine film grain. Re-encodes (slow-ish here).
# Usage: scripts/grade.sh in.mp4 out.mp4 [strength 0.0-1.0, default 1.0]
#        scripts/grade.sh --frame in.mp4 out.png [time_s]   (grade one frame, for previews)
set -euo pipefail

grade_chain() {
  local s="${1:-1.0}"
  # glow: blur a copy of the bright parts and screen it back over the image
  echo "split[a][b];[b]curves=all='0/0 0.55/0 1/1',gblur=sigma=18[g];[a][g]blend=all_mode=screen:all_opacity=$(awk -v s=$s 'BEGIN{printf "%.2f",0.45*s}'),\
colorbalance=rs=$(awk -v s=$s 'BEGIN{printf "%.3f",-0.06*s}'):gs=$(awk -v s=$s 'BEGIN{printf "%.3f",0.01*s}'):bs=$(awk -v s=$s 'BEGIN{printf "%.3f",0.10*s}'):rm=$(awk -v s=$s 'BEGIN{printf "%.3f",0.03*s}'):bm=$(awk -v s=$s 'BEGIN{printf "%.3f",-0.02*s}'):rh=$(awk -v s=$s 'BEGIN{printf "%.3f",0.10*s}'):gh=$(awk -v s=$s 'BEGIN{printf "%.3f",0.04*s}'):bh=$(awk -v s=$s 'BEGIN{printf "%.3f",-0.10*s}'),\
eq=contrast=$(awk -v s=$s 'BEGIN{printf "%.3f",1+0.12*s}'):saturation=$(awk -v s=$s 'BEGIN{printf "%.3f",1+0.18*s}'):gamma=0.97,\
vignette=angle=PI/4.5,noise=alls=$(awk -v s=$s 'BEGIN{printf "%d",6*s}'):allf=t,format=yuv420p"
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
