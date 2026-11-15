#!/usr/bin/env bash
# Micro-explainer builder (15 Nov 2026): segments (clips or still push-ins) + one narration wav + ASS captions
# -> joined at 720x1280, rose grade to 1080x1920 and captions burned in, all in one final encode. Clip sound stays low under the voice; stills are silent.
# Usage: scripts/micro.sh <spec.txt> <narration.wav> <captions.ass> <out.mp4>
# Still push-ins are zoomed at 2x and shrunk (area): zoompan rounds to whole pixels, which stuttered ("vibrating", owner 15 Nov).
# spec lines:  clip|<file>|<start_s>|<dur_s>      still|<file>|<dur_s>[|zoom_per_frame, default 0.0008]
set -euo pipefail
cd "$(dirname "$0")/.."
spec="$1"; nar="$2"; ass="$3"; out="$4"
T=$(mktemp -d); trap 'rm -rf "$T"' EXIT
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
i=0; ins=""; fc=""
while IFS='|' read -r kind f a b c <&3; do
  [[ -z "$kind" || "$kind" == \#* ]] && continue
  n=$(printf '%02d' $i); o="$T/s$n.mkv"
  if [[ "$kind" == clip ]]; then
    ffmpeg -v error -y -ss "$a" -t "$b" -i "$f" -map 0:v -map 0:a? -vf "$V" -c:v libx264 -preset veryfast -crf 20 \
      -af "volume=0.18,apad" -t "$b" -c:a pcm_s16le -ar 48000 -ac 2 "$o" </dev/null
    # clips without audio: add silence
    if ! ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$o" | grep -q .; then
      ffmpeg -v error -y -i "$o" -f lavfi -t "$b" -i anullsrc=r=48000:cl=stereo -map 0:v -map 1:a -c:v copy -c:a pcm_s16le "$T/x.mkv" </dev/null && mv "$T/x.mkv" "$o"
    fi
  else
    z="${b:-0.0008}"
    ffmpeg -v error -y -loop 1 -t "$a" -i "$f" -f lavfi -t "$a" -i anullsrc=r=48000:cl=stereo \
      -vf "scale=2880:-2,zoompan=z='1+${z}*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=1440x2580:fps=24,scale=720:1290:flags=area,crop=720:1280,format=yuv420p,setsar=1" \
      -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -t "$a" -c:a pcm_s16le -ar 48000 -ac 2 "$o" </dev/null
  fi
  ins="$ins -i $o"; fc="$fc[$i:v][$i:a]"; i=$((i+1))
done 3< "$spec"
# One final encode: join + narration mix + rose grade (1080x1920) + burned captions.
# (Until 15 Nov this was three encodes: cut -> grade.sh -> captions. Same filters, same order.)
G="$(GRADE_SCALE=1080:1920 bash scripts/grade.sh --chain 1.0 rose)"
nice -n 10 ffmpeg -v error -y $ins -i "$nar" -filter_complex "${fc}concat=n=$i:v=1:a=1[vcat][bed];[$i:a]adelay=150:all=1,apad[n];[bed][n]amix=inputs=2:normalize=0:duration=first[aout];[vcat]${G},ass=$ass:shaping=complex[vout]"   -map "[vout]" -map "[aout]" -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -pix_fmt yuv420p   -c:a aac -b:a 160k -movflags +faststart "$out" </dev/null
echo "$out: $(ffprobe -v error -show_entries format=duration,size -of csv=p=0 "$out")"
