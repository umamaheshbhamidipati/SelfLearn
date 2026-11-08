---
name: ai-video-studio
description: Make short AI films and Reels with Google AI tools driven by Claude — character stills in Gemini (Nano Banana), image-to-video clips in Google Flow (Veo), review and edit with ffmpeg. Use when the user wants to plan, generate, review, cut or post an AI video, reel, short film, or wants to study a reference reel. Triggers on "AI video", "reel", "short film", "Nano Banana", "Google Flow", "Veo", "animate this image", "rough cut".
---

# AI Video Studio (Claude + Gemini Nano Banana + Google Flow)

A tested pipeline for making 30-second Reels up to 5-minute AI short films. Claude plans, writes
prompts, drives the browser, reviews every clip frame by frame, and cuts the film with ffmpeg.
The human approves spending, purchases and anything that gets posted.

## Tools this skill expects

| Need | Tool |
|---|---|
| Drive Gemini / Flow / Instagram in the user's signed-in browser | Claude in Chrome (`mcp__claude-in-chrome__*`) |
| Character stills | Gemini app → image generation (Nano Banana) |
| Image → video | Google Flow (flow.google.com), Veo 3.1 Lite / Omni Flash |
| Backup video tools | Kling (kling.ai), Adobe Firefly video, Higgsfield MCP if connected |
| Review + edit | ffmpeg (on PATH). This skill's `scripts/` for review and Reel cuts; the repo's root `scripts/` for YouTube (join, audio, captions, Shorts) |

## Ground rules (always)

- **Never spend credits or money without the user's go-ahead for that batch.** Approve each Flow clip with
  "Approve", never "Always approve". Never buy plans — the user buys them.
- **Never post** to Instagram/YouTube for the user without explicit approval of the exact video + caption.
- **No children in source images.** Flow silently rejects them (upload reaches ~93% then vanishes, no error).
- Accept privacy policies / terms only after the user says yes. Leave marketing opt-ins unticked.
- Reference reels from other creators are for studying structure only — never copy their footage, caption or music choice.
- Work in the project folder `projects/YYYY-MM-DD-<slug>/media/` → `stills/`, `clips/`, `clips/old/`, `out/`
  (gitignored; back up with `scripts/backup.sh`). Plans, prompts and logs go in the project's `.md` files.
- **Never hide or crop out the Flow/AI watermark**, and label AI content on every platform.

## The pipeline

### 1. Plan
- For a Reel: 10–15 shots, ~30 s, one colour palette, one visual motif.
- For a short film: write the script first (see `references/script-template.md`). Budget clips: usable ≈ 6 s per
  8 s clip, retries ×1.5–2. Flow Lite = 10 credits/clip.
- Mark each shot NEW / REUSE / LIP-SYNC.

### 2. Character master still (Gemini, Nano Banana)
- One prompt builds the master character: look first (style, film stock), then subject, then setting, then camera,
  then `Vertical 9:16`. See `references/prompts.md`.
- Every later still: *"Using the [master] image as the exact character reference (same face, crown, jewellery,
  costume) …"* + one shot line. Doing all stills in the **same Gemini chat** keeps the face consistent and lets you
  reference "the master image above" without re-uploading.
- Review every still before animating — fix drift now, it only gets worse in video.
- **Still quality gate** (owner, 2026-11-08: "image generation plays the key role"). A still is animated only
  if it passes all of these; otherwise regenerate it (stills cost 0 credits, clips cost 10):
  1. Faces: young adult (no elderly, no children); deity flawless, crisp, no wrinkles, eyes in sharp focus.
  2. Anatomy: count hands, fingers and arms (deities: exactly four arms, all attached); no bent necks.
  3. Jewellery: deities wear otherworldly light/crystal ornaments; humans wear normal Telugu jewellery.
  4. Light and palette: golden backlight or rim light, rose-gold palette, deep blacks, not orange.
  5. Frame: full 9:16 edge to edge, no black bars, no text or logos.
  6. Zoom check: crop the face at 100 % (`ffmpeg … crop`) and look. Soft or smeared → regenerate.
  Send the owner a contact sheet of the stills and get an OK before spending Flow credits.
- Download: click the last "Download full size image" button
  (`[...document.querySelectorAll('button')].filter(b=>(b.getAttribute('aria-label')||'').includes('Download full size')).pop().click()`).

### 3. Animate (Google Flow)
1. Check credits: avatar menu shows "N Google Flow credits" and the daily refresh time. Free = 50/day (no
   rollover); AI Plus adds 200/month and unlocks 1080p download.
2. Agent settings (sliders icon in the right panel): video 9:16, x1, **Veo 3.1 - Lite** (10 credits). Keep
   "Confirm before generating: Always".
3. Upload stills (see the file-input trick in `references/browser-gotchas.md`).
4. Right-click the image → **Animate** → type a *motion-only* prompt → click the **send arrow** (Enter often doesn't send).
5. Agent replies "costing 10 credits?" → **Approve**. Flow renders ~1 min per clip; queue them one after another.
6. Download: right-click video → Download → **720p** (keep one resolution across the film).
7. Free video is often blocked 2–5 PM UTC (7:30–10:30 PM IST). Generate earlier.

### 4. Review every clip (never trust the thumbnail)
```bash
bash scripts/contact_sheet.sh clip.mp4 sheet.jpg      # 6 frames across the clip, side by side
```
Read the sheet and check: same face/costume, motion actually happened, no floating/sliding, no frozen pose,
palette matches, no morphing hands. Re-roll bad clips with a sharper prompt (see failure table in `references/prompts.md`).

### 5. Edit
```bash
bash scripts/roughcut.sh cut_list.txt out.mp4          # crossfades, crop, optional warm grade
```
`cut_list.txt` lines: `path|start|duration|transition` (transition = fade, fadewhite, fadeblack, …).
Rhythm: **open on the strongest image (face or hero shot) as the very first frame**, 2–3 s cuts,
one long hero shot (5–6 s), end on the blessing/payoff shot. (Updated 2026-11-05: the first reel
opened on a slow detail shot and kept viewers only 2 s on average. See `docs/lessons.md`.)
No fade-in from black (`roughcut.sh` has none unless `--fade-in`). Set a cover frame when posting. Mute the export — add licensed
music in Instagram's own audio library.

### 5b. YouTube versions
- Long video (16:9): generate clips in 16:9, then from the repo root
  `scripts/join.sh` → `scripts/add-audio.sh --voice/--music` → `scripts/captions.sh`.
- Short (9:16): either generate 9:16 and use `roughcut.sh`, or convert a 16:9 cut with `scripts/shorts.sh`.
- Music: YouTube Audio Library (or another licence you can show); note it in `publish.md`.
- Tick YouTube's "altered or synthetic content" box for realistic AI people, places or events.
- This laptop is slow: run re-encodes outside 09:00–15:35 (the trading bot runs then).

### 6. Study a reference reel (optional)
User downloads the reel file. Then:
```bash
bash scripts/shot_detect.sh ref.mp4        # cut timestamps
bash scripts/contact_sheet.sh ref.mp4 ref_grid.jpg 24
```
Write a shot table: time, shot size, action, purpose. Copy the *structure*, not the content.

## Credit maths (Flow, Oct 2026)

| Output | Clips | Credits incl. retries | Free-tier days (50/day) |
|---|---|---|---|
| 30 s Reel | 10–12 | 150–250 | 3–5 |
| 4 min short | ~30 new | ~420 | 6–9 |
| 10 min film | ~100 | 1,500–2,000 | ~30–40 |

## Lip-sync (dialogue)
Generate the speaking shot silent (face visible, mouth closed, near-camera), record the line as audio, then use
Kling's **Lip Sync** on the clip. Veo can speak quoted lines itself but non-English (e.g. Telugu) pronunciation
is unproven — test one line before committing a whole film.
