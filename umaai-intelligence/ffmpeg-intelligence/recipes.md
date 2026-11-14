# ffmpeg recipes (each one run on this laptop, 14 Nov 2026, at 360x640 test size)
`V="scale=1080:1920,fps=24,format=yuv420p,setsar=1"` (use the project's size).

## Soft dissolve between two clips (= CapCut "Slow Fade")
`[0:v]$V[a];[1:v]$V[b];[a][b]xfade=transition=fade:duration=0.5:offset=<len_a-0.5>[v]`
Audio: `acrossfade=d=0.5`. Other xfade looks: fadewhite (divine reveal), fadeblack, dissolve.

## Warm-light intro (≈ CapCut In animation "Warm Spread", 1.2 s)
gblur's sigma cannot change over time, so fade out a blurred copy and a warm colour plate:
`[0:v]$V,split[a][b];[b]gblur=sigma=12,format=yuva420p,fade=t=out:st=0:d=1.2:alpha=1[bl];[a][bl]overlay=format=auto[s];`
`[1:v]format=yuva420p,fade=t=out:st=0:d=1.0:alpha=1[w];[s][w]overlay=format=auto,format=yuv420p[v]`
with input 1 = `-f lavfi -i color=c=0xFFE9B0:s=WxH:r=24`. CapCut starts brighter (near white): raise the plate or shorten d.

## Corner glow (partial match for CapCut "Corner Sunflare")
`[0:v]$V,format=gbrp[b];color=c=black:s=WxH:r=24,format=gbrp,geq=r='255*pow(max(0,1-hypot(X-CX,Y-CY)/R),2.2)':g='225*pow(...)':b='160*pow(...)'[l];[b][l]blend=all_mode=screen:shortest=1,format=yuv420p[v]`
(CX,CY = corner, R ≈ 1.4 x width.) Gives a soft warm glow only. CapCut's version also draws moving ray streaks and
lifts the whole frame: for real streaks use CapCut, or a rays still from Nano Banana screen-blended the same way.
geq is slow on this CPU: render the light plate once to a PNG and loop it.

## Slow push-in on a still or held shot
`zoompan=z='1+0.0008*on':x='iw/2-iw/zoom/2':y='ih/2-ih/zoom/2':d=1:s=WxH:fps=24` (≈ 4 % over 2 s). Upscale the input 2x first to avoid jitter.

## Levels
Voice is the reference. Music ≈ 15 dB under, effects ≈ 6.5 dB under, 1.2 s music fades. Measure with `-af ebur128`.

## Checks after every render
`ffprobe -count_frames` (frames ≈ duration x fps, video duration = format duration), `volumedetect`, frame sheet at 3-4 fps.
