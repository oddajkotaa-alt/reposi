#!/usr/bin/env bash
set -euo pipefail

# Switch Telegram/Flow automation from container Hermes to host-side Hermes,
# while keeping the same /opt/data brain (skills, config, Obsidian, cache).
# Run on the VPS HOST as root, not inside the Docker container and not inside noVNC.

echo "=== Host Flow Hermes switch: use /opt/data brain on host DISPLAY=:1 ==="
if [ "$(id -u)" -ne 0 ]; then
  echo "ERROR: run this on VPS/host terminal as root, not inside noVNC and not inside the container."
  exit 1
fi

echo "\n[1/8] Basic host check"
echo "user=$(whoami) host=$(hostname) pwd=$PWD"
if [ ! -d /home/flowdesk ]; then
  echo "ERROR: /home/flowdesk not found. This looks like the container, not the VPS host. Stop here."
  exit 2
fi
if [ ! -d /opt/data ]; then
  echo "ERROR: /opt/data not found on host. Need the shared Hermes home mounted at /opt/data."
  exit 3
fi

export HERMES_HOME=/opt/data
export HOME=/opt/data/home
export DISPLAY=:1
export XAUTHORITY=/home/flowdesk/.Xauthority
export PATH="/root/.local/bin:/opt/data/home/.local/bin:/usr/local/bin:/opt/hermes/bin:/opt/hermes/.venv/bin:$PATH"
mkdir -p /opt/data/home /opt/data/logs /opt/data/backups

echo "\n[2/8] Find host Hermes binary"
HER=""
for c in /opt/hermes/.venv/bin/hermes /opt/hermes/bin/hermes /root/.local/bin/hermes /opt/data/home/.local/bin/hermes hermes; do
  if command -v "$c" >/dev/null 2>&1; then HER="$(command -v "$c")"; break; fi
  if [ -x "$c" ]; then HER="$c"; break; fi
done
if [ -z "$HER" ]; then
  echo "ERROR: Hermes binary not found on host. Install host Hermes first, or tell me this output."
  exit 4
fi
echo "HER=$HER"
"$HER" --version 2>/dev/null || true

echo "\n[3/8] Back up/disable old separate host brain if it exists"
TS="$(date +%Y%m%d_%H%M%S)"
if [ -d /root/hermes-host-data ] && [ ! -L /root/hermes-host-data ]; then
  echo "Moving /root/hermes-host-data -> /root/hermes-host-data.BACKUP_$TS"
  mv /root/hermes-host-data "/root/hermes-host-data.BACKUP_$TS"
else
  echo "No active /root/hermes-host-data directory to move."
fi

# Compatibility symlink: accidental old commands now use the good brain.
if [ ! -e /root/hermes-host-data ]; then
  ln -s /opt/data /root/hermes-host-data
  echo "Created symlink /root/hermes-host-data -> /opt/data"
fi

echo "\n[4/8] Check VNC/Flow desktop processes"
ps -ef | grep -E 'Xtigervnc|Xvnc|websockify|google-chrome|chrome|chromium|cua-driver' | grep -v grep || true
if ! ps -ef | grep -E 'Xtigervnc|Xvnc' | grep -v grep >/dev/null; then
  echo "WARNING: I do not see TigerVNC/Xvnc. Flow desktop may need to be started."
fi

if [ ! -e "$XAUTHORITY" ]; then
  echo "WARNING: $XAUTHORITY does not exist. computer_use may fail until VNC creates it."
fi

echo "\n[5/8] Stop container Telegram gateway only, keep dashboard container running"
if command -v docker >/dev/null 2>&1 && docker ps --format '{{.Names}}' 2>/dev/null | grep -qx 'hermes-agent'; then
  docker exec hermes-agent /command/s6-svc -d /run/service/gateway-default 2>/dev/null || true
  echo "Disabled container gateway-default service. Container itself is still running."
else
  echo "Docker/container gateway not accessible or not found; skipping."
fi

echo "\n[6/8] Stop old host gateway/cua daemons"
pkill -f 'hermes gateway run' 2>/dev/null || true
pkill -f 'cua-driver serve' 2>/dev/null || true
sleep 2

echo "\n[7/8] Start cua-driver serve against host VNC display"
CUA=""
for c in /usr/local/bin/cua-driver /root/.local/bin/cua-driver /opt/data/home/.local/bin/cua-driver cua-driver; do
  if command -v "$c" >/dev/null 2>&1; then CUA="$(command -v "$c")"; break; fi
  if [ -x "$c" ]; then CUA="$c"; break; fi
done
if [ -n "$CUA" ]; then
  echo "CUA=$CUA"
  nohup env HERMES_HOME="$HERMES_HOME" HOME="$HOME" DISPLAY="$DISPLAY" XAUTHORITY="$XAUTHORITY" "$CUA" serve >/opt/data/logs/cua-driver-host-flow.log 2>&1 &
  sleep 2
  tail -40 /opt/data/logs/cua-driver-host-flow.log || true
else
  echo "WARNING: cua-driver binary not found on host. Hermes may install/use packaged MCP, but doctor may fail."
fi

echo "\n[8/8] Start host Hermes gateway using /opt/data brain"
nohup env HERMES_HOME="$HERMES_HOME" HOME="$HOME" DISPLAY="$DISPLAY" XAUTHORITY="$XAUTHORITY" PATH="$PATH" "$HER" gateway run --replace --force >/opt/data/logs/host-hermes-flow-gateway.log 2>&1 &
sleep 8

echo "\n=== Gateway log tail ==="
tail -80 /opt/data/logs/host-hermes-flow-gateway.log || true

echo "\n=== Doctor quick check ==="
env HERMES_HOME="$HERMES_HOME" HOME="$HOME" DISPLAY="$DISPLAY" XAUTHORITY="$XAUTHORITY" PATH="$PATH" "$HER" computer-use doctor || true

echo "\nDONE. Now send Telegram bot: test host flow"
echo "Expected: DISPLAY=:1 and computer_use should capture the Flow/noVNC desktop, not 0x0."
