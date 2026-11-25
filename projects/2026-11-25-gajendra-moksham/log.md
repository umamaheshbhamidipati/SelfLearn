# Log — gajendra-moksham

## Generation (every clip and its cost)

| Date | Shot | Tool | Credits | Pool before → after | Result | What I changed |
|---|---|---|---|---|---|---|
| 25 Nov 10:40 | 1-01 | Veo 3.1 Lite 720p | 10 | 200 → 190 | PARTIAL: usable 0-5 s (jaws on hind leg early; after ~5 s croc slides under belly/front legs). Croc grey-brown, not near-black | start s1-01_c, prompt = seedance-1-01.md |
| 25 Nov 10:41 | 1-02 | Veo 3.1 Lite 720p | 10 | 190 → 180 | PASS: usable 0-7.9 s (three peaks hold, no animals; lake blue-teal) | start s1-02_b |
| 25 Nov 10:42 | 1-03 | Veo 3.1 Lite 720p | 10 | 180 → 170 | PARTIAL: usable 0-3.5 s (spray from trunk; later reframe, calves shift, spray stops) | start s1-03_a |
| 25 Nov 10:43 | 1-04 | Veo 3.1 Lite 720p | 10 | 170 → 160 | PARTIAL: usable 2.5-5.5 s (croc jaws visible above splash 1-1.7 s = FAIL there; then sits upright like a dog) | start s1-04_a |
| 25 Nov 10:44 | 1-06 | Veo 3.1 Lite 720p | 10 | 160 → 150 | PARTIAL: usable 0-4 s (fast time-lapse; peak drifts toward twin peaks by end; moon fades ~6 s) | start s1-06_a |
| 25 Nov 10:45 | 1-07 | Veo 3.1 Lite 720p | 10 | 150 → 140 | PARTIAL: usable 2-7.9 s (glitch 0.7-1.7 s: ear folds, pink blob near trunk; eye sharp, ornament OK) | start s1-07_a |

**Veo used:** 60 / 200 (Ep 1 first tries; balance read 140 at 10:53). **Seedance used:** 0 / 30.

## Sessions

### 25 Nov (08:00-) project set up (0 credits)
- Read CLAUDE.md, credit plan, weekly plan (approved 25 Nov), skill + prompts, lessons, preflight, characters, Tripurasura format.
- Sources: SB 8.2-8.4 checked (`research.md`). Pothana poems NOT verified: left out. Lotus timing differs from the plan (owner decision 1).
- Wrote brief, research, draft narration Ep 1-2, `shots.md`.

### 25 Nov 08:15-08:40 stills started (0 credits)
- **Flow balance 08:15 Wed 25 Nov: 200 credits, "Resets Dec 15 at 3:47 PM"** (no daily part visible).
- Flow project "Nov 25 - 08:07" created; vishnu_C uploaded. Refs made: gajendra_A (looked like a calf: replaced),
  **gajendra_B (locked)**, croc_A, garuda_A. Prompts: `stills-prompts.md`.
- How-to (new, 25 Nov): Flow has a direct prompt bar with Image settings (9:16, x1, "0 credits"). Full-size still =
  tile img src with `=s512-rw` replaced by `=s0` (768x1376 JPEG); JS `<a download>` saves it to ~/Downloads
  (the earlier "find -newermt '-3 minutes'" check was wrong syntax: use "3 minutes ago").
- Chrome asked "flow.google.com wants to access other apps and services on this device" (from a localhost test I
  abandoned): leave it / Block.

### 25 Nov 08:50-09:40 stills done (0 credits), contact sheet sent; SESSION STOPPED HERE (context limit)
- Owner (via main session, 25 Nov): "Garuda should have eagle face" → `refs/garuda_B.jpg` (true eagle head) locked;
  garuda_A rejected. Higgsfield balance (connector) 08:50: 100.
- Chosen stills in `media/stills/`: s1-01_c, s1-02_a, s1-03_a, s1-04_a, s1-05_a, s1-06_a, s1-07_a, s1-08_a (trunk
  empty, no lotus), s2-01_b, s2-02_a, s2-03_a, s2-04_a, s2-05_a, s2-06_a, s2-07_c. All color_check OK.
  Sheet `media/stills/contact-sheet-v1.jpg` sent to the owner 25 Nov ~09:40.
- My own review (beyond the subagent's): **s2-02 FAIL** (stands on grass; he must be chest-deep in the lake);
  **s2-07 FAIL** (disc a tilted ellipse in 3 tries: fix with an end/clip prompt "faces the camera like a clock face"
  or accept); **s1-02 note** (single spire, not the three peaks of the other stills: redo with gajendra_B attached
  as the mountain ref); s1-04 reads a little like sitting (OK for a clip start? ask).
- Ingredient attach in Flow: "+" (Add ingredients) → click asset → "Add to prompt"; search "vishnu" to find vishnu_C.
  Two assets are named "Elephant standing by lotus lake": the NEWER one is gajendra_B. Focus the prompt box by its
  aria-label "What do you want to create?" (coordinate clicks hit grid tiles and open the editor).

## NEXT (fresh session)
1. Wait for the owner's stills OK + narration OK (`narration-ep1.txt`, `narration-ep2.txt`) + decisions in `script.md`
   (lotus timing; the Pothana/Lakshmi line).
2. Redo s2-02 (in water), s1-02 (three peaks), maybe s2-07; then 2-up check vs refs.
3. Write `motion-prompts.md` (one Veo prompt per V shot, "Sound: ... No music, no speech.", no deity names).
4. Read the Flow balance (200 at 08:15 25 Nov), log it; Veo clips Ep 1 first: one Approve per clip, never "Always
   approve", stop at 200 total, 720p only. Send the owner s1-01_c for the Seedance test (`seedance-1-01.md`).
5. TTS (Achird) after narration OK; cut Ep 1 after 15:35 (copy Tripurasura `build_ep1.sh`); post text for approval.
   Target: Ep 1 for approval Sat 28 Nov, post Mon 30 Nov 06:00; Ep 2 for Thu 3 Dec.

### 25 Nov: owner "Stills OK, fix 3" (stills sheet v1 approved; redo s2-02, s1-02, s2-07). s1-04 kept as is.
Narration + script decisions (lotus timing, Pothana/Lakshmi line) NOT answered yet.

## 25 Nov: owner correction on Vaikuntha
- Owner: "Vishnu doesn't live in palace, he live in Vaikuntam". The VAIKUNTHA SET in `shots.md` was a marble palace hall: now
  Vaikuntha as a divine realm (ocean of milky light, floating glowing lotuses, luminous clouds), no building/walls/pillars/throne;
  Vishnu on a glowing lotus seat. **Redo s2-03 and s2-04** (0 credits) along with s2-02, s1-02, s2-07. Added to the preflight checklist.
- Fixes done (0 credits), sheet `media/stills/contact-sheet-fix1.jpg` sent: **s2-02_b** (chest-deep, eyes closed),
  **s1-02_b** (three peaks), **s2-07_e** (disc face-on; elephant younger-looking and knee-deep: watch in the clip).
  s2-07_d rejected (disc an ellipse). Raw copies left in ~/Downloads (*_raw.jpeg): delete only with the owner's OK.
- Disc wording that worked (add to prompts.md fix table): "like a COIN STANDING ON ITS EDGE … perfect full CIRCLE,
  like the full moon or a round clock on a wall … as tall as it is wide … NOT a horizontal spinning plate".
- Final stills: s1-01_c, s1-02_b, s1-03_a, s1-04_a, s1-05_a, s1-06_a, s1-07_a, s1-08_a, s2-01_b, s2-02_b, s2-05_a,
  s2-06_a, s2-07_e. **NOT final: s2-03_a and s2-04_a** (palace arches/pillars/throne, checked by the main session 25 Nov;
  owner: "Check images generate, it's like some palace"). Redo both with the new VAIKUNTHA SET (0 credits) and send the owner a
  2-up before any clip. Next: see "NEXT" above (steps 3-5) in a fresh session.
- Owner 25 Nov: **"Narration OK as is"** (Ep 1 + Ep 2), with the lotus moved to Ep 2 (s1-08 empty trunk, lotus in
  s2-07) and the Pothana/Lakshmi line kept. Next: TTS (Achird) early in the day, then NEXT steps 3-5, fresh session.

## 25 Nov 10:30- Veo clips, Ep 1 first tries (60 credits)
- **Flow balance 10:35: 200**, "Resets Dec 15 at 3:47 PM" (no daily +50 visible). After 6 clips: **140** (read 10:53).
- Prompts: `motion-prompts.md`. Direct prompt bar, Video, **Frames** (start frame), Veo 3.1 - Lite, 9:16, x1, 720p, "Generating will use 10 credits" read before every click; one click per clip.
- How-to (new): the Start-frame picker's "Upload media" opens a native file dialog. Fix: in JS, patch `HTMLInputElement.prototype.click` to capture the file input (append it to body), then `file_upload` the local still into it. Uploads keep their file name (`s1-03_a.jpg`), so the right still is certain.
- Downloads: the row's Download button saves the 720p mp4 straight to ~/Downloads, but slowly (up to ~1 min, queued; repeat clicks give duplicates: cmp, then delete).
- Review (subagent, 3 fps): elephant reads grey rather than the ref's silver-white in all clips (check against gajendra_B myself before re-rolling; may be the grade). Seedance 1-01 still and steps sent to the owner 10:30.
- Flow "typed" text can lose its start if a menu is open: read the prompt box back (length) before generating.
