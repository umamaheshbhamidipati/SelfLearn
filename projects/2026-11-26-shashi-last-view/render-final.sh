#!/usr/bin/env bash
# Full 1080p encode + a phone-size preview. Run after 15:35 IST (Kite bot uses the CPU before that).
set -euo pipefail
cd "$(dirname "$0")"
python3 -I timeline.py --run > media/work/render.log 2>&1
nice -n 19 ffmpeg -v error -y -i media/out/the-last-view-16x9.mp4 -vf scale=960:540 -c:v libx264 -preset veryfast \
  -crf 26 -c:a aac -b:a 96k -movflags +faststart media/out/the-last-view-preview-540p.mp4
echo done >> media/work/render.log
