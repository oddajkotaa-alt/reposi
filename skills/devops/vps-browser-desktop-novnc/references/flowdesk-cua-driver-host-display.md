# Flowdesk cua-driver host display troubleshooting

Use this when Telegram-connected Hermes runs in a container or different runtime, while Google Flow runs in the VPS host VNC desktop as `flowdesk` on display `:1`.

## Symptom

- noVNC is reachable and shows a real Flow desktop for the user.
- Host processes show `Xtigervnc :1`, `websockify ... 6080 ... 5901`, and Chrome crashpad/Chrome processes under `flowdesk`.
- Agent-side `computer_use` sees `0x0` or no desktop.
- `hermes computer-use doctor` on host reports `X11 is not reachable` or `cua-driver mcp produced no initialize response`.

## Checks

```bash
pgrep -af 'websockify|Xtigervnc|google-chrome' | head -20
ls -l /home/flowdesk/.Xauthority
command -v cua-driver
```

Expected VNC auth file:

```text
-rw------- 1 flowdesk flowdesk ... /home/flowdesk/.Xauthority
```

## Fix pattern

If `cua-driver` was installed under `/root/.local/bin`, `flowdesk` cannot execute it via `/root/...`. Copy it to a world-executable path first:

```bash
cp /root/.local/bin/cua-driver /usr/local/bin/cua-driver && chmod 755 /usr/local/bin/cua-driver
```

Then start the daemon as `flowdesk` against the VNC display:

```bash
pkill -9 cua-driver || true
runuser -u flowdesk -- bash -lc 'DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority cua-driver serve >/tmp/cua-driver-flowdesk.log 2>&1 &'
```

Run doctor with full, non-ellipsized env vars:

```bash
DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority hermes computer-use doctor
```

If it still fails, inspect logs before trying another doctor loop:

```bash
tail -80 /tmp/cua-driver-flowdesk.log
```

## Communication note

Do not show shortened paths like `/home/...rity` in commands. The user often pastes exactly what is displayed; use full paths or separate short `export` commands.
