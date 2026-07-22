#!/usr/bin/env bash
# Sync Telegram-uploaded images from a Hermes Docker container into a VPS/noVNC
# browser user's Google Flow upload folder.
#
# Run on the VPS host as root, not inside the Hermes container.
# Defaults match the user's common setup; override via environment variables:
#   CONTAINER=hermes-agent DST_DIR=/home/flowdesk/flow-uploads/books ./flow-image-sync.sh

set -euo pipefail

CONTAINER="${CONTAINER:-hermes-agent}"
SRC_DIR="${SRC_DIR:-/opt/data/cache/images}"
DST_DIR="${DST_DIR:-/home/flowdesk/flow-uploads/books}"
OWNER="${OWNER:-flowdesk:flowdesk}"
STATE_DIR="${STATE_DIR:-/root/.flow-image-sync}"
STATE_FILE="$STATE_DIR/copied.txt"
POLL_SECONDS="${POLL_SECONDS:-5}"

mkdir -p "$DST_DIR" "$STATE_DIR"
touch "$STATE_FILE"

echo "Watching $CONTAINER:$SRC_DIR -> $DST_DIR"

while true; do
  docker exec "$CONTAINER" sh -lc "find '$SRC_DIR' -maxdepth 1 -type f \\( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.heic' \\) -printf '%T@ %p\n' | sort -n" 2>/dev/null |
  while read -r _ts path; do
    [ -n "${path:-}" ] || continue
    if grep -Fxq "$path" "$STATE_FILE"; then
      continue
    fi

    ext="${path##*.}"
    count=$(ls -1 "$DST_DIR"/telegram-reference-* 2>/dev/null | wc -l || true)
    next=$((count + 1))
    out="$DST_DIR/telegram-reference-$(printf '%02d' "$next").$ext"

    docker cp "$CONTAINER:$path" "$out" 2>/dev/null || continue
    chown "$OWNER" "$out" 2>/dev/null || true
    echo "$path" >> "$STATE_FILE"
    echo "Copied $path -> $out"
  done

  sleep "$POLL_SECONDS"
done
