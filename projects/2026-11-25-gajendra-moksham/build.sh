#!/usr/bin/env bash
# Gajendra Moksham Ep 1 / Ep 2 cut, 27 Nov 2026 (0 credits: existing clips + free still zooms).
# Narration = Gemini TTS Achird (media/epN/audio-draft/L01..L09.wav), trimmed + 1.08x like Tripurasura (owner option 3, 18 Nov).
# Sound = narration + each clip's own Veo sound (-11 dB) + a very low bed looped from one clip. NO music.
# -> rose grade 1080x1920 -> Telugu captions + end card -> phone copy (720p) + upload copy.
# Run OUTSIDE 09:00-15:35: bash projects/2026-11-25-gajendra-moksham/build.sh 1   (or 2; SEGCHECK=1 = timings only)
set -euo pipefail
cd "$(dirname "$0")/../.."
EP=${1:?episode 1 or 2}
R=projects/2026-11-25-gajendra-moksham; P=$R/media/ep$EP; AD=$P/audio-draft; TEMPO=${TEMPO:-1.08}; A=$P/audio-t$TEMPO; O=$R/media/out
S=$R/media/stills; K=$R/media/clips
T=$(mktemp -d); mkdir -p "$O" "$A"; GAP=${GAP:-0.25}; LEAD=0.15; CARD=${CARD:-2.0}; N=9
V="scale=720:1280:force_original_aspect_ratio=increase,crop=720:1280,fps=24,format=yuv420p,setsar=1"
ENC="-c:v libx264 -preset veryfast -crf 20 -c:a pcm_s16le -ar 48000 -ac 2"
echo 0 > "$T/n"; nxt(){ local n=$(( $(cat "$T/n") + 1 )); echo $n > "$T/n"; printf '%s/a%02d.mkv' "$T" $n; }
clip(){ # file start dur   (keeps the clip's own sound)
  ffmpeg -v error -y -ss "$2" -t "$3" -i "$1" -map 0:v -map 0:a -vf "$V" -af apad -t "$3" $ENC "$(nxt)"; }
hold(){ # file start usable slot  -> clip, then its last frame held (for the ffmpeg zoom clips)
  ffmpeg -v error -y -ss "$2" -t "$3" -i "$1" -map 0:v -map 0:a -vf "$V,tpad=stop_mode=clone:stop_duration=20" -af apad -t "$4" $ENC "$(nxt)"; }
push(){ # still dur [zoom-per-frame]   slow centred push-in on a still, silent track
  local z=${3:-0.0005}
  ffmpeg -v error -y -loop 1 -t "$2" -i "$S/$1.jpg" -f lavfi -t "$2" -i anullsrc=r=48000:cl=stereo \
    -vf "scale=1440:-2,zoompan=z='1+$z*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=720x1290:fps=24,crop=720:1280,format=yuv420p,setsar=1" \
    -map 0:v -map 1:a -af apad -t "$2" $ENC "$(nxt)"; }
add(){ printf '%.4f' "$(echo "$1 + $2" | bc -l)"; }; sub(){ printf '%.4f' "$(echo "$1 - $2" | bc -l)"; }
lt(){ [ "$(echo "$1 < $2" | bc -l)" = 1 ]; }
fit(){ # clipfile start usable slot still   -> clip for min(usable,slot), then the still for the rest
  if lt "$3" "$4"; then clip "$1" "$2" "$3"; push "$5" "$(sub "$4" "$3")" 0.0004; else clip "$1" "$2" "$4"; fi; }
# trim TTS lead/tail silence (once)
for i in $(seq 1 $N); do f=$(printf 'L%02d.wav' $i); [ -f "$A/$f" ] && continue
  ffmpeg -v error -y -i "$AD/$f" -af "silenceremove=start_periods=1:start_threshold=-45dB,areverse,silenceremove=start_periods=1:start_threshold=-45dB,areverse,atempo=$TEMPO,adelay=50|50,apad=pad_dur=0.12" -ar 48000 -ac 2 "$A/$f"; done
for i in $(seq 1 $N); do d[$i]=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$A/$(printf 'L%02d' $i).wav"); done
t=$LEAD; for i in $(seq 1 $N); do st[$i]=$t; s[$i]=$(add "${d[$i]}" $GAP); t=$(add "$t" "${s[$i]}"); done
D=$(printf '%.2f' "$(add "$(sub "$t" $GAP)" $CARD)"); echo "total $D s"; for i in $(seq 1 $N); do echo "L$i ${st[$i]} +${s[$i]}"; done
[ -n "${SEGCHECK:-}" ] && { rm -rf "$T"; exit 0; }
# ---- picture, line by line (usable ranges from the 25-26 Nov reviews in log.md) ----
if [ "$EP" = 1 ]; then
  BED=$K/1-02.mp4; TITLE="గజేంద్ర మోక్షం"; SUB="భాగం 1 · తర్వాతి భాగం: శరణు"; F=$O/ep1-gajendra
  fit "$K/1-01.mp4" 0 5.0 "$(add $LEAD "${s[1]}")" s1-01_c     # L1 hook: jaws on the leg
  fit "$K/1-02.mp4" 0 7.9 "${s[2]}" s1-02_b                    # L2 Trikuta, the lake
  fit "$K/1-03.mp4" 0 6.3 "${s[3]}" s1-03_a                    # L3 herd plays, trunk spray
  fit "$K/1-04_slow.mp4" 0 4.98 "${s[4]}" s1-04_a              # L4 pulls, croc under water
  push s1-05_a "${s[5]}" 0.0006                                # L5 herd on the shore (free zoom)
  fit "$K/1-06.mp4" 0 4.0 "${s[6]}" s1-06_a                    # L6 sun and moon: a thousand years
  fit "$K/1-07.mp4" 2.0 5.9 "${s[7]}" s1-07_a                  # L7 weaker: the eye
  push s1-08_a "$(add "$(add "${s[8]}" "${s[9]}")" $CARD)" 0.0004   # L8-L9 trunk to the sky + end card (free zoom)
else
  BED=$K/2-06.mp4; TITLE="గజేంద్ర మోక్షం"; SUB="భాగం 2 · తర్వాతి భాగం: మోక్షం"; F=$O/ep2-gajendra
  fit "$K/2-01.mp4" 1.5 6.4 "$(add $LEAD "${s[1]}")" s2-01_b   # L1 hook: beam onto the trunk
  push s2-02_b "$(add "${s[2]}" "${s[3]}")" 0.0004             # L2-L3 the prayer (free zoom)
  push s2-03_c "${s[4]}" 0.0004                                # L4 Anantashayana, asleep (free zoom, L4 length)
  hold "$K/2-04_zoom.mp4" 0 5.0 "${s[5]}"                      # L5 eyes open, rises (free zoom + crossfade)
  fit "$K/2-05.mp4" 0 4.7 "${s[6]}" s2-05_a                    # L6 mounts Garuda
  fit "$K/2-06.mp4" 0 2.6 "${s[7]}" s2-06_a                    # L7 tearing through the clouds
  hold "$K/2-07_zoom.mp4" 0 6.0 "${s[8]}"                      # L8 chakra blazes (free zoom + glow)
  hold "$K/2-08.mp4" 0 3.7 "$(add "${s[9]}" $CARD)"            # L9 chakra flies + end card on its last clean frame
fi
# ---- mix + captions ----
segs=$(ls "$T"/a*.mkv); in=""; fc=""; i=0
for g in $segs; do in="$in -i $g"; fc="$fc[$i:v][$i:a]"; i=$((i+1)); done; nseg=$i
C=$R/captions-ep$EP.ass; sed -n '1,15p' projects/2026-11-09-samudra-manthan/captions-ep4.ass > $C
ts(){ awk -v t="$1" 'BEGIN{m=int(t/60); printf "0:%02d:%05.2f", m, t-60*m}'; }
vin=""; vf=""; mix=""; k=0
for i in $(seq 1 $N); do idx=$((nseg+1+k)); ms=$(printf '%.0f' "$(echo "${st[$i]}*1000" | bc -l)")
  vin="$vin -i $A/$(printf 'L%02d' $i).wav"; vf="$vf[$idx:a]adelay=${ms}|${ms}[n$k];"; mix="$mix[n$k]"
  txt=$(sed -n "${i}p" $R/narration-ep$EP.txt); echo "Dialogue: 0,$(ts "${st[$i]}"),$(ts "$(add "${st[$i]}" "$(add "${d[$i]}" 0.25)")"),Cap,,0,0,0,,$txt" >> $C; k=$((k+1)); done
E1=$(add "${st[$N]}" "$(add "${d[$N]}" 0.3)")
{ echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Title,,0,0,0,,{\\pos(540,1330)\\fs110\\fad(400,0)}$TITLE"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Sub,,0,0,0,,{\\pos(540,1480)\\fs60\\fad(400,0)}$SUB"
  echo "Dialogue: 0,$(ts "$E1"),$(ts "$D"),Brand,,0,0,0,,{\\pos(540,1600)\\fad(400,0)}UmaAI Studio"; } >> $C
ffmpeg -v error -y $in -stream_loop -1 -i "$BED" $vin -filter_complex \
  "${fc}concat=n=$nseg:v=1:a=1[v][ca];[$nseg:a]atrim=0:$D,asetpts=N/SR/TB,volume=-24dB[bed];[ca]volume=-11dB[cl];${vf}${mix}amix=inputs=$k:normalize=0[vo];[vo][cl][bed]amix=inputs=3:normalize=0:duration=longest,afade=t=out:st=$(sub "$D" 1.2):d=1.2,alimiter=limit=0.84:level=disabled,loudnorm=I=-16:TP=-1.5[a]" \
  -map "[v]" -map "[a]" -c:v libx264 -preset veryfast -crf 16 -c:a aac -b:a 160k -t "$D" "$F-cut.mp4"
rm -rf "$T"
GRADE_SCALE=1080:1920 bash scripts/grade.sh "$F-cut.mp4" "$F-graded.mp4" 1.0 rose >/dev/null 2>&1
ffmpeg -y -v error -i "$F-graded.mp4" -i "$F-cut.mp4" -vf "ass=$C:shaping=complex,scale=out_range=tv,format=yuv420p" -map 0:v -map 1:a \
  -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -color_range tv -c:a copy -shortest "$F.mp4"
ffmpeg -y -v error -i "$F.mp4" -vf "scale=720:1280:flags=lanczos:out_range=tv,format=yuv420p" -c:v libx264 -profile:v main -preset veryfast \
  -b:v 1.3M -maxrate 1.8M -bufsize 3M -color_range tv -c:a aac -b:a 128k -movflags +faststart "$F-phone.mp4"
echo "EP${EP}_DONE $D s"; ls -la "$F"*.mp4
