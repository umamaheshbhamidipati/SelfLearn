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
