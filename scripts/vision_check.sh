#!/usr/bin/env bash
# Second-opinion image/contact-sheet check with Gemini against a written SPEC (not "is it good?").
# Usage: scripts/vision_check.sh image.(jpg|png|webp) "spec: what must be true"  [model]
# Key: GEMINI_API_KEY in .env. The image is sent to Google (free tier: may be reviewed): only project media, no personal photos.
# Tested 12 Nov 2026: see docs/lessons.md. Treat the answer as a hint, never as a verdict.
set -euo pipefail
cd "$(dirname "$0")/.."
[[ -f .env ]] && { set -a; . ./.env; set +a; }
: "${GEMINI_API_KEY:?GEMINI_API_KEY missing}"
img="$(readlink -f "$1")"; spec="$2"; model="${3:-gemini-3.5-flash}"
case "${img##*.}" in jpg|jpeg) mime=image/jpeg;; png) mime=image/png;; webp) mime=image/webp;; *) echo "unsupported type" >&2; exit 1;; esac
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
base64 -w0 "$img" > "$tmp/b64"
prompt="You are a strict visual QA reviewer for AI-generated Indian mythology video frames. Check the image ONLY against this spec. For each separate requirement in the spec, answer PASS, FAIL or UNSURE with one short reason describing what you actually see. If the image is a contact sheet of several frames from one clip, judge the clip across the frames. Do not praise. SPEC: $spec"
jq -n --rawfile d "$tmp/b64" --arg m "$mime" --arg p "$prompt" '{contents:[{parts:[{inlineData:{mimeType:$m,data:$d}},{text:$p}]}]}' > "$tmp/req.json"
curl -s --max-time 180 "https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent" \
  -H 'Content-Type: application/json' -H "X-goog-api-key: $GEMINI_API_KEY" -d @"$tmp/req.json" \
  | jq -r '.candidates[0].content.parts[].text? // .error.message'
