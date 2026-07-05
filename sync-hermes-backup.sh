#!/usr/bin/env bash
set -euo pipefail

CONTAINER="${HERMES_CONTAINER:-hermes-agent}"
REPO_DIR="${HERMES_BACKUP_REPO:-/home/hermes/hermes-backup}"
STAGING_DIR="$REPO_DIR/.backup-work"
STAMP="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

cd "$REPO_DIR"

if ! docker inspect "$CONTAINER" >/dev/null 2>&1; then
  echo "ERROR: Docker container '$CONTAINER' not found" >&2
  exit 1
fi

rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR"

copy_if_exists() {
  local src="$1"
  local dest="$2"
  if docker exec "$CONTAINER" test -e "$src"; then
    mkdir -p "$(dirname "$STAGING_DIR/$dest")"
    docker cp "$CONTAINER:$src" "$STAGING_DIR/$dest"
  fi
}

# Durable non-secret state. Keep this list intentionally small.
copy_if_exists /opt/data/config.yaml config.yaml
copy_if_exists /opt/data/SOUL.md SOUL.md
copy_if_exists /opt/data/memories memories
copy_if_exists /opt/data/cron cron
copy_if_exists /opt/data/skills skills
copy_if_exists /opt/data/plans plans
copy_if_exists /opt/data/skins skins
copy_if_exists /opt/data/hooks hooks

# Replace tracked content with the freshly staged safe subset.
for path in config.yaml SOUL.md memories cron skills plans skins hooks; do
  rm -rf "$REPO_DIR/$path"
  if [ -e "$STAGING_DIR/$path" ]; then
    mv "$STAGING_DIR/$path" "$REPO_DIR/$path"
  fi
done
rm -rf "$STAGING_DIR"

# Extra safety cleanup: remove files that should never be committed if copied indirectly.
find "$REPO_DIR" \
  \( -name '.env' -o -name '*.env' -o -name 'auth.json' -o -name '*.lock' -o -name '*.pid' -o -name '*.db' -o -name '*.sqlite' -o -name '*.pyc' \) \
  -not -path '*/.git/*' -type f -delete
find "$REPO_DIR" \
  \( -name 'logs' -o -name 'cache' -o -name 'audio_cache' -o -name 'image_cache' -o -name 'images' -o -name 'lazy-packages' -o -name 'node_modules' -o -name '__pycache__' -o -name 'sessions' -o -name 'pairing' -o -name 'platforms' \) \
  -not -path '*/.git/*' -type d -prune -exec rm -rf {} +

git add .

if git diff --cached --quiet; then
  echo "No Hermes backup changes at $STAMP"
  exit 0
fi

git commit -m "Hermes backup $STAMP"

if git remote get-url origin >/dev/null 2>&1; then
  git push origin main
else
  echo "No Git remote configured; committed locally only."
fi
