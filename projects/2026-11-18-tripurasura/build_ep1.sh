#!/usr/bin/env bash
# Tripurasura Ep 1 (మూడు పురాలు), 18 Nov 2026: cut fitted to the AI narration -> soft Earshot effects in the same mix
# -> rose grade 1080x1920 -> Telugu captions + end card -> phone copy (720p tv-range) + upload copy (<10 MB).
# Voice = Gemini TTS Achird: media/ep1/audio-draft/L01..L10.wav, trimmed here into media/ep1/audio/ (lead 0.05, tail 0.12 s).
# Clips: 01 cities, 06 Maya, 09 iron city's shadow (clean ranges below, from the 3 fps review). Rest = still push-ins.
# Run OUTSIDE 09:00-15:35: bash projects/2026-11-18-tripurasura/build_ep1.sh   (SEGCHECK=1 = segments only)
set -euo pipefail
cd "$(dirname "$0")/../.."
R=projects/2026-11-18-tripurasura; P=$R/media/ep1; AD=$P/audio-draft; TEMPO=${TEMPO:-1.08}; A=$P/audio-t$TEMPO; O=$P/out; S=$P/stills; K=$P/clips
T=$(mktemp -d); mkdir -p "$O" "$P/sfx" "$A"; GAP=${GAP:-0.25}; LEAD=0.15; CARD=${CARD:-2.0}   # owner 18 Nov: option 3 (1.08x, 0.25 s gaps, 2.0 s card)
# clean clip ranges: start and usable length (s); a slot longer than the usable part is filled with the clip's still
# 18 Nov review: 01 clean 0-6.0 s; 06 FAIL (lightning from 1.3 s) -> still only; 09 FAIL, 2.5-4.5 s usable (Devas look up).
# Owner: "Use free zooms" (no re-rolls; Ep 1 credits end at 30).
C01S=${C01S:-0.0}; C01L=${C01L:-6.0}; C09S=${C09S:-2.5}; C09L=${C09L:-2.0}
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
ENC="-c:v libx264 -preset veryfast -crf 20 -c:a pcm_s16le -ar 48000 -ac 2"
echo 0 > "$T/n"; nxt(){ local n=$(( $(cat "$T/n") + 1 )); echo $n > "$T/n"; printf '%s/a%02d.mkv' "$T" $n; }
clip(){ # file start dur   (keeps the clip's own sound)
  ffmpeg -v error -y -ss "$2" -t "$3" -i "$1" -map 0:v -map 0:a -vf "$V" -af apad -t "$3" $ENC "$(nxt)"; }
push(){ # still dur [zoom-per-frame] [extra vf]
  local z=${3:-0.0008} x=${4:-}
  ffmpeg -v error -y -loop 1 -t "$2" -i "$S/$1.jpg" -f lavfi -t "$2" -i anullsrc=r=48000:cl=stereo \
    -vf "scale=1440:-2,zoompan=z='1+$z*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=720x1290:fps=24,crop=720:1280,format=yuv420p,setsar=1$x,format=yuv420p" \
    -map 0:v -map 1:a -af apad -t "$2" $ENC "$(nxt)"; }
add(){ printf '%.4f' "$(echo "$1 + $2" | bc -l)"; }; sub(){ printf '%.4f' "$(echo "$1 - $2" | bc -l)"; }
lt(){ [ "$(echo "$1 < $2" | bc -l)" = 1 ]; }
fit(){ # clipfile start usable slot still   -> clip for min(usable,slot), then the still for the rest
  if lt "$3" "$4"; then clip "$1" "$2" "$3"; push "$5" "$(sub "$4" "$3")" 0.0006; else clip "$1" "$2" "$4"; fi; }
# trim TTS lead/tail silence (once)
for i in $(seq 1 10); do f=$(printf 'L%02d.wav' $i); [ -f "$A/$f" ] && continue
  ffmpeg -v error -y -i "$AD/$f" -af "silenceremove=start_periods=1:start_threshold=-45dB,areverse,silenceremove=start_periods=1:start_threshold=-45dB,areverse,atempo=$TEMPO,adelay=50|50,apad=pad_dur=0.12" -ar 48000 -ac 2 "$A/$f"; done
for i in $(seq 1 10); do d[$i]=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$A/$(printf 'L%02d' $i).wav"); done
t=$LEAD; for i in $(seq 1 10); do st[$i]=$t; s[$i]=$(add "${d[$i]}" $GAP); t=$(add "$t" "${s[$i]}"); done
D=$(printf '%.2f' "$(add "$(sub "$t" $GAP)" $CARD)"); echo "total $D s"; for i in $(seq 1 10); do echo "L$i ${st[$i]} +${s[$i]}"; done
# ---- picture, line by line ----
fit "$K/01.mp4" $C01S $C01L "$(add $LEAD "${s[1]}")" s01_cities_a      # L1 hook: gold, silver, iron cities
push s02_brothers_b "${s[2]}"                                           # L2 Tarakasura's three sons
push s03_tapas_b "${s[3]}" 0.0006                                       # L3 tapas
push s04_brahma_c "${s[4]}"                                             # L4 Brahma refuses
push s05_smile_a "${s[5]}" 0.0015                                       # L5 a strange boon (sly smile)
push s06_maya_a "${s[6]}" 0.0010                                        # L6 Maya builds the cities (clip 06 failed)
push s07_align_a "${s[7]}" 0.0006                                       # L7 once in a thousand years
push s08_vision_a "${s[8]}" 0.0012                                      # L8 one single arrow
push s09_shadow_a "$(sub "${s[9]}" $C09L)" 0.0008; clip "$K/09.mp4" $C09S $C09L   # L9 tormented the worlds: still, then the Devas look up
push s10_peak_a "$(add "${s[10]}" $CARD)" 0.0005 ",fade=t=in:d=0.3"    # L10 teaser + end card
if [ -n "${SEGCHECK:-}" ]; then for g in "$T"/a*.mkv; do echo "$(basename $g) $(ffprobe -v error -show_entries format=duration -of csv=p=0 $g)"; done; rm -rf "$T"; exit 0; fi
# ---- sound effects (Earshot, soft; peak lands on the cut) ----
E=~/.local/opt/earshot-venv/bin/earshot; fx=()
cue(){ # id peak-time(s) cue-time(s) volume
  local f="$P/sfx/$(echo "$1" | tr '/' '_').wav"; [ -f "$f" ] || "$E" sfx render "$1" -o "$f" >/dev/null
  local ms; ms=$(printf '%.0f' "$(echo "($3-$2)*1000" | bc -l)"); [ "$ms" -lt 0 ] && ms=0
  fx+=("$f|$ms|$4"); }
cue pro_impact/deep 0.213 "${st[1]}" 0.10                 # hook
cue shimmer/m1 0.705 "${st[4]}" 0.07                      # Brahma appears
cue mallet/glock 0.011 "${st[5]}" 0.07                    # the sly smile
cue riser/swell 2.192 "${st[8]}" 0.07                     # into "one single arrow"
cue pro_impact/swell 0.456 "$(add "${st[8]}" 1.6)" 0.08   # on "బాణంతో"
cue fit/bell/small_bell 0.062 "${st[10]}" 0.07            # the silhouette
cue shimmer/m1 0.705 "$(add "${st[10]}" "${s[10]}")" 0.07 # into the end card
# ---- mix + captions ----
segs=$(ls "$T"/a*.mkv); in=""; fc=""; i=0
for g in $segs; do in="$in -i $g"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done; nseg=$i
C=$R/captions-ep1.ass; sed -n '1,15p' projects/2026-11-09-samudra-manthan/captions-ep4.ass > $C
ts(){ awk -v t="$1" 'BEGIN{m=int(t/60); printf "0:%02d:%05.2f", m, t-60*m}'; }
vin=""; vf=""; mix=""; k=0
for i in $(seq 1 10); do idx=$((nseg+1+k)); ms=$(printf '%.0f' "$(echo "${st[$i]}*1000" | bc -l)")
  vin="$vin -i $A/$(printf 'L%02d' $i).wav"; vf="$vf[$idx:a]adelay=${ms}|${ms}[n$k];"; mix="$mix[n$k]"
  txt=$(sed -n "${i}p" $R/narration-ep1.txt); echo "Dialogue: 0,$(ts "${st[$i]}"),$(ts "$(add "${st[$i]}" "$(add "${d[$i]}" 0.25)")"),Cap,,0,0,0,,$txt" >> $C; k=$((k+1)); done
for f in "${fx[@]}"; do IFS='|' read -r w ms vol <<< "$f"; idx=$((nseg+1+k)); vin="$vin -i $w"
  vf="$vf[$idx:a]aformat=sample_rates=48000:channel_layouts=stereo,adelay=${ms}|${ms},volume=$vol[n$k];"; mix="$mix[n$k]"; k=$((k+1)); done
E1=$(add "${st[10]}" "$(add "${d[10]}" 0.3)")
{ echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Title,,0,0,0,,{\\pos(540,1330)\\fs110\\fad(400,0)}త్రిపురాసుర సంహారం"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Sub,,0,0,0,,{\\pos(540,1480)\\fs60\\fad(400,0)}భాగం 1 · తర్వాతి భాగం: దివ్య రథం"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Brand,,0,0,0,,{\\pos(540,1600)\\fad(400,0)}UmaAI Studio"; } >> $C
# sound bed = clip 01's own wind, looped, very low
ffmpeg -v error -y $in -stream_loop -1 -i "$K/01.mp4" $vin -filter_complex \
  "${fc}concat=n=$nseg:v=1:a=1[v][ca];[$nseg:a]atrim=0:$D,asetpts=N/SR/TB,volume=-24dB[bed];[ca]volume=-11dB[cl];${vf}${mix}amix=inputs=$k:normalize=0[vo];[vo][cl][bed]amix=inputs=3:normalize=0:duration=longest,afade=t=out:st=$(sub "$D" 1.2):d=1.2,alimiter=limit=0.84:level=disabled,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 16 -c:a aac -b:a 160k -t "$D" "$O/ep1-cut.mp4"
rm -rf "$T"
GRADE_SCALE=1080:1920 bash scripts/grade.sh $O/ep1-cut.mp4 $O/ep1-graded.mp4 1.0 rose >/dev/null 2>&1
F=$O/ep1-moodu-puralu.mp4
ffmpeg -y -v error -i $O/ep1-graded.mp4 -i $O/ep1-cut.mp4 -vf "ass=$C:shaping=complex,scale=out_range=tv,format=yuv420p" -map 0:v -map 1:a \
  -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -color_range tv -c:a copy -shortest $F
ffmpeg -y -v error -i $F -vf "scale=720:1280:flags=lanczos:out_range=tv,format=yuv420p" -c:v libx264 -profile:v main -preset veryfast \
  -b:v 1.3M -maxrate 1.8M -bufsize 3M -color_range tv -c:a aac -b:a 128k -movflags +faststart $O/ep1-moodu-puralu-phone.mp4
cd $O; ffmpeg -y -v error -i ep1-moodu-puralu.mp4 -c:v libx264 -preset medium -b:v 1.5M -pass 1 -passlogfile ep1pass -an -f null /dev/null
ffmpeg -y -v error -i ep1-moodu-puralu.mp4 -c:v libx264 -preset medium -b:v 1.5M -pass 2 -passlogfile ep1pass -pix_fmt yuv420p -color_range tv \
  -c:a aac -b:a 128k -movflags +faststart ep1-moodu-puralu-upload-10mb.mp4; rm -f ep1pass*
echo EP1_FINAL_DONE
