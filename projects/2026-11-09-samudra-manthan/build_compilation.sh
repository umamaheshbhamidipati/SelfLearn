#!/usr/bin/env bash
# Samudra Manthan Ep 1-4 compilation for YouTube long-form (16:9, 1920x1080, tv-range yuv420p).
# Each 9:16 master sits in the centre (608x1080, Flow watermark untouched) over a blurred,
# darkened, scaled-up copy of itself. 3 s title card first (title-compilation.ass on a blurred
# Ep 1 frame + a soft swell). Episodes keep their own sound and their end-card teasers.
# Loudness: whole track measured, gain to -16 LUFS, alimiter -1 dBFS with level=disabled.
# Run from this project folder, OUTSIDE 09:00-15:35 IST:  nice -n 19 bash build_compilation.sh
# Env: ONLY=audio|video|copies|check to run one stage; UPLOAD10=0 skips the <=10 MB 1080p copy.
set -euo pipefail
cd "$(dirname "$0")"
M=media; O=$M/compilation; mkdir -p "$O"
EP=("$M/ep1/out/ep1-kurma-voice-sfx.mp4" "$M/ep2/out/ep2-neelakantha.mp4"
    "$M/ep3/out/ep3-amrutham.mp4" "$M/ep4/out/ep4-rahu.mp4")
RANGE=(tv pc tv tv)            # Ep 2's master is full-range (yuvj420p); converted to tv here
TITLE=3.0; FPS=24; TARGET=-16
SWELL=$M/ep4/sfx/riser_swell.wav
OUT=$O/samudra-manthan-full-16x9.mp4
h=$(date +%H%M); if [ "$h" -ge 0900 ] && [ "$h" -lt 1535 ] && [ "${FORCE:-0}" != 1 ]; then
  echo "09:00-15:35 IST: Kite bot hours, no encoding. (FORCE=1 to override)"; exit 1; fi
stage() { [ -z "${ONLY:-}" ] || [ "$ONLY" = "$1" ]; }

# exact frame-rounded video length of each episode
dur=(); for f in "${EP[@]}"; do
  n=$(ffprobe -v error -select_streams v:0 -count_packets -show_entries stream=nb_read_packets -of csv=p=0 "$f")
  dur+=("$(printf '%.6f' "$(echo "$n/$FPS" | bc -l)")"); done
echo "episode lengths: ${dur[*]}"
t=$TITLE; echo "chapters:"; for i in 0 1 2 3; do
  s=${t%.*}; printf '  Ep %d starts at %.2f s (%d:%02d)\n' $((i+1)) "$t" $((s/60)) $((s%60))
  t=$(echo "$t+${dur[$i]}" | bc -l); done; printf '  end %.2f s\n' "$t"

# ---- stage 1: audio (concat, measure, gain, limiter) ----
if stage audio; then
  in=(); fc="anullsrc=r=48000:cl=stereo,atrim=0:$TITLE[sil];"
  in+=(-i "$SWELL"); fc+="[0:a]aresample=48000,aformat=channel_layouts=stereo,volume=0.12,adelay=600|600,afade=t=in:d=0.4[sw];"
  fc+="[sil][sw]amix=inputs=2:duration=first:normalize=0,afade=t=out:st=$(echo "$TITLE-0.5"|bc):d=0.5[a0];"
  for i in 0 1 2 3; do in+=(-i "${EP[$i]}"); k=$((i+1)); d=${dur[$i]}
    fc+="[$k:a]aresample=48000,aformat=sample_fmts=fltp:channel_layouts=stereo,apad,atrim=0:$d,asetpts=N/SR/TB,afade=t=in:d=0.03,afade=t=out:st=$(echo "$d-0.05"|bc -l):d=0.05[a$k];"; done
  fc+="[a0][a1][a2][a3][a4]concat=n=5:v=0:a=1[a]"
  ffmpeg -y -v error "${in[@]}" -filter_complex "$fc" -map "[a]" -c:a pcm_f32le "$O/audio-raw.wav"
  I=$(ffmpeg -nostats -hide_banner -i "$O/audio-raw.wav" -af ebur128=peak=true -f null - 2>&1 | awk '/Integrated loudness/{f=1} f&&/I:/{print $2; exit}')
  g=$(echo "$TARGET - ($I)" | bc -l); echo "raw $I LUFS -> gain $g dB"
  ffmpeg -y -v error -i "$O/audio-raw.wav" -af "volume=${g}dB,alimiter=limit=0.891:attack=5:release=50:level=disabled" -c:a pcm_s16le "$O/audio-final.wav"
  ffmpeg -nostats -hide_banner -i "$O/audio-final.wav" -af ebur128=peak=true -f null - 2>&1 | grep -E "^\s+(I|LRA|Peak):"
fi

# ---- stage 2: video (title + 4 episodes, centred over blurred self) ----
BG="scale=320:-2,crop=320:180,boxblur=10:2,lutyuv=y='16+(val-16)*0.42':u='128+(val-128)*0.8':v='128+(val-128)*0.8',scale=1920:1080:flags=bicubic,setsar=1"
FG="scale=608:1080:flags=lanczos,setsar=1"
if stage video; then
  ffmpeg -y -v error -ss 1.0 -i "${EP[0]}" -frames:v 1 "$O/title-plate.png"
  in=(-loop 1 -framerate $FPS -t $TITLE -i "$O/title-plate.png"); fc=""
  fc+="[0:v]format=yuv420p,$BG,lutyuv=y='16+(val-16)*0.7',ass=title-compilation.ass,fade=t=in:d=0.5,trim=0:$TITLE,setpts=PTS-STARTPTS,format=yuv420p[v0];"
  for i in 0 1 2 3; do in+=(-i "${EP[$i]}"); k=$((i+1))
    fc+="[$k:v]trim=0:${dur[$i]},setpts=PTS-STARTPTS,fps=$FPS,scale=in_range=${RANGE[$i]}:out_range=tv,format=yuv420p,split[b$k][f$k];"
    fc+="[b$k]$BG[bb$k];[f$k]$FG[ff$k];[bb$k][ff$k]overlay=656:0,format=yuv420p[v$k];"; done
  fc+="[v0][v1][v2][v3][v4]concat=n=5:v=1:a=0[v]"
  in+=(-i "$O/audio-final.wav"); ai=$(( ${#EP[@]} + 1 ))
  ffmpeg -y -hide_banner -stats_period 30 "${in[@]}" -filter_complex "$fc" -map "[v]" -map $ai:a \
    -c:v libx264 -preset medium -crf 20 -pix_fmt yuv420p -color_range tv -colorspace bt709 -color_primaries bt709 -color_trc bt709 \
    -c:a aac -b:a 192k -ar 48000 -movflags +faststart -shortest "$OUT"
fi

# ---- stage 3: phone copy (720p, <10 MB) and <=10 MB 1080p upload fallback ----
two_pass() { # in out scale vkbps
  local P="$O/2pass-$(basename "$2" .mp4)"
  ffmpeg -y -v error -i "$1" -vf "scale=$3:flags=lanczos,format=yuv420p" -c:v libx264 -preset medium -b:v "$4"k -pass 1 -passlogfile "$P" -an -f null /dev/null
  ffmpeg -y -v error -i "$1" -vf "scale=$3:flags=lanczos,format=yuv420p" -c:v libx264 -preset medium -b:v "$4"k -pass 2 -passlogfile "$P" \
    -color_range tv -colorspace bt709 -color_primaries bt709 -color_trc bt709 -c:a aac -b:a 64k -movflags +faststart "$2"
  rm -f "$P"*; ls -l "$2"; }
if stage copies; then
  two_pass "$OUT" "$O/samudra-manthan-full-phone.mp4" 1280:720 360
  [ "${UPLOAD10:-1}" = 0 ] || two_pass "$OUT" "$O/samudra-manthan-full-upload-10mb.mp4" 1920:1080 380
fi

# ---- stage 4: checks (frame sheet, loudness, format) ----
if stage check; then
  mkdir -p "$O/review"
  ffmpeg -y -v error -i "$OUT" -vf "fps=1/8,scale=384:216,tile=4x6:padding=4" -frames:v 1 "$O/review/sheet.jpg"
  # one frame 1.5 s into each episode at full size (watermark check)
  t=$TITLE; for i in 0 1 2 3; do ffmpeg -y -v error -ss "$(echo "$t+1.5"|bc -l)" -i "$OUT" -frames:v 1 -vf scale=960:540 "$O/review/ep$((i+1))-start.jpg"; t=$(echo "$t+${dur[$i]}"|bc -l); done
  ffprobe -v error -show_entries stream=codec_name,width,height,pix_fmt,color_range:format=duration,size -of compact "$OUT"
  ffmpeg -nostats -hide_banner -i "$OUT" -af ebur128=peak=true -f null - 2>&1 | grep -E "^\s+(I|Peak):"
fi
