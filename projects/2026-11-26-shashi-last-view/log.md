# Log — shashi-last-view

## 26 Nov 2026

- Done: project folder; 17 images unzipped to `media/in/` (renamed img01..17), 8 narration clips to `media/audio/a1..a8.mpeg`
  (duplicate `12.34.39 (2)` dropped, cmp-identical). Contact sheet `media/work/contact.jpg`; image → narration map and
  gaps in `brief.md`. Credits spent: 0.
- Asked the parent session to save Shashi's pasted script to the side-session notes folder (needed for exact caption text;
  no speech-to-text tool on this laptop).
- Waiting on: owner answers (format, captions, music, gaps, timer numbers, credit/watermark).
- Next: build after 15:35 IST with ffmpeg (zoompan + xfade, glitch on img08/img10, narration joined with ~0.4 s gaps,
  loudnorm -16 LUFS), phone-size preview + PASS/FAIL to the owner.

### Build (26 Nov, afternoon)

- Owner (via main session): build with defaults, send the preview. Chosen: 16:9 1920x1080 25 fps; burned-in English captions
  (from the narration transcripts, not the script: the voice is a retelling); no music, no SFX; timers on the images left
  as they are (known issue); gaps covered with the closest images (hospital = glitch frames img08/img04; "Tomorrow" call =
  img15/img17; final "watching the same video" = a phone mock-up made in ffmpeg showing img11, then img04 close-up);
  title card "THE LAST VIEW"; end card with the script's closing text; no credit/watermark.
- `timeline.py` builds everything in one ffmpeg run: 28 shots, zoompan (1.25x pre-scale) + 0.5 s crossfades
  (fadewhite into the memory flash, pixelize into glitch frames, rgbashift/noise flicker on glitch shots), captions
  aligned to the real pauses (silencedetect + DP over speech segments), narration at fixed starts with 0.6 s gaps,
  two-pass loudnorm. Length 2:37.6.
- Test render 480x270 10 fps (83 s on this laptop): -16.5 LUFS, true peak -1.3 dBFS; black only on the title card and the
  scripted "2… 1." blackout. Glitch, phone and end-card shots checked on a frame sheet.
- Full encode scheduled: `systemd-run --user` timer `shashi-render` at 15:36 → `media/out/the-last-view-16x9.mp4` +
  `the-last-view-preview-540p.mp4` (log `media/work/render.log`).

### Render + preview (26 Nov, 15:36-15:55)

- Full encode 15:36-15:50 (~14 min, x264 medium crf 19): `media/out/the-last-view-16x9.mp4`, 1920x1080 25 fps, 157.6 s,
  145 MB; preview `the-last-view-preview-540p.mp4` 10.7 MB.
- PASS/FAIL: length 2:37.6 PASS; black frames only on the title card (0-2.2 s) and the scripted "2… 1." blackout
  (133.1-135.4 s) PASS; audio/video same length, narration at the planned starts PASS; captions readable (white, black
  outline, ~63 px) PASS; loudness -16.5 LUFS, true peak -1.3 dBFS PASS. Only freeze = the static end card (150.8 s on).
- Preview sent to the owner by Telegram (`send-preview.sh`, UmaAI bot) + notify-phone note with defaults and known
  issues; also via SendUserFile. Credits: 0. Nothing posted anywhere.
- Open: owner's changes (9:16 version, music, timer overlay, credit line). Hand Shashi the 1080p file (145 MB: too big for
  WhatsApp as video; send as a document or re-encode smaller if needed).
