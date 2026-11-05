#!/usr/bin/env bash
# Create projects/YYYY-MM-DD-<slug>/ from templates/.
# Usage: scripts/new-project.sh my-first-short
set -euo pipefail
cd "$(dirname "$0")/.."

slug="${1:?usage: scripts/new-project.sh <slug>}"
[[ "$slug" =~ ^[a-z0-9-]+$ ]] || { echo "slug: use lowercase letters, digits and dashes" >&2; exit 1; }

dir="projects/$(date +%F)-$slug"
[[ -e "$dir" ]] && { echo "$dir already exists" >&2; exit 1; }

mkdir -p "$dir/media/stills" "$dir/media/clips/old" "$dir/media/audio" "$dir/media/out"
for t in brief shots publish log; do
  sed "s/<title>/$slug/" "templates/$t.md" > "$dir/$t.md"
done
printf '# Script — %s\n\n' "$slug" > "$dir/script.md"
echo "Created $dir"
