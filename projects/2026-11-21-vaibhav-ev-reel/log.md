# Log — vaibhav-ev-reel

## Generation

| Date | Shot | Mode | Credits | Result | What I changed |
|---|---|---|---|---|---|
| 21 Nov | s01_dead_a | Gemini still | 0 | PASS (saved) | rider by dead white scooter |
| 21 Nov | s02_phone_a | Gemini still | 0 | PASS (saved) | rider on phone |
| 21 Nov | s03_battery_a | Gemini still | 0 | FAIL: technician had the rider's face (owner) | redone as a stocky, curly-haired, moustached man: different now |
| 21 Nov | s04 controller, s05 handover, s06 ride | Gemini still | 0 | made, NOT downloaded (Gemini full-size downloads stalled after 3) | |

**Credits used total:** 0 (owner, 21 Nov: images only, no Veo).

## State 21 Nov ~21:50
- Client sent 3 real photos in chat (shop front with signage; two men repairing a battery and a charger on the floor;
  a man repairing a hub motor in the shop). They are not on disk yet: owner to save them to `media/ref/`.
- Shop front sign confirms the address: Naidupeta Circle, Kalavoddu Road, Khammam.
- **Plan change:** the real shop is small and simple, so AI workshop/technician stills would misrepresent it. Use the REAL
  photos for the shop and repair shots; AI stills only for the customer story (s01 dead, s02 phone, s06 ride).
  The AI technician stills (s03, s04, s05) are dropped, which also removes the lookalike problem.
- Gemini chat "Electric Scooter Breakdown Photo Prompt" holds all stills; s06_ride still to download (full size).


## After 7 days (Instagram Insights / YouTube Studio)

| Metric | Instagram | YouTube Shorts |
|---|---|---|
| Views | | |
| **Average watch time** (main metric; baseline 0:02) | | |
| % views from non-followers | | |
| **Shares** | | |
| **Saves** | | |
| Follows / subscribers gained | | |
| Likes / comments | | |

One lesson (also add to `docs/lessons.md`):

## 21 Nov ~22:00: first full cut (images only, 0 credits)
- Client's 4 real photos saved by the owner to `media/ref/1-4.jpeg`. `build.sh` + `reel.ass` → `media/out/vaibhav-ev-reel.mp4`
  (26 s, 1080x1920, 24 fps, muted; build 2m17s on the laptop).
- Order: AI s01 dead scooter → AI s02 phone (both labelled "AI-generated image"; zoom anchored bottom-right so the Gemini
  sparkle stays) → real shop front → battery/charger (blurred fill, knee cropped) → hub motor → wiring (heart stickers
  still faintly visible) → signboard brands close-up (soft, low-res) → logo end card (name, Telugu address, కాల్: 74166 09872).
- Fixes after the contact sheet: hook text moved up off the rider's head; end-card text larger; 📞 emoji had no glyph → "కాల్:".
- s06_ride (rider riding off, helmet) is made in Gemini but Chrome would not save it (full-size downloads stalled after 3,
  also from the image viewer). Owner can download it by hand to `media/stills/s06_ride_a.png`; `build.sh` adds it automatically.
- Next: owner/friend review → music in Instagram's audio library at posting (or a royalty-free track) → friend posts.

## 22 Nov ~00:30: smooth zoom + Telugu voice
- Owner: "video is sometimes vibrating". zoompan rounds to whole pixels → replaced with `perspective` (sub-pixel, cubic,
  smoothstep ease 1.00→1.06). Checked first vs last frame: clean push-in, no distortion.
- Owner: add the Telugu voice we use for reels → Achird via `scripts/tts.sh`, lines in `narration.txt`.
  L1-L5 and L7 done; **L6 and L8 failed: free TTS quota (10/day for gemini-3.8-flash-tts) used up; resets ~13:35 IST.**
  After the reset: `scripts/tts.sh` L6 and L8 (loop in log 21 Nov style, `</dev/null`), then `./build.sh` (auto-retimes).
- `build.sh` now: trim voice silence → `timeline.py` (shot lengths = line + 0.45 s; L7 spread over the brands sign and
  the services board; end card ≥ 4 s) → segments → voice track by adelay → captions + AAC. 31.3 s, voice -16.3 LUFS.
- If `media/stills/s06_ride_a.png` exists, shot 08 uses the riding still instead of the services board.

## 22 Nov 07:30: owner "you missed some voices"
- Missing = L6 (wiring shot) and L8 (end card). TTS retried at 07:29: still HTTP 429 (daily quota, resets ~13:35 IST).
- `finish-voice.sh` added: records missing lines (retries every 10 min, up to 4 h), waits until 15:36, runs `build.sh`,
  sends `notify-phone`. Scheduling it with `systemd-run --user --on-calendar` was blocked by the permission check:
  owner to run it, or ask a session after 13:35.

## 22 Nov 13:47: all 8 voice lines
- L6 + L8 recorded (Achird) after the quota reset. L8 now ends "ఇప్పుడే కాల్ చేయండి: ఏడు నాలుగు ఒకటి ఆరు ఆరు... సున్నా తొమ్మిది ఎనిమిది ఏడు రెండు" (owner: number in Telugu words).
- Rebuilt (Sunday, no market, nice 10): 36.9 s; end card 10.5 s to fit the spoken address + number. Not yet listened to by Claude: owner to check pronunciation.
