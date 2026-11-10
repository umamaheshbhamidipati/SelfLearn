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
| 2026-11-10 | 09 v3 | Veo 3.1 Lite 9:16, **first + last frame** | 10 | rendered, owner to review | Flow agent first proposed **6 videos / 60 credits** → rejected; re-asked for exactly one |
| 2026-11-10 | 01 v3 | Veo 3.1 Lite 9:16 | 10 | rendered, owner to review | gazes down at the diya, then raises eyes to camera level only, "never above the camera" (owner chose option B) |

**Credits used total:** 90 (balance 130 → 80 after the batch → **40** after 4 owner-approved re-rolls on 10 Nov; Flow shows "Resets Nov 15 at 3:47 PM" and no daily top-up
was visible — check tomorrow whether the 50/day refresh exists).

Owner pacing rule (2026-11-10): max 50 credits a day. Day 2 (11 Nov): 03, 04, 05, 06, 10.
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

## Next (resume here, Tue 2026-11-10: owner moved it from Monday)

1. Owner: animate on Tuesday 10 Nov. Check credits first (was 130 on 8 Nov evening).
2. Flow project "Nov 08 - 18:42" (agent already set to Veo 3.1 Lite, 9:16, ×1). Right-click each still → Animate →
   motion prompt from shots.md → Approve "10 credits" per clip. Ask owner for the batch size first.
3. Download clips to media/clips/01–10.mp4 (1080p if offered on PLUS), review with contact_sheet.sh.
4. Cut to vo-te.wav (pauses ~4.2, 7.4, 11.9, 15.3, 19.1, 22.2, 25.6 s), `GRADE_SCALE=1080:1920 grade.sh … 1.0 rose`,
   end card "కార్తీక దీపం", music low under the voice. Post Mon 16 Nov ~6 AM.
- 2nd review by ChatGPT (free, owner's account, contact sheet attached to chat only): all 10 OK for anatomy, faces,
  ages and physics. Its only "issue" was the small star watermark bottom-right = Google's visible AI watermark:
  **keep it** (channel rule: never hide or remove AI watermarks).
