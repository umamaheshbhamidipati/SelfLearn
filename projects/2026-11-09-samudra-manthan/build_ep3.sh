#!/usr/bin/env bash
# Ep 3 (Amrutham) FINAL, 16 Nov 2026: cut fitted to the AI narration -> rose grade 1080x1920 -> Telugu captions + end card
# -> phone copy (720p, tv-range yuv420p) + upload copy (<10 MB, for the Chrome upload).
# Voice = Gemini TTS Achird (media/ep3/audio-draft/L01..L09.wav) + clip sounds; no music.
# Batch C: if media/ep3/clips/03.mp4 / 05.mp4 exist they are used, otherwise still push-ins (s03_lakshmi_a, s05_asuras_a).
# Run outside 09:00-15:35 from anywhere: bash projects/2026-11-09-samudra-manthan/build_ep3.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
R=projects/2026-11-09-samudra-manthan; P=$R/media/ep3; A=$P/audio-draft; O=$P/out; T=$(mktemp -d); mkdir -p "$O" "$P/cover"
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
clip(){ # name src start dur keepaudio(1/0)
  if [ "$5" = 1 ]; then a="-map 0:a"; else a="-f lavfi -t $4 -i anullsrc=r=48000:cl=stereo -map 1:a"; fi
  ffmpeg -v error -y -ss "$3" -t "$4" -i "$P/clips/$2.mp4" $a -map 0:v -vf "$V" -c:v libx264 -preset veryfast -crf 20 -af apad -t "$4" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
push(){ # name still dur
  ffmpeg -v error -y -loop 1 -t "$3" -i "$P/stills/$2.jpg" -f lavfi -t "$3" -i anullsrc=r=48000:cl=stereo \
    -vf "scale=1440:-2,zoompan=z='1+0.0008*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=720x1290:fps=24,crop=720:1280,format=yuv420p,setsar=1" \
    -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -af apad -t "$3" -c:a pcm_s16le -ar 48000 -ac 2 "$T/$1.mkv"; }
# Slot per line = speech + 0.4 s (L1 3.24 +0.15 lead, L2 5.32, L3 4.60, L4 3.96, L5 3.08, L6 3.24, L7 3.44, L8 5.40, L9 end card)
#              picture                                          line / slot
clip a01 01 1.0  3.39 1      # L1 HOOK: hands lift the kalasha (best 1-4 s)        3.39
push a02 s02a_kamadhenu_a 1.77  # L2 Kamadhenu                                     5.32
push a03 s02b_airavata_b  1.77  #    Airavata (four tusks)
push a04 s02c_parijata_a  1.78  #    Parijata
if [ -f "$P/clips/03.mp4" ]; then clip a05 03 0 2.3 1; else push a05 s03_lakshmi_a 2.3; fi  # L3 Lakshmi rises  4.60
push a06 s03b_garland_a   2.3   #    Lakshmi garlands Vishnu
clip a07 04 0    3.96 1      # L4 Dhanvantari with the kalasha                       3.96
if [ -f "$P/clips/05.mp4" ]; then clip a08 05 0 3.08 1; else push a08 s05_asuras_a 3.08; fi  # L5 Asuras run   3.08
clip a09 06 0    3.24 1      # L6 Mohini                                             3.24
clip a10 07 0    3.44 1      # L7 Mohini shares (clean 0-3.4 s)                      3.44
clip a11 09 0    2.5  1      # L8 the Asura in the Devas' row (clean 0-2.5 s)        5.40
push a12 s09_rahu_c       2.9   #    push-in on the sly glance
# end card (L9 teaser + title): clip 09 at 2.4 s (sly glance, before the grin), darkened
ffmpeg -v error -y -ss 2.4 -i "$P/clips/09.mp4" -frames:v 1 "$P/cover/rahu_frame.png"
ffmpeg -v error -y -loop 1 -t 4.6 -i "$P/cover/rahu_frame.png" -f lavfi -t 4.6 -i anullsrc=r=48000:cl=stereo \
  -vf "$V,eq=brightness=-0.12,fade=t=in:d=0.4" \
  -map 0:v -map 1:a -c:v libx264 -preset veryfast -crf 20 -af apad -t 4.6 -c:a pcm_s16le -ar 48000 -ac 2 "$T/a13.mkv"
segs=$(ls "$T"/a*.mkv); n=$(echo "$segs" | wc -l); in=""; fc=""; i=0
for s in $segs; do in="$in -i $s"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done
# narration: line starts = running sum of (speech + 0.4); captions written from the same timings
C=$R/captions-ep3.ass; sed -n '1,15p' $R/captions-ep1.ass > $C
ts(){ awk -v t="$1" 'BEGIN{m=int(t/60); printf "0:%02d:%05.2f", m, t-60*m}'; }
vin=""; vf=""; t=0.15; k=0; mix=""
for L in "$A"/L*.wav; do d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$L"); ms=$(printf '%.0f' "$(echo "$t*1000" | bc -l)")
  vin="$vin -i $L"; idx=$((n+1+k)); vf="$vf[$idx:a]adelay=${ms}|${ms}[n$k];"; mix="$mix[n$k]"
  txt=$(sed -n "$((k+1))p" $R/narration-ep3.txt); e=$(echo "$t+$d+0.25" | bc -l)
  [ $k -lt 8 ] && echo "Dialogue: 0,$(ts $t),$(ts $e),Cap,,0,0,0,,$txt" >> $C; [ $k -eq 8 ] && L9=$t
  echo "L$((k+1)) starts $t"; t=$(echo "$t+$d+0.4" | bc -l); k=$((k+1)); done
D=$(echo "$t-0.4+1.9" | bc -l); D=$(printf '%.2f' "$D"); echo "total $D s"
{ echo "Dialogue: 0,$(ts $L9),$(ts $D),Title,,0,0,0,,{\\pos(540,1300)\\fad(400,0)}అమృతం"
  echo "Dialogue: 0,$(ts $L9),$(ts $D),Sub,,0,0,0,,{\\pos(540,1470)\\fad(400,0)}తర్వాతి భాగం: రాహువు"
  echo "Dialogue: 0,$(ts $L9),$(ts $D),Brand,,0,0,0,,{\\pos(540,1600)\\fad(400,0)}UmaAI Studio"; } >> $C
ffmpeg -v error -y $in -stream_loop -1 -i "$P/clips/06.mp4" $vin -filter_complex \
  "${fc}concat=n=$n:v=1:a=1[v][ca];[$n:a]atrim=0:$D,asetpts=N/SR/TB,volume=-22dB[bed];[ca]volume=-11dB[fx];${vf}${mix}amix=inputs=$k:normalize=0[vo];[vo][fx][bed]amix=inputs=3:normalize=0:duration=longest,afade=t=out:st=$(echo "$D-1.2"|bc):d=1.2,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 16 -c:a aac -b:a 160k -t "$D" "$O/ep3-cut.mp4"
rm -rf "$T"
GRADE_SCALE=1080:1920 bash scripts/grade.sh $O/ep3-cut.mp4 $O/ep3-graded.mp4 1.0 rose >/dev/null 2>&1
F=$O/ep3-amrutham.mp4
ffmpeg -y -v error -i $O/ep3-graded.mp4 -i $O/ep3-cut.mp4 -vf "ass=$C:shaping=complex,scale=out_range=tv,format=yuv420p" -map 0:v -map 1:a \
  -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -color_range tv -c:a copy -shortest $F
# phone copy: 720p, tv-range yuv420p, Main profile (the 1080p full-range file did not open on the phone, 16 Nov)
ffmpeg -y -v error -i $F -vf "scale=720:1280:flags=lanczos:out_range=tv,format=yuv420p" -c:v libx264 -profile:v main -preset veryfast \
  -b:v 1.3M -maxrate 1.8M -bufsize 3M -color_range tv -c:a aac -b:a 128k -movflags +faststart $O/ep3-amrutham-phone.mp4
# upload copy: 1080x1920 under 10 MB (Chrome upload limit), two-pass
cd $O; ffmpeg -y -v error -i ep3-amrutham.mp4 -c:v libx264 -preset medium -b:v 1.6M -pass 1 -passlogfile ep3pass -an -f null /dev/null
ffmpeg -y -v error -i ep3-amrutham.mp4 -c:v libx264 -preset medium -b:v 1.6M -pass 2 -passlogfile ep3pass -pix_fmt yuv420p -color_range tv \
  -c:a aac -b:a 128k -movflags +faststart ep3-amrutham-upload-10mb.mp4; rm -f ep3pass*
echo EP3_FINAL_DONE
