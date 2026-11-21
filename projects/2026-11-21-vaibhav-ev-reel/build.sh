#!/usr/bin/env bash
# Vaibhav EV reel: images only (0 Flow credits). Run from this project folder.
# Each image -> 1080x1920 24 fps segment with a slow push-in; text burned from reel.ass; muted (music added in-app).
# AI stills: zoom anchored bottom-right so the Gemini sparkle watermark is never cropped.
set -euo pipefail
cd "$(dirname "$0")/media"
mkdir -p out/seg
R=24; W=1080; H=1920

# seg <name> <input> <seconds> <prefilter producing ~WxH or larger> <anchor: br|c|top>
seg() {
  local name=$1 in=$2 dur=$3 pre=$4 anchor=$5 n=$(( $3 * R ))
  local x y
  case $anchor in
    br)  x='iw-iw/zoom'; y='ih-ih/zoom' ;;
    top) x='iw/2-(iw/zoom/2)'; y='0' ;;
    *)   x='iw/2-(iw/zoom/2)'; y='ih/2-(ih/zoom/2)' ;;
  esac
  ffmpeg -v error -y -loop 1 -i "$in" -vf "$pre,scale=$((W*2)):$((H*2)),zoompan=z='1+0.06*on/$n':x='$x':y='$y':d=$n:s=${W}x${H}:fps=$R,setsar=1,format=yuv420p" \
    -frames:v $n -c:v libx264 -preset veryfast -crf 18 "out/seg/$name.mp4"
}

fill() { # landscape photo -> blurred 9:16 background with the photo centred
  echo "split[a][b];[a]scale=$W:$H:force_original_aspect_ratio=increase,crop=$W:$H,boxblur=30:3,eq=brightness=-0.08[bg];[b]scale=$W:-2[fg];[bg][fg]overlay=0:(H-h)/2"
}

seg 01_dead   stills/s01_dead_a.png  3 "scale=$W:-2,crop=$W:$H:0:0" br
seg 02_phone  stills/s02_phone_a.png 3 "scale=$W:-2,crop=$W:$H:0:0" br
seg 03_shop   ref/1.jpeg             4 "scale=$W:$H" top
seg 04_batt   ref/2.jpeg             3 "crop=1000:680:0:0,$(fill)" c
seg 05_motor  ref/3.jpeg             3 "scale=$W:-2,crop=$W:$H:0:200" c
seg 06_wiring ref/4.jpeg             3 "crop=608:1080:120:330,scale=$W:$H" c
seg 07_brands ref/1.jpeg             3 "crop=470:180:105:630,$(fill)" c
if [[ -f stills/s06_ride_a.png ]]; then seg 08_ride stills/s06_ride_a.png 3 "scale=$W:-2,crop=$W:$H:0:0" br; fi

# end card: white background, logo; text comes from reel.ass
ffmpeg -v error -y -f lavfi -i "color=white:s=${W}x${H}:r=$R:d=4" -i ref/card-front.png \
  -filter_complex "[1]crop=320:210:370:80,scale=640:-2[l];[0][l]overlay=(W-w)/2:330,format=yuv420p" \
  -t 4 -c:v libx264 -preset veryfast -crf 18 out/seg/09_end.mp4

ls out/seg/*.mp4 | sed "s|^|file '$PWD/|; s|$|'|" > out/seg/list.txt
ffmpeg -v error -y -f concat -safe 0 -i out/seg/list.txt -c copy out/silent_notext.mp4
T=$(ffprobe -v error -show_entries format=duration -of csv=p=0 out/silent_notext.mp4)
sed "s/@END@/0:00:$(printf '%05.2f' "$(echo "$T - 4" | bc)")/; s/@FIN@/0:00:$(printf '%05.2f' "$T")/" ../reel.ass > out/seg/reel.ass
ffmpeg -v error -y -i out/silent_notext.mp4 -vf "ass=out/seg/reel.ass" -c:v libx264 -preset medium -crf 19 -an out/vaibhav-ev-reel.mp4
echo "done: out/vaibhav-ev-reel.mp4 ($T s)"
