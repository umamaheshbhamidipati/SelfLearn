#!/usr/bin/env bash
# Vaibhav EV reel: images only (0 Flow credits) + Telugu voice (Achird, scripts/tts.sh). Run from anywhere.
# Shot lengths follow the voice lines (timeline.py). Missing lines get fallback lengths and silence.
# AI stills: zoom anchored bottom-right so the Gemini sparkle watermark is never cropped.
set -euo pipefail
P="$(cd "$(dirname "$0")" && pwd)"
cd "$P/media"
mkdir -p out/seg audio/vo
R=24; W=1080; H=1920

# 1. trim silence at both ends of each voice line
for f in audio/vo/L?.wav; do
  t="${f%.wav}_trim.wav"
  [[ -f "$t" && "$t" -nt "$f" ]] && continue
  ffmpeg -v error -y -i "$f" -af "silenceremove=start_periods=1:start_threshold=-45dB,areverse,silenceremove=start_periods=1:start_threshold=-45dB,areverse" "$t"
done

# 2. timings, captions and voice positions
python3 "$P/timeline.py"
declare -A D; while read -r k v; do D[$k]=$v; done < out/seg/durations.txt

# 3. one segment per shot, sub-pixel push-in with perspective (zoompan shook: owner 21 Nov)
seg() {
  local name=$1 in=$2 pre=$3 anchor=$4
  local n; n=$(python3 -c "print(round(${D[$name]}*$R))")
  local s="(on/$n)" z ox oy
  z="(1+0.06*$s*$s*(3-2*$s))"
  case $anchor in
    br)  ox="(W-W/$z)"; oy="(H-H/$z)" ;;
    top) ox="(W-W/$z)/2"; oy="0" ;;
    *)   ox="(W-W/$z)/2"; oy="(H-H/$z)/2" ;;
  esac
  local x1="$ox+W/$z" y2="$oy+H/$z"
  ffmpeg -v error -y -loop 1 -framerate $R -i "$in" -vf "$pre,scale=$W:$H,setsar=1,perspective=x0='$ox':y0='$oy':x1='$x1':y1='$oy':x2='$ox':y2='$y2':x3='$x1':y3='$y2':interpolation=cubic:eval=frame,format=yuv420p" \
    -frames:v "$n" -c:v libx264 -preset veryfast -crf 18 "out/seg/$name.mp4"
}
fill() { # landscape/odd photo -> blurred 9:16 background with the photo centred
  echo "split[a][b];[a]scale=$W:$H:force_original_aspect_ratio=increase,crop=$W:$H,boxblur=30:3,eq=brightness=-0.08[bg];[b]scale=$W:-2[fg];[bg][fg]overlay=0:(H-h)/2"
}
AI="scale=$W:-2,crop=$W:$H:0:0"
rm -f out/seg/0*.mp4
seg 01_dead   stills/s01_dead_a.png  "$AI" br
seg 02_phone  stills/s02_phone_a.png "$AI" br
seg 03_shop   ref/1.jpeg             "scale=$W:$H" top
seg 04_batt   ref/2.jpeg             "crop=1000:680:0:0,$(fill)" c
seg 05_motor  ref/3.jpeg             "scale=$W:-2,crop=$W:$H:0:200" c
seg 06_wiring ref/4.jpeg             "crop=608:1080:120:330,scale=$W:$H" c
seg 07_brands ref/1.jpeg             "crop=470:180:105:630,$(fill)" c
if [[ -n "${D[08_ride]:-}" ]]; then seg 08_ride stills/s06_ride_a.png "$AI" br
else seg 08_board ref/1.jpeg "crop=300:430:600:860,$(fill)" c; fi

n=$(python3 -c "print(round(${D[09_end]}*$R))")
ffmpeg -v error -y -f lavfi -i "color=white:s=${W}x${H}:r=$R" -i ref/card-front.png \
  -filter_complex "[1]crop=320:210:370:80,scale=640:-2[l];[0][l]overlay=(W-w)/2:330,format=yuv420p" \
  -frames:v "$n" -c:v libx264 -preset veryfast -crf 18 out/seg/09_end.mp4

ls out/seg/0*.mp4 | sed "s|^|file '$PWD/|; s|$|'|" > out/seg/list.txt
ffmpeg -v error -y -f concat -safe 0 -i out/seg/list.txt -c copy out/silent_notext.mp4

# 4. voice track: each line placed at its shot start
python3 - <<'EOF' > out/seg/voice_cmd.txt
import json
v = json.load(open("out/seg/voice.json"))
ins = " ".join(f"-i audio/vo/{s}_trim.wav" for s, _ in v["lines"])
parts = [f"[{i}]adelay={int(t*1000)}:all=1[a{i}]" for i, (_, t) in enumerate(v["lines"])]
mix = "".join(f"[a{i}]" for i in range(len(v["lines"])))
print(ins)
print(";".join(parts) + f";{mix}amix=inputs={len(v['lines'])}:normalize=0,apad,atrim=0:{v['total']}[out]")
EOF
mapfile -t VC < out/seg/voice_cmd.txt
# shellcheck disable=SC2086
ffmpeg -v error -y ${VC[0]} -filter_complex "${VC[1]}" -map "[out]" -ar 48000 -ac 2 -c:a pcm_s16le audio/voice_full.wav

# 5. burn captions, add voice
ffmpeg -v error -y -i out/silent_notext.mp4 -i audio/voice_full.wav -vf "ass=out/seg/reel.ass" \
  -c:v libx264 -preset medium -crf 19 -c:a aac -b:a 160k -shortest out/vaibhav-ev-reel.mp4
echo "done: out/vaibhav-ev-reel.mp4 ($(ffprobe -v error -show_entries format=duration -of csv=p=0 out/vaibhav-ev-reel.mp4) s)"
