#!/usr/bin/env bash
# Add a voiceover and/or background music to a video, then normalise loudness for YouTube (-14 LUFS).
# Music is looped/trimmed to the video length and kept quiet under the clip sound and voice.
# Usage: scripts/add-audio.sh in.mp4 out.mp4 [--voice voice.mp3] [--music music.mp3] [--music-vol 0.15] [--mute-clip]
set -euo pipefail

in="${1:?usage: scripts/add-audio.sh in.mp4 out.mp4 [--voice f] [--music f] [--music-vol 0.15] [--mute-clip]}"
out="${2:?missing out.mp4}"; shift 2
voice=""; music=""; mvol="0.15"; mute=0
while (( $# )); do
  case "$1" in
    --voice) voice="$2"; shift 2 ;;
    --music) music="$2"; shift 2 ;;
    --music-vol) mvol="$2"; shift 2 ;;
    --mute-clip) mute=1; shift ;;
    *) echo "unknown option $1" >&2; exit 1 ;;
  esac
done
[[ -n "$voice$music" ]] || { echo "give --voice and/or --music" >&2; exit 1; }

inputs=(-i "$in"); parts=(); filt=""; idx=1
has_audio=$(ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$in" | head -1)
if [[ -n "$has_audio" && $mute -eq 0 ]]; then filt+="[0:a]volume=1.0[clip];"; parts+=("[clip]"); fi
if [[ -n "$voice" ]]; then inputs+=(-i "$voice"); filt+="[$idx:a]volume=1.0[voice];"; parts+=("[voice]"); idx=$((idx+1)); fi
if [[ -n "$music" ]]; then inputs+=(-stream_loop -1 -i "$music"); filt+="[$idx:a]volume=$mvol[music];"; parts+=("[music]"); fi

filt+="$(printf '%s' "${parts[@]}")amix=inputs=${#parts[@]}:duration=first:normalize=0,loudnorm=I=-14:TP=-1.5:LRA=11[a]"
nice -n 10 ffmpeg -hide_banner -loglevel warning -stats -y "${inputs[@]}" -filter_complex "$filt" \
  -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -ar 48000 -shortest -movflags +faststart "$out"
echo "Audio added: $out"
