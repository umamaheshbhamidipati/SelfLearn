#!/usr/bin/env bash
# Ep 1 sound test (13 Nov 2026): rough cut in shot order, each clip's own Veo sound kept where it is
# sound effects (01 howl, 07 growl/hiss, 11 impact, 12 rumble), muted where Veo made only music (04, 15),
# plus a continuous low sea/rumble bed (clip 12's audio looped) under the stills. No narration yet.
# 720x1280, no grade (test only). Run from the repo root: bash projects/2026-11-09-samudra-manthan/build_soundtest.sh
set -euo pipefail
P=projects/2026-11-09-samudra-manthan/media/ep1
T=$(mktemp -d); O=$P/out; mkdir -p "$O"
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
clip(){ # name src start dur keepaudio(1/0)
  if [ "$5" = 1 ]; then a="-map 0:a"; else a="-f lavfi -t $4 -i anullsrc=r=48000:cl=stereo -map 1:a"; fi
  ffmpeg -v error -y -ss "$3" -t "$4" -i "$P/clips/$2.mp4" $a -map 0:v -vf "$V" -c:v libx264 -preset veryfast -crf 20 -af apad -t "$4" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
push(){ # name still dur
  ffmpeg -v error -y -loop 1 -t "$3" -i "$P/stills/$2.jpg" -f lavfi -t "$3" -i anullsrc=r=48000:cl=stereo \
    -vf "scale=1440:-2,zoompan=z='1+0.0008*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=720x1290:fps=24,crop=720:1280,format=yuv420p,setsar=1" \
    -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -af apad -t "$3" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
clip a01 01 0   3.5 1
push a02 s02_indra_weak 2.5
push a03 s03_devas_walk 2.5
clip a04 04 0.5 3.0 0
push a06 s06_mandara 2.5
clip a07 07 1.0 3.0 1
push a08 s08_asuras 2.5
push a09 s09_devas 2.5
push a10 s10_churn_leftright 3.0
clip a11 11 0   3.5 1
clip a12 12 0   6.0 1
clip a15 15 0   4.0 0
# join with the concat FILTER (the concat demuxer dropped segments / drifted with mixed audio)
segs=$(ls "$T"/a*.mkv); n=$(echo "$segs" | wc -l); in=""; fc=""; i=0
for s in $segs; do in="$in -i $s"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done
D=0; for s in $segs; do d=$(ffprobe -v error -select_streams v -count_frames -show_entries stream=nb_read_frames -of csv=p=0 "$s"); D=$(echo "$D + $d/24" | bc -l); done
D=$(printf '%.2f' "$D"); echo "picture $D s from $n segments"
# bed: clip 12 rumble looped, -14 dB under; clip sounds on top; gentle fade in/out
ffmpeg -v error -y $in -stream_loop -1 -i "$P/clips/12.mp4" -filter_complex \
  "${fc}concat=n=$n:v=1:a=1[v][ca];[$n:a]atrim=0:$D,asetpts=N/SR/TB,volume=-14dB,afade=t=in:d=1[bed];[ca]volume=-3dB[fx];[fx][bed]amix=inputs=2:normalize=0:duration=first,afade=t=in:d=0.5,afade=t=out:st=$(echo "$D-1.5"|bc):d=1.5,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 20 -c:a aac -b:a 160k -t "$D" "$O/ep1-soundtest.mp4"
rm -rf "$T"; ffprobe -v error -show_entries format=duration -of csv=p=0 "$O/ep1-soundtest.mp4"
