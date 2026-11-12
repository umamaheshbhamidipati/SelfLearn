#!/usr/bin/env bash
# Streak tracker for the daily 10-15 minute step (docs/streak.csv).
# Rule: a day counts if it has at least one entry. ONE missed day is allowed (grace day); TWO missed days in a row end the streak.
# Usage:  scripts/streak.sh add "what you did" [minutes] [YYYY-MM-DD]   |   scripts/streak.sh show
set -euo pipefail
cd "$(dirname "$0")/.."
f=docs/streak.csv
case "${1:-show}" in
  add)
    step="${2:?what you did}"; mins="${3:-10}"; day="${4:-$(date +%F)}"
    printf '%s,"%s",%s,\n' "$day" "${step//\"/}" "$mins" >> "$f"
    echo "Logged $day: $step ($mins min)"; "$0" show ;;
  show)
    python3 - "$f" <<'PY'
import csv, sys, datetime as dt
rows = list(csv.DictReader(open(sys.argv[1])))
days = sorted({dt.date.fromisoformat(r['date']) for r in rows})
if not days: print("No entries yet."); sys.exit()
today = dt.date.today()
def streaks(days):
    best = cur = 0; prev = None; run = []
    for d in days:
        if prev is None or (d - prev).days <= 2:   # gap of 1 missed day allowed
            cur += 1
        else:
            cur = 1
        best = max(best, cur); prev = d
    return cur, best
cur, best = streaks(days)
last = days[-1]
alive = (today - last).days <= 2
mins = sum(int(r['minutes'] or 0) for r in rows)
print(f"Days with a step: {len(days)} | current streak: {cur if alive else 0} | best: {best} | total minutes: {mins}")
print(f"Last step: {last} ({(today-last).days} day(s) ago)" + ("" if alive else "  -> streak ended; start again today, one small step"))
week = [d for d in days if (today - d).days < 7]
print(f"This week (last 7 days): {len(week)}/7 days")
PY
    ;;
  *) echo "usage: streak.sh add \"step\" [minutes] [date] | show" >&2; exit 1 ;;
esac
