#!/usr/bin/env bash
# send-preview.sh <video> "<caption>": Telegram sendVideo to the owner via the UmaAI bot.
# Token goes to curl via a stdin config (never on the command line or in output).
set -euo pipefail
f="${1:?video}"; cap="${2:?caption}"
get(){ grep -E "^$1=" /home/umamahesh/code/SelfLearn/.env | cut -d= -f2- | tr -d '"'"'"' '; }
tok=$(get UMAAI_TELEGRAM_BOT_TOKEN); chat=$(get UMAAI_TELEGRAM_CHAT_ID)
[[ -n "$tok" && -n "$chat" ]] || { echo "no Telegram config"; exit 1; }
[[ $(stat -c %s "$f") -lt 50000000 ]] || { echo "file over 50 MB"; exit 1; }
printf 'url = "https://api.telegram.org/bot%s/sendVideo"\n' "$tok" |
  curl -sS -m 300 -K - --form-string "chat_id=$chat" --form-string "caption=$cap" \
       --form-string "supports_streaming=true" -F "video=@$f" |
  python3 -I -c 'import sys,json; r=json.load(sys.stdin); print("ok" if r.get("ok") else "failed: "+str(r.get("description")))'
