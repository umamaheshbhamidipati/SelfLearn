#!/usr/bin/env bash
# Karthika Deepam rough cut: hard cuts timed to media/audio/vo-te.wav. Run from this folder, outside 09:00-15:35.
set -euo pipefail
M=media; T=$M/out/seg; mkdir -p $T
N=(-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -r 24 -an)
clip(){ # name src start dur
  ffmpeg -y -v error -ss "$3" -t "$4" -i $M/clips/$2.mp4 -vf "scale=720:1280,setsar=1" "${N[@]}" $T/$1.mp4; }
push(){ # name still dur zoomEnd
  local f=$(awk -v d="$3" 'BEGIN{printf "%d",d*24}')
  ffmpeg -y -v error -loop 1 -i $M/stills/$2.jpg -t "$3" -vf "scale=2160:-2,zoompan=z='1+($4-1)*on/$f':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=$f:s=720x1280:fps=24,setsar=1" "${N[@]}" $T/$1.mp4; }
clip s01 01 0   2.6
clip s02 02 0   1.8
clip s03 06 1.5 3.0
clip s04 03 0   2.5
clip s05 05 1.5 2.5
clip s06 09 0   2.0
push s07 04 2.2 1.15
push s08 09_end 2.5 1.15
clip s09 07 0   3.5
clip s10 08 5.5 2.6
push s11 10 3.1 1.12
: > $T/list.txt; for i in 01 02 03 04 05 06 07 08 09 10 11; do echo "file 's$i.mp4'" >> $T/list.txt; done
ffmpeg -y -v error -f concat -i $T/list.txt -c copy $M/out/cut.mp4
ffprobe -v error -show_entries format=duration -of csv=p=0 $M/out/cut.mp4
