# UmaAI intelligence: what works, measured

Index for the production knowledge base (started 14 Nov 2026, owner brief "Autonomous AI filmmaking engine").
Load only the file you need. Existing docs are linked, not copied.

## Which tool for which job
| Job | Tool | Why |
|---|---|---|
| Moving pictures, character motion, atmosphere | Google Flow (Veo 3.1 Lite, 10 credits / 8 s clip) | only source of real motion |
| Stills, character references | Nano Banana in Flow (0 credits) | reference image keeps the character consistent |
| Cut, narration timing, Telugu captions, grade, sound mix, encodes | ffmpeg on the laptop (`scripts/`, per-project `cut_*.sh`) | reproducible, re-runnable, no watermark |
| Light rays with streaks, effect packs, quick dissolves by hand | CapCut on the phone (skill `capcut-mobile`) | only when ffmpeg cannot match it; adds a re-encode and an end card |

Push-ins and zooms made in ffmpeg or CapCut are digital moves on a finished frame, not camera moves. Say so in reports.

## Where things live
- Flow: `flow-intelligence/README.md` -> `.claude/skills/ai-video-studio/references/prompts.md` (failure -> fix table), per-project `log.md` (credits), `docs/lessons.md`.
- ffmpeg: `ffmpeg-intelligence/recipes.md` (tested filter recipes), `scripts/`, `.claude/skills/ai-video-studio/scripts/`.
- CapCut: `capcut-intelligence/catalogue.md` (tested effects), `docs/capcut-phone-recipe.md`, skill `capcut-mobile`.
- Recipes by genre: `cinematic-recipes/mythological.md`.
- Quality: `quality-intelligence/metrics.csv` (one row per production), `docs/preflight-checklist.md`, `docs/metrics.csv` (audience).

## Baseline audit, 14 Nov 2026 (checked by command, not assumed)
- Laptop: ffmpeg 8.0.1 with xfade, zoompan, gblur, blend, overlay, curves, lut3d, ass/subtitles, drawtext, ebur128, loudnorm, sidechaincompress, minterpolate; libx264/libx265/aac; 6 Telugu fonts; Python 3.14; 187 GB free. CPU is the limit (AMD A4-5000): 1080p encodes take minutes, no long encodes 09:00-15:35.
- Phone: Realme RMX2117 over USB adb, scrcpy 3.3.4, CapCut 20.1.0 activated (needs the owner's VPN; never touch VPN or system settings).
- Flow: reached through Claude in Chrome in the owner's signed-in browser. Balance read 19:25 IST: 50 credits, resets 15 Nov 3:47 PM. Visible watermarking is on (required in region).
- Repo: 4 video projects (Lakshmi, Happy Diwali, Karthika Deepam, Samudra Manthan), 11 scripts, skills `ai-video-studio` and `capcut-mobile`, templates, lessons, metrics.
- Published: Ep 1 scheduled on YouTube Mon 16 Nov 7:30 AM IST. Ep 2 re-planned (9 shots), clips 06 and 08 made, 5 clips to go.

## Limits that stay in force (CLAUDE.md)
No publishing, purchases, account sign-ins, VPN or system-setting changes without the owner. Never hide the AI watermark.
No copyrighted music or likenesses. Media stays out of git.
