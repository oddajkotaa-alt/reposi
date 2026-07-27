# Flow/noVNC display recovery: Xauthority mismatch

Use this when Telegram/Hermes/Computer Use cannot control the user's real Google Flow desktop and errors point to display `:1`, Xauthority, or `xdpyinfo` failure for user `flowdesk`.

## Symptom

Even `flowdesk` cannot open its own TigerVNC display `:1`; `.Xauthority` exists but its cookie does not match the current VNC server. Flow checks may hang because Chrome/noVNC is alive but automation cannot access the display.

## Safe recovery sequence

Run in the VPS SSH/Linux shell, not Windows local terminal.

Check xauth:

```bash
runuser -u flowdesk -- bash -lc 'xauth list'
```

Restart VNC `:1` to regenerate the display/session. This closes current noVNC/Chrome windows, but the Chrome profile usually remains in `/home/flowdesk/.config/google-chrome`.

```bash
runuser -u flowdesk -- vncserver -kill :1 || true
runuser -u flowdesk -- vncserver :1 -geometry 1280x1700 -depth 24 -localhost yes
```

Start Chrome Flow in that display:

```bash
runuser -u flowdesk -- bash -lc 'cd /home/flowdesk && DISPLAY=:1 HOME=/home/flowdesk XDG_RUNTIME_DIR=/tmp google-chrome --no-first-run --disable-dev-shm-usage --password-store=basic https://labs.google/fx/tools/flow >/tmp/flow-chrome.log 2>&1 &'
```

Test display:

```bash
runuser -u flowdesk -- bash -lc 'DISPLAY=:1 xdpyinfo >/tmp/xdpyinfo.log 2>&1; tail -20 /tmp/xdpyinfo.log'
```

Expected sign of success: output includes display information such as `name of display: :1`.

Restart cua-driver for the same display:

```bash
pkill -9 cua-driver || true
runuser -u flowdesk -- bash -lc 'DISPLAY=:1 cua-driver serve >/tmp/cua-driver-flowdesk.log 2>&1 &'
runuser -u flowdesk -- bash -lc 'DISPLAY=:1 hermes computer-use doctor'
```

Ask the user to paste the final doctor output.

## Pitfalls

- Do not ask for or type VNC/Google passwords or 2FA.
- Clearly label commands as VPS SSH/Linux shell commands.
- Do not frame this as a permanent tool limitation; it is a recoverable display/session mismatch.
