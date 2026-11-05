# SelfLearn — AI video learning + YouTube channel

Goal: learn AI video generation by making real videos, publish them to the owner's YouTube
channel, and grow subscribers slowly and honestly. Learning first; one finished video beats
ten perfect plans.

## Tools (what each one is for)

| Job | Tool | Notes |
|---|---|---|
| Ideas, scripts, shot lists, Flow prompts, titles, descriptions | Claude | This repo |
| Video clips | Google Flow (Veo) | **Credits: 50/day + 200/month.** Manual, in the browser only |
| Stills: thumbnails, character reference images | Nano Banana (in Flow / Gemini app) | Feed the reference image back into Flow for consistent characters |
| Voiceover (optional) | ElevenLabs free tier | Check the free tier's commercial-use terms before monetising |
| Editing | ffmpeg (`scripts/`), CapCut for hand edits | ffmpeg 8.0.1 installed 2026-11-05 |
| YouTube SEO | vidIQ free extension, YouTube Studio analytics | |

## Channel plan (decided 2026-11-05)

- **Channel:** **UmaAI**, AI-made Telugu short stories. Devotional / mythological is the first
  series (Diwali Lakshmi, Nov 2026); other, non-devotional short stories come later. Keep each
  series in its own YouTube playlist and give each a consistent look and title prefix, so viewers
  of one series can find more of the same. Language: Telugu (captions in Telugu; English title
  line optional).
- **Primary: Instagram @umamaheshbhamidipati** (426 followers on 2026-11-05; Telugu audience that
  already watches its temple/devotional reels). 1–2 Reels a week, 20–30 s, 9:16.
- **YouTube: brand channel "UmaAI Studio", @UmaAIVideoStudio** (created by the owner 2026-11-05,
  youtube.com/@UmaAIVideoStudio) for the same videos as Shorts.
  The personal channel @UmaMaheshBhamidipati (332 subs; hit = a 139K-view repair how-to) stays
  tech/repair; Telugu "how I make AI videos" tutorials may go there later.
- **Credits:** ~350/week free (50/day) + 200/month ≈ 400/week. One 30 s Reel ≈ 150–250 credits,
  so 1–2 a week fits; reuse clips across videos.
- **Success metric:** average watch time and shares/saves, not likes. Baseline (first AI reel,
  15 Oct): 401 views, 0:02 average watch time, 0 shares/saves/follows. Next target: 5–8 s.

## Skill

`.claude/skills/ai-video-studio/` is the tested pipeline from Oct 2026 (a 30 s devotional Reel + a
4-min Telugu short-film plan): character stills in Nano Banana, image-to-video in Flow, clip review with
contact sheets, Reel rough cuts. Read its `SKILL.md` and `references/prompts.md` (prompt failure → fix
table) before planning a video. Measured: Veo 3.1 Lite = 10 credits per 8 s clip, ~1.5–2 tries per
usable clip, so a 30 s Reel ≈ 150–250 credits.

## Workflow per video

1. `scripts/new-project.sh <slug>` → creates `projects/YYYY-MM-DD-<slug>/` from `templates/`.
2. Fill `brief.md` (idea, audience, length, format: Short 9:16 or long 16:9).
3. Claude writes `script.md` and `shots.md`: one Flow prompt per shot, using
   `templates/flow-prompt.md`. Repeat the same character/style block in every prompt.
4. Plan credits in `shots.md` before generating: test prompts on the cheaper/fast mode,
   spend quality credits only on final shots. Log what each shot cost in `log.md`.
5. Generate in Flow (by hand, or Claude via Chrome with your Approve per clip); download clips to `projects/<slug>/media/clips/` as `01.mp4`, `02.mp4`…
6. Edit with `scripts/` (join, add audio, captions, Shorts crop). Final file in `media/out/`.
7. Publish: run the hook check in `publish.md` first, then post (Instagram first, then the same
   video as a YouTube Short). Tick YouTube's
   "altered or synthetic content" disclosure when the video shows realistic AI-made people,
   places or events.
8. After 7 days, fill the metrics table in `log.md` (average watch time and shares first) and add
   one lesson to `docs/lessons.md`.

## Rules

- **No media in git.** Clips, audio and images stay in `media/` (gitignored). Back them up with
  `scripts/backup.sh` (rclone → `gdrive:SelfLearn/`). Commit the text (briefs, prompts, logs).
- **Flow is driven only through Claude in Chrome**, in the owner's signed-in browser. The owner
  approves each batch in chat (which clips, how many credits); Claude then clicks Approve once per
  clip in that batch and never "Always approve". Anything beyond the approved batch needs a new OK. No unofficial APIs or CLIs
  (e.g. gflow-cli) and no headless bots on the Google account: account risk.
- **Never hide, crop out or blur the Flow/AI watermark.** Label AI content on YouTube and Instagram.
- **No copyrighted characters, logos, real people's likeness or music** in prompts or edits.
  Use YouTube Audio Library or royalty-free music; note the source in `publish.md`.
- **This laptop is slow (AMD A4-5000).** Re-encoding 1 min of 1080p takes minutes. Prefer
  stream copy (`join.sh` does this when clips match). Run long encodes outside 09:00–15:35
  so they don't compete with the Kite bot. No Remotion/heavy renders here.
- Commit and push after each video's text is done (GitHub is the source of truth).
- Never commit secrets. API keys, if ever needed, go in `.env` (chmod 600, gitignored).

## Layout

```
.claude/skills/ai-video-studio/   the Flow + Nano Banana pipeline skill (SKILL.md, prompts, review/cut scripts)
templates/   brief, flow-prompt, shots, publish, log templates (copied per project)
scripts/     ffmpeg + backup helpers (bash; run from the repo root)
projects/    one folder per video: YYYY-MM-DD-slug/{brief,script,shots,publish,log}.md + media/
docs/        lessons.md (what worked), prompt-library.md (prompts worth reusing)
```
