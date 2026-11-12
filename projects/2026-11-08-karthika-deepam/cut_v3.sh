#!/usr/bin/env bash
# Karthika v3 (12 Nov, owner: "clip was not accurate"): pictures now match the words.
# Line 4 "light a lamp at your doorstep" -> the doorstep woman looking up (clip 01, later part), not Shiva.
# Line 5 "Om Namah Shivaya" -> Shiva face (08) with eyes open looking straight at the viewer, then the end card on the river (10).
# Voice vo-te2.wav lines: L1 0-3.35, L2 4.20-6.49, L3 7.37-12.48, L4 13.29-16.07, L5 16.82-18.0 (silencedetect).
set -euo pipefail
M=media; T=$M/out/seg3; mkdir -p $T
N=(-c:v libx264 -preset veryfast -crf 17 -pix_fmt yuv420p -r 24 -an)
clip(){ ffmpeg -y -v error -ss "$3" -t "$4" -i $M/clips/$2.mp4 -vf "scale=720:1280,setsar=1" "${N[@]}" $T/$1.mp4; }
push(){ local f=$(awk -v d="$3" 'BEGIN{printf "%d",d*24}')
  ffmpeg -y -v error -loop 1 -i $M/stills/$2.jpg -t "$3" -vf "scale=2160:-2,zoompan=z='1+($4-1)*on/$f':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=$f:s=720x1280:fps=24,setsar=1" "${N[@]}" $T/$1.mp4; }
clip s01 01 0   2.0      #  0.0- 2.0  L1 hook: she lights the diya at her doorstep
clip s02 02 0   1.4      #  2.0- 3.4  L1 aerial ghat
clip s03 06 1.5 2.6      #  3.4- 6.0  L2 temple
clip s04 03 0   1.9      #  6.0- 7.9  L2/L3 temple lamps
clip s05 05 1.5 2.0      #  7.9- 9.9  L3 tulasi
push s06 04 1.5 1.15     #  9.9-11.4  L3 macro diya
push s07 09_end 1.5 1.12 # 11.4-12.9  L3 couple, diya on the water
clip s08 01 3.8 3.2      # 12.9-16.1  L4 "light a lamp at YOUR doorstep": she looks up, smiles, holds the diya
clip s09 08 3.5 3.0      # 16.1-19.1  L5 "Om Namah Shivaya": Shiva's eyes open and look STRAIGHT at the viewer (08 @3.5-6.5; eyes close again after 7.5)
push s10 10 2.4 1.12     # 19.1-21.5  end card on the river of lamps
# Clip 07 (Shiva in the sky) dropped: his eyes look DOWN the whole clip (owner, 12 Nov).
: > $T/list.txt; for i in 01 02 03 04 05 06 07 08 09 10; do echo "file 's$i.mp4'" >> $T/list.txt; done
ffmpeg -y -v error -f concat -i $T/list.txt -c copy $M/out/cut_v3.mp4
ffprobe -v error -show_entries format=duration -of csv=p=0 $M/out/cut_v3.mp4
