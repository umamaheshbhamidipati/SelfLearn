# Seedance test, shot 1-01 (owner runs it by hand on higgsfield.ai; cap 30 credits; approved 25 Nov)

Why: the Seedance vs Veo test (`docs/experiments.md`): the same start still and the same prompt in both. Veo does its
own 1-01 in Flow. The Higgsfield connector can read the balance but has no generate tool (25 Nov), and Claude does not
drive higgsfield.ai (their automation rule). **Balance read by the connector 25 Nov 08:50: 100 credits, plan lite.**

## Settings (higgsfield.ai → Video → Seedance 2.5)
- Mode: image reference / **start image** (omni reference). Start image: `media/stills/s1-01_<chosen>.jpg`
  (the file is named in `log.md` after the stills OK; I'll send it to your phone). Also add as references:
  `media/refs/gajendra_B.jpg` and `media/refs/croc_A.jpg`.
- Aspect **9:16**, duration **5 s**, **Draft ON (480p)**, audio ON.
- Read the credit cost the site shows before clicking Generate. Order: draft 1 → if it looks right, **finalize that
  draft at 720p** (not 1080p). If draft 1 is wrong, one more draft, then stop. Stop at 30 credits total.

## Prompt (paste exactly)
```
The first frame is the start. Low angle at water level in a misty lotus lake at dawn. The water explodes in a white
splash as ONE giant near-black crocodile bursts up and clamps its jaws on the LEFT HIND LEG of ONE massive silver-white
bull elephant with a jewelled gold forehead plate, hanging gold bells and gold-ringed tusks. The elephant rears its
head, throws its trunk up and trumpets, then pulls forward hard; the crocodile holds on and twists, dragging the leg
back; lotus leaves and spray fly. Exactly one elephant and one crocodile for the whole clip; the jaws stay on the hind
leg; real anatomy (one trunk, two tusks, four legs; the crocodile one head, one tail); no blood, no wounds. Handheld
camera shake, slight push-in. Natural colours, no orange cast. Sound: a huge splash, the elephant's trumpet, churning
water, the crocodile's hiss. No music, no speech.
```

## After it runs
Download the clip to `media/clips/1-01_seedance.mp4` (or send it to Claude); note the credits the site charged.
Claude logs: credits, the 3 fps check against the 1-01 "Must be true" lines, and the verdict vs the Veo clip.
