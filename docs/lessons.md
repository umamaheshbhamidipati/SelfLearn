# Lessons

One line per video: what worked, what to stop doing.

| Date | Video | Lesson |
|---|---|---|
| 2026-10-15 | First AI reel (goddess on a lion, Instagram) | 401 views but **0:02 average watch time**, 0 shares/saves/follows. Opened on a slow macro (water drops + part of a paw), grid tile was black (no cover), caption was about me ("My first AI video"), music was a Western dance track. Next: open on the face/hero shot, set a cover, devotional caption + hashtags, fitting audio. |
| 2026-11-05 | Diwali Lakshmi (edit) | Veo adds particles (coins, sparks) that drift across faces when the prompt mentions coins or fireworks near a close-up. For a calm end card, a slow push-in on the clean still (ffmpeg zoompan) beats a Veo clip and costs 0 credits. Check every shot with a 2 fps contact sheet before posting. |
| 2026-11-05 | Diwali Lakshmi (prompts) | A detailed character block + one action per shot + motion-only Flow prompts gave 10/10 usable Veo clips first try (100 credits, 0 re-rolls). |
| 2026-11-05 | Diwali Lakshmi (review) | Veo adds long blinks and keeps actions going (person walks off): check close-ups with labelled 2 fps frame strips and trim to the good window before cutting. |
| 2026-11-05 | Diwali Lakshmi (Telugu text) | Telugu needs libass complex shaping (ASS + `shaping=complex`), letter spacing 0, and a Latin fallback font; `subtitles` and `drawtext` break clusters. |
| 2026-11-05 | Diwali Lakshmi (voice) | Owner's own Telugu voice, split into one file per line, is easy to place on shots and sounds better than AI Telugu voices. |
| 2026-11-05 | Diwali Lakshmi (publishing) | Confirm the exact publish time in chat before the last click; Chrome uploads are limited to 10 MB (two-pass re-encode to fit). |
| 2026-11-08 | Diwali Lakshmi (3-day numbers) | Hero-face opening + devotional caption + Telugu voice: IG average watch 0:02 → 0:04, first share and follow; YouTube Short 0:25 avg (85%) and +4 subs from 256 views. But 75.8% swipe away on YouTube: the very first second still needs motion + the question. |
| 2026-11-08 | Happy Diwali (structure) | Reference-reel structure (fast 1–2 s cuts, adult reaction faces, one spectacle, gold Telugu title card) worked: the YouTube Short averaged **132.7 % viewed** in its first 3½ hours (people rewatched), against 85 % for the Lakshmi Short. Keep this structure for festival greetings. |
| 2026-11-08 | Happy Diwali (stills) | Two hand actions in one prompt ("holds a diya" + "namaste") gave a **three-handed** grandmother; "head on his shoulder" gave a **bent neck**. One hand action per still, ask for upright heads, and count hands and arms on every still before animating. |
| 2026-11-08 | Happy Diwali (stills) | "Anamorphic film still" makes Nano Banana add **black letterbox bars**. Always write "FULL-FRAME 9:16 edge to edge, no black bars". Generating stills inside Flow (Nano Banana, 0 credits) avoids Gemini's stuck full-size downloads. |
| 2026-11-08 | Happy Diwali (credits) | 10 clips ≈ 100 credits; a failed clip ("audio generation" error) is not charged. Approved budget (120) was enough. |
| 2026-11-08 | Happy Diwali (grade) | Do all colour work in **RGB** (`format=gbrp`): a screen-blend glow in YUV turned the whole video **purple**. Always check a graded frame next to the ungraded one before rendering the full video. |
| 2026-11-08 | Happy Diwali (grade) | The owner's "blurry" was my bug: ffmpeg `blend=all_mode=normal` weights the **first** input by the opacity, so a "12 % mist" was 88 % blur. Compare a **100 % face crop** (raw vs graded) after any grade change; output 1080×1920 (lanczos + `cas` sharpen) so platforms compress less. |
| 2026-11-08 | Happy Diwali (grade) | Guessing a grade went wrong twice (too dark and orange). Matching an owner-supplied reference **by numbers** (black level, average brightness, saturation, RGB in shadows/mids/highlights) got close in one pass. Different references want different looks: `film` (matte) and `rose` (deep blacks, rose shadows; now the default). |
| 2026-11-08 | Happy Diwali (look) | Grading can't fix age, wrinkles or plain jewellery: **the still decides the look**. Owner rules from now: young adults only; deities flawless and beautiful/handsome; otherworldly celestial jewellery. Still quality gate in the skill; owner OKs a contact sheet before any credits. |
| 2026-11-08 | Happy Diwali (music) | YouTube Studio on desktop can't add music to a Short: mix a YouTube Audio Library track in with ffmpeg (YouTube Audio Library License = no credit needed). I can't hear audio: send the owner a preview to approve on the phone. |
| 2026-11-08 | Channel setup | Multi-language audio on YouTube needs **Advanced features** (phone verification only unlocks Intermediate). The AI Studio speech playground needs a Gemini API key. Instagram's Meta AI translation dubs Telugu speech, so reels need narration for it to work. Plan: `docs/multilingual-voice-plan.md`. |

Full retro with every failure and fix: `docs/2026-11-05-retro.md`.
