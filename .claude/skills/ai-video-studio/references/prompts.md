# Prompt templates that worked

## Master character still (Gemini / Nano Banana)

```
Cinematic 35mm film still, 1980s Indian mythological cinema style. [CHARACTER: face, crown/hair,
jewellery, costume colours in detail], [POSE / ACTION], [SETTING]. Misty twilight, glittering bokeh,
warm Kodak tones, soft film grain, shallow depth of field. Vertical 9:16.
```
Rule of thumb: **look → subject → setting → camera → ratio**. Spell out costume colours; vague costumes drift.

## Follow-up stills (same chat)

```
Using the [master image above / attached image] as the exact character reference (same face, crown,
jewellery, saree, lion), create a new 9:16 cinematic 35mm film still, [same look words]. Shot: [ONE SHOT LINE].
Keep the character identical. No text, no watermark, no extra fingers, no distorted face.
```

Good shot lines (vary scale every shot):
- Extreme wide establishing shot, tiny figure far away, a giant leaf framing the top
- Medium shot, walking toward camera, right hand raised in blessing
- Face close-up, calm eyes to camera, jewellery glinting, soft rim light
- Extreme macro of a jewelled hand holding a lotus
- Macro of a paw on a wet leaf, droplets
- Top-down view of glittering water, tiny glowing figure
- Low-angle hero shot, halo behind, lion roaring
- Back-view silhouette on a lotus platform, mist, aurora

## Motion prompts (Flow / Veo, image = first frame)

Describe **motion only** — the image already defines the look.

```
Animate this image into one 9:16 video using Veo 3.1 Lite, image as the first frame.
Motion: [ONE main action] , [1–2 secondary motions: hair, cloth, mist, sparkles], [ONE camera move].
[look words]. Keep face, crown and costume identical, smooth natural motion, no morphing.
```

Camera moves: slow push-in · dolly back · slow orbit · overhead drone drift · static camera · rack focus.

## Failure → fix table (from real re-rolls)

| What went wrong | Prompt fix |
|---|---|
| Characters float / slide over water like a sticker | "walks with clear natural leg movement, paws stepping through the water making splashes and ripples, grounded, realistic scale and physics, no floating or sliding" |
| Mouth stuck open for the whole clip (frozen roar) | Sequence it: "first closes its mouth and stands calm, then lets out ONE roar, then closes its mouth again" |
| Neon / oversaturated colour | "natural colours, no neon, warm golden-hour light" — but Flow keeps the first frame's palette, so fix the *still* if colour matters |
| Subject barely moves | Name a bigger action + a camera move; avoid only "subtle" verbs |
| Figure grows / rushes toward camera in a wide | "stays small and far away in the frame, moving only a little" |
| Face drifts between clips | Regenerate the still from the master in the same chat; keep prompts listing the same costume words |
| Upload vanishes at ~93% | Image contains a child → remove the child from the still |

## Caption pattern for devotional reels
Short poetic lines (one idea per line) → the story in 2–3 lines → festival/day tie-in → 3–5 hashtags.
Mark "AI content" (Instagram label).
