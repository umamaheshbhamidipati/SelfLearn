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
**Continuity (shot list):** one location and light per episode (a "set" line repeated in every prompt); every shot names what it carries into the next (object, person or movement); at least one touch/reaction beat; every motion prompt ends with "Sound: ..." and the clip's own sound is kept under the narration.
**Things that move by nature:** chakra spins, flame flickers, water flows, aura glows: name the motion in the prompt and check it in the clip. **Emotion by action, not posture:** "losing power" = the power visibly leaves (aura drains, crown dulls), not a bowed head. **Ending:** the last spoken word finishes at least 0.5 s before any fade; a teaser line must say "next part".
**Physics:** nobody sits on or in water; mountain stays on Kurma's shell; things that must move do move (sinking visibly sinks).
**Mythology/sources:** follow `research.md`; belief-based moments narrated as belief; no copyrighted characters, real people or music.
**Clips:** the motion asked for actually happens; no morphing hands/faces; same face and costume start to end; one continuous shot; foam/ocean milk-white or cream, not brown.
**Narration vs picture:** every narration line has a picture under it that shows what the words say ("light a lamp at your doorstep" = a doorstep lamp, "Om Namah Shivaya" = Shiva). Check by listing line → shot before cutting.
**Eyes:** deities look at the viewer when addressed ("Om Namah Shivaya"); check the clip's frames for downcast or closed eyes and pick the seconds where they look straight.
**Audio:** duration within +/-10 % of the script's expected length; no extra speech before line 1 (silencedetect segments match the number of lines); loudness about -16 LUFS voice; style prompts are never spoken aloud (check the first 10 s).
**Cover / text:** exact Telugu spelling copied from the script (no AI layout tool rewriting it).
**Extra characters in a clip (owner, 15 Nov, lion v2):** a side character from the first frame can join the action (the rabbit climbed the well rim and went down with the lion). Check every used second of the clip at 3 fps, not 1 fps, for who moves where; trim around it or prompt "the rabbit stays sitting still in the corner".
**Telugu in every caption style (owner, 15 Nov):** any ASS style that shows Telugu, the brand line included, must use a Telugu font (`Noto Serif Telugu`, which also has Latin letters). A Latin font such as `Noto Serif` falls back unshaped, AND any letter spacing other than 0 (the Brand style had Spacing 2) breaks Telugu shaping in libass even with a Telugu font. Both broke నీతి కథలు on 15 Nov. Test-render the end card line on a plain frame (`color` source + `ass`, one frame) and zoom in before the full render.
**Kalasha / pot shots (owner correction, 17 Nov):** lid on, no flame, lamp or wick inside; glowing pots read as a diya to Nano Banana/Veo. Write "no flame, no fire, no wick, no lamp, not a diya" in every pot prompt.
**Same character across a series (locked list: `docs/characters.md`; owner, 19 Nov, Samudra Manthan Ep 1 vs Ep 4 Vishnu):** a god or hero who appears in more than one episode is made from ONE locked reference (`media/refs/<name>_<letter>.png`, written in every episode's shots file). Before animating any new still of them, make a 2-up sheet: the new still next to a frame of the same character from the earlier episode(s); face, skin tone, crown and ornaments, number of arms and colours must match. Any difference = re-make the still, not the clip.
**Vaikuntha is not a palace (owner correction, 25 Nov, Gajendra Moksham):** Vishnu's abode is Vaikuntha, a divine realm, not a royal palace. No marble halls, pillars, walls, thrones or palace architecture in any Vaikuntha still or prompt; show a realm of light (milky ocean, glowing lotuses, luminous clouds) and seat him on a lotus of light. Check every Vishnu-at-home still for buildings before it is animated.
