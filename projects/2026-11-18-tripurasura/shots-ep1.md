# Shots, Tripurasura Ep 1: మూడు పురాలు (planned 18 Nov 2026; NOT approved: narration and credits wait for the owner)

Narration `narration-ep1.txt` (10 lines, Achird, not recorded yet). Estimate ~36 s speech, ~40 s with the end card
(Ep 4's 10 lines = 36.1 s); slots are fixed after TTS (speech + 0.4 s). If the take runs over 38 s of speech, drop
"పుష్యమి నక్షత్రం వేళ" (L7) first, then merge L5 into L6.
Rules: `docs/preflight-checklist.md`; no deity names in Veo motion prompts; no gore; no fire or lamps anywhere in
Ep 1 (the deepam belongs to Ep 3); all people 20-35.
Media: `media/ep1/{stills,clips,audio-draft,audio,review,out}`.

## Blocks (copy word for word into every still prompt)

**Still colour line:** "Ultra-detailed cinematic still, NEUTRAL natural colour balance, true-to-life skin tones
(natural wheat-brown or soft peach, NOT orange), no orange or pink cast, deep blue-grey sky, cool neutral light
with a thin warm rim light, razor-sharp focus, shallow depth of field. Vertical 9:16, full frame edge to edge, no
black bars, no text, no logos, no watermark." (Warmth comes later from `grade.sh rose`.)

**SET (one place for Ep 1):** "a vast cosmic sky at blue hour above a high barren rocky plateau; layers of
cloud; three floating cities at three heights: a GOLD city high above the clouds, a SILVER city in the middle sky,
a dark IRON city low above the earth; stars just appearing."

**Three cities block:** "GOLD city: domes and spires of gleaming gold on a floating island of cloud, highest in the
frame. SILVER city: towers of polished silver on a floating rock, moon-pale, in the middle. IRON city: heavy
fortress walls of dark blue-grey iron with rivets, lowest, hovering above the plateau. Each city is round in plan,
walled, no smoke, no fire, no flags, no text."

**Brothers block (Asuras, colour-coded):** "three young men, about 25-30, brothers with a family likeness, strong
and handsome, not monstrous, no horns, thick dark moustaches, small bronze crowns, bare chests with bronze armlets.
The ELDEST (centre) wears GOLD silk and a gold sash; the second (left) wears STEEL-BLUE silk with dark iron
armlets; the youngest (right) wears SILVER-WHITE silk. Exactly three men, no women, two arms each, no grey hair."

**Brahma block:** "a divinely handsome young god (about 30) with FOUR faces (front, two sides, one hidden behind),
flawless crisp luminous golden skin, no wrinkles, short neat black beard on each face or clean-shaven (no grey),
seated on a huge glowing pink lotus of light, white and gold silk; four arms holding a palm-leaf book, a water pot
with its lid on (no flame, no fire, no wick, no lamp, not a diya), prayer beads, the fourth hand raised; crown of
woven light and translucent crystal, ornaments floating weightlessly."

**Maya block:** "a young Asura architect (about 28), lean, thoughtful, small bronze crown, dark-blue silk wrap,
a golden measuring cord around his shoulders; his hands draw glowing gold lines in the air like a blueprint."

**Teaser silhouette (no face):** "a lone figure seated in meditation on a snow peak, seen from behind and below,
matted hair tied high with a thin crescent moon glowing in it, a trident planted beside him, deep blue night,
stars; pure silhouette, no face visible."

## Shots (NEW = new still or clip; FX = ffmpeg only; slots fixed after TTS)

| # | Line | Shot | Must be true | Source | Credits |
|---|---|---|---|---|---|
| 01 | L1 hook | **HERO:** the three cities stacked in the sky, camera tilts up slowly from the iron city to the gold one | exactly THREE cities: gold top, silver middle, iron low; each walled, round, no fire/smoke/flags/text; the plateau visible at the bottom; no people; sky blue, not orange | NEW still s01_cities → **clip 01** | 10 |
| 02 | L2 | The three brothers stand side by side on the plateau, low angle, the three cities behind them | Brothers block: exactly 3 men, colour order steel-blue (L) / gold (C) / silver (R); young, no grey; small bronze crowns; 2 arms and 5 fingers each; the cities in the same arrangement as s01 | NEW still s02_brothers, push-in | 0 |
| 03 | L3 | The three seated in deep meditation on the plateau at night, eyes closed, a faint blue-white aura rising from them | same three faces and colours as s02; seated on rock (not floating, not on water); NO fire, no lamps; aura soft, not flames | NEW still s03_tapas, slow push-in | 0 |
| 04 | L4 | Brahma above them on the lotus of light, the raised hand gently refusing (palm out) | Brahma block: four faces, four arms all attached, young, no grey; water pot lidded, no flame; the brothers small below, looking up; one lotus | NEW still s04_brahma, push-in (+ soft shimmer) | 0 |
| 05 | L5 | ECU: the eldest (gold) looks up with a slow sly half-smile | same face as s02 centre; gold silk; small bronze crown; smile small, not a grin; eyes sharp | NEW still s05_smile, fast push-in | 0 |
| 06 | L6 | (clip 06 FAILED 18 Nov; owner: free push-in on s06_maya_a) Maya draws glowing gold lines in the air; behind him the lines rise into the three city outlines | Maya block; two hands, ten fingers, both drawing; three city outlines in gold light (not solid yet); plateau, blue hour | NEW still s06_maya → **clip 06** (Lean-min: push-in) | 10 |
| 07 | L7 | The three cities drift toward one line; one bright star (Pushya) above, a thin crescent moon | three cities same as s01; they are NOT yet in a perfect line (nearly); one star brighter than the rest; no text | NEW still s07_align, slow push-in + FX slow sideways drift | 0 |
| 08 | L8 | A vision: three translucent city silhouettes in a perfect row, front to back, and ONE thin line of white light passing straight through all three | exactly three silhouettes, overlapping in a row; ONE straight line of light, no bow, no person, no arrowhead gore; dreamlike, dark background | NEW still s08_vision, push-in + soft impact on "ఒకే ఒక్క బాణం" | 0 |
| 09 | L9 | (clip 09 FAILED; owner: push-in on s09 + clip 09 2.5-4.5 s) the dark iron city glides over a white-gold heavenly palace; its shadow falls on the courtyard; young Devas look up and step back | iron city same as s01; Devas: young men 20-35, medium tiered crowns, ivory-gold silk, no weapons raised, no injury; no fire, no smoke, no bodies | NEW still s09_shadow → **clip 09** | 10 |
| 10 | L10 + end card | The silhouette on the snow peak, crescent glowing; end card text in the lower third | Teaser silhouette block: no face; crescent in the hair; trident beside; lower third plain dark sky; end card in Noto Serif Telugu, Spacing 0, test-rendered first | NEW still s10_peak, very slow push-in + small bell; end card | 0 |

**Lean plan (recommended): 3 clips (01, 06, 09) = 30 credits first try, at most 60 with one re-roll each.**
**Lean-min:** 01 + 09 only = 20 (max 40); shot 06 becomes a push-in on s06_maya.
If a clip fails twice: push-in on its still (no third roll without a new OK).

## Still prompts (Nano Banana in the Flow agent, 0 credits; colour line + SET + blocks + shot line)
- s01_cities — SET + Three cities block: "Wide establishing shot looking up from the plateau: the iron city low and
  large, the silver city above it, the gold city highest and smallest among the clouds. No people."
- s02_brothers — s01 attached as the exact reference for the cities + Brothers block: "Low-angle full shot, the
  three brothers stand side by side on the rocky plateau, arms folded or at their sides, proud; the three cities
  behind and above them."
- s03_tapas — s02 attached (same faces, same colours): "The same three men sit cross-legged on the rock in deep
  meditation, eyes closed, backs straight, a faint blue-white glow rising from their shoulders like mist. Night,
  stars. No fire, no lamps."
- s04_brahma — s03 attached + Brahma block: "High in the sky above the three seated men, the god sits on the
  lotus of light, looking down kindly; his upper right hand raised, palm out, in a gentle refusal. The three men
  small at the bottom, looking up."
- s05_smile — s02 attached: "Extreme close-up of the man in GOLD silk (centre), looking up, a slow sly
  half-smile, eyes sharp; the sky behind soft."
- s06_maya — Maya block + SET: "Medium shot from behind his shoulder: he raises both hands and draws glowing
  gold lines in the air; far behind him, the lines have become three glowing outlines of round walled cities at
  three heights, not yet solid."
- s07_align — s01 attached (same cities) + SET: "The three cities have drifted almost into one line, one behind
  the other, seen from the side; above them a single brilliant star and a thin crescent moon."
- s08_vision — "Dark starry background. Three translucent glowing silhouettes of round walled cities (gold,
  silver, iron tints) in a perfect row one behind the other, and ONE thin straight line of white light passing
  through the centre of all three. No people, no bow."
- s09_shadow — s01 attached for the iron city: "A white-and-gold heavenly palace courtyard with marble pillars on
  clouds; the dark iron city glides overhead and its shadow falls across the courtyard; three young Devas (Deva
  group: ivory-gold silk, medium tiered crowns, men 20-35, no grey hair) look up and step back. No fire, no
  smoke, no weapons, no injury."
- s10_peak — Teaser silhouette block: "Wide shot, the figure small on the peak in the upper middle; the lower
  third plain dark blue sky."

## Motion prompts (Veo 3.1 Lite, image = first frame, "exactly ONE video, x1, 9:16, 10 credits"; NO names)
Every prompt ends: "Keep the cities / faces and costumes identical, smooth natural motion, no morphing."
- 01: "The three floating cities hang perfectly still in place while clouds drift slowly past them; the camera
  tilts up slowly from the dark iron city at the bottom to the gold city at the top. No new cities appear. Sound:
  deep low wind, a faint metallic hum. No music, no speech."
- 06: "The man keeps drawing glowing gold lines in the air with both hands; far behind him the three glowing
  outlines slowly fill in and become solid cities of gold, silver and iron, rising a little. Camera completely
  still. Sound: a soft shimmering hum, distant stone grinding. No music, no speech."
- 09: "The dark iron city glides slowly from the right across the sky above the courtyard; its shadow sweeps
  over the marble floor; the three young men look up and take one step back. Nobody falls. Camera completely
  still. Sound: a deep rumble, wind. No music, no speech."

## Edit (build_ep1.sh, after the clips; copy of Samudra Manthan build_ep4.sh)
Slots = speech + 0.4; 0.15 s lead; L10 slot + 1.9 s end card. Soft Earshot pass (audio only, peak on the cut):
pro_impact/deep at 0.15 (L1), shimmer on the s04 Brahma cut, riser/swell into L8, soft impact on "బాణం",
fit/bell/small_bell into the end card; volumes 0.07-0.10, `alimiter level=disabled`. Rose grade 1080x1920; phone copy
tv-range yuv420p. Encodes outside 09:00-15:35.
