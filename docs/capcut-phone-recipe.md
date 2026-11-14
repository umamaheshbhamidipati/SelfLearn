# CapCut 20.1.0 on the Realme RMX2117 (India): what made it work (14 Nov 2026)

CapCut is blocked in India. The app ships its own request blocker (logcat tag
`Helios:Network-White`, "Block request <host>") and the editor needs `editor-api` / `commerce-api`
to be reachable. Symptom: blank tool icons, Add returns to the home screen, no project.

## Recipe that worked (reconstructed from the phone's logcat, 06:19-06:24 US time)
1. Phone region/locale/timezone set to the US (English US, America/New_York) BEFORE the next steps.
2. Force-stop CapCut, then Settings > Apps > CapCut > Storage > **Clear data** (fresh first run).
3. Connect RiseupVPN (Amsterdam exit, tun0) BEFORE opening CapCut.
4. Open CapCut with the VPN up, accept the terms, let the home screen load (icons appear).
5. New video > pick clip > Add: EditActivity opens (project saved as 1114-02).

## Why earlier runs failed (my reading, not proven)
- I changed the region AFTER the app's first run, so it kept sending `region=IN` (cached).
- I cleared data with the region still India, or with no network at all.
- Wi-Fi off / airplane mode does not help: the blocker acts inside the app.

## Notes
- Do not clear CapCut data again, or repeat steps 1-4.
- Cloud features (templates, AI, auto captions) need the VPN; cutting and export work locally.
- adb cannot clear app data or change system settings on this phone: do it in the Settings UI.

## Ep 1 export test (14 Nov 2026): verdict = optional finishing tool
- Pushed the Ep 1 final to /sdcard/Movies (adb push), imported in CapCut (tick HD), exported at 1080P.
- Result: 1080x1920, captions + Veo mark + audio intact; 56 MB at ~9 Mbps (ours 18 MB at 2.9 Mbps),
  re-encoded to 30 fps (ours 24); export took about 1 minute.
- Free export adds a ~2 s black CapCut logo outro (video 49.2 s vs audio 47.2 s). Delete the last
  clip in the editor, or trim with ffmpeg: `-t <audio length> -c copy`.
- A sign-in prompt can appear (close it with X, never sign in) and ad popups after export (close with X).
- Chrome/YouTube upload limit is 10 MB: re-encode with ffmpeg afterwards, as for Ep 1.
- Use CapCut for animated titles, zoom keyframes, speed ramps; keep ffmpeg for joins, narration, grade.
- Exports land in /sdcard/DCIM/Camera/lv_*.mp4; pull with adb.
