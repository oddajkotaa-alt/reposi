# Host Hermes for Google Flow browser automation when Telegram Hermes runs in Docker

Use this reference when the user wants one Telegram workflow that drives a VPS/noVNC Google Flow browser, but the currently Telegram-connected Hermes is running in Docker while the VNC/Chrome desktop runs on the VPS host.

## Symptom pattern

- noVNC + Google Flow work in the VPS browser.
- Docker Hermes receives Telegram messages/images.
- `computer-use install` inside Docker succeeds, but `doctor` reports X11 not reachable or cannot capture the VNC display.
- Running host `cua-driver` without Xauthority can print: `Authorization required, but no authorization protocol specified`.
- A copied Hermes home can report an old gateway PID that actually belongs to the Docker container.

## Key concept

`computer_use` must run in the same host/display context as the browser it controls. If Chrome/VNC is on the VPS host as `flowdesk`, a Docker Hermes usually cannot inspect/inject X11 events unless the display/socket/auth are deliberately exposed. The practical fix is to run a host Hermes for Google Flow automation and switch the Telegram gateway to that host Hermes.

## Host Hermes setup recipe

Assume VNC display is `:1`, desktop user is `flowdesk`, and copied Hermes data is `/root/hermes-host-data`.

1. Install host Hermes if missing:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
/root/.local/bin/uv tool install hermes-agent
/root/.local/bin/hermes --version
```

2. Copy Docker Hermes data to host once (adjust container name if needed):

```bash
rm -rf /root/hermes-host-data
docker cp hermes-agent:/opt/data /root/hermes-host-data
```

3. Start/verify `cua-driver` on the host with the VNC display auth:

```bash
export PATH="/root/.local/bin:$PATH"
export HERMES_HOME=/root/hermes-host-data
export HERMES_REAL_HOME=/root/hermes-host-data
export DISPLAY=:1
export XAUTHORITY=/home/flowdesk/.Xauthority

pkill -f cua-driver || true
cua-driver serve >/root/host-cua-driver.log 2>&1 &
sleep 2
hermes computer-use doctor
```

Success requires both:

- `ax_capability` OK
- `screen_capture_capability` OK

If root gets an authorization error, re-check `XAUTHORITY=/home/flowdesk/.Xauthority` and that the VNC server is running as `flowdesk`.

4. Test host Hermes before moving Telegram:

```bash
export PATH="/root/.local/bin:$PATH"
export HERMES_HOME=/root/hermes-host-data
export HERMES_REAL_HOME=/root/hermes-host-data
export DISPLAY=:1
export XAUTHORITY=/home/flowdesk/.Xauthority
hermes
```

Ask it to capture Google Flow with `computer_use`. If Chrome is not open, launch it from the host terminal:

```bash
runuser -u flowdesk -- bash -lc 'cd /home/flowdesk && DISPLAY=:1 HOME=/home/flowdesk XDG_RUNTIME_DIR=/tmp google-chrome --no-first-run --disable-dev-shm-usage --password-store=basic https://labs.google/fx/tools/flow' &
```

## Switching Telegram gateway from Docker Hermes to host Hermes

Do not run two gateways against the same Telegram bot. First inspect the current process/container:

```bash
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'
ps -ef | grep -E 'hermes gateway|gateway run|hermes-agent' | grep -v grep
```

A Docker gateway may appear as UID `10000` running `/opt/hermes/.venv/bin/hermes gateway run --replace`.

Create a host gateway launcher:

```bash
cat > /root/start-host-hermes-gateway.sh <<'EOF'
#!/usr/bin/env bash
set -e

export PATH="/root/.local/bin:$PATH"
export HERMES_HOME=/root/hermes-host-data
export HERMES_REAL_HOME=/root/hermes-host-data
export DISPLAY=:1
export XAUTHORITY=/home/flowdesk/.Xauthority

rm -f /root/hermes-host-data/gateway.pid /root/hermes-host-data/gateway.lock

pkill -f cua-driver 2>/dev/null || true
cua-driver serve >/root/host-cua-driver.log 2>&1 &
sleep 2

nohup hermes gateway run --replace --force >/root/host-hermes-gateway.log 2>&1 &
sleep 3

hermes gateway status --deep || true
tail -40 /root/host-hermes-gateway.log || true
EOF
chmod +x /root/start-host-hermes-gateway.sh
```

Then switch. Prefer stopping only the container gateway service, not the whole container/TUI, when the user is actively chatting in the containerized Hermes:

```bash
# On s6-based Hermes containers, s6-svc is under /command
# This disables the gateway-default service but keeps the container running.
docker exec hermes-agent sh -lc '/command/s6-svc -d /run/service/gateway-default || true; pkill -f "hermes gateway run" || true'

# Stop any host gateway that was started with the wrong environment.
systemctl --user stop hermes-gateway 2>/dev/null || true
pkill -f 'hermes_cli.main gateway run' 2>/dev/null || true
pkill -f 'hermes gateway run' 2>/dev/null || true

/root/start-host-hermes-gateway.sh
```

If the host gateway log says `No messaging platforms enabled`, it almost always means the launcher did not set `HERMES_HOME` to the copied container data. Re-run with `export HERMES_HOME=/root/hermes-host-data` and confirm `/root/hermes-host-data/.env` contains the platform credentials.

If a host Hermes one-shot still reports `computer_use backend unavailable` and looks for the socket under `/root/hermes-host-data/home/.cache/cua-driver/cua-driver.sock`, bridge the host data home to the real `flowdesk` daemon socket:

```bash
mkdir -p /root/hermes-host-data/home/.cache
rm -rf /root/hermes-host-data/home/.cache/cua-driver
ln -s /home/flowdesk/.cache/cua-driver /root/hermes-host-data/home/.cache/cua-driver
ls -l /root/hermes-host-data/home/.cache/cua-driver/cua-driver.sock
```

Then verify with a one-shot host Hermes run before telling the user Telegram is fixed:

```bash
HERMES_HOME=/root/hermes-host-data DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority \
  /root/.local/share/uv/tools/hermes-agent/bin/hermes chat -q 'Use computer_use capture. If it works, say what window title you see.' --toolsets computer_use
```

Test Telegram delivery without relying on the gateway polling loop:

```bash
HERMES_HOME=/root/hermes-host-data /root/.local/share/uv/tools/hermes-agent/bin/hermes send --to telegram 'Host Hermes gateway is ready; message the bot again.' --json
```

Test by messaging the same Telegram bot. If no reply, inspect:

```bash
tail -80 /root/host-hermes-gateway.log
```

## Beginner communication notes

- A command that prints nothing may have succeeded; say that before the user worries.
- Avoid repeated “run doctor” loops. If the user says they already sent the same thing several times, acknowledge the loop and give a new clean path.
- Give one command at a time during the actual support flow. Use scripts/launchers to hide repeated exports instead of making the user paste long env blocks repeatedly.
- Make clear which surface each command belongs to: VPS/root terminal, noVNC browser, or inside Hermes.
