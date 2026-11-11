#!/usr/bin/env bash
# cut -> rose grade 1080p -> end card + voice (vo-te2.wav). Run from the project folder, outside 09:00-15:35.
set -euo pipefail
bash cut.sh
GRADE_SCALE=1080:1920 bash ../../scripts/grade.sh media/out/cut.mp4 media/out/graded.mp4 1.0 rose >/dev/null 2>&1
ffmpeg -y -v error -i media/out/graded.mp4 -i media/audio/vo-te2.wav -vf "ass=endcard.ass:shaping=complex" -map 0:v -map 1:a -af apad \
  -c:v libx264 -preset veryfast -b:v 2.6M -maxrate 3.2M -bufsize 6M -pix_fmt yuv420p -c:a aac -b:a 160k -shortest media/out/karthika-voice-v2.mp4
echo DONE > media/out/v2.done
