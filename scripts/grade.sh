#!/usr/bin/env bash
# Cinematic "festival" grade: glow (bloom) around lights, a little extra contrast and saturation,
# soft vignette, fine film grain. No colour shift: footage from Flow/Nano Banana is already
# teal-and-gold, and the old teal/orange colorbalance turned it purple (2026-11-08).
# Looks: "soft" (default, above) and "epic" (stronger, film-trailer look like the reference reel:
# teal shadows + gold highlights, S-curve contrast, more glow/saturation, deeper vignette).
# All colour work runs in RGB (gbrp): in YUV the blend/colorbalance turned footage purple.
# Re-encodes (slow-ish here).
# Usage: scripts/grade.sh in.mp4 out.mp4 [strength, default 1.0] [soft|epic]
#        scripts/grade.sh --frame in.mp4 out.png [time_s] [strength] [soft|epic]   (one-frame preview)
set -euo pipefail

grade_chain() {
  local s="${1:-1.0}" look="${2:-soft}"
  if [[ "$look" == "epic" ]]; then
    local f; f() { awk -v s="$s" -v k="$1" -v b="${2:-0}" 'BEGIN{printf "%.3f", b+k*s}'; }
    echo "format=gbrp,split[a][b];[b]curves=all='0/0 0.5/0 1/1',gblur=sigma=22[g];[a][g]blend=all_mode=screen:all_opacity=$(f 0.4),\
colorbalance=rs=$(f -0.08):gs=$(f 0.00):bs=$(f 0.10):rm=$(f -0.01):bm=$(f 0.01):rh=$(f 0.01):gh=$(f 0.01):bh=$(f -0.02),\
curves=all='0/0 0.25/$(f -0.04 0.25) 0.75/$(f 0.04 0.75) 1/1',\
eq=saturation=$(f 0.1 1):gamma=0.97,\
vignette=angle=PI/4,noise=alls=$(awk -v s=$s 'BEGIN{printf "%d",5*s}'):allf=t,format=yuv420p"
    return
  fi
  echo "format=gbrp,split[a][b];[b]curves=all='0/0 0.55/0 1/1',gblur=sigma=16[g];[a][g]blend=all_mode=screen:all_opacity=$(awk -v s=$s 'BEGIN{printf "%.2f",0.35*s}'),\
eq=contrast=$(awk -v s=$s 'BEGIN{printf "%.3f",1+0.08*s}'):saturation=$(awk -v s=$s 'BEGIN{printf "%.3f",1+0.08*s}'):gamma=0.98,\
vignette=angle=PI/5,noise=alls=$(awk -v s=$s 'BEGIN{printf "%d",4*s}'):allf=t,format=yuv420p"
}

if [[ "${1:-}" == "--frame" ]]; then
  in="$2"; out="$3"; t="${4:-1}"
  ffmpeg -hide_banner -loglevel error -y -ss "$t" -i "$in" -frames:v 1 -vf "$(grade_chain "${5:-1.0}" "${6:-soft}")" "$out"
  exit 0
fi
in="${1:?usage: scripts/grade.sh in.mp4 out.mp4 [strength]}"; out="${2:?missing out.mp4}"; s="${3:-1.0}"; look="${4:-soft}"
nice -n 10 ffmpeg -hide_banner -loglevel warning -stats -y -i "$in" -vf "$(grade_chain "$s" "$look")" \
  -c:v libx264 -preset veryfast -crf 18 -c:a copy -movflags +faststart "$out"
echo "Graded: $out"
