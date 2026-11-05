# AI Video Studio — a Claude skill for Google AI (Nano Banana + Flow)

The workflow used (Oct 2026) to make a 30-second devotional Reel and plan a 4-minute Telugu short film,
with Claude doing most of the clicking, prompting, reviewing and editing. Now part of the SelfLearn repo.

## What I actually did (one afternoon)

1. **Stills in Gemini (Nano Banana).** Claude wrote one "master character" prompt (a goddess on a lion in a
   lotus pond, 1980s Indian film look). I generated it in the Gemini app, then 9 more shots in the *same chat*,
   each saying "use the master image as the exact character reference". Same face in all 10.
2. **Claude reviewed every still** and flagged problems (e.g. one image looked like a bad cut-out; one had a
   child, which Google Flow later refused to animate — so we replaced it).
3. **Tried the free video tools.** Firefly (100 credits a clip, 540p), Kling (20 credits a clip, slow queue),
   Gemini app video (paywalled). **Google Flow won**: 10 credits per 8-second 720p Veo 3.1 Lite clip, 50 free
   credits a day, best quality and character consistency.
4. **Claude drove Flow in my Chrome** (Claude in Chrome extension): uploaded the stills, wrote a motion prompt
   for each, and stopped at every "costing 10 credits?" for an Approve. Then downloaded the clips.
5. **Claude checked every clip frame by frame** with ffmpeg contact sheets. Two clips were wrong (pair
   floating over the water, lion's mouth frozen open). It rewrote the prompts and we re-rolled them.
6. **Claude cut the film with ffmpeg**: 30 s, 2–3 s cuts, one long hero shot, warm film grade, muted —
   music gets added in Instagram's own library so the Reel isn't muted for copyright
   (for YouTube: YouTube Audio Library, see SKILL.md).
7. **Studied a viral reel** (140K likes) shot by shot to learn its rhythm, then re-cut ours to match.
8. **Wrote a 4-minute Telugu short film script** (narration + lip-synced lines) with a shot list and a credit
   budget (~420 credits ≈ a week of daily credits).

Cost: ₹0 for the Reel on free tiers; I later took Google AI Plus (₹399/month, +200 Flow credits, 1080p).

## Install

Already installed: this folder lives at `SelfLearn/.claude/skills/ai-video-studio/`, so Claude Code loads it
whenever a session runs in `~/code/SelfLearn`. Needs ffmpeg (installed 2026-11-05) and, for driving Flow,
the Claude in Chrome extension with Gemini and Flow signed in. Work inside `projects/<date-slug>/media/`
(create one with `scripts/new-project.sh <slug>` from the repo root).

## First prompt to try

> Use the ai-video-studio skill. I want a 30-second Reel about <topic>. Write the master character prompt and
> 10 shot prompts, I'll generate them in Gemini and save to <folder>. Then animate them in Google Flow with
> Veo 3.1 Lite, review each clip, and make a rough cut.

## What's inside

| File | What it is |
|---|---|
| `SKILL.md` | The pipeline Claude follows (plan → stills → Flow → review → edit) and the ground rules |
| `references/prompts.md` | Still + motion prompt templates and a "what went wrong → prompt fix" table |
| `references/browser-gotchas.md` | How Claude uploads files into Flow, download quirks, popups, free-tier numbers |
| `references/script-template.md` | Template for a short-film script with shot list and credit budget |
| `scripts/contact_sheet.sh` | 6 frames from a clip side by side — how Claude "watches" a video |
| `scripts/roughcut.sh` | Cut list → finished 9:16 rough cut with crossfades and optional warm grade |
| `scripts/shot_detect.sh` | Finds cut points in a reference reel |
| `scripts/cut_list.example.txt` | The cut list from my Reel, as a starting point |

## Rules I kept (worth keeping)
- Approve each credit spend yourself; never click "Always approve".
- Claude doesn't buy plans or post for you — you do those.
- No children in images for Google tools; reference reels are for learning structure, never for copying.
- Expect 1.5–2 tries per usable clip; budget credits accordingly.
