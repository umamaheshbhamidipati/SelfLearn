---
name: capcut-mobile
description: Drive CapCut on the owner's Android phone (Realme RMX2117, USB adb) from the laptop to add finishing touches to a Reel - soft dissolves, an English title, export - then pull the file back. Use when the user says CapCut, "edit on the phone", "add a transition/dissolve", or wants a CapCut export checked. Not for the main cut: joins, narration, Telugu captions and the grade stay in ffmpeg (scripts/).
---

# CapCut on the phone (tested 14 Nov 2026)

CapCut 20.1.0 (`com.lemon.lvoverseas`) on a Realme RMX2117, Android 12, adb serial `YTTG759PIVR4GQQO`,
1080x2400 screen. CapCut is blocked in India; it only works after the activation below. Background,
evidence and log lines: `docs/capcut-phone-recipe.md`.

## Role in the pipeline
ffmpeg builds the cut (joins, narration timing, Telugu captions, rose grade). CapCut is optional polish:
soft dissolves between scenes, an English title, simple zooms. Plain cuts come out better from ffmpeg
(CapCut re-encodes to 30 fps, adds an end card, and inflates the file).

## Rules (do not break)
- The owner's steps: installing apps, any account sign-in, system settings (region, timezone, Wi-Fi,
  airplane mode, VPN choice), accepting terms unless the owner says "agree" in chat, posting anything.
- Never sign in. If a TikTok/Google/email sign-in screen appears, close it (X or back arrow).
- Close every promo/Pro/"Get offer"/"Unlock now" popup with its X. Never tap the offer button.
- Keep the paid toggles off: AI ultra HD, Optical flow, "AI UHD", 2k/4k.
- Never crop or hide the Veo/Flow watermark. Label AI content when posting.
- Music: none from CapCut's library (free assets are personal use only; "Commercial use" tracks are
  reportedly TikTok-only). Add songs in the Instagram app at posting; YouTube Audio Library for YouTube.
- Do not clear CapCut's data: it undoes the activation.
- One export at a time.

## Activation (only if CapCut breaks again)
Symptoms: blank grey tool icons, no Templates, Add returns to the home screen, logcat full of
`Helios:Network-White ... Block request`. Order matters:
1. Owner sets phone Region/Language to US English and timezone to a US city.
2. Settings > Apps > CapCut > Storage > Clear data (adb `pm clear` is refused on this phone).
3. Owner connects RiseupVPN (Amsterdam worked) BEFORE opening CapCut.
4. Open CapCut, accept terms (owner's OK), wait for icons to load. Check: no new `Block request` lines.
Wi-Fi off / airplane mode does NOT help. Android runs one VPN at a time, so no Tailscale alongside it.

## Driving the phone
```bash
S=YTTG759PIVR4GQQO; D=<scratchpad>
adb -s $S exec-out screencap -p > $D/x.png      # then Read the png
adb -s $S shell input tap X Y
adb -s $S shell input swipe X1 Y1 X2 Y2 500
adb -s $S shell monkey -p com.lemon.lvoverseas -c android.intent.category.LAUNCHER 1
```
- Screenshot before every tap; layouts shift (home has a promo banner variant; the picker grid moves when
  the selection tray appears). Retry a tap that did not register after a fresh screenshot.
- Batch at most 2-3 blind taps; popups land on top of taps.
- The owner may drive the same phone via scrcpy at the same time: say what you are about to do.

## Getting clips onto the phone
```bash
adb -s $S shell mkdir -p /sdcard/Movies/<album>
adb -s $S push clip.mp4 /sdcard/Movies/<album>/t1.mp4
adb -s $S shell am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file:///sdcard/Movies/<album>/t1.mp4
```
CapCut's picker can show a stale list: force-stop CapCut, reopen, then pick the album from the
"Albums" dropdown. Select clips in story order; tick HD to avoid compression.

## Edits that worked
- **Dissolve:** scroll the timeline to the cut, tap the small box on the join > search icon >
  "dissolve/ fade" > **Slow Fade**, drag the duration slider to ~0.5 s, tap the tick.
  "Clips are too short" dialog: Got it (CapCut duplicates frames, length kept).
- **Title (English only):** Text > Add text > tap the "Enter text" field FIRST, then
  `adb shell input text "Two%sWords"` (%s = space) > tick. Typing with no field focused sends key
  shortcuts and muted all clips once: afterwards look for "Unmute clip" on the timeline and fix it.
  Telugu cannot be typed via adb: owner types it on the phone, or burn it with ffmpeg instead.
- **Not working here:** text Animations list stays empty (cloud assets). Treat titles as static.

## To try next (from tutorials, UNTESTED on this phone)
Source: Navin Verse "CapCut Video Editing Tutorial 2026" (Telugu, 21 min) summary, 14 Nov 2026.
Test one at a time on a 2-clip project; move a line up to "Edits that worked" only after an export passes.
| Feature | Where (per tutorial) | Devotional use | Notes |
|---|---|---|---|
| In / Out / Combo animation on a clip | clip > Animations | gentle "fade in"/"zoom in" on the deity reveal | may need cloud assets (text animations did not load) |
| Video effects (glow, light rays, particles) | Effects > Video effects | divine light on the hero shot | sparingly; skip fire/glitch styles |
| Speed > Curves | clip > Speed > Curve | slow-in on the blessing moment | Normal for most shots |
| Beats on audio | audio > Beats (auto) | cut on drum hits if music is ever used in-app | we add music in Instagram, so low priority |
| Adjust / HSL / Filters | clip > Adjust | warm gold tint per shot | our ffmpeg rose grade already does this |
| Optical flow (smooth slow motion) | Speed > Optical flow | slow-mo of flowing water/cloth | Pro (diamond icon): do not enable |
| Masking / overlays / layers | Overlay + Mask | halo or chakra overlay, title over a mask | |
| Remove BG / camera tracking | clip > Remove BG / Tracking | probably not needed for AI clips | heavy on this phone |
| Text-to-speech, voice effects, audio isolation | Text / Audio | not used: narration is Gemini TTS; isolation may be Pro | AI-voice disclosure if ever used |

## Export
- Tap the resolution button (shows "AI UHD"/"1080P"): set 1080p (or 720p), frame rate 30, paid toggles
  off, then Export. 1080p/24 gave broken files in our test; 30 fps is the safe setting.
- Wait until "Saved to device" AND the file size in `/sdcard/DCIM/Camera/` stops changing (check twice,
  30 s apart). A 2-clip 720p export took over 1 minute. Pulling early gives a truncated file.
- Exports land in `/sdcard/DCIM/Camera/lv_0_<date><time>.mp4`. Pull to the scratchpad or
  `projects/<slug>/media/` (gitignored), never into git.

## Check every export before showing the owner
```bash
ffprobe -v error -count_frames -select_streams v -show_entries stream=width,height,avg_frame_rate,nb_read_frames,duration -of default=nw=1 f.mp4
ffprobe -v error -show_entries format=duration -of default=nw=1 f.mp4
ffmpeg -hide_banner -i f.mp4 -vn -af volumedetect -f null - 2>&1 | grep -E 'mean_volume|max_volume'
```
PASS = video duration ~= format duration, frames ~= duration x fps, audio present, a frame sheet shows
the dissolve/title. Expect a ~2 s black CapCut logo card at the end: trim it with
`ffmpeg -i f.mp4 -t <length-without-card> -c copy out.mp4` or delete the last clip in CapCut.
For phone preview via SendUserFile keep files under 30 MB (re-encode to 720p if larger).
