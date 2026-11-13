# Pre-flight + QA checklist (how we judge stills, clips and audio without the owner watching everything)

Owner has a full-time job (12 Nov 2026): Claude pre-screens everything, the owner only sees a short summary and decides.
**Every correction the owner makes becomes a new line here, and every new video/reel starts by reading this file and `docs/lessons.md`.**

## Process per shot
1. **Before generating:** write the "Must be true" list for the shot in `shots.md` (story, mythology, layout, anatomy, colour). Start from the rules below.
2. **Generate** (stills 0 credits first; clips only after the still passes).
3. **Check, in this order:**
   1. `scripts/color_check.sh <file>`: numeric warm/orange cast (no AI). Catches the orange look with certainty.
   2. File facts: resolution, duration vs expected, silence/loudness for audio (`ffprobe`, `silencedetect`, `loudnorm`).
   3. `scripts/vision_check.sh <image-or-contact-sheet> "<the shot's Must-be-true list>"`: Gemini checks the list item by item. Second opinion only.
   4. Claude looks at the image/contact sheet at full size and answers every Must-be-true line YES/NO (not "looks good"). Zoom on faces and hands.
4. **Fix before showing:** anything failing is regenerated (stills) or logged with the fix (clips).
5. **Owner summary:** one contact sheet, PASS/FAIL per shot, at most 2-3 questions. Decisions in ~5 minutes.

## What each checker is good for (tested 12 Nov 2026 on 8 known cases)
| Checker | Caught | Missed |
|---|---|---|
| `color_check.sh` (numbers) | orange cast on 3/3 warm refs; 0 false alarms on 7 neutral files | anything that is not colour |
| Gemini with a specific spec | vajra not in hand, mountain not sinking, groups sharing one shore (clip 10), tall crown | groups side by side in clip 14 (said PASS), orange cast (said natural); one false alarm ("rocky not forested") |
| Gemini audio | language, gist, tone | an extra 10 s of spoken English instructions (see lessons) |
| Duration / silence numbers (audio) | the same fault (28 s vs 18 s) | tone, naturalness |
| Claude by eye without a spec | image quality, obvious anatomy | everything the owner caught on 12 Nov (vajra, layout, orange) |
| Owner | naturalness, devotion, mythological correctness | n/a: use sparingly |

Rule: **never accept "looks good". Check each Must-be-true line.**

## Must-be-true lines to copy into every shot (grow this list)
**Colour / look (all shots):** neutral natural colour balance; skin natural brown or peach, NOT orange; no orange/pink cast (`color_check.sh` = OK); full 9:16, no black bars, no text/logos.
**People:** young adults only (about 20-35); count the men/women ("exactly N men, no women" for Deva/Asura groups); one face per named character and same as its reference; hands: count fingers; deities exactly four arms when required.
**Objects in hands:** the named object is GRIPPED by a visible hand (vajra, chakra, conch, gada, lotus), not resting on a shoulder or sash.
**Crowns:** Vishnu tallest; Devas (Indra, Agni, Varuna) medium tiered; Asuras small bronze.
**Layout (Samudra Manthan):** Asuras LEFT / Devas RIGHT on OPPOSITE shores pulling opposite ends of ONE serpent (Asuras at the head); Mandara in the centre; Kurma beneath it; Vishnu above the summit when shown. Never both groups together.
**Long creatures / ropes (Vasuki):** trace the body with a finger from head to tail: exactly TWO ends (one head, one tail), each piece a group holds must connect to the coil on the mountain; a tip pointing at the other group = FAIL. Same hood count and colour as the earlier clips. Fix the still before animating: Veo turns a loose end into a new head.
**Recurring places and props:** the mountain, serpent and costumes in a new still must match the clips already made (put one frame of a clip next to the still). **Groups:** check the age of EVERY face (no grey hair or beards) and each deity's own object (Indra = vajra, Varuna = noose), not only the main figure.
**Physics:** nobody sits on or in water; mountain stays on Kurma's shell; things that must move do move (sinking visibly sinks).
**Mythology/sources:** follow `research.md`; belief-based moments narrated as belief; no copyrighted characters, real people or music.
**Clips:** the motion asked for actually happens; no morphing hands/faces; same face and costume start to end; one continuous shot; foam/ocean milk-white or cream, not brown.
**Narration vs picture:** every narration line has a picture under it that shows what the words say ("light a lamp at your doorstep" = a doorstep lamp, "Om Namah Shivaya" = Shiva). Check by listing line → shot before cutting.
**Eyes:** deities look at the viewer when addressed ("Om Namah Shivaya"); check the clip's frames for downcast or closed eyes and pick the seconds where they look straight.
**Audio:** duration within +/-10 % of the script's expected length; no extra speech before line 1 (silencedetect segments match the number of lines); loudness about -16 LUFS voice; style prompts are never spoken aloud (check the first 10 s).
**Cover / text:** exact Telugu spelling copied from the script (no AI layout tool rewriting it).
