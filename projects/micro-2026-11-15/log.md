# Micro-explainers and moral stories, batch 1 (15 Nov 2026)
Owner approved all 5 story cards (`docs/micro-cards-2026-11-15.md`). Built with `scripts/micro.sh` (new):
spec of clips/still push-ins + one narration wav + ASS captions -> rose grade 1080x1920. ~5.5 min per video on this laptop.
Voice: Gemini TTS Achird, one call per video (5 calls, no quota error). Captions timed from pauses (silencedetect).
Flow credits: 0 (10 stills, Nano Banana 2.1, free at 0 balance): c1 moon, c2 crescent, l1-l4 lion story, t1-t4 Tenali Rama.

| video | length | pictures | check |
|---|---|---|---|
| kurma | 17.5 s | Ep 1 clips 12, 11 + kurma frame | PASS: hook text from frame 0, captions readable, voice -20.5 dB mean |
| vasuki | 15.9 s | Ep 1 clip 01, 10c + 3 stills | PASS |
| chandra | 15.3 s | r1b, c1, clip 08 (0-2.8 s), c2, s8 | PASS; note: throat natural in the hook still, blue in the later shots |
| lion (నీతి కథలు) | 23.8 s | l2, l1, l2, l3, l4 stills | PASS (9.5 MB, stills only, rabbit picture used twice) |
| tenali (నీతి కథలు) | 19.3 s | t3, t1, t2, t3, t4 stills | PASS (thieves picture used twice) |
Not verified by ear: caption timing against the voice (set from measured pauses). Nothing uploaded.

## State at handoff (15 Nov, about 13:00 IST) - session closed under the "keep sessions small" rule
Done: all 5 videos rendered with the OLD three-pass micro.sh (before pulling 5f0cf42) and sent to the owner's phone:
kurma, vasuki, chandra, lion, tenali in `media/out/`. Frame sheets and loudness checked. Text committed (6bed2c4).
In progress: nothing rendering.
Next steps (new session):
1. Wait for the owner's review: caption timing by ear, Telugu pronunciation, which videos to post.
2. Reused-content rule (roadmap): Kurma and Vasuki use only Ep 1 clips and stills. Add at least one NEW picture
   to each before posting (Nano Banana, free).
3. Chandra: hook still has a natural throat, later shots a blue throat; swap the hook still if the owner minds.
4. When a video is posted: `scripts/metrics.py post`; first run `scripts/metrics.py due`.
5. Ep 2 (separate session): animate conch stills s1_conch_a and s6_conch_b (10 credits each). Read the balance in
   Flow first: the 3:47 PM 15 Nov reset is the MONTHLY reset, not a daily one. Then cut Ep 2 from manifest-ep2.json.
Open questions for the owner: "made for kids" setting for the two moral stories; whether to spend 10 credits each on
one animated clip per moral story; standing approval for Flow credits is NOT in CLAUDE.md (edit was blocked).
Correction: this session told the owner credits were "50 a day free". Wrong: paid PLUS, one monthly pool.

## Owner review (15 Nov, afternoon) and next job: v2 at 29-30 s
Owner: "videos are good". **Drop Kurma and Vasuki** (same content as Ep 1; do not post). **Chandra, lion and Tenali
Rama are over too fast: remake each at about 29-30 s.**
Plan for the new session (use the new single-encode `scripts/micro.sh`, about 2 min per render):
- Longer narration, one TTS call per video (drafts below, about 40-45 words each; aim for 27-28 s of speech + 1.5 s tail).
  Time captions from the pauses (`silencedetect`), as in batch 1.
- Each new line needs its own picture: 3-4 NEW stills per video (Nano Banana, free), no picture used twice.
- Fix from review notes: Chandra hook still must match the later throat colour (use a blue-throat still for the hook
  or keep the throat natural throughout).
- Optional, ask first: one 10-credit clip per moral story (lion at the well, thieves drawing water).

### Draft narration v2 (owner has not checked the added facts yet: ask in one line before recording)
**Chandra** (adds the 27 wives and Rohini, the usual Puranic account):
శివుని తలపై చంద్రుడు ఎందుకు ఉంటాడు? | పురాణ కథనం ప్రకారం, చంద్రుడు దక్షుని ఇరవై ఏడు మంది కుమార్తెలను పెళ్లాడాడు. |
కానీ రోహిణిని మాత్రమే ఎక్కువగా ప్రేమించాడు. | కోపించిన దక్షుడు, "నువ్వు క్షీణించిపోతావు" అని శపించాడు. |
రోజురోజుకూ కరిగిపోతున్న చంద్రుడు, శివుణ్ణి ప్రార్థించాడు. | శివుడు కరుణించి, అతన్ని తన శిరస్సుపై ధరించాడు. |
అందుకే చంద్రుడు తగ్గుతూ, మళ్లీ పెరుగుతూ ఉంటాడు. | అందుకే శివుడు… చంద్రశేఖరుడు.
New stills: moon among 27 bright stars; moon close to one bright star; thin fading moon over dark sea; growing moon.
No Daksha, no human form of Chandra.

**Lion and rabbit:**
సింహాన్ని ఓడించింది… ఒక చిన్న కుందేలు! | అడవిలో ఒక క్రూర సింహం, రోజుకొక జంతువును ఆహారంగా కోరేది. |
ఒకరోజు కుందేలు వంతు వచ్చింది. అది కావాలనే ఆలస్యంగా వెళ్లింది. | "రాజా! దారిలో ఇంకో సింహం నన్ను ఆపింది.
ఈ అడవికి తానే రాజునంటోంది" అని చెప్పింది. | కోపంతో ఊగిపోయిన సింహాన్ని, కుందేలు ఒక బావి దగ్గరకు తీసుకెళ్లింది. |
నీళ్లలో తన నీడను చూసి, శత్రువనుకుని సింహం దూకేసింది! | అడవి అంతా ఊపిరి పీల్చుకుంది. | బలం కన్నా… బుద్ధి గొప్పది.
New stills: animals pleading before the lion; rabbit walking slowly alone; rabbit leading the lion along a path;
empty well with ripples.

**Tenali Rama:**
దొంగలతోనే తన తోటకు నీళ్లు పెట్టించాడు! | ఎండాకాలం. తెనాలి రామకృష్ణుని తోట ఎండిపోతోంది. |
ఒక రాత్రి, తోటలో దొంగలు దాక్కున్నారని అతను గమనించాడు. | "మన నగల పెట్టెను బావిలో దాచేద్దాం" అని గట్టిగా చెప్పి,
ఒక పెట్టెను బావిలో పడేశాడు. | దొంగలు రాత్రంతా బావి నీళ్లు తోడి పోశారు. | తెల్లారేసరికి… తోట అంతా తడిసింది.
పెట్టెలో ఉన్నవి రాళ్లే! | రామకృష్ణుడు నవ్వుతూ, "నా తోటకు నీళ్లు పెట్టినందుకు ధన్యవాదాలు" అన్నాడు. | తెలివి ఉంటే… కష్టం కూడా లాభమే.
New stills: dry cracked garden at noon; thieves hiding in bushes (close); open chest full of stones at the well;
thieves running at dawn.

## v2 build (15 Nov, evening session): chandra, lion, tenali at 29-30 s
Owner OK'd in chat: narration as drafted, 12 new stills (0 credits), 2 clips (10 credits each). Plan and prompts: `v2-plan.md`.
- **Narration:** `narration-v2.txt`, one Gemini TTS call each (Achird). Raw takes ran 25.9 / 33.8 / 33.6 s, so pauses were capped
  (0.55 s chandra, 0.4 s lion/tenali) and tempo set (0.95 / 1.05 / 1.0) -> `*-v2t.wav` 26.3 / 28.8 / 28.6 s. A Gemini transcription
  confirmed every line is present and gave the order; caption breaks come from the measured pauses.
  Lesson: a `while read` loop around tts.sh eats stdin (ffmpeg): read the list on fd 3 and give tts.sh `</dev/null`.
- **Flow (new project "Nov 15 - 17:36"):** 12 Nano Banana 2.1 stills, 1K (768x1376): c3_stars, c4_rohini, c5_fading, c6_growing,
  l5_plead, l6_walk, l7_lead, l8_ripples, t5_dry, t6_hiding, t7_stones, t8_running. vision_check: all PASS (c3 has 24 stars, not 27).
  2 clips, Veo 3.1 Lite, 1 try each, both PASS: `media/clips/lion_well.mp4` (snarl, leap ~4 s, splash; used 2.5-6.7 s),
  `tenali_water.mp4` (men hauling and pouring water; used 0-2.85 s and 4.25-7.9 s). Each approved once, "Approve" not "Always".
  **Credits: 50 before, 30 after** (stills free). The account menu said "Resets Nov 16 at 3:10 PM": check whether this pool is daily.
  Upload trick: the Upload menu opens a native picker; instead put files in a page-made `<input type=file>` and dispatch a drop.
  Download: tile menu (⋮) -> Download -> 1K (images) / 720p (videos). JS fetch of the tile `img` only gives a 286x512 thumbnail.
- **Chandra hook fix:** hook now c2_crescent (no throat visible); s8 blue-throat only at the end, r1b dropped.
- Specs `*-v2.spec`, captions `*-v2.ass` (save/brand line from the last caption +1 s). Kurma and Vasuki dropped (owner).

| v2 video | length | loudness | check |
|---|---|---|---|
| chandra-v2 | 29.0 s | -17.1 LUFS | PASS (vision check, 8-frame sheet: captions readable, no face covered, end card) |
| lion-v2 | 30.0 s | -16.7 LUFS | PASS (8 frames) |
| tenali-v2 | 30.0 s | -16.7 LUFS | PASS (10 frames, no children) |
Render ~6 min each tonight (Chrome busy at the same time; ~2 min alone). Sent to the owner's phone 15 Nov night.
Not verified by ear: caption timing against the voice, Telugu pronunciation. Nothing posted.
Next: owner review -> post from @umaaivideostudio with the personal account as collaborator, one a day, hours apart
(`docs/channel-growth-plan.md`); register each with `metrics.py post`.
Clean-up for the owner: ~/Downloads has 8 small thumbnail files (l5_plead.jpg ... t8_running.jpg) and 3 "(1)" duplicates
from this session; safe to delete.
