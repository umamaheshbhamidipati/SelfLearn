# SelfLearn — AI video learning + YouTube channel

Goal: learn AI video generation by making real videos, publish them to the owner's YouTube
channel, and grow subscribers slowly and honestly. Learning first; one finished video beats
ten perfect plans.

**Read first:** `docs/handoff-2026-11-15.md` (changes made by another session on 15 Nov) and
`docs/roadmap-2026-27.md` (money audit, gates and the 1-year plan).

## Tools (what each one is for)

| Job | Tool | Notes |
|---|---|---|
| Ideas, scripts, shot lists, Flow prompts, titles, descriptions | Claude | This repo |
| Video clips | Google Flow (Veo) | **Paid Flow PLUS plan, ₹399/month (`docs/finance.csv`). 200/month (resets the 15th) + 50/day per owner (25 Nov; daily part not fully confirmed). Spending rules: `docs/credit-plan.md`.** Plan from the balance Flow shows. Manual, in the browser only |
| Stills: thumbnails, character reference images | Nano Banana (in Flow / Gemini app) | Feed the reference image back into Flow for consistent characters |
| Voiceover (optional) | ElevenLabs free tier | Check the free tier's commercial-use terms before monetising |
| Editing | ffmpeg (`scripts/`); hand edits in Instagram's Edits app (phone) or Kdenlive (new PC). CapCut is blocked in India: phone only, optional polish, via the `capcut-mobile` skill with the owner's VPN connected (owner rule, 14 Nov 2026); never for the main cut | ffmpeg 8.0.1 installed 2026-11-05 |
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
- **Credits:** one monthly pool on the paid PLUS plan, resets on the 15th (the 50/day + 200/month figure was wrong: `docs/lessons.md`, 10 Nov). Record the balance in the project log before each batch. One 30 s Reel ≈ 150–250 credits,
  so 1–2 a week fits; reuse clips across videos.
- **Success metric:** average watch time and shares/saves, not likes. Baseline (first AI reel,
  15 Oct): 401 views, 0:02 average watch time, 0 shares/saves/follows. Next target: 5–8 s.

## Skill

`.claude/skills/ai-video-studio/` is the tested pipeline from Oct 2026 (a 30 s devotional Reel + a
4-min Telugu short-film plan): character stills in Nano Banana, image-to-video in Flow, clip review with
contact sheets, Reel rough cuts. Read its `SKILL.md` and `references/prompts.md` (prompt failure → fix
table) before planning a video. Measured: Veo 3.1 Lite = 10 credits per 8 s clip, ~1.5–2 tries per
usable clip, so a 30 s Reel ≈ 150–250 credits.

`.claude/skills/analytics-ingest/` (15 Nov 2026) keeps `docs/metrics.csv` complete: `docs/posts.csv` registers every
post, `scripts/metrics.py due` lists the readings due (1, 3, 7 and 28 days), `add` appends a checked row, `report`
compares against the roadmap targets. Use it for every number that goes into a log, verdict or lesson.

`.claude/skills/reference-teardown/` (15 Nov 2026) measures a reference video the owner supplies (cuts, shot lengths,
first 3 seconds, letterbox, loudness), gives frame sheets to look at and a teardown to fill in, and keeps the pattern
tally in `docs/reference-patterns.md`. A pattern needs three references and our own test before it becomes a rule.

## Workflow per video

1. `scripts/new-project.sh <slug>` → creates `projects/YYYY-MM-DD-<slug>/` from `templates/`.
2. Fill `brief.md` (idea, audience, length, format: Short 9:16 or long 16:9).
3. Claude writes `script.md` and `shots.md`: one Flow prompt per shot, using
   `templates/flow-prompt.md`. Repeat the same character/style block in every prompt.
4. **Pre-flight:** write each shot's "Must be true" list in `shots.md`; after generating, run `scripts/color_check.sh`, `scripts/vision_check.sh`, check every line YES/NO yourself and show the owner only a PASS/FAIL summary (`docs/preflight-checklist.md`; the owner has a full-time job). Every owner correction becomes a new line there.
   Plan credits in `shots.md` before generating: test prompts on the cheaper/fast mode,
   spend quality credits only on final shots. Log what each shot cost in `log.md`.
5. Generate in Flow (by hand, or Claude via Chrome with your Approve per clip); download clips to `projects/<slug>/media/clips/` as `01.mp4`, `02.mp4`…
6. Edit with `scripts/` (join, add audio, captions, Shorts crop). Final file in `media/out/`.
7. Publish: run the hook check in `publish.md` first, then post (Instagram first, then the same
   video as a YouTube Short). Tick YouTube's
   "altered or synthetic content" disclosure when the video shows realistic AI-made people,
   places or events.
8. On the day it is posted, register it: `metrics.py post`. After 7 days, fill the metrics table in `log.md` (average watch time and shares first) and add
   one lesson to `docs/lessons.md`.

## Look and casting (owner, 2026-11-08; applies from the next video)

- **Young adults only** (about 20–35). No elderly people, no children (Flow rejects children anyway).
- **Deities are divinely beautiful:** goddesses beautiful, gods handsome; flawless, crisp, luminous
  skin, no wrinkles, no blemishes. Soft peach skin tone, not orange.
- **Divine jewellery looks otherworldly, not human:** crowns and ornaments of glowing light,
  crystal and celestial metal, floating or levitating pieces, sacred geometry, inner light.
  Ordinary humans in a scene wear normal Telugu jewellery.
- **Grade:** default `GRADE_SCALE=1080:1920 scripts/grade.sh in out 1.0 rose` (matched to the owner's
  2nd reference: deep blacks, warm rose shadows, rosy skin, cream highlights, crisp). Alternative `film`
  (matte, 1st reference). Output 1080×1920 (lanczos + sharpen): sharper after Instagram/YouTube
  compression. Bake the look into the stills too (prompt words in
  `.claude/skills/ai-video-studio/references/prompts.md`); grading can't fix skin texture or age.
- **Sharpness:** Veo 3.1 Lite gives 720p. For hero/face shots, check if Flow offers 1080p / upscale
  and what it costs before the batch; ask the owner to approve the extra credits.

## Rules

- **Keep sessions small (owner, 15 Nov 2026).** Every call re-sends the whole conversation, and the plan's usage
  limit ran out mid-build when sessions reached 500k-830k tokens per call (14-15 Nov: about 330M tokens re-read in
  one day across SelfLearn and signaliq).
  - One session per video or task. At the start of a new task, say so and ask the owner to open a fresh session.
  - When context passes about 150k tokens, stop at the next safe point, write the state into the project's
    `log.md` (done, in progress, next step, open questions), commit the text, and ask the owner to compact or
    start a new session. Do not carry on past about 200k.
  - State lives in the repo (`CLAUDE.md`, the project's `.md` files, `docs/`), never only in the conversation.
  - Look at images sparingly: one small contact sheet per check, not full-size frames; each image is re-sent on
    every later call. Do bulk frame review in a subagent and keep only its verdict.
  - Routine build, render and logging steps do not need the largest model; suggest Sonnet for them.
- **No media in git.** Clips, audio and images stay in `media/` (gitignored). Back them up with
  `scripts/backup.sh` (rclone → `gdrive:SelfLearn/`). Commit the text (briefs, prompts, logs).
- **Flow is driven only through Claude in Chrome**, in the owner's signed-in browser. Since 25 Nov the
  owner approves **once a week**: the exact shot list plus a hard credit cap per tool (`docs/credit-plan.md`).
  Claude then clicks Approve once per clip in that list, stops at the cap, and never "Always approve". Anything beyond the approved batch needs a new OK. No unofficial APIs or CLIs
  (e.g. gflow-cli) and no headless bots on the Google account: account risk.
- **Never hide, crop out or blur the Flow/AI watermark.** Label AI content on YouTube and Instagram.
- **No copyrighted characters, logos, real people's likeness or music** in prompts or edits.
  Use YouTube Audio Library or royalty-free music; note the source in `publish.md`.
- **New PC plan (12 Nov 2026):** see `docs/pc-workflow-plan.md` (Ryzen 9 9900X, Ubuntu, 3090 later; laptop becomes server-only).
  The laptop rules below apply to the laptop only.
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
docs/        lessons.md (what worked), prompt-library.md, measurement.md + metrics.csv + experiments.md + finance.csv
```
