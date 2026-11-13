#!/usr/bin/env bash
# Ep 1 FINAL cut step 1 (generated from build_ep1_draft.sh, 13 Nov 2026): same cut, Vishnu clip darkened/cooled, end card without text
# Ep 1 cut: shots fitted to the timed narration (draft AI voice, media/ep1/audio-draft/L01..L11.wav).
# 720x1280, ungraded: for approving picture-to-line fit and sound. Final = same cut, final voice, grade.sh rose at 1080x1920, music.
# Each line gets a slot = its speech + 0.4 s. Clip sound kept on 01, 07, 11, 12, 10c; rumble bed under everything.
# Run from the repo root: bash projects/2026-11-09-samudra-manthan/build_ep1_draft.sh
set -euo pipefail
R=projects/2026-11-09-samudra-manthan; P=$R/media/ep1; A=$P/audio-draft
T=$(mktemp -d); O=$P/out; mkdir -p "$O"
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
clip(){ # name src start dur keepaudio(1/0)
  if [ "$5" = 1 ]; then a="-map 0:a"; else a="-f lavfi -t $4 -i anullsrc=r=48000:cl=stereo -map 1:a"; fi
  ffmpeg -v error -y -ss "$3" -t "$4" -i "$P/clips/$2.mp4" $a -map 0:v -vf "$V" -c:v libx264 -preset veryfast -crf 20 -af apad -t "$4" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
push(){ # name still dur
  ffmpeg -v error -y -loop 1 -t "$3" -i "$P/stills/$2.jpg" -f lavfi -t "$3" -i anullsrc=r=48000:cl=stereo \
    -vf "scale=1440:-2,zoompan=z='1+0.0008*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=720x1290:fps=24,crop=720:1280,format=yuv420p,setsar=1" \
    -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -af apad -t "$3" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
#            line: picture                                   slot
clip a01 01  0   2.4 1   # L1 Devas lost their strength       4.4
push a02 s02_indra_weak 2.0
push a03 s03_devas_walk 2.0   # L2 took refuge in Vishnu      3.8
VFIX="format=gbrp,curves=all='0/0 0.5/0.36 1/0.82',colorbalance=rm=-0.06:bm=0.07:rh=-0.05:bh=0.06:rs=-0.03:bs=0.05,format=yuv420p,"
V0="$V"; V="${VFIX}$V"
clip a04 04  0   7.9 0   # L2 end + L3 Vishnu speaks          1.8 + 6.1 (one long take)
V="$V0"
push a05 s06_mandara 2.0      # L4 Mandara the rod            4.0
clip a06 07  1.0 2.0 1   #    Vasuki the rope
push a07 s08_asuras 1.96      # L5 Asuras at the head         3.92
push a08 s09_devas 1.96       #    Devas at the tail
clip a09 10c 0   2.4 1   # L6 churning began                  4.8
clip a10 11  0   2.4 1   #    the mountain sank
clip a11 12  0   6.52 1  # L7 + L8 Kurma, mountain on his back 6.52
clip a12 10c 3.4 4.52 1  # L9 the churning went on            4.52
clip a13 15  0   4.04 0  # L10 the ocean turned dark          4.04
# end card (L11): Kurma frame darkened + title
ffmpeg -v error -y -loop 1 -t 3.6 -i "$P/cover/kurma_frame.png" -f lavfi -t 3.6 -i anullsrc=r=48000:cl=stereo \
  -vf "$V,eq=brightness=-0.12,fade=t=in:d=0.4" \
  -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -af apad -t 3.6 -c:a pcm_s16le -ar 48000 -ac 2 "$T/a14.mkv"
segs=$(ls "$T"/a*.mkv); n=$(echo "$segs" | wc -l); in=""; fc=""; i=0
for s in $segs; do in="$in -i $s"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done
# narration: line starts = running sum of (speech + 0.4)
vin=""; vf=""; t=0.15; k=0; mix=""
for L in "$A"/L*.wav; do d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$L"); ms=$(printf '%.0f' "$(echo "$t*1000" | bc -l)")
  vin="$vin -i $L"; idx=$((n+1+k)); vf="$vf[$idx:a]adelay=${ms}|${ms}[n$k];"; mix="$mix[n$k]"; echo "L$((k+1)) starts $t"; t=$(echo "$t+$d+0.4" | bc -l); k=$((k+1)); done
D=$(echo "$t+0.6" | bc -l); D=$(printf '%.2f' "$D"); echo "total $D s"
ffmpeg -v error -y $in -stream_loop -1 -i "$P/clips/12.mp4" $vin -filter_complex \
  "${fc}concat=n=$n:v=1:a=1[v][ca];[$n:a]atrim=0:$D,asetpts=N/SR/TB,volume=-22dB[bed];[ca]volume=-11dB[fx];${vf}${mix}amix=inputs=$k:normalize=0[vo];[vo][fx][bed]amix=inputs=3:normalize=0:duration=longest,afade=t=out:st=$(echo "$D-1.2"|bc):d=1.2,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 16 -c:a aac -b:a 160k -t "$D" "$O/ep1-cut.mp4"
rm -rf "$T"; ffprobe -v error -show_entries stream=codec_type,duration -of csv=p=0 "$O/ep1-cut.mp4"
