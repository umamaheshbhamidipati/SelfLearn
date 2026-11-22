#!/usr/bin/env bash
# Record missing voice lines when the TTS quota allows, rebuild after market hours, tell the owner's phone.
# Run via: systemd-run --user --on-calendar='2026-11-22 13:40' <abs path to this script>
set -uo pipefail
P="$(cd "$(dirname "$0")" && pwd)"; REPO="$(cd "$P/../.." && pwd)"
cd "$REPO"
missing() { for s in $(cut -d'|' -f1 "$P/narration.txt"); do [[ -f "$P/media/audio/vo/$s.wav" ]] || echo "$s"; done; }
for try in $(seq 1 24); do                     # every 10 min, up to 4 h
  for s in $(missing); do
    text=$(grep "^$s|" "$P/narration.txt" | cut -d'|' -f2)
    scripts/tts.sh "$text" "$P/media/audio/vo/$s.wav" Achird </dev/null || true
  done
  [[ -z "$(missing)" ]] && break
  sleep 600
done
if [[ -n "$(missing)" ]]; then
  ~/.local/bin/notify-phone "Vaibhav EV reel: voice lines $(missing | tr '\n' ' ')still blocked by the TTS quota. Nothing rebuilt."
  exit 1
fi
while [[ $(date +%H%M) -lt 1536 ]]; do sleep 120; done   # no long encodes 09:00-15:35 (Kite bot)
if "$P/build.sh" > "$P/media/out/build.log" 2>&1; then
  ~/.local/bin/notify-phone "Vaibhav EV reel rebuilt with all 8 Telugu voice lines: media/out/vaibhav-ev-reel.mp4. Open the Claude app and ask to see it."
else
  ~/.local/bin/notify-phone "Vaibhav EV reel: voice lines done but the rebuild failed (media/out/build.log)."
fi
