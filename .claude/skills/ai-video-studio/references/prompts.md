# Prompt templates that worked

## Master character still (Gemini / Nano Banana)

```
Cinematic 35mm film still, 1980s Indian mythological cinema style. [CHARACTER: face, crown/hair,
jewellery, costume colours in detail], [POSE / ACTION], [SETTING]. Misty twilight, glittering bokeh,
warm Kodak tones, soft film grain, shallow depth of field. Vertical 9:16.
```
Rule of thumb: **look → subject → setting → camera → ratio**. Spell out costume colours; vague costumes drift.

### UmaAI look blocks (owner rules, 2026-11-08: see CLAUDE.md "Look and casting")

Look (every still; matches the owner's 2nd reference, the default):
```
Ultra-detailed cinematic portrait still, warm golden-hour backlight with a soft rim light on the hair,
rose-gold and blush-pink palette, deep rich shadows with a warm rose tint, creamy highlights,
razor-sharp focus on the eyes, shallow depth of field with soft bokeh. Vertical 9:16, full frame
edge to edge, no black bars.
```
Alternative matte look (1st reference): `Matte cinematic film still, Kodak Portra 400 look, soft diffused
light, lifted soft blacks, muted olive-teal background, creamy highlights, fine film grain.`
Deity (add to the character line):
```
Divinely beautiful [goddess / handsome god], youthful face (about 25), flawless crisp luminous
skin with a soft peach glow, no wrinkles, no blemishes, serene eyes.
Otherworldly celestial jewellery, not human-made: a crown of woven light and translucent crystal,
ornaments of glowing celestial metal with inner light, small pieces floating weightlessly around
the head and arms, faint sacred-geometry patterns shimmering in the gold.
```
People in the scene: `young Telugu adults in their twenties, natural healthy skin, [attire]`.
Never: old / elderly / grandmother / children.

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
| Objects duplicate / vanish when a character releases something (Karthika 09: diya floats off but the plate still holds a diya, then the plate disappears) | Avoid "let go / release / drop" actions. Keep objects in hand: "they hold the plate with the lit diya between them the whole time; nothing appears or disappears". Name the object exactly as it is in the still (plate + diya, not just "diya"). Or trim to the seconds before the release. If the story needs the object to change state (diya set afloat, plate left empty), make an END-frame still in Nano Banana (0 credits) and animate first + last frame so Veo knows where every object ends up |
| Diya flame grows huge and dominates the face (Karthika 01: prompt said "the flame grows") | Never ask fire to grow. "the small diya flame stays small and steady, fingertip size, flickers gently, does not grow or flare; it does not cover her face or hands" |

## Caption pattern for devotional reels
Short poetic lines (one idea per line) → the story in 2–3 lines → festival/day tie-in → 3–5 hashtags.
Mark "AI content" (Instagram label).
