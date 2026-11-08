#!/usr/bin/env bash
# Cinematic "festival" grade: glow (bloom) around lights, a little extra contrast and saturation,
# soft vignette, fine film grain. No colour shift: footage from Flow/Nano Banana is already
# teal-and-gold, and the old teal/orange colorbalance turned it purple (2026-11-08).
# Looks: "soft" (default, above), "film" (matte, reference 1), "rose" (rich, reference 2) and "epic" (stronger, film-trailer look like the reference reel:
# teal shadows + gold highlights, S-curve contrast, more glow/saturation, deeper vignette).
# All colour work runs in RGB (gbrp): in YUV the blend/colorbalance turned footage purple.
# Re-encodes (slow-ish here).
# Usage: scripts/grade.sh in.mp4 out.mp4 [strength, default 1.0] [soft|film|rose|epic]
# GRADE_SCALE=1080:1920 upscales (lanczos) before sharpening: crisper after Instagram/YouTube compression.
#        scripts/grade.sh --frame in.mp4 out.png [time_s] [strength] [soft|film|rose|epic]   (one-frame preview)
set -euo pipefail

grade_chain() {
  local s="${1:-1.0}" look="${2:-soft}"
  if [[ "$look" == "rose" ]]; then
    # Matched to the owner's 2nd reference reel (2026-11-08, Lakshmi on a lotus): deep blacks,
    # warm rose-red shadows (no teal), rosy skin, cream highlights, slightly lower saturation, crisp.
    local f; f() { awk -v s="$s" -v k="$1" -v b="${2:-0}" 'BEGIN{printf "%.3f", b+k*s}'; }
    echo "format=gbrp,split[a][b];[b]curves=all='0/0 0.6/0 1/1',gblur=sigma=20[g];[a][g]blend=all_mode=screen:all_opacity=$(f 0.2),\
colorbalance=rs=$(f 0.12):gs=$(f -0.03):bs=$(f -0.02):rm=$(f 0.08):gm=$(f -0.01):bm=$(f 0.08):rh=$(f -0.04):bh=$(f 0.10),\
eq=saturation=$(f -0.15 1),\
curves=all='0/0 0.3/$(f 0.03 0.3) 0.7/$(f 0.01 0.7) 1/$(f -0.05 1)',\
${GRADE_SCALE:+scale=$GRADE_SCALE:flags=lanczos,}cas=strength=$(f 0.6),noise=alls=$(awk -v s=$s 'BEGIN{printf "%d",3*s}'):allf=t,format=yuv420p"
    return
  fi
  if [[ "$look" == "film" ]]; then
    # Matched to an owner-supplied reference reel (2026-11-08) by measuring luma/RGB per zone:
    # lifted matte blacks, brighter mids, ~20% less saturation, peach (not orange) skin,
    # creamy highlights (blue added to kill the yellow), soft wide bloom, fine grain.
    # NB ffmpeg blend "normal": opacity weights the FIRST input, so the blurred layer goes first.
    local f; f() { awk -v s="$s" -v k="$1" -v b="${2:-0}" 'BEGIN{printf "%.3f", b+k*s}'; }
    echo "format=gbrp,split[a][b];[b]curves=all='0/0 0.6/0 1/1',gblur=sigma=30[g];[a][g]blend=all_mode=screen:all_opacity=$(f 0.30),\
split[c][d];[d]gblur=sigma=7[e];[e][c]blend=all_mode=normal:all_opacity=$(f 0.12),\
huesaturation=colors=c+b:saturation=$(f -0.55):intensity=$(f -0.04),\
huesaturation=colors=r+y:saturation=$(f -0.12),\
eq=saturation=$(f -0.08 1),\
colorbalance=rs=$(f 0.03):bs=$(f -0.02):rm=$(f 0.04):rh=$(f -0.02):bh=$(f 0.12),\
curves=all='0/$(f 0.10) 0.15/$(f 0.06 0.15) 0.31/$(f 0.14 0.31) 0.6/$(f 0.09 0.6) 1/$(f -0.05 1)',\
${GRADE_SCALE:+scale=$GRADE_SCALE:flags=lanczos,}cas=strength=$(f 0.6),noise=alls=$(awk -v s=$s 'BEGIN{printf "%d",4*s}'):allf=t,format=yuv420p"
    return
  fi
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
  -c:v libx264 -preset medium -crf 16 -c:a copy -movflags +faststart "$out"
echo "Graded: $out"
