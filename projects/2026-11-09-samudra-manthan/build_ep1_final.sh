#!/usr/bin/env bash
# Ep 1 FINAL (13 Nov 2026): cut (Vishnu fix) -> rose grade 1080x1920 -> captions + end card. Voice = AI (Achird) + clip sounds; no music.
# Run outside 09:00-15:35 from anywhere: bash projects/2026-11-09-samudra-manthan/build_ep1_final.sh
set -euo pipefail
cd "$(dirname "$0")/../.."
R=projects/2026-11-09-samudra-manthan; O=$R/media/ep1/out
bash $R/cut_ep1.sh
GRADE_SCALE=1080:1920 bash scripts/grade.sh $O/ep1-cut.mp4 $O/ep1-graded.mp4 1.0 rose >/dev/null 2>&1
ffmpeg -y -v error -i $O/ep1-graded.mp4 -i $O/ep1-cut.mp4 -vf "ass=$R/captions-ep1.ass:shaping=complex" -map 0:v -map 1:a \
  -c:v libx264 -preset veryfast -b:v 3M -maxrate 4M -bufsize 8M -pix_fmt yuv420p -c:a copy -shortest $O/ep1-kurma-voice-sfx.mp4
echo EP1_FINAL_DONE
