# Reference study: Lakshmi, elephant and owl (AI reel, 13 Nov 2026)

File: `~/Downloads/igexport-DfrpWpJOPC9.mp4` (Instagram export from the owner; someone else's video, watermark "ashfall.exe"; study only, never reuse).
30.1 s, 720×1280, 24 fps; the picture is **16:9 letterboxed** inside 9:16 (black bars top and bottom). Sound runs the whole time with no silent gap; the owner hears real elephant, owl and laughter sounds.

## Shot list (measured from 2 fps frames)
| Time | Length | Shot | Joins the next shot by |
|---|---|---|---|
| 0.0–2.0 | 2.0 s | Lakshmi from behind, hair and crown; elephant beside her | the elephant |
| 2.0–5.3 | 3.3 s | close-up: elephant's trunk lifts a pink lotus from the pond | the lotus |
| 5.3–7.0 | 1.7 s | close-up: her raised hand, gold coins falling | her |
| 7.0–9.0 | 2.0 s | close-up: her foot on a lotus petal | the lotus |
| 9.0–15.5 | 6.5 s | two-shot: elephant offers the lotus, she takes it, smiles, strokes his trunk | she looks up |
| 15.5–18.3 | 2.8 s | same two-shot: an owl swoops down and drops a marigold garland round her neck; she laughs | the owl |
| 18.3–22.8 | 4.5 s | wide: owl lands beside her lotus seat, elephant behind | the owl |
| 23.0–30.1 | 7.1 s | close: owl's eye, she strokes its head, it closes its eyes | end |
8 shots, average 3.7 s, range 1.7–7.1 s.

## Why it feels continuous (what we are missing)
1. **One place, one time, one light.** Every shot is the same moonlit lotus pond, same blue night palette. Our Ep 1 jumps between a celestial court, clouds, open ocean and cliffs, each lit differently.
2. **A chain of actions, not a list of pictures.** Each shot hands something to the next: the trunk lifts the lotus → she receives the lotus → the owl arrives → the owl lands → she strokes the owl. The thing that moves (lotus, owl) carries your eye across the cut. Our Ep 1 shots each show a separate fact ("Mandara", "Vasuki", "Asuras") with nothing passing between them.
3. **Characters touch and react.** Gift, smile, laugh, stroke, the owl closing its eyes. Emotion comes from interaction. Our characters stand and pull; nobody reacts to anybody.
4. **Detail inserts of the same scene.** Hair, trunk, hand, foot: 1.7–3.3 s close-ups that build the place piece by piece before the wide shot. Cheap, and Veo is good at them. Our close-ups are separate portraits on different backgrounds.
5. **Long takes when something happens.** 6.5 s and 7.1 s shots let an action finish. Our cuts are 1.5–2.5 s everywhere.
6. **Real sound.** Elephant, owl and laughter, under the music. **Our Veo clips already have native sound** (mean −14 to −18 dB on clips 01, 04, 07, 11, 12, 15), but `build`/`cut` scripts throw it away and play only narration + music.

Not to copy: the 16:9 letterbox (it wastes 60 % of a phone screen; keep full 9:16), and nothing of its characters, music or look as such.

## What we change (applies from the next video; Ep 1 where it is cheap)
| Change | How | Cost |
|---|---|---|
| Keep Veo's sound | mix each clip's own audio under the narration (about −12 dB below the voice, ducked while a line plays); music lower still | 0 credits, edit only |
| Ask for the sound | end every motion prompt with the sounds wanted: "Sound: waves crashing, the serpent hisses, men grunt as they pull; no music, no speech" (for Lakshmi-type scenes: "the elephant trumpets softly, she laughs") | 0 |
| One location per episode | write a one-line "set" in `shots.md` (place, time, light) and repeat it in every prompt; the court/cloud shots become one short prologue | 0 |
| Chain the shots | in `shots.md` add a column "carries into next shot" (object or person); a shot without one is a candidate to cut. Where possible start clip N+1 from the **last frame** of clip N (export with ffmpeg, upload as the start image) | 10 per clip as now |
| Interaction beats | at least one touch/reaction per video (Vishnu's hand on Kurma's shell; an Asura and a Deva lock eyes across the water) | 10 |
| Detail inserts | 2–3 close-ups of the same scene (hands gripping scales, foam on the shell, a crown in the spray) instead of new portraits | 10 each, or 0 as stills |
| Shot length | vary 1.5–7 s; let the hero action (Kurma rising) run 5–7 s | 0 |

Untested: whether Flow can start a clip from an uploaded last frame without proposing extra videos (lesson 10 Nov: first + last frame made the agent propose 6 videos). Test once, with "exactly ONE video, 10 credits".
