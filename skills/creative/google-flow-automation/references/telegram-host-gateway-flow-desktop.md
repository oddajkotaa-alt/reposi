# Telegram/Host Gateway Access to VPS Flow Desktop

Session-derived recovery pattern for when Google Flow is working in VPS noVNC/Chrome, but Telegram Hermes cannot see or control it.

## Symptom

Telegram-side agent reports one or more of:

- `computer_use` returns `0x0` or no screen.
- It says it is running inside a container and cannot access Docker/host desktop.
- Active gateway process is something like `/opt/hermes/.venv/bin/hermes gateway run --replace` inside the `hermes-agent` container.
- noVNC/Chrome/Flow works for the user, and host `cua-driver health_report` passes, but Telegram still cannot operate Flow.

## Root cause pattern

The Telegram bot may be served by a container gateway that does not share the host X11/noVNC desktop or the host `cua-driver` socket. The Flow desktop is on the VPS host (`DISPLAY=:1` as `flowdesk`), while the gateway handling Telegram is in a container.

## Recovery pattern

1. Verify host desktop/driver first:

```bash
sudo -u flowdesk env DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority cua-driver doctor
```

or:

```bash
sudo -u flowdesk env DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority cua-driver call health_report
```

2. Stop only the container gateway service, not the whole container/TUI, if applicable:

```bash
docker exec hermes-agent sh -lc '/command/s6-svc -d /run/service/gateway-default || true; pkill -f "hermes gateway run" || true'
```

3. Start the host gateway with the same Hermes home/config used by the container, but with Flow desktop env:

```bash
export HERMES_HOME=/root/hermes-host-data
export DISPLAY=:1
export XAUTHORITY=/home/flowdesk/.Xauthority
export PATH="/root/.local/share/uv/tools/hermes-agent/bin:/root/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
nohup /root/.local/share/uv/tools/hermes-agent/bin/hermes gateway run --replace >/root/host-hermes-gateway.log 2>&1 &
```

4. If Hermes looks for the cua socket under `$HERMES_HOME/home/.cache/cua-driver`, symlink it to the `flowdesk` socket:

```bash
mkdir -p /root/hermes-host-data/home/.cache
rm -rf /root/hermes-host-data/home/.cache/cua-driver
ln -s /home/flowdesk/.cache/cua-driver /root/hermes-host-data/home/.cache/cua-driver
```

5. Verify with a host Hermes one-shot using `computer_use` before asking the user to retry Telegram.

## Safety notes

- Do not type or request VNC/Google passwords. The user handles noVNC/Google login.
- Do not restart gateway/service controls during active Flow work unless the user asked to fix Telegram/gateway routing.
- This is a recovery pattern, not a permanent negative claim about containers. Container gateway is fine for normal chat; host gateway is needed when Telegram must control the host Flow desktop.
