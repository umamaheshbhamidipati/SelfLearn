#!/usr/bin/env bash
# Rough cut from a cut list: trims, centred 9:16 fill (keeps the AI watermark visible), crossfades,
# optional warm film grade, muted output.
#
# Usage: roughcut.sh <cut_list.txt> <out.mp4> [--grade] [--xfade 0.3]
# cut_list.txt, one shot per line ('#' comments allowed):
#   path/to/clip.mp4|start_seconds|duration_seconds|transition_into_next
# transitions: fade fadeblack fadewhite dissolve wipeleft slideup circleopen ... (ffmpeg xfade names)
set -e
source "$(dirname "$0")/_ff.sh"
LIST="$1"; OUT="$2"; shift 2 || true
GRADE=0; XF=0.3
while [ $# -gt 0 ]; do
  case "$1" in
    --grade) GRADE=1 ;;
    --xfade) XF="$2"; shift ;;
  esac
  shift
done
[ -f "$LIST" ] && [ -n "$OUT" ] || { echo "usage: roughcut.sh <cut_list.txt> <out.mp4> [--grade] [--xfade 0.3]" >&2; exit 1; }

inputs=(); filt=""; i=0; durs=(); trans=()
while IFS='|' read -r f s d t; do
  f=$(echo "$f" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
  [ -z "$f" ] && continue
  case "$f" in \#*) continue ;; esac
  [ -f "$f" ] || { echo "missing clip: $f" >&2; exit 1; }
  inputs+=(-i "$f")
  end=$(awk -v s="$s" -v d="$d" 'BEGIN{printf "%.3f", s+d}')
  # Fill 720x1280, centred. No extra zoom or off-centre crop: never hide the Flow/AI watermark.
  filt+="[$i:v]trim=$s:$end,setpts=PTS-STARTPTS,fps=24,scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,setsar=1,format=yuv420p[v$i];"
  durs[$i]=$d; trans[$i]=${t:-fade}; i=$((i+1))
done < "$LIST"
[ "$i" -ge 1 ] || { echo "cut list is empty" >&2; exit 1; }

prev="v0"; off=0
for ((k=1; k<i; k++)); do
  off=$(awk -v o="$off" -v d="${durs[$((k-1))]}" -v x="$XF" 'BEGIN{printf "%.3f", o+d-x}')
  filt+="[$prev][v$k]xfade=transition=${trans[$((k-1))]}:duration=$XF:offset=$off[x$k];"
  prev="x$k"
done
total=$(awk -v o="$off" -v d="${durs[$((i-1))]}" 'BEGIN{printf "%.3f", o+d}')
fo=$(awk -v t="$total" 'BEGIN{printf "%.3f", t-0.8}')
post=""
if [ "$GRADE" = 1 ]; then
  # warm, slightly desaturated 1980s film look + light grain + vignette
  post="colorbalance=rs=0.04:gs=-0.01:bs=-0.06:rm=0.06:gm=-0.02:bm=-0.06:rh=0.05:gh=0.01:bh=-0.06,eq=saturation=0.92:contrast=1.04:gamma=0.98,vignette=angle=PI/5,noise=alls=4:allf=t,"
fi
filt+="[$prev]${post}fade=t=in:st=0:d=0.4,fade=t=out:st=$fo:d=0.8,format=yuv420p[out]"

"$FF" -v error -y "${inputs[@]}" -filter_complex "$filt" -map "[out]" -an \
  -c:v libx264 -preset medium -crf 22 -maxrate 8M -bufsize 16M -pix_fmt yuv420p -movflags +faststart "$OUT"
echo "shots=$i total=${total}s -> $OUT"
