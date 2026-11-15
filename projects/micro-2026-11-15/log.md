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
