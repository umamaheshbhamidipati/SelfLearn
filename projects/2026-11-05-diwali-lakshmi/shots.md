# Shots — Diwali: why Lakshmi Devi comes home

**Character block (copy word for word into every Lakshmi prompt):**
Goddess Lakshmi as a serene adult woman, warm golden-brown skin, large calm kohl-lined eyes,
red bindi, ornate gold crown with rubies, long black hair, heavy gold temple jewellery
(layered necklaces, jhumka earrings, armlets), deep red silk saree with a wide gold zari border,
four arms: upper two hands each hold a pink lotus, lower right hand raised in blessing,
lower left hand releasing gold coins.

**Style block (every prompt):**
Cinematic 35mm film still, 1980s Indian mythological cinema style, warm Kodak tones, soft film
grain, shallow depth of field, palette of glowing diya-gold and deep night blue. Vertical 9:16.
No text, no watermark, no extra fingers, no distorted face.

**Rule from the first reel:** shot 01 (her face) must be the first frame. No slow detail opening.

| # | Used (s) | What happens | Mode | Status |
|---|---|---|---|---|
| 01 | 0–3 | **HOOK** face close-up, diya light, eyes to camera | Lite | clip ✅ |
| 02 | 3–6 | Milk ocean churning at night, golden light rising | Lite | clip ✅ |
| 03 | 6–9 | Pink lotus rising from the glowing waves and opening | Lite | clip ✅ |
| 04 | 9–14 | **HERO** Lakshmi standing on the lotus, low angle, halo | Lite | clip ✅ |
| 05 | 14–17 | Two white elephants raise trunks and shower water | Lite | clip ✅ |
| 06 | 17–19 | Macro: gold coins falling from her palm | Lite | still ✅ |
| 07 | 19–22 | Village street at night, rows of diyas, muggulu (rangoli) | Lite | still ✅ |
| 08 | 22–24 | Lakshmi's red footprints on a doorstep, diyas glowing | Lite | still ✅ |
| 09 | 24–27 | Lakshmi steps through a lamp-lit doorway, blessing | Lite | still ✅ |
| 10 | 27–30 | Blessing to camera, fireworks behind (end card) | Lite | still ✅ |

10 clips × 10 credits = 100, plus ~50 for re-rolls.

Stills generated 2026-11-05 in one Gemini chat ("1980s Mythological Goddess Lakshmi Portrait"),
1536×2752 PNG in `media/stills/` (00-master + 01–10). 08 re-rolled once: first version had the
footprints walking out of the house (kept as `08-v1-outward.png`). Face consistent across
00/01/04/09/10; four arms intact in 04/09/10. 06 came out palm-up (fine).
Risk: four arms can morph in motion. If they do, re-roll once with "four arms stay still and
complete"; if still bad, regenerate that still with only the blessing hand visible.

---

## Step 1: master still (Gemini → image, new chat)

```
Cinematic 35mm film still, 1980s Indian mythological cinema style. Goddess Lakshmi as a serene
adult woman, warm golden-brown skin, large calm kohl-lined eyes, red bindi, ornate gold crown with
rubies, long black hair, heavy gold temple jewellery (layered necklaces, jhumka earrings, armlets),
deep red silk saree with a wide gold zari border, four arms: upper two hands each hold a pink lotus,
lower right hand raised in blessing, lower left hand releasing gold coins. Standing on a large pink
lotus floating on a calm glowing ocean at night, soft golden halo behind her head, hundreds of tiny
diya lights floating on the water. Full-body frontal shot, eye level. Warm Kodak tones, soft film
grain, shallow depth of field, palette of glowing diya-gold and deep night blue. Vertical 9:16.
No text, no watermark, no extra fingers, no distorted face.
```
Check before going on: face pleasant and calm, exactly four arms, hands correct, saree red + gold.
Re-generate until it is right: every other shot copies this face.

## Step 2: the other stills (same Gemini chat)

Start each with:
```
Using the master image above as the exact character reference (same face, crown, jewellery,
red-and-gold saree, four arms), create a new 9:16 cinematic 35mm film still in the same 1980s
Indian mythological cinema look, warm Kodak tones, diya-gold and night-blue palette. Shot: <SHOT LINE>.
Keep the character identical. No text, no watermark, no extra fingers, no distorted face.
```
(For shots 02, 03, 05, 06, 07, 08 that do not show her face, keep the look words but drop
"keep the character identical".)

| # | SHOT LINE |
|---|---|
| 01 | Tight face close-up, calm eyes looking straight into the camera, warm flickering diya light on her face from below, gold crown and jhumkas glinting, blurred diya bokeh behind |
| 02 | Extreme wide shot of a vast milky-white ocean at night, huge swirling waves, a column of golden light rising from the centre, stars above (no people) |
| 03 | Close shot of a giant pink lotus bud rising out of glowing milky waves, petals beginning to open, golden light spilling from inside |
| 04 | Low-angle hero shot, Lakshmi standing tall on the open lotus, four arms with two lotuses, blessing hand and gold coins, bright golden halo, mist and sparkles |
| 05 | Two majestic white elephants standing in the glowing ocean on either side of the frame, trunks raised high, water arcing from their trunks, golden mist (Lakshmi small in the centre, far away) |
| 06 | Extreme macro of her jewelled lower left hand, palm down, gold coins falling and catching the light, dark blue background |
| 07 | Night street of a traditional Andhra village, rows of lit clay diyas along every doorstep, white muggulu rangoli patterns on the ground, one adult woman in a saree placing a diya, warm glow, no children |
| 08 | Close shot of a house threshold at night painted with small red footprints walking inward (Lakshmi's footprints), clay diyas on both sides, mango-leaf toran above the door |
| 09 | Medium shot from inside a lamp-lit home, Lakshmi stepping in through the open wooden doorway, blessing hand raised, diyas glowing at her feet |
| 10 | Medium close-up, Lakshmi smiling gently and raising her blessing hand to the camera, golden fireworks bursting in the night sky behind her |

Save as `media/stills/01.png` … `10.png`.

## Step 3: motion prompts (Flow, Veo 3.1 Lite, 9:16, image = first frame)

Prefix every one with: `Animate this image into one 9:16 video, image as the first frame.`
Suffix every one with: `Warm 1980s film look. Keep face, crown, jewellery and saree identical, smooth natural motion, no morphing, no text.`

| # | Motion |
|---|---|
| 01 | She slowly blinks once and her eyes stay on the camera; diya flames flicker on her face; earrings sway slightly; very slow push-in. |
| 02 | Huge milky waves swirl and churn in a slow spiral; the column of golden light grows brighter; slow aerial drone drift forward. |
| 03 | The lotus rises out of the waves and its petals open fully, golden light pouring out; water drips from the petals; static camera. |
| 04 | She rises gently upward on the lotus, the halo brightens, mist and sparkles drift around her, gold coins fall from her lower left hand; four arms stay complete; slow tilt up. |
| 05 | Both elephants lift their trunks higher and spray arcs of water that sparkle in the golden light; ripples spread across the ocean; slow push-in. |
| 06 | Gold coins pour from the palm one after another, spinning and glinting as they fall; shallow focus; static camera. |
| 07 | The woman sets the diya down and its flame catches; all the flames along the street flicker; a light breeze moves her saree; slow dolly along the street. |
| 08 | Diya flames flicker; a soft golden glow travels along the footprints into the house; leaves of the toran stir; slow push-in toward the door. |
| 09 | She walks in through the doorway with clear natural steps, grounded, no floating; the diya light brightens as she enters; blessing hand stays raised; camera holds. |
| 10 | She smiles and holds the blessing gesture; golden fireworks burst and fade in the sky behind her; flames flicker; slow push-in. |

Clips 01–05 animated 2026-11-05 (Flow project "Nov 05 - 13:30", Veo 3.1 Lite, 9:16), all usable
first try. 01: long blink (eyes closed ~1.5–3.5 s) → start the cut where her eyes are open.

Download each at 720p as `media/clips/01.mp4` … `10.mp4`. Review with
`bash .claude/skills/ai-video-studio/scripts/contact_sheet.sh <clip> <sheet.jpg>` before editing.
