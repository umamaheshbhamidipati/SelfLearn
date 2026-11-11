#!/usr/bin/env bash
# Telugu (or any language) narration with Gemini TTS. Key: GEMINI_API_KEY in .env (gitignored, chmod 600).
# Free tier: Google may use inputs/outputs and humans may review them: never put personal info in the text.
# Usage: scripts/tts.sh "<text>" out.wav [voice=Achird] [style prompt]
#        scripts/tts.sh -f text.txt out.wav [voice] [style]
set -euo pipefail
cd "$(dirname "$0")/.."
[[ -f .env ]] && { set -a; . ./.env; set +a; }
: "${GEMINI_API_KEY:?GEMINI_API_KEY missing (put it in .env)}"

if [[ "${1:-}" == "-f" ]]; then text="$(cat "$2")"; shift 2; else text="${1:?text}"; shift; fi
out="${1:?out.wav}"; voice="${2:-Achird}"
style="${3:-}"   # default: NONE. A style prefix gets READ ALOUD (Karthika, 11 Nov): only pass one if you will check the audio
model="${TTS_MODEL:-gemini-3.8-flash-tts}"

tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
jq -n --arg t "${style:+$style: }$text" --arg v "$voice" \
  '{contents:[{parts:[{text:$t}]}],generationConfig:{responseModalities:["AUDIO"],
    speechConfig:{voiceConfig:{prebuiltVoiceConfig:{voiceName:$v}}}}}' > "$tmp/req.json"
code=$(curl -s --max-time 120 -o "$tmp/resp.json" -w '%{http_code}' \
  "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent" \
  -H 'Content-Type: application/json' -H "X-goog-api-key: $GEMINI_API_KEY" -d @"$tmp/req.json")
if [[ "$code" != 200 ]]; then echo "TTS failed: HTTP $code $(jq -c '.error.message? // .' "$tmp/resp.json" | head -c 300)" >&2; exit 1; fi
jq -r '.candidates[0].content.parts[0].inlineData.data' "$tmp/resp.json" | base64 -d > "$tmp/raw.wav"
# The API returns a RIFF WAV (24 kHz mono). Normalise to -16 LUFS, 48 kHz for video.
ffmpeg -hide_banner -loglevel error -y -i "$tmp/raw.wav" -af loudnorm=I=-16:TP=-1.5 -ar 48000 "$out"
echo "$out: $(ffprobe -v error -show_entries format=duration -of csv=p=0 "$out") s ($voice)"
