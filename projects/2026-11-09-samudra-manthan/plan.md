# Plan — Samudra Manthan (Phase 1 findings, for owner approval)

Status: planning only. **No stills, no clips, no credits spent.** Master image review pending (image not yet received).

## 1. Why Nano Banana keeps giving female-looking Devas

1. **Our own look block feminises.** The repo's deity block says "divinely beautiful", "flawless crisp luminous skin
   with a soft peach glow", "serene eyes", floating jewellery. In image models those words cluster strongly with
   women. Applied to a crowd, the model "spends" them on some faces as female.
2. **"Devas" ≈ "Devis" / "celestials".** The word is ambiguous to the model (devi, apsara, celestial beings).
   Group + jewellery + crowns + long hair + no explicit gender count → a mixed crowd.
3. **Mythological-art priors.** Calendar-art Devas are beardless, long-haired, heavily ornamented and soft-faced:
   androgynous before any prompt.
4. **Crowd diversity default.** For "a group of people" the model varies gender unless told the exact count of men.
5. **Small faces.** In a wide master shot each face is a few dozen pixels; the model renders generic soft faces,
   which read as female. Region edits re-run the same priors, so repeated edits keep failing.

## 2. Most reliable approach (recommended)

Don't fight the crowd. Split the problem:

1. **Male Deva wording, applied to every Deva prompt** (replaces the deity beauty words for Devas only):
   "adult men, unmistakably masculine: strong square jaw, defined brow, broad shoulders, bare muscular chest,
   [moustache / short beard / clean-shaven but rugged], hair tied up under the crown" + "handsome", never
   "beautiful/graceful/luminous/soft". Add the count: "exactly six men, no women".
2. **Approve 5 named male Deva portraits first** (Indra as leader with vajra; 4 more distinct faces: e.g. Agni-type,
   Vayu-type, Varuna-type, a young warrior). Portraits = big faces, so gender and identity are controllable.
3. **In crowd/churning shots, show the Devas from behind or in profile, straining on the rope.** That is also what
   real rope-pulling looks like. Faces in wide shots stay small, turned, or in shadow; identity comes from costume
   (cream/ivory/gold) and screen side.
4. **Faces appear only in medium/close shots,** each built from an approved portrait attached as reference
   (Flow "Add to prompt", as done for Karthika still 07).
5. Region editing only for one or two stray faces in an otherwise good image; if a face fails twice, regenerate
   the shot instead.
6. Every still: zoom-check each Deva face at 100 % (existing quality gate, step 6) plus "count men / any women?".

Same method for Asuras (fewer issues so far): approve 3–4 portraits, maroon/bronze/black-gold armour, always screen-left.

## 3. Character reference plan (stills only, 0 credits in Flow Nano Banana)

Per character: front portrait, 3/4 medium, full body — 16:9 framing for the film. One Flow project for refs.
Test Flow's **Characters** feature (left menu, "Create character") — if it locks a face better than "Add to
prompt", use it for every recurring character.

| # | Character | Key locks | Watch-outs |
|---|---|---|---|
| 1 | Vishnu | deep natural blue skin (not neon), 4 arms with shankha/chakra/gada/padma, celestial crown, yellow silk | count arms; hands holding the right objects |
| 2 | Kurma | island-sized tortoise, mountain-bearing shell, Vishnu's colour accents | no half-human form; shell must visibly carry Mandara |
| 3 | Shiva | reuse Karthika Shiva block (ash/silver-blue glow, matted hair, crescent, Ganga, third eye, serpent, trishula) | blue throat only in the Neelakantha shots |
| 4 | Parvati | luminous, regal, celestial jewellery | young adult, dignified |
| 5 | Devas ×5 portraits + group | male wording above, cream/ivory/gold | the main risk — approve each face |
| 6 | Asuras ×3–4 portraits + group | maroon/bronze/black-gold armour, powerful not monstrous | |
| 7 | Vasuki | one design: many-hooded serpent king, one continuous body, distinct head and tail | count hoods; body continuity in every still |
| 8 | Mandara | forested mountain | scale vs Kurma |
| 9 | Dhanvantari | young, radiant, amrita kalasha (Bhagavata: dark skin, yellow garments) | 2 or 4 arms — owner choice |
| 10 | Lakshmi | rises on a lotus from the milk ocean | — |
| 11 | Mohini | beautiful, dignified, holds the kalasha; no sensual framing | — |

## 4. Five-minute structure (16:9, Telugu narration, ~300 s)

| Act | Time | Beats | Shots (≈4.5–6 s each) |
|---|---|---|---|
| Cold open | 0:00–0:12 | Strongest image first: the churning wide, Vasuki taut, lightning; title | 2 |
| 1 Devas fall | 0:12–0:50 | Devas weakened (curse framed as one telling) → go to Vishnu → "churn the Ksheera Sagara with the Asuras" | 7 |
| 2 Preparation | 0:50–1:35 | Mandara carried, Vasuki as rope, sides chosen, mountain sinks, **Kurma rises and bears it** (hero) | 9 |
| 3 Churning | 1:35–2:10 | Pulling, waves like mountains, Vasuki's breath, Vishnu above the summit | 7 |
| 4 Halahala | 2:10–3:15 | Poison rises, creation darkens, all flee to Shiva, **Shiva drinks, throat turns blue, Neelakantha** (climax; Parvati's touch as tradition) | 12 |
| 5 Treasures | 3:15–3:50 | Kamadhenu, Airavata, Kalpavriksha/Parijata, **Lakshmi** (no count, no order claim) | 6 |
| 6 Amrita | 3:50–4:45 | **Dhanvantari rises with the kalasha**, Asuras seize it, Mohini, nectar to the Devas, Rahu exposed (optional) | 10 |
| Ending | 4:45–5:05 | Cosmic image, dharma message, end card | 3 |
| **Total** | **~5:05** | | **~56 shots** |

Pacing: slower than the Reels (4.5–6 s average, not 2–3 s); the YouTube Shorts teaser is cut from the climax later
(`scripts/shorts.sh`).

## 5. Credit budget (to be re-verified in Flow before any batch)

| Item | Estimate |
|---|---|
| Video clips | 56 shots; about 6 can be 0-credit still push-ins (title, treasures, end card) → ~50 clips |
| Veo 3.1 Lite @ 10 credits/clip, ×1.3 retries (Diwali got 10/10 first try; mythic scale will be harder) | **~650 credits** |
| Hero upgrades (Neelakantha, Kurma, Dhanvantari) at a higher-quality model or 1080p, if Flow offers and the owner approves | +100–200 |
| **Planning total** | **≈ 650–850 credits** |
| Stills (Nano Banana in Flow) | 0 credits |

At ~400 credits/week (50/day + 200/month, per CLAUDE.md) that is about **2 weeks** of generating. Last recorded balance
was 130 (8 Nov, Karthika still pending ≤ 120) — so Samudra Manthan clips realistically start after the Karthika
reel. First spend: a **test batch of the 3 priority shots** (Neelakantha, Kurma, grand churn) ≈ 30–40 credits.

## 6. To verify before writing the final screenplay
- Parvati holding Shiva's throat: devotional tradition, not in the texts read → narrate as "భక్తుల నమ్మకం" or show
  without claiming scripture. Owner to decide whether to include.
- Durvasa garland scene: Vishnu Purana only (Bhagavata just names the curse) → frame as "ఒక కథనం ప్రకారం" or skip.
- Treasure order / "14 ratnas": no fixed claim.
- Rahu → Ketu: later tradition; include Rahu's beheading only if time allows.
- Pothana padyam on Parvati's mangalasutra: unverified — do not quote.
- **Ocean colour:** the Ksheera Sagara is a milk ocean — check the master image.
- Dhanvantari 2 vs 4 arms (convention): owner choice.

## 7. Open decisions for the owner
1. Approve the Deva approach (portraits first, backs/profiles in crowd shots).
2. ~~Parvati's throat moment~~ — decided 2026-11-10: included, consent + throat touch narrated as belief.
3. ~~Rahu~~ — decided 2026-11-10: dropped (possible stand-alone Short later).
(§4–5 five-minute film superseded 2026-11-10 by 3 × 9:16 episodes — see script.md.)
4. Narration voice: owner's own voice (best result on Diwali) or Achird (Gemini TTS, chosen for Karthika).
5. Send the current master image.
