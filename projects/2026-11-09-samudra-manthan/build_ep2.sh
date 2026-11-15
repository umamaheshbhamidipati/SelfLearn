#!/usr/bin/env bash
# Ep 2 (Neelakantha) FINAL, 15 Nov 2026: cut fitted to the AI narration -> rose grade 1080x1920 -> Telugu captions + end card.
# Voice = Gemini TTS Achird (media/ep2/audio-draft/L01..L09.wav) + clip sounds; no music. Halahala = conch rule (log.md).
# Run outside 09:00-15:35 from anywhere: bash projects/2026-11-09-samudra-manthan/build_ep2.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
R=projects/2026-11-09-samudra-manthan; P=$R/media/ep2; A=$P/audio-draft; O=$P/out; T=$(mktemp -d); mkdir -p "$O" "$P/cover"
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
clip(){ # name src start dur keepaudio(1/0)
  if [ "$5" = 1 ]; then a="-map 0:a"; else a="-f lavfi -t $4 -i anullsrc=r=48000:cl=stereo -map 1:a"; fi
  ffmpeg -v error -y -ss "$3" -t "$4" -i "$P/clips/$2.mp4" $a -map 0:v -vf "$V" -c:v libx264 -preset veryfast -crf 20 -af apad -t "$4" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
push(){ # name still dur
  ffmpeg -v error -y -loop 1 -t "$3" -i "$P/stills/$2.jpg" -f lavfi -t "$3" -i anullsrc=r=48000:cl=stereo \
    -vf "scale=1440:-2,zoompan=z='1+0.0008*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=720x1290:fps=24,crop=720:1280,format=yuv420p,setsar=1" \
    -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -af apad -t "$3" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
# Slot per line = speech + 0.4 s (L1 3.04, L2 2.96, L3 3.80, L4 2.24, L5 3.64, L6 5.24, L7 3.24, L8 4.28, L9 2.00)
#              picture                                       line / slot
push a01 s1_conch_a 1.6      # HOOK: conch brimming with violet smoke (still; clip 01 0-2.5 s fails: smoke over the face)
clip a02 02 0    1.84 1      # L1 Halahala rose from the milk ocean (column)    3.44
clip a03 02 1.84 3.36 1      # L2 the worlds burned                              3.36
clip a04 04 0    4.20 1      # L3 Devas ran to Kailasa                           4.20
clip a05 05 0    2.64 1      # L4 Parvati consented (before the namaste)         2.64
clip a06 01 2.6  1.84 1      # L5 Shiva takes the conch (clean 2.6-4.44 s)       4.04
clip a07 06 0    2.2  1      #    drinks from the conch (clean 0-2.2 s; smoke drifts up after)
clip a08 07 0    5.64 1      # L6 Parvati's hand on his throat                   5.64
clip a09 08 0    2.9  1      # L7 throat turned blue (skip the 3.2-5.3 s flare)  3.64
clip a10 08 5.6  2.24 1      # L7 end + L8 start: Neelakantha, calm
clip a11 04 4.1  3.18 1      # L8 poison before nectar: the Devas kneel          4.68
# end card (L9 + L10 teaser + title): calm Neelakantha frame, darkened
ffmpeg -v error -y -ss 7.5 -i "$P/clips/08.mp4" -frames:v 1 "$P/cover/neelakantha_frame.png"
ffmpeg -v error -y -loop 1 -t 6.95 -i "$P/cover/neelakantha_frame.png" -f lavfi -t 6.95 -i anullsrc=r=48000:cl=stereo \
  -vf "$V,eq=brightness=-0.12,fade=t=in:d=0.4" \
  -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -af apad -t 6.95 -c:a pcm_s16le -ar 48000 -ac 2 "$T/a12.mkv"
segs=$(ls "$T"/a*.mkv); n=$(echo "$segs" | wc -l); in=""; fc=""; i=0
for s in $segs; do in="$in -i $s"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done
# narration: line starts = running sum of (speech + 0.4); captions written from the same timings
C=$R/captions-ep2.ass; sed -n '1,15p' $R/captions-ep1.ass > $C
ts(){ awk -v t="$1" 'BEGIN{m=int(t/60); printf "0:%02d:%05.2f", m, t-60*m}'; }
vin=""; vf=""; t=0.15; k=0; mix=""
for L in "$A"/L*.wav; do d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$L"); ms=$(printf '%.0f' "$(echo "$t*1000" | bc -l)")
  vin="$vin -i $L"; idx=$((n+1+k)); vf="$vf[$idx:a]adelay=${ms}|${ms}[n$k];"; mix="$mix[n$k]"
  txt=$(sed -n "$((k+1))p" $R/narration-ep2.txt); e=$(echo "$t+$d+0.25" | bc -l)
  [ $k -lt 9 ] && echo "Dialogue: 0,$(ts $t),$(ts $e),Cap,,0,0,0,,$txt" >> $C; [ $k -eq 8 ] && L9=$t; [ $k -eq 9 ] && L10=$t
  echo "L$((k+1)) starts $t"; t=$(echo "$t+$d+0.4" | bc -l); k=$((k+1)); done
D=$(echo "$t-0.4+1.9" | bc -l); D=$(printf '%.2f' "$D"); echo "total $D s"
{ echo "Dialogue: 0,$(ts $L9),$(ts $D),Title,,0,0,0,,{\\pos(540,1300)\\fad(400,0)}నీలకంఠుడు"
  echo "Dialogue: 0,$(ts $L10),$(ts $D),Sub,,0,0,0,,{\\pos(540,1470)\\fad(400,0)}తర్వాతి భాగం: అమృతం"
  echo "Dialogue: 0,$(ts $L9),$(ts $D),Brand,,0,0,0,,{\\pos(540,1600)\\fad(400,0)}UmaAI Studio"; } >> $C
ffmpeg -v error -y $in -stream_loop -1 -i "$P/clips/02.mp4" $vin -filter_complex \
  "${fc}concat=n=$n:v=1:a=1[v][ca];[$n:a]atrim=0:$D,asetpts=N/SR/TB,volume=-22dB[bed];[ca]volume=-11dB[fx];${vf}${mix}amix=inputs=$k:normalize=0[vo];[vo][fx][bed]amix=inputs=3:normalize=0:duration=longest,afade=t=out:st=$(echo "$D-1.2"|bc):d=1.2,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 16 -c:a aac -b:a 160k -t "$D" "$O/ep2-cut.mp4"
rm -rf "$T"
GRADE_SCALE=1080:1920 bash scripts/grade.sh $O/ep2-cut.mp4 $O/ep2-graded.mp4 1.0 rose >/dev/null 2>&1
ffmpeg -y -v error -i $O/ep2-graded.mp4 -i $O/ep2-cut.mp4 -vf "ass=$C:shaping=complex" -map 0:v -map 1:a \
  -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -pix_fmt yuv420p -c:a copy -shortest $O/ep2-neelakantha.mp4
echo EP2_FINAL_DONE
