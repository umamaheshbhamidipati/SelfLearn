#!/usr/bin/env bash
# Ep 4 (Rahu, series finale), 18 Nov 2026: cut fitted to the AI narration -> soft Earshot effects in the same mix
# -> rose grade 1080x1920 -> Telugu captions + end card -> phone copy (720p tv-range) + upload copy (<10 MB).
# Voice = Gemini TTS Achird, trimmed lines in media/ep4/audio/L01..L10.wav (lead/tail silence cut); no music.
# Clips: ep4 03 (re-roll, clean 2.7-5.8 s), ep4 06 (clean 0.4-3.2 s); reused ep3 09, 07, 06. Rest = still push-ins.
# Run OUTSIDE 09:00-15:35: bash projects/2026-11-09-samudra-manthan/build_ep4.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
R=projects/2026-11-09-samudra-manthan; P=$R/media/ep4; P3=$R/media/ep3; A=$P/audio; O=$P/out; S=$P/stills
T=$(mktemp -d); mkdir -p "$O" "$P/sfx"; GAP=0.35; LEAD=0.15; WHITE=0.5; CARD=2.6
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
ENC="-c:v libx264 -preset veryfast -crf 20 -c:a pcm_s16le -ar 48000 -ac 2"
n=0; nxt(){ n=$((n+1)); printf '%s/a%02d.mkv' "$T" $n; }
clip(){ # file start dur   (keeps the clip's own sound)
  ffmpeg -v error -y -ss "$2" -t "$3" -i "$1" -map 0:v -map 0:a -vf "$V" -af apad -t "$3" $ENC "$(nxt)"; }
push(){ # still dur [zoom-per-frame] [extra vf]
  local z=${3:-0.0008} x=${4:-}
  ffmpeg -v error -y -loop 1 -t "$2" -i "$S/$1.jpg" -f lavfi -t "$2" -i anullsrc=r=48000:cl=stereo \
    -vf "scale=1440:-2,zoompan=z='1+$z*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=720x1290:fps=24,crop=720:1280,format=yuv420p,setsar=1$x" \
    -map 0:v -map 1:a -af apad -t "$2" $ENC "$(nxt)"; }
add(){ echo "$1 + $2" | bc -l; }; sub(){ echo "$1 - $2" | bc -l; }
# line durations and start times
for i in $(seq 1 10); do d[$i]=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$A/$(printf 'L%02d' $i).wav"); done
t=$LEAD; for i in $(seq 1 10); do st[$i]=$t; s[$i]=$(add "${d[$i]}" $GAP); t=$(add "$t" "${s[$i]}"); [ $i = 7 ] && t=$(add "$t" $WHITE); done
D=$(printf '%.2f' "$(add "$(sub "$t" $GAP)" $CARD)"); echo "total $D s"
# ---- picture, line by line ----
L1=$(add $LEAD "${s[1]}");  clip "$P3/clips/09.mp4" 0 2.5;  push s09_rahu_c "$(sub "$L1" 2.5)"            # L1 hook: the sly glance
clip "$P3/clips/07.mp4" 0 3.0;  push s02b_row_b "$(sub "${s[2]}" 3.0)"                                     # L2 Mohini pours; he sits between Surya and Chandra
push s03_drop_a "$(sub "${s[3]}" 3.1)";  clip "$P/clips/03.mp4" 2.7 3.1                                  # L3 one drop; he swallows
h=$(echo "${s[4]}/2" | bc -l); push s04a_surya_a "$h" 0.0015; push s04b_chandra_a "$(sub "${s[4]}" "$h")" 0.0015   # L4 Surya + Chandra recognise him
push s05a_point_a 0.7 0.0015; push s05b_caught_a "$(sub "${s[5]}" 0.7)" 0.0015                           # L5 "He's an Asura!"
# L6 Mohini dissolves into Vishnu (ep3 clip 06 tail, 0.5 s dissolve), then the disc spins and flies left (clean 0.4-3.2 s)
l6=$(sub "${s[6]}" 0.5)
ffmpeg -v error -y -ss 2.0 -t 1.0 -i "$P3/clips/06.mp4" -ss 0.4 -t "$l6" -i "$P/clips/06.mp4" -filter_complex \
  "[0:v]$V[a];[1:v]$V[b];[a][b]xfade=transition=fade:duration=0.5:offset=0.5[v];[0:a]atrim=0:0.75,afade=t=out:st=0.25:d=0.5,apad=pad_dur=0[x];[1:a]adelay=500|500[y];[x][y]amix=inputs=2:normalize=0,apad[aud]" \
  -map "[v]" -map "[aud]" -t "${s[6]}" $ENC "$(nxt)"
L7=$(add "${s[7]}" $WHITE); push s07_ring_a "$L7" 0.0012 ",fade=t=out:st=$(sub "${s[7]}" 0.6):d=0.6:color=white"   # L7 ring of light, cut to white
push s08_head_a "${s[8]}" 0.0006                                                                          # L8 the immortal head
# L9 the shadow moves over the sun: a soft black disc slides from the left edge onto the sun (sun centred ~(360,630) at 720x1280)
ffmpeg -v error -y -f lavfi -i "color=black:s=170x170,format=rgba,geq=r=0:g=0:b=0:a='255*clip((85-hypot(X-85,Y-85))/3,0,1)'" -frames:v 1 "$T/disc.png"
l9=${s[9]}
ffmpeg -v error -y -loop 1 -t "$l9" -i "$S/s09_sun_a.jpg" -loop 1 -t "$l9" -i "$T/disc.png" -f lavfi -t "$l9" -i anullsrc=r=48000:cl=stereo \
  -filter_complex "[0:v]$V[bg];[bg][1:v]overlay=x='-170+(360+85)*min(t/($l9-0.3),1)':y=630-85:shortest=1,format=yuv420p[v]" \
  -map "[v]" -map 2:a -t "$l9" $ENC "$(nxt)"
push s10_diamond_a "$(add "${s[10]}" $CARD)" 0.0005 ",fade=t=in:d=0.3"                                    # L10 + end card
# ---- sound effects (Earshot, soft; peak lands on the cut) ----
E=~/.local/opt/earshot-venv/bin/earshot; fx=(); fi_=0
cue(){ # id peak-time(s) cue-time(s) volume
  local f="$P/sfx/$(echo "$1" | tr '/' '_').wav"; [ -f "$f" ] || "$E" sfx render "$1" -o "$f" >/dev/null
  local ms; ms=$(printf '%.0f' "$(echo "($3-$2)*1000" | bc -l)"); [ "$ms" -lt 0 ] && ms=0
  fx+=("$f|$ms|$4"); }
cue pro_impact/deep 0.213 "${st[1]}" 0.10
cue mallet/glock 0.011 "${st[4]}" 0.08; cue mallet/glock 0.011 "$(add "${st[4]}" "$h")" 0.08
cue fit/whoosh.short/bamboo_swish 0.130 "$(add "${st[5]}" 0.7)" 0.08
cue riser/swell 2.192 "$(add "${st[6]}" 2.8)" 0.08
cue pro_impact/swell 0.456 "$(add "${st[7]}" "${s[7]}")" 0.10
cue impact/deep 0.084 "${st[8]}" 0.07
cue fit/bell/small_bell 0.062 "$(add "${st[10]}" 0.3)" 0.07
cue shimmer/m1 0.705 "$(add "${st[10]}" "${s[10]}")" 0.07
# ---- mix + captions ----
segs=$(ls "$T"/a*.mkv); in=""; fc=""; i=0
for g in $segs; do in="$in -i $g"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done; nseg=$i
C=$R/captions-ep4.ass; sed -n '1,15p' $R/captions-ep1.ass | sed 's/^Style: Brand,Noto Serif,40,\(.*\),100,100,2,/Style: Brand,Noto Serif Telugu,40,\1,100,100,0,/' > $C
ts(){ awk -v t="$1" 'BEGIN{m=int(t/60); printf "0:%02d:%05.2f", m, t-60*m}'; }
vin=""; vf=""; mix=""; k=0
for i in $(seq 1 10); do idx=$((nseg+1+k)); ms=$(printf '%.0f' "$(echo "${st[$i]}*1000" | bc -l)")
  vin="$vin -i $A/$(printf 'L%02d' $i).wav"; vf="$vf[$idx:a]adelay=${ms}|${ms}[n$k];"; mix="$mix[n$k]"
  txt=$(sed -n "${i}p" $R/narration-ep4.txt); echo "Dialogue: 0,$(ts "${st[$i]}"),$(ts "$(add "${st[$i]}" "$(add "${d[$i]}" 0.25)")"),Cap,,0,0,0,,$txt" >> $C; k=$((k+1)); done
for f in "${fx[@]}"; do IFS='|' read -r w ms vol <<< "$f"; idx=$((nseg+1+k)); vin="$vin -i $w"
  vf="$vf[$idx:a]aformat=sample_rates=48000:channel_layouts=stereo,adelay=${ms}|${ms},volume=$vol[n$k];"; mix="$mix[n$k]"; k=$((k+1)); done
E1=$(add "${st[10]}" "$(add "${d[10]}" 0.3)")
{ echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Title,,0,0,0,,{\\pos(540,1330)\\fad(400,0)}సముద్ర మథనం"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Sub,,0,0,0,,{\\pos(540,1480)\\fs60\\fad(400,0)}సమాప్తం · ఓం నమో నారాయణాయ"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Brand,,0,0,0,,{\\pos(540,1600)\\fad(400,0)}UmaAI Studio"; } >> $C
T7=$(printf '%.2f' "$(add "${st[7]}" "${s[7]}")")
ffmpeg -v error -y $in -stream_loop -1 -i "$P3/clips/06.mp4" $vin -filter_complex \
  "${fc}concat=n=$nseg:v=1:a=1[v][ca];[$nseg:a]atrim=0:$D,asetpts=N/SR/TB,volume=-22dB,afade=t=out:st=$(sub "$T7" 1.0):d=1.0[bed];[ca]volume=-11dB[cl];${vf}${mix}amix=inputs=$k:normalize=0[vo];[vo][cl][bed]amix=inputs=3:normalize=0:duration=longest,afade=t=out:st=$(sub "$D" 1.2):d=1.2,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 16 -c:a aac -b:a 160k -t "$D" "$O/ep4-cut.mp4"
rm -rf "$T"
GRADE_SCALE=1080:1920 bash scripts/grade.sh $O/ep4-cut.mp4 $O/ep4-graded.mp4 1.0 rose >/dev/null 2>&1
F=$O/ep4-rahu.mp4
ffmpeg -y -v error -i $O/ep4-graded.mp4 -i $O/ep4-cut.mp4 -vf "ass=$C:shaping=complex,scale=out_range=tv,format=yuv420p" -map 0:v -map 1:a \
  -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -color_range tv -c:a copy -shortest $F
ffmpeg -y -v error -i $F -vf "scale=720:1280:flags=lanczos:out_range=tv,format=yuv420p" -c:v libx264 -profile:v main -preset veryfast \
  -b:v 1.3M -maxrate 1.8M -bufsize 3M -color_range tv -c:a aac -b:a 128k -movflags +faststart $O/ep4-rahu-phone.mp4
cd $O; ffmpeg -y -v error -i ep4-rahu.mp4 -c:v libx264 -preset medium -b:v 1.6M -pass 1 -passlogfile ep4pass -an -f null /dev/null
ffmpeg -y -v error -i ep4-rahu.mp4 -c:v libx264 -preset medium -b:v 1.6M -pass 2 -passlogfile ep4pass -pix_fmt yuv420p -color_range tv \
  -c:a aac -b:a 128k -movflags +faststart ep4-rahu-upload-10mb.mp4; rm -f ep4pass*
echo EP4_FINAL_DONE
