# Earshot audit and Ep 3 trial (17 Nov 2026)

**What:** Earshot 0.4.1 (github.com/Leonxlnx/earshot, MIT, alpha, last commit 6 Nov 2026), "ears for coding agents":
describe/match/critique audio and render timed sound effects. CLI + Python API + MCP server.

## Audit
- Licence: code MIT. Sound bank = 201 entries: 186 procedural recipes (rendered from code, so no third-party
  rights) + 15 real recordings, all **CC0** from Freesound (docs/CREDITS_FIT.md). Safe for monetised videos.
- Network: only `llm.py` (Gemini audio, needs an API key, unused) and the CLAP/AST model download for
  describe/match (unused). The `sfx`/`kit` path is offline.
- Code execution: `subprocess` only calls ffmpeg (video.py, gallery.py); `np.load(allow_pickle=False)`. Nothing odd.
- Weight: full install pulls torch + transformers (~1 GB+). The `sfx`/`kit` path does **not** import torch, so it
  is installed without them: `~/.local/opt/earshot-venv` (609 MB, binary wheels only), source installed with `--no-deps`.
  `earshot describe/match/critique` will NOT work in this venv (needs torch); not needed for us.
- Bank fit for devotional reels: useful = shimmer, reverse_swell, riser, soft impact/swell, small bell, soft
  whooshes. Not useful = UI clicks, typing, glitch, logo stings. No natural sounds (water, animals): clip audio stays.

## Usage
```
E=~/.local/opt/earshot-venv/bin/earshot
$E sfx list | grep shimmer          # ids, length, peak time
$E sfx render shimmer/m1 -o k.wav   # 24-bit WAV; --dur, --apex, --pitch, --peak
$E sfx check k.wav                  # clicks, clipping, tail audit
```
Mix: `adelay=<ms>` so the effect's **peak** lands on the cut (start = cut time - peak time from `sfx list`),
`volume` 0.07-0.2, `amix normalize=0`, then `alimiter=limit=0.84:level=disabled`.
**Gotcha:** ffmpeg's `alimiter` has auto make-up gain on by default (`level=1`); it raised the whole track
by ~1.5 LU and clipped (+1.4 dBFS). Always pass `level=disabled`.

## Ep 3 trial (audio only, video stream copied: no re-encode)
Effects on the v2 phone copy: shimmer pro_shimmer/m1 peaking at 3.39 s (Kamadhenu), reverse_swell/breath at
5.16 s (Airavata), fit/bell/small_bell at 6.93 s (Parijata), shimmer/m1 from 10.3 s (garland), riser/swell
peaking at 32.43 s + pro_impact/swell into the end card. Two levels sent to the owner:
`media/ep3/sfx-test/ep3-sfx-soft-phone.mp4` (-15.9 LUFS, effects barely audible) and `...-medium-phone.mp4`
(-16.0 LUFS, peak -4.0 dBFS). Original phone copy: -15.9 LUFS.
**Verdict: pending the owner's ear.** If kept: add an `sfx` step to build_ep3.sh after the final rebuild with
clip 05 (timings move if shot lengths change).
