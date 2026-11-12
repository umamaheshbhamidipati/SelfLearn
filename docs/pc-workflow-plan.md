# Video + AI workflow plan for the new PC (drafted 12 Nov 2026)

Hardware (owner, 12 Nov): new PC in Hyderabad, Ryzen 9 9900X (12 cores), 32 GB DDR5, Ubuntu 26.04, **no GPU at first**
(iGPU), a used RTX 3090 (24 GB) later. Old HP laptop = always-on light server only (Kite bot, backups, monitoring).
Realme 12 Pro 5G (Wi-Fi) = camera + phone edits in Instagram's Edits app (no CapCut). Goal: run AI locally, avoid paid
AI long term, 1080p, CPU-friendly until the GPU arrives.

## Pace (owner, 12 Nov 2026): no hurry
The PC takes about **6 months** to build (to about May 2027). We go slowly and study as we go: nothing here is urgent, and the
channel keeps running on Flow + the laptop meanwhile. Each month adds one small thing we understand, and each lesson goes to `docs/lessons.md`.

| When | Study / do (small, on the laptop or phone, no new hardware needed) |
|---|---|
| Nov-Dec 2026 | Keep making Samudra Manthan on Flow. Write the script-to-captions script (no Whisper) and make `scripts/` path-independent. |
| Jan 2027 | Read about faster-whisper and IndicTrans2 (how they work, model sizes). Try Whisper `small` on a 60 s Hindi/English phone clip on the laptop only if the bot is idle (slow is fine). |
| Feb 2027 | Read about Telugu TTS options; prepare the 5-line blind-test sheet and the owner's own-voice reference clip. |
| Mar 2027 | Learn ffmpeg filters properly (grade, crop, subtitles) with small experiments; Kdenlive basics on the Windows PC if useful. |
| Apr 2027 | Write `scripts/bench.sh`; decide the order of installs for day 1. |
| May 2027 onward | PC boots: steps 5-9 below, then the 3090 steps when it arrives. |

## Principles
1. **Split by machine.** Laptop: never video or AI work (see CLAUDE.md). PC: all local video and AI. Phone: capture and
   quick Instagram edits. Cloud (Google Flow, Gemini TTS) stays until a local tool *passes our own test*.
2. **GitHub is the source of truth** (text, scripts); media stays out of git, backed up by `scripts/backup.sh` (rclone to Drive).
3. **Every local tool must beat or match the cloud one on a blind test with our own Telugu content** before it replaces it.
   Benchmarks below are community numbers, not ours.
4. Flow clips cannot be replaced by anything we can run locally today at the same quality (see "Local video generation").

## What runs where

| Job | Now (laptop + phone + cloud) | New PC, CPU only | New PC + RTX 3090 |
|---|---|---|---|
| Ideas, scripts, shot lists | Claude (this repo) | same | same |
| Stills | Nano Banana in Flow (0 credits) | same | optional: ComfyUI image models (own style/LoRA), only if Nano Banana limits hurt |
| Video clips | Flow / Veo 3.1 Lite (credit-limited) | same | Flow for hero shots; local Wan 2.2 or LTX-2.x for b-roll/experiments |
| Voiceover | Gemini TTS (Achird) or the owner's own voice | try IndicF5 / Indic Parler-TTS on CPU (slow but fine for 20-60 s lines) | faster, same models |
| Captions (our own AI videos) | **From the script text** (we already have it): split by line, time from the TTS audio | same | same |
| Captions (recorded phone videos) | Edits auto-captions | faster-whisper (see caveat) | faster-whisper large, GPU |
| Subtitle translation | by hand/Claude | IndicTrans2 or NLLB on CPU (short text is fine) | faster |
| Grade, join, crop, burn captions | ffmpeg (rose grade ~10 min per 18 s here) | ffmpeg; expect minutes → well under a minute (estimate, measure) | same, NVENC for encodes |
| Upscale 720p to 1080p | ffmpeg lanczos + sharpen | same (AI upscalers are too slow on CPU) | Real-ESRGAN / Video2X (try on one clip) |
| Visual timeline | Edits on the phone | Kdenlive or Shotcut | same |

## Honest caveats (from a quick check of public sources, not from our tests)
- **Whisper and Telugu:** zero-shot Whisper large-v3 is weak on Telugu. The [Dolphin paper](https://arxiv.org/pdf/2503.20212) reports very high WER for it, and community fine-tunes such as [BuzzASR/telugu](https://huggingface.co/BuzzASR/telugu) report roughly 38-47 % WER on hard sets (self-reported, different test sets). Hindi and English are far better. So: do not build a Telugu captioning plan on Whisper alone. For our own AI videos use the script text instead; for recorded Telugu speech, test a fine-tuned model on 2-3 of the owner's own clips and expect to proofread.
- **Telugu TTS:** [IndicF5](https://huggingface.co/ai4bharat/IndicF5) (explicit Telugu support, ~0.4B parameters, voice cloning from a reference clip) and [Indic Parler-TTS](https://huggingface.co/ai4bharat/indic-parler-tts) (steerable voice by text description) are the open candidates. A 2026 [preprint](https://arxiv.org/html/2604.25441) says open models still trail commercial ones, and Chatterbox does not handle Telugu. No head-to-head Telugu listening test exists; we must run one (same 5 lines: Gemini Achird vs IndicF5 vs Indic Parler vs the owner's voice).
- **Local video generation:** a used 3090 can run [LTX-2 / Wan 2.2](https://codeshrew.github.io/ai-lab-notes/posts/2026-02-10_local-ai-video-generation-ltx2-rtx3090) image-to-video at about 2-8 minutes per clip per community reports, with Wan leaning to quality and LTX to speed ([overview](https://insiderllm.com/guides/local-ai-video-generation/)). Expect lower quality than Veo. Worth it for free b-roll and experiments, not as a Veo replacement. Without a GPU, do not try.
- **The GPU's value for this repo:** our pipeline is Flow-centric (cloud). A 3090 helps with upscaling, local TTS/Whisper speed and experiments; it does not remove the Flow credit limit by itself. Decide the purchase after the CPU-only tests show what is actually slow.
- The new PC's iGPU works with the standard amdgpu driver. The `amdgpu` blacklist and `radeon` notes in the laptop's setup are **laptop-only**; do not copy them.
- The 9900X's iGPU is basic (display only for our purposes); keep encodes on the CPU (x264) until the 3090.

## Phone track (recorded videos)
Realme 12 Pro: record 1080p (30 fps), steady, good light, voice clear. Quick cuts in Edits for Instagram; add Instagram's licensed audio only in the app. Move the raw file to the PC (rclone/Drive or USB) when a longer edit, subtitles, or a YouTube version is needed. Telugu captions: Whisper draft on the PC, proofread by the owner, burn in with ffmpeg (`scripts/captions.sh`).

## Steps
**Before the PC arrives (laptop, cheap):**
1. Make `scripts/` work from any clone path and any machine (no hard-coded `/home/umamahesh`).
2. Add a script that builds captions from `script.md` lines and the per-line TTS timings (no Whisper needed).
3. Write `scripts/bench.sh`: times the rose grade on one clip, `faster-whisper` on a 60 s sample, and a TTS line; so the PC can be measured the day it boots.
4. Update CLAUDE.md: the "slow laptop" rules apply to the laptop only; CapCut is not used (Edits on the phone, Kdenlive on the PC).

**When the PC boots (CPU-only phase):**
5. Install ffmpeg, git, rclone, Node/Python venv, Kdenlive; clone the repo; restore `rclone` config; pull media from `gdrive:SelfLearn/`.
6. Run `bench.sh` and record the numbers in this file (grade time, Whisper real-time factor, TTS seconds per line).
7. Blind test of Telugu TTS (5 lines, 4 voices); owner picks. Keep Gemini if nothing beats it.
8. Test one fine-tuned Telugu Whisper model on 2-3 of the owner's own recordings; record the error rate by eye.
9. Test IndicTrans2 on one caption set Telugu to Hindi/English; owner or Claude proofreads.

**When the 3090 arrives:**
10. NVIDIA driver, CUDA build of faster-whisper, NVENC check; ComfyUI.
11. Upscale one 720p Flow clip to 1080p and compare side by side with the lanczos version.
12. One LTX-2 / Wan 2.2 image-to-video test from a Samudra Manthan still, compare with Flow. Decide where local video fits (b-roll only, or nothing).

## Rules that stay
- Flow only through Claude in Chrome in the owner's browser, owner approves each batch; never hide the AI watermark; label AI content.
- No media in git; no secrets in git; commit and push text after each video.
- No real people's likeness, copyrighted characters or music.
