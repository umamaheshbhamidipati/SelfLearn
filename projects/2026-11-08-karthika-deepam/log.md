# Log — karthika-deepam

## Generation

| Date | Shot | Mode | Credits | Result | What I changed |
|---|---|---|---|---|---|
| 2026-11-10 | 01 hook | Veo 3.1 Lite 9:16 | 10 | rendered, not yet reviewed | — |
| 2026-11-10 | 07 Shiva in sky | Veo 3.1 Lite 9:16 | 10 | rendered, not yet reviewed | — |
| 2026-11-10 | 08 Shiva close-up | Veo 3.1 Lite 9:16 | 10 | rendered, not yet reviewed | — |
| 2026-11-10 | 02 aerial ghat | Veo 3.1 Lite 9:16 | 10 | rendered, not yet reviewed | — |
| 2026-11-10 | 09 couple | Veo 3.1 Lite 9:16 | 10 | **rejected (owner):** diya released but the plate still held a diya, then the plate vanished | added "both stay seated on the dry stone step, no one moves into the water" |
| 2026-11-10 | 01 v1 | | | **rejected (owner):** flame grew huge and dominated | prompt had "the flame grows" |
| 2026-11-10 | 09 v2 | Veo 3.1 Lite 9:16 | 10 | rendered, first frame OK, not yet reviewed | hold the plate the whole time, nothing released/appears/disappears |
| 2026-11-10 | 01 v2 | Veo 3.1 Lite 9:16 | 10 | **rejected (owner):** flame small now, but she looks up above the camera | flame stays small, fingertip size |
| 2026-11-10 | 09 v2 | | | **rejected (owner):** wanted the diya set afloat and the empty plate kept on her lap | v2 prompt held the plate the whole time |
| 2026-11-10 | 09 end still | Nano Banana 2.1 | 0 | "Couple smiling near floating diya": empty plate at her lap, diya on the water | end frame for first+last-frame video |
| 2026-11-10 | 09 v3 | Veo 3.1 Lite 9:16, **first + last frame** | 10 | **partly rejected (owner):** as he lifts the diya off, a 2nd diya stays on the plate → use only the first ~1.5–2 s (see "Resume here") | Flow agent first proposed **6 videos / 60 credits** → rejected; re-asked for exactly one |
| 2026-11-10 | 01 v3 | Veo 3.1 Lite 9:16 | 10 | rendered, owner to review | gazes down at the diya, then raises eyes to camera level only, "never above the camera" (owner chose option B) |

**Credits used total:** 90 (balance 130 → 80 after the batch → **40** after 4 owner-approved re-rolls on 10 Nov; Flow shows "Resets Nov 15 at 3:47 PM" and no daily top-up
was visible — check tomorrow whether the 50/day refresh exists).

Owner pacing rule (2026-11-10): max 50 credits a day. ~~Day 2: 03, 04, 05, 06, 10~~ → revised below (only 40 left).

## RESUME HERE — handoff to the AMD laptop (written 2026-11-10 evening on DESKTOP-NQRVIV1)

The desktop has **no ffmpeg and no Karthika media**, so the edit moves to the AMD laptop (ffmpeg 8.0.1, stills,
`media/audio/vo-te.wav`). Flow is driven from the owner's Chrome on that machine as before.

**Flow project "Nov 08 - 18:42"** (agent: Veo 3.1 Lite, 9:16, x1, confirm Always). In the **Videos** filter the
newest is first. Which version to use:

| Shot | Use | Flow title (hover shows it) | Status |
|---|---|---|---|
| 01 | **v3** (newest of the 3 woman-with-diya clips) | "Woman holding diya smiling" | owner to watch: eyes go down → camera, never above |
| 02 | v1 | aerial river with gopuram | owner hasn't flagged it |
| 07 | v1 | "Shiva raises blessing…" | owner hasn't flagged it |
| 08 | v1 | Shiva close-up | owner hasn't flagged it |
| 09 | **v3, first ~1.5–2 s only** (first+last-frame clip, the newest couple clip) | "Sacred Riverfront Diya Rit…" session | 2nd diya appears once he lifts it |
| 09 end | still **"Couple smiling near floating diya"** (Images filter, newest) | | 0-credit push-in |
| 03, 04, 05, 06, 10 | stills only, no clips yet | | see plan |

Download: right-click → Download → 720p for videos, 1K for stills (wait ~1 s between menu clicks) →
`media/clips/01.mp4`, `02.mp4`, `07.mp4`, `08.mp4`, `09.mp4`; end still → `media/stills/09_end.png`.
Review each with `bash .claude/skills/ai-video-studio/scripts/contact_sheet.sh media/clips/NN.mp4 sheet_NN.jpg`.

**09 fix = edit, 0 credits (owner OK'd).** Veo 3.1 Lite failed the diya release 3 times (duplicate diya / vanishing
plate), so the release happens between cuts:
1. `09.mp4` from 0 to the last clean frame before the 2nd diya shows (~1.5–2 s; find it on a 2 fps contact sheet).
2. Shot **04** (diya on a leaf drifting on the water): 0-credit zoompan push-in on still 04, ~1.5 s.
3. `09_end.png`: slow zoompan push-in, ~2 s (couple smiling, empty plate on her lap).
Viewer sees: diya leaves → floats → plate empty. Never two diyas in one frame.

**Credits:** balance **40** until reset **15 Nov 15:47**. No daily +50 was seen on 10 Nov — check the avatar menu
first; if it rose, the 50/day exists. Plan for the rest (owner to confirm the batch each day):
- Clips: **03, 05, 06** = 30 credits. **04 and 10** = 0-credit push-ins on the stills. Keep 10 for one re-roll.
- Motion prompts in shots.md. Lessons from today (in the skill's prompts.md): never ask fire to "grow"; say
  "eyes stop at camera level, never above"; avoid release/drop actions; read the agent's count+cost before Approve
  (it proposed 6 videos / 60 credits once).

**Then the cut** (outside 09:00–15:35): cut to `vo-te.wav` (pauses ~4.2, 7.4, 11.9, 15.3, 19.1, 22.2, 25.6 s),
`GRADE_SCALE=1080:1920 scripts/grade.sh … 1.0 rose`, end card "కార్తీక దీపం", music low under the voice.
Owner previews on the phone. **Post Mon 16 Nov ~6 AM** (Instagram first, then YouTube Short; AI label on).

Samudra Manthan: script + Ep 2 shot list are done (`projects/2026-11-09-samudra-manthan/`); its stills (0 credits)
can start any time, clips after the 15 Nov reset. Open: narration voice, master image review (Flow project
"Samudhra Manthan").
Flow agent sessions used: "Cinematic Candlelight Wa…", "Sacred Rituals and Divine …" (project "Nov 08 - 18:42").

## After 7 days (Instagram Insights / YouTube Studio)

| Metric | Instagram | YouTube Shorts |
|---|---|---|
| Views | | |
| **Average watch time** (main metric; baseline 0:02) | | |
| % views from non-followers | | |
| **Shares** | | |
| **Saves** | | |
| Follows / subscribers gained | | |
| Likes / comments | | |

One lesson (also add to `docs/lessons.md`):

## Status (2026-11-08 evening)

- Flow credits: **130** (resets 15 Nov 15:47). Plan ≤ 120 (see shots.md). Nothing generated yet.
- Narration: `scripts/tts.sh -f narration.txt media/audio/vo-te.wav Achird` → **28.1 s**, pauses at
  ~4.2, 7.4, 11.9, 15.3, 19.1, 22.2, 25.6 s (silencedetect −35 dB). Owner to check pronunciation.
- Karthika Masam 2026: 10 Nov – 8 Dec; Somavarams 16/23/30 Nov, 7 Dec; Pournami 24 Nov (web sources; verify locally).
- Stills (2026-11-08 ~18:45–19:05): Flow project "Nov 08 - 18:42", Nano Banana 2.1, 9:16, **0 credits**. 10 made in 3
  agent messages (1 + 5 + 4; batching several numbered images in one message works). Downloaded at 1K
  (768×1376) via right-click → Download → 1K (wait ~1 s between menu clicks or the click is lost).
  Redone free: 07 (looked like an illustration, face didn't match 08 → regenerated with 08 attached as
  reference via "Add to prompt"), 02 and 10 (North Indian shikhara → "South Indian temple with a tall gopuram").
  Rejected in `media/stills/rejected/`. Contact sheet `media/contact_stills.jpg` sent to owner for OK.
- Agent settings saved for animation: video 9:16, ×1, **Veo 3.1 - Lite** (default was Omni 1.2 Flash).
- Owner caught 09: the woman was sitting on/in the river (no step under her). Missed in my check. Redone (0 credits):
  "both seated on the SAME dry stone step, river one step BELOW, no person on or in the water". New gate item:
  check physics, not only hands (who sits on what, where the water is).

## (Superseded by "RESUME HERE" above) Next, as planned on 8 Nov

1. Owner: animate on Tuesday 10 Nov. Check credits first (was 130 on 8 Nov evening).
2. Flow project "Nov 08 - 18:42" (agent already set to Veo 3.1 Lite, 9:16, ×1). Right-click each still → Animate →
   motion prompt from shots.md → Approve "10 credits" per clip. Ask owner for the batch size first.
3. Download clips to media/clips/01–10.mp4 (1080p if offered on PLUS), review with contact_sheet.sh.
4. Cut to vo-te.wav (pauses ~4.2, 7.4, 11.9, 15.3, 19.1, 22.2, 25.6 s), `GRADE_SCALE=1080:1920 grade.sh … 1.0 rose`,
   end card "కార్తీక దీపం", music low under the voice. Post Mon 16 Nov ~6 AM.
- 2nd review by ChatGPT (free, owner's account, contact sheet attached to chat only): all 10 OK for anatomy, faces,
  ages and physics. Its only "issue" was the small star watermark bottom-right = Google's visible AI watermark:
  **keep it** (channel rule: never hide or remove AI watermarks).

## Progress 2026-11-11 (AMD laptop, morning)

- **Credits: 90** (were 40 on 10 Nov evening) → the daily +50 does exist. Reset still 15 Nov 15:47.
- A stale "Approve 10 credits" prompt from the old couple session was still open in the Flow agent panel:
  **left untouched** (not in an approved batch).
- Downloaded (720p, 7.9 s each) to media/clips: 01 (v3), 02, 07, 08, 09 (v3); end still media/stills/09_end.jpg.
- Review by contact sheets, what to use in the cut:
  - 01: looks down at diya, then smiles at camera, eyes never above. Use ~0–5 s.
  - 02: clean drone glide. Use any ~2 s.
  - 07: glow washes out the face after ~3.5 s → use only 0–3 s.
  - 08: eyes closed until ~3 s; pink wisps near face ~5 s → use ~5.5–7.9 s (eyes open, calm).
  - 09: clean for 0–~2 s (before the hand reaches the water), then 04 push-in, then 09_end push-in.
- Still to animate: 03, 05, 06 (30 credits); 04 and 10 = push-ins (0). Waiting for owner to confirm the batch.

## Clips 03, 05, 06 (2026-11-11, owner approved 3 clips = 30 credits)

- Made in a fresh agent session so the stale old "Approve" prompt stayed untouched. Each time the agent asked
  "1 video, 10 credits" → plain Approve (never "Always approve"). Credits should now be ~60 (90 − 30).
- Downloaded 720p → media/clips/03.mp4, 05.mp4, 06.mp4. Right-click → Animate sometimes opens the image editor
  instead (row/banner shift): screenshot after each right-click, and wait 2 s between menu clicks.
- Review (12 frames each):
  - 03: man lights the pillar lamps cleanly, flames small. Raised arm looks a little long mid-clip (~2.5–5.5 s) →
    use 0–2.5 s only.
  - 05: calm, eyes closed, gentle smile, smoke wisps, flames small. Fine for the whole clip (use ~1.5–4 s).
  - 06: slow tilt up the gopuram with mist, trident at the top, architecture holds. Use ~1.5–4.5 s.
- All 8 animated shots are now in hand: 01, 02, 03, 05, 06, 07, 08, 09. Push-ins (0 credits): 04, 10, 09_end.
- NEXT: the cut (outside 09:00–15:35) to vo-te.wav, rose grade, end card, music; owner previews on phone.
