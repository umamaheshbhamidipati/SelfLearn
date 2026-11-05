#!/usr/bin/env bash
# Back up every project's media/ folder to Google Drive (gdrive:SelfLearn/<project>/media).
# Copy only: never deletes anything on Drive. Run after each generation session.
# Usage: scripts/backup.sh [project-folder]   (default: all projects)
set -euo pipefail
cd "$(dirname "$0")/.."

targets=("$@"); (( ${#targets[@]} )) || targets=(projects/*/)
for p in "${targets[@]}"; do
  p="${p%/}"; [[ -d "$p/media" ]] || continue
  name="$(basename "$p")"
  echo "== $name"
  rclone copy "$p/media" "gdrive:SelfLearn/$name/media" --progress --transfers 2
done
echo "Backup done. Verify with: rclone check projects/<name>/media gdrive:SelfLearn/<name>/media --one-way"
