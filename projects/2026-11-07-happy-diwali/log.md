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
