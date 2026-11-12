#!/usr/bin/env bash
# v3: cut -> rose grade 1080p -> end card + voice (Instagram file) -> + music (YouTube file). Outside 09:00-15:35.
set -euo pipefail
cd "$(dirname "$0")"
bash cut_v3.sh
GRADE_SCALE=1080:1920 bash ../../scripts/grade.sh media/out/cut_v3.mp4 media/out/graded_v3.mp4 1.0 rose >/dev/null 2>&1
# Instagram: narration only (song added in the app)
ffmpeg -y -v error -i media/out/graded_v3.mp4 -i media/audio/vo-te2.wav -vf "ass=endcard_v3.ass:shaping=complex" -map 0:v -map 1:a -af apad \
  -c:v libx264 -preset veryfast -b:v 2.4M -maxrate 3.0M -bufsize 6M -pix_fmt yuv420p -c:a aac -b:a 160k -shortest media/out/karthika-v3-instagram-voice-only.mp4
# YouTube: narration + Dreams Of River Ganga about 10 dB under, fade in/out; video stream copied
D=$(ffprobe -v error -show_entries format=duration -of csv=p=0 media/out/karthika-v3-instagram-voice-only.mp4)
ffmpeg -y -v error -i media/out/karthika-v3-instagram-voice-only.mp4 -i media/audio/music-dreams-of-river-ganga.mp3 -filter_complex \
  "[1:a]atrim=0:$D,asetpts=PTS-STARTPTS,loudnorm=I=-27:TP=-3,afade=t=in:d=1,afade=t=out:st=$(awk -v d=$D 'BEGIN{print d-2}'):d=2[m];[0:a][m]amix=inputs=2:duration=first:normalize=0[a]" \
  -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 160k media/out/karthika-v3-youtube-with-music.mp4
echo DONE > media/out/v3.done
