#!/usr/bin/env bash
# Tripurasura Ep 2 (దివ్య రథం), 21 Nov 2026 (copied from build_ep2.sh): cut fitted to the AI narration -> soft Earshot effects in the same mix
# -> rose grade 1080x1920 -> Telugu captions + end card -> phone copy (720p tv-range) + upload copy (<10 MB).
# Voice = Gemini TTS Achird: media/ep2/audio-draft/L01..L09.wav, trimmed here into media/ep2/audio-t1.08/ (lead 0.05, tail 0.12 s).
# Clips: A chariot (L1 + L3), B bull (L8). Rest = still push-ins (Gemini stills, 0 credits, 21 Nov).
# Run OUTSIDE 09:00-15:35: bash projects/2026-11-18-tripurasura/build_ep2.sh   (SEGCHECK=1 = segments only)
set -euo pipefail
cd "$(dirname "$0")/../.."
R=projects/2026-11-18-tripurasura; P=$R/media/ep2; AD=$P/audio-draft; TEMPO=${TEMPO:-1.08}; A=$P/audio-t$TEMPO; O=$P/out; S=$P/stills; K=$P/clips
T=$(mktemp -d); mkdir -p "$O" "$P/sfx" "$A"; GAP=${GAP:-0.25}; LEAD=0.15; CARD=${CARD:-2.0}   # owner 18 Nov: option 3 (1.08x, 0.25 s gaps, 2.0 s card)
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
for i in $(seq 1 9); do f=$(printf 'L%02d.wav' $i); [ -f "$A/$f" ] && continue
  ffmpeg -v error -y -i "$AD/$f" -af "silenceremove=start_periods=1:start_threshold=-45dB,areverse,silenceremove=start_periods=1:start_threshold=-45dB,areverse,atempo=$TEMPO,adelay=50|50,apad=pad_dur=0.12" -ar 48000 -ac 2 "$A/$f"; done
for i in $(seq 1 9); do d[$i]=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$A/$(printf 'L%02d' $i).wav"); done
t=$LEAD; for i in $(seq 1 9); do st[$i]=$t; s[$i]=$(add "${d[$i]}" $GAP); t=$(add "$t" "${s[$i]}"); done
D=$(printf '%.2f' "$(add "$(sub "$t" $GAP)" $CARD)"); echo "total $D s"; for i in $(seq 1 9); do echo "L$i ${st[$i]} +${s[$i]}"; done
# ---- picture, line by line ----
# Clips (21 Nov review): A PASS whole (chariot, slow pull-back); B PASS whole (bull lifts the chariot). L3 = the rest of A
# (a moving clip keeps the Veo watermark whole; a push-in on a clip frame would crop it).
fit "$K/A.mp4" 0.0 4.0 "$(add $LEAD "${s[1]}")" s01_chariot_a        # L1 hook: the universe becomes a chariot
push s02_plea_b "${s[2]}" 0.0008                                       # L2 the Devas plead before Mahadeva
fit "$K/A.mp4" 4.0 3.9 "${s[3]}" s01_chariot_a                         # L3 golden chariot, sun and moon wheels
push s04_brahma_reins_d "${s[4]}" 0.0008                               # L4 four Vedas = horses, Brahma = charioteer
push s05_bow_a "${s[5]}" 0.0006                                        # L5 Meru = bow, Adishesha = string
push s06_arrow_a "${s[6]}" 0.0015                                      # L6 and the arrow? Vishnu, Agni the tip
push s07_kneel_b "${s[7]}" 0.0010                                      # L7 the horses fall to their knees
fit "$K/B.mp4" 0.0 7.9 "${s[8]}" s08_bull_a                            # L8 Vishnu becomes the bull and lifts it
push s09_draw_a "$(add "${s[9]}" $CARD)" 0.0005 ",fade=t=in:d=0.3"     # L9 teaser (Shiva draws the bow) + end card
if [ -n "${SEGCHECK:-}" ]; then for g in "$T"/a*.mkv; do echo "$(basename $g) $(ffprobe -v error -show_entries format=duration -of csv=p=0 $g)"; done; rm -rf "$T"; exit 0; fi
# ---- sound effects (Earshot, soft; peak lands on the cut) ----
E=~/.local/opt/earshot-venv/bin/earshot; fx=()
cue(){ # id peak-time(s) cue-time(s) volume
  local f="$P/sfx/$(echo "$1" | tr '/' '_').wav"; [ -f "$f" ] || "$E" sfx render "$1" -o "$f" >/dev/null
  local ms; ms=$(printf '%.0f' "$(echo "($3-$2)*1000" | bc -l)"); [ "$ms" -lt 0 ] && ms=0
  fx+=("$f|$ms|$4"); }
cue pro_impact/deep 0.213 "${st[1]}" 0.10                 # hook
cue shimmer/m1 0.705 "${st[4]}" 0.07                      # Brahma appears
cue pro_impact/swell 0.456 "${st[6]}" 0.08                # "మరి బాణం?"
cue pro_impact/deep 0.213 "$(add "${st[7]}" 1.2)" 0.08    # the horses fall
cue riser/swell 2.192 "${st[9]}" 0.07                     # into the teaser
cue shimmer/m1 0.705 "$(add "${st[9]}" "${s[9]}")" 0.07   # into the end card
# ---- mix + captions ----
segs=$(ls "$T"/a*.mkv); in=""; fc=""; i=0
for g in $segs; do in="$in -i $g"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done; nseg=$i
C=$R/captions-ep2.ass; sed -n '1,15p' projects/2026-11-09-samudra-manthan/captions-ep4.ass > $C
ts(){ awk -v t="$1" 'BEGIN{m=int(t/60); printf "0:%02d:%05.2f", m, t-60*m}'; }
vin=""; vf=""; mix=""; k=0
for i in $(seq 1 9); do idx=$((nseg+1+k)); ms=$(printf '%.0f' "$(echo "${st[$i]}*1000" | bc -l)")
  vin="$vin -i $A/$(printf 'L%02d' $i).wav"; vf="$vf[$idx:a]adelay=${ms}|${ms}[n$k];"; mix="$mix[n$k]"
  txt=$(sed -n "${i}p" $R/narration-ep2.txt); echo "Dialogue: 0,$(ts "${st[$i]}"),$(ts "$(add "${st[$i]}" "$(add "${d[$i]}" 0.25)")"),Cap,,0,0,0,,$txt" >> $C; k=$((k+1)); done
for f in "${fx[@]}"; do IFS='|' read -r w ms vol <<< "$f"; idx=$((nseg+1+k)); vin="$vin -i $w"
  vf="$vf[$idx:a]aformat=sample_rates=48000:channel_layouts=stereo,adelay=${ms}|${ms},volume=$vol[n$k];"; mix="$mix[n$k]"; k=$((k+1)); done
E1=$(add "${st[9]}" "$(add "${d[9]}" 0.3)")
{ echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Title,,0,0,0,,{\\pos(540,1330)\\fs110\\fad(400,0)}త్రిపురాసుర సంహారం"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Sub,,0,0,0,,{\\pos(540,1480)\\fs60\\fad(400,0)}భాగం 2 · చివరి భాగం: ఒక్క బాణం"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Brand,,0,0,0,,{\\pos(540,1600)\\fad(400,0)}UmaAI Studio"; } >> $C
# sound bed = clip A's own rumble, looped, very low
ffmpeg -v error -y $in -stream_loop -1 -i "$K/A.mp4" $vin -filter_complex \
  "${fc}concat=n=$nseg:v=1:a=1[v][ca];[$nseg:a]atrim=0:$D,asetpts=N/SR/TB,volume=-24dB[bed];[ca]volume=-11dB[cl];${vf}${mix}amix=inputs=$k:normalize=0[vo];[vo][cl][bed]amix=inputs=3:normalize=0:duration=longest,afade=t=out:st=$(sub "$D" 1.2):d=1.2,alimiter=limit=0.84:level=disabled,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 16 -c:a aac -b:a 160k -t "$D" "$O/ep2-cut.mp4"
rm -rf "$T"
GRADE_SCALE=1080:1920 bash scripts/grade.sh $O/ep2-cut.mp4 $O/ep2-graded.mp4 1.0 rose >/dev/null 2>&1
F=$O/ep2-divya-ratham.mp4
ffmpeg -y -v error -i $O/ep2-graded.mp4 -i $O/ep2-cut.mp4 -vf "ass=$C:shaping=complex,scale=out_range=tv,format=yuv420p" -map 0:v -map 1:a \
  -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -color_range tv -c:a copy -shortest $F
ffmpeg -y -v error -i $F -vf "scale=720:1280:flags=lanczos:out_range=tv,format=yuv420p" -c:v libx264 -profile:v main -preset veryfast \
  -b:v 1.3M -maxrate 1.8M -bufsize 3M -color_range tv -c:a aac -b:a 128k -movflags +faststart $O/ep2-divya-ratham-phone.mp4
cd $O; ffmpeg -y -v error -i ep2-divya-ratham.mp4 -c:v libx264 -preset medium -b:v 1.5M -pass 1 -passlogfile ep2pass -an -f null /dev/null
ffmpeg -y -v error -i ep2-divya-ratham.mp4 -c:v libx264 -preset medium -b:v 1.5M -pass 2 -passlogfile ep2pass -pix_fmt yuv420p -color_range tv \
  -c:a aac -b:a 128k -movflags +faststart ep2-divya-ratham-upload-10mb.mp4; rm -f ep2pass*
echo EP2_FINAL_DONE
