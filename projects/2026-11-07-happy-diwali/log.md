# Log — happy-diwali

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

## Status 2026-11-07 ~22:50 IST (session paused: usage limit)
- Stills: all made in Flow (Nano Banana, 0 credits) except 01, 02, 04 (Gemini). Grandmother redone twice (3 hands; letterbox), couple redone (bent neck).
- Clips: 10 generated in Flow project "Nov 07 - 22:08" (Veo 3.1 Lite). Muggulu failed once (audio, not charged) and was re-run. Credits 180 → ~80.
- Downloaded to media/clips: 01 diyas rising, 02 aerial, 03 grandmother, 04 young woman, 05 firework man, 06 muggulu, 07 couple, 08 ghat.
- Still to download: 09 "Fireworks bursting over village", 10 "Goddess raises blessing hand" (Lakshmi in sky).
- Then: fast-cut edit (1–2 s cuts), scripts/grade.sh, gold end card, review, post Diwali morning.

## Edit (2026-11-08, Diwali morning)

- Cut: `cut_list.txt` → `roughcut.sh … --xfade 0.25` → 20.0 s.
- Grade: `scripts/grade.sh` strength 1.0. First try turned everything **purple**: the screen-blend glow
  ran in YUV (and colorbalance pushed it further). Fix: `format=gbrp` before the split, colorbalance removed.
- End card: `endcard.ass` (Noto Serif Telugu, gold, complex shaping) burned in → `media/out/happy-diwali.mp4` (silent; add music on Instagram).
- YouTube music: **Raag Hamsadhwani** (Sandeep Das, Mayank Raina, Bivakar Chaudhuri), YouTube Audio Library,
  "YouTube Audio Library License" (no attribution needed). Used 1.0–21.0 s, 2 s fade-out, loudnorm → `media/out/happy-diwali-music.mp4`.
  Instagram: owner adds the music from the first AI reel in the app.

## Published

- **YouTube Short:** 2026-11-08 ~07:15 IST, public, UmaAI Studio (@UmaAIVideoStudio), playlist
  "భక్తి కథలు | Devotional Stories", AI use = Yes, not made for kids · https://youtube.com/shorts/d6YAm7o147w
  File: `media/out/happy-diwali-yt.mp4` (2-pass 3.3 Mbps, 8.6 MB, under the 10 MB browser-upload limit).
  Title: దీపావళి శుభాకాంక్షలు 🪔 Happy Diwali 2026 | UmaAI Studio
- **Instagram:** posted 2026-11-08 morning by the owner: `happy-diwali.mp4` + the first AI reel's music + the owner's own voice-over at the end (added in the app).
- 2026-11-08 afternoon: owner said the grade was "not up to the mark". Added `grade.sh … 1.0 epic` (teal shadows,
  gold highlights, S-curve, stronger glow, colour work in RGB) → `media/out/happy-diwali-epic.mp4` (reference;
  the posted versions use the soft grade). Epic 1.4 tested: skin too orange, Lakshmi blown out.
- Owner: epic still "orangish". Retuned: highlights and midtones near-neutral (only teal in shadows), glow 0.5→0.4,
  saturation +20%→+10%. colorbalance `pl=1` caused dark blotches in the sky: removed. Re-rendered happy-diwali-epic.mp4.
- Owner supplied a reference reel (devotional, matte film look; kept in media/reference, not reused). Measured it vs our
  cut: ref brighter (avg luma 104 vs 72), lifted blacks (p2 30 vs 5), less chroma (33 vs 47), creamy highlights
  (213,202,196 vs our yellow 230,202,152). New `grade.sh … film` matches those numbers + pro-mist diffusion and muted
  blues → `media/out/happy-diwali-film.mp4` (reference only). Owner: leave this video as posted; improve from the next.
- Owner rules for next videos (now in CLAUDE.md): young adults only, deities flawless and beautiful/handsome,
  otherworldly celestial jewellery, film grade.
