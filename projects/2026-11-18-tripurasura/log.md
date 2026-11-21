# Log — tripurasura

## Generation

| Date | Shot | Mode | Credits | Result | What I changed |
|---|---|---|---|---|---|

**Credits used total:** 

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

## 18 Nov (09:40-10:30): series planned (0 credits, nothing generated)
- Project created; read CLAUDE.md, preflight, lessons 15-17 Nov, earshot audit, the skill, Samudra Manthan Ep 4.
- Sources: Shiva Purana Yuddha Khanda ch 1-3, 8-10 read (wisdomlib, Shastri) → `research.md`. Karthika Purnima =
  **Tue 24 Nov 2026** (3 sources). Third city = steel/iron (SP 1.47). The smile version = Tamil Shaiva tradition,
  not SP. Ganesha-first beat (SP 10.5-9) kept for Ep 3.
- Wrote `brief.md`, `script.md` (3 episodes + 5 decisions for the owner + credit plan), `narration-ep1.txt`,
  `shots-ep1.md` (10 shots, Lean 3 clips = 30 credits, max 60; Lean-min 20), `audit-ep1.md` (5 lines fixed, 1 flag).
- Waiting on the owner: narration OK? decisions 1-4? Lean (30) or Lean-min (20)? Then: TTS early in the day
  (Achird), stills (0 credits) + contact sheet, read the Flow balance, clips with Approve once per clip, build
  after 15:35.

## 18 Nov (10:00-10:50): owner approvals, TTS partial, stills, clips (via the main session)
- Owner (relayed by the parent session): Ep 1 narration "Approve as written"; preacher episode "Leave it out";
  Ep 3 "Arrow only"; Ep 1 credits "Lean: 30, max 60" (clips 01, 06, 09, one Approve each, one re-roll each at most);
  iron accepted; aim Ep 3 for Tue 24 Nov.
- TTS (Achird): L1-L3 done (3.20, 6.00, 4.32 s raw) in `media/ep1/audio-draft/`; then HTTP 429 **daily** quota
  (GenerateRequestsPerDayPerProjectPerModel-FreeTier = **10/day** for gemini-3.8-flash-tts; other sessions had used
  7). Retry after ~13:35 IST for L4-L10.
- Stills, 0 credits (Flow project "Nov 18 - 09:57", Nano Banana 2.1 in the agent): 10 made, then s02/s03/s04
  regenerated with s01 + s02 attached (pillar palaces instead of the floating cities), s04 a third time
  (s04_b Brahma came out feminine and illustrated). Picks: s01_a, s02_b, s03_b, s04_c, s05_a, s06_a, s07_a, s08_a,
  s09_a, s10_a; all `color_check` OK; subagent check PASS (notes: s06 lines pale white not gold; s07 gold city
  below silver = reads as drifting; s09 Devas walk rather than step back).
- Flow balance before clips: **200**, "Resets Dec 15 at 3:47 PM". Clips 01 (s01), 06 (s06), 09 (s09): agent asked
  "1 video, 10 credits" each time; Approve clicked once per clip. **Spent 30 of the approved max 60.**
- Gotchas: clicking the send arrow while the agent is generating = Stop (cancelled the first s01). Send with JS
  (`aria-label="Start generation"`). Grid right-click menus open at varying offsets and every other right-click after
  a download is swallowed: Escape, wait 2 s, right-click, screenshot, then click.

## 18 Nov (10:30-11:10): clip review, owner's later decisions, cover, post text
- Clip review (subagent, 3 fps): **01 PARTIAL, clean 0.0-6.0 s** (cloud bank swells after 5.5 s; silver city drifts);
  **06 FAIL** (lightning from 1.3 s, three new solid cities of a different design incl. copper, outlines stay = ~6 city
  forms; clean 0.0-1.3 s); **09 FAIL** (the city does not move, no shadow sweep, camera creeps, doubled pillar at
  3-4 s; best 2.5-4.5 s, Devas looking up).
- Owner (via the main session, after the clips were made): wants to see the 3 motion prompts before credits are
  spent. The clips had already been generated under the earlier "Lean 30, max 60" OK; re-rolls of 06/09 (20 more)
  wait for the owner's OK on the prompts.
- Owner: L1 → "బంగారు, వెండి, ఇనుప పురాలు… వాటిని కూల్చాలంటే ఒకే ఒక్క బాణం!", L7 → "వెయ్యేళ్లకు ఒక్కసారి…
  పుష్యమి నక్షత్రం వేళ ఆ మూడూ ఒకే వరుసలోకి వస్తాయి."; narration approved. Smile tradition in Ep 3's caption only.
  Schedule locked: Ep 1 Fri 20, Ep 2 Sun 22, Ep 3 Tue 24 Nov morning. Old L01 TTS deleted (L01, L04-L10 to record after
  the quota reset ~13:35).
- Cover `media/ep1/cover/cover-ep1.jpg`: clip 01 at 1.5 s + "ఒకే ఒక్క బాణం?" (Noto Serif Telugu, shaping checked).
- Post text draft `ep1-post-text.md` (owner's opening + usual format), sent for approval.
- 18 Nov 11:20 owner: "Use free zooms": no re-rolls; L6 = push-in on s06_maya_a, L9 = push-in on s09 + clip 09 2.5-4.5 s. **Ep 1 credits end at 30** (balance ~170). build_ep1.sh updated.
- 18 Nov ~11:35 owner: re-roll 06 v2 + 09 v2 (20 credits, last try; fallback = free zoom) once the extra 50 credits show. Balance read **170** ("Resets Dec 15 at 3:47 PM"): extra 50 not there yet, waiting.
- 18 Nov 13:44: TTS L01, L04-L10 done (Achird, no 429). Trimmed speech 43.2 s (L01 4.8 s); full cut ~50 s at 1.0x. Voice previews `media/ep1/review/voice/ep1-voice-x1.0.mp3` (46.7 s) and `-x1.08.mp3` (43.6 s). build_ep1.sh takes TEMPO=1.08. Asked the owner: 1.0 / 1.08 / 1.08 + shorter gaps / cut words. Default draft at 15:35 = 1.08.
- 18 Nov ~14:30 owner: Ep 1 length option 3 (1.08x, 0.25 s gaps, 2.0 s card, ~46 s; build defaults changed); Ep 1 post text approved; Ep 2/3 narration approved (golden chariot; Ep 3 L3 "పూజించండి"). Next for Ep 2/3: shots + Lean prompts for approval.
- 18 Nov 15:36-15:55: Ep 1 draft built (option 3): 46.2 s, -16.0 LUFS, LRA 2.5. Phone copy `media/ep1/out/ep1-moodu-puralu-phone.mp4` (720x1280, 8.1 MB). Frame review (subagent, 1 fps sheet + 0.5/44.5/45.8 s): captions, end card, no black/frozen frames, Veo watermark intact, young adults only: all PASS. Note: grade reads cool navy (rose only on skin/lotus), soft miss.
- 18 Nov 16:01: upload copy re-encoded at 1.5M (was 1.6M, 10.03 MB, over Chrome's 10 MB upload limit): now **9.45 MB**. Main file not re-encoded. Re-rolls 06/09 still wait for the credit check.
- 18 Nov ~16:05: balance read **220** (the extra 50 arrived). Re-rolls run as approved: 06 v2 + 09 v2, one video each, one Approve each. Balance after **200** (20 spent; Ep 1 total 50). Downloads 720p → `clips/06v2.mp4`, `clips/09v2.mp4`.
  - 06 v2 **FAIL** (review, 3 fps sheet): electric arcs of light between his hands from 0.7 s, outlines drift up into the sky, camera drifts. No 2 s usable. No third try (owner): L6 keeps the free zoom on s06_maya_a.
  - 09 v2 **PASS**: three brothers (blue/gold/silver as Ep 1) look up, the dark iron city slides in right→left, its shadow darkens them (3.7-5.7 s); a moon enters at the right ~3.7 s (fits the scene); watermark visible. Used 1.7-5.0 s (3.3 s) at L9 after a 1.1 s push-in on s09_shadow_a. Rebuild started ~16:15.
- 18 Nov 16:30: Ep 1 rebuilt with 09v2 at L9 (still 36.2-37.3 s, clip 37.3-40.6 s): 46.2 s, -15.9 LUFS. Phone copy `media/ep1/out/ep1-moodu-puralu-phone.mp4` (8.1 MB), upload copy 9.45 MB. L9 frames checked: captions readable over the dark shadow, watermark visible. Sent for the owner's review.
- 19 Nov: STOP on Instagram/Meta automation (Instagram flagged @umaaivideostudio for "automated behavior" ~04:24; owner recovered it). Ep 1 Instagram post on Fri 20 Nov = owner by hand from the phone; Claude prepares the file + caption only. FB Page on hold. YouTube + Flow unaffected. Noted at the top of `ep1-post-text.md`.
- 19 Nov: locked references (owner lesson, Vishnu Ep 1 vs Ep 4): `media/refs/shiva_A.jpg` (= Samudra Manthan ep2 s1_hook_a), `brahma_A.jpg` (= Ep 1 s04_brahma_c), `peak_A.jpg` (= Ep 1 s10_peak_a). Named in shots-ep2.md and shots-ep3.md; Ep 3 s07 no longer offers the Karthika 08.jpg Shiva (different face).
- 21 Nov 06:07: Ep 1 YouTube Short PUBLIC https://youtube.com/shorts/09gKGxckc9w (posted by the main session on the owner's request). Playlists: new త్రిపురాసుర సంహారం | Tripurasura Samharam (oldest first) + Devotional Stories; 13 hashtags; AI = yes; not for kids; cover set. Instagram: owner by hand. FB on hold.
- 21 Nov 06:00-06:45: Ep 2/3 Flow batch (owner: "Approve Ep 2 and Ep 3 clips with 50 credits for both"). Balance before **220**, after **170** (50 spent: 5 clips, one Approve each). Flow had a new agent UI; uploads via the Upload menu (file input caught in JS, no native picker).
  - Stills (0 credits) → `media/ep2/stills/`: s01_chariot_a (moon wheel on the chariot's left, 4 horses, nobody riding), s08_bull_a (made from s01), s09_draw_a (made with refs/shiva_A + s01). 2-up s09_draw vs shiva_A: face, crescent, third eye, serpent glow, tiger skin, skin tone match; two arms; no orb: PASS.
  - Prompt changes vs shots files: A "toward the camera" → "from right to left" (the still is a side view); B "rises from below and lifts" → "rises higher, carrying" (the still already shows it lifted).
  - Clip review (3 fps sheets; subagent for B/D/E, own look at A/C):
    - A `ep2/clips/A.mp4` **PASS**: chariot stable, slow pull-back, horses gallop in place. Whole clip.
    - B `ep2/clips/B.mp4` **PASS**: one calm bull, chariot level on its back, no morphing; faint constellation lines in the sky from 2.7 s. Whole clip (or 0-2.5 s).
    - C `ep3/clips/C.mp4` **FAIL**: the cities never move into a line; only the star flares and fades (moon turns into a star). Fallback: push-in on Ep 1 s07_align_a.
    - D `ep3/clips/D.mp4` **PASS trimmed**: one arrow streak at 1.3 s, bow stays in his hands, two arms, face = shiva_A; pose drifts after ~6 s. Use 1.3-5.9 s.
    - E `ep3/clips/E.mp4` **FAIL (strict)**: the cities burn in white smoke and sparks but stay largely intact; an unprompted ground fire appears bottom-right from 1.3 s (cannot crop: the watermark is there). Owner decides: use as is (0-5.5 s) or fall back to a still.
  - No re-rolls made (any re-roll needs a new OK).
- 21 Nov ~06:20-06:45: re-rolls C v2 + E v2 (owner: "Re-roll C and E"), one Approve each. Balance 170 → **150** (20 spent). The first turn was stopped mid-download; on restart the balance (150) and the Flow grid confirmed both had run, so nothing was generated twice. Files: `ep3/clips/Cv2.mp4`, `ep3/clips/Ev2.mp4` (sheets in `ep3/review/`).
  - C v2 prompt: cities "clearly MOVE" (iron city slides right, silver glides behind, gold drifts left) into one line; moon/star unchanged. **PASS**: the front city slides to the centre and the silver/gold cities end stacked directly behind it (one line) by ~5 s; the moon stays; the small star fades (fine). Use 2.0-7.9 s (or whole clip).
  - E v2 prompt: cities crack and crumble to ash and embers, "no ground fire, no smoke columns", lower frame unchanged. **FAIL (strict)**: the cities do crack with fire veins and crumble away (the main point, which v1 missed), but small ground fires appear at the bottom from ~1 s and tall smoke columns fill the frame by ~4 s. Per the owner's rule the fallback is E v1 0-5.5 s; note v1 has the same ground-fire flaw and its cities never crumble, so **v2 0-4.0 s looks better than v1**: owner to choose.
- Ep 2/3 cut NOT started (handed to a fresh session; this one passed the 200k context limit). Still to do, in order:
  1. TTS: `narration-ep2.txt` and `narration-ep3.txt` (Achird, `scripts/tts.sh`; 9 lines each; free quota 10/day per model, resets ~13:35 IST, so one episode per quota day or record after 13:35). No audio exists yet.
  2. Remaining stills (0 credits; attach `media/refs/shiva_A.jpg` / `brahma_A.jpg` / `peak_A.jpg` per shots files, 2-up check): Ep 2 s02_plea, s03 (clip A frame ok), s04_brahma_reins, s05_bow, s06_arrow, s07_kneel; Ep 3 s02_wait, s03_voice, s04_ganesha, s06_ash (or clip E), s07_face; Ep 3 s08/s09 reuse Karthika stills.
  3. `build_ep2.sh` / `build_ep3.sh` copied from `build_ep1.sh` (clips: Ep 2 A at L1, B at L8; Ep 3 Cv2 at L1, D 1.3-5.9 s at L5, E choice at L6). Encodes outside 09:00-15:35.
  4. Post text for Ep 2/3 (owner approves exact text); Instagram posted by the owner by hand (no Meta automation, 19 Nov).
- 21 Nov ~06:45: owner reports Ep 1 is on the Facebook Page (posted by hand): https://www.facebook.com/reel/1178217948227203 (AI content label on, approved caption). Registered in posts.csv.
- 21 Nov ~06:55: Ep 1 Instagram reel https://www.instagram.com/reel/Df_C1SAi5qO/ posted by the main session in Chrome, on the owner's explicit request after a reminder of the 19 Nov automation flag (one post, slow steps, no page scripts). Collab invite to @umamaheshbhamidipati, AI label on, cover set, approved caption. Ep 1 is now on YouTube, Facebook and Instagram.

## 21 Nov (06:57-): Ep 2/3 cut session (fresh session; owner: "Start, use E v2")
- TTS Ep 2 (Achird, `scripts/tts.sh`, no style): L01-L09 done in `media/ep2/audio-draft/` (raw 3.9-5.1 s each, 39 s total).
  One per-minute 429 after L04 (retried after a pause). Gemini 3.5 Flash transcription of the 9 lines: every line
  present, no English, no noises. Ep 3: L01-L02 done (`media/ep3/audio-draft/`), then the **daily** 429 (10/day for
  gemini-3.8-flash-tts; "retry in 6h26m" at ~07:10 = ~13:35 IST). L03-L09 after the reset.
- Ep 2 stills, 0 credits, **Gemini app (gemini.google.com, Create image, 9:16)** in the owner's Chrome, refs attached
  through the hidden file input (open Upload & tools first, then the inputs exist). → `media/ep2/stills/`:
  - s02_plea_a FAIL (Shiva's skin blue-grey; ref is warm natural) → **s02_plea_b PASS** (2-up vs shiva_A: face, crescent,
    third eye, serpent, tiger skin, skin tone; 4 Devas with joined palms on the snow, peak + trident as peak_A).
  - s04_brahma_reins_a/b/c FAIL (only 3 horses; Gemini kept copying the attached frame's layout) → **s04_brahma_reins_d
    PASS** (brahma_A only attached; four horses abreast, Brahma crown/black beards/four arms, lotus + book, reins).
  - **s05_bow_a PASS** (s09_draw_a attached for the bow: one rocky gold bow, serpent string, hoods top, tail bottom).
  - **s06_arrow_a PASS** (one arrow, small flame tip, navy core, no figure).
  - s07_kneel_a FAIL (Shiva tiny, horses read as two) → **s07_kneel_b PASS** (face = shiva_A, four horses, front legs folded).
  - s03 = no still: L3 uses clip A 4.0-7.9 s (a push-in on a clip frame would crop the Veo watermark).
  - All `color_check` OK. Gemini stills carry the small sparkle mark bottom-right (shiva_A has it too); push-ins crop
    the corners slightly, as in Ep 1.
  - Gotcha: blind clicks on the Gemini start page hit a suggestion chip and opened a "Victorian detective" Deep Research
    chat (plan only, not started); left in the owner's history.
- `build_ep2.sh` (from build_ep1.sh; option 3: 1.08x, 0.25 s gaps, 2.0 s card): A 0-4.0 s (L1), A 4.0-7.9 s (L3),
  B whole slot (L8), push-ins elsewhere; end card "భాగం 2 · చివరి భాగం: ఒక్క బాణం". Total **37.6 s**. Full encode
  started 07:42 (before 09:00).
- Post text draft `ep2-post-text.md` (Ep 1 pattern), for the owner's word-for-word approval.
