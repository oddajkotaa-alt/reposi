---
name: vps-browser-desktop-novnc
description: Set up and troubleshoot a browser-accessible Linux desktop on a VPS using XFCE, TigerVNC, noVNC, and websockify for tools like Google Flow.
tags:
  - vps
  - novnc
  - vnc
  - xfce
  - chromium
  - beginner-support
---

# VPS browser desktop via noVNC

Use this when the user wants a VPS-hosted browser/desktop they can open from their normal browser, especially for Google Flow or other web apps that need a persistent remote browser.

## User communication style

- Assume beginner level unless proven otherwise.
- Give commands one at a time or in very small chunks.
- Say when a command may produce no output and that this usually means success.
- Do not ask for passwords, Google credentials, 2FA codes, API keys, or secrets.
- If Google login/2FA appears, stop automation and tell the user to handle it manually in the noVNC browser.
- When a user reports “nothing happened,” first check whether they are in a heredoc/editor prompt or whether the command succeeded silently.

## Setup workflow

1. Check OS and package manager before installing:
   - `. /etc/os-release && echo "$PRETTY_NAME"`
   - `command -v apt-get || command -v dnf || command -v yum`
   - `whoami` and `id` to confirm root privileges.
2. On Debian/Ubuntu, run `apt-get update` before installs.
3. If apt has public key/signature errors, fix the broken repository key or disable the broken third-party source temporarily before continuing.
4. Install the browser/desktop stack:
   - `chromium`
   - `xfce4`
   - `xfce4-goodies`
   - `tigervnc-standalone-server`
   - `novnc`
   - `websockify`
   - `dbus-x11`
   - `x11-xserver-utils`
   - `curl`
5. Prefer creating a normal desktop user such as `flowdesk` instead of running the desktop as root.
6. Configure `/home/flowdesk/.vnc/xstartup` to start XFCE through dbus:
   - unset `SESSION_MANAGER`
   - unset `DBUS_SESSION_BUS_ADDRESS`
   - run `exec dbus-launch --exit-with-session startxfce4`
7. Start TigerVNC on display `:1` with a tall resolution such as `1280x1700` and bind VNC itself to localhost:
   - `runuser -u flowdesk -- vncserver :1 -geometry 1280x1700 -depth 24 -localhost yes`
8. Start noVNC/websockify on public port 6080 forwarding to local VNC 5901:
   - `websockify --web /usr/share/novnc 0.0.0.0:6080 localhost:5901`
9. Launch a browser into the VNC display. Prefer Google Chrome if available because it may preserve the user's previous Google Flow login and avoids Snap Chromium issues:
   - `command -v google-chrome || command -v google-chrome-stable || command -v firefox || command -v firefox-esr || command -v chromium || command -v chromium-browser`
   - `runuser -u flowdesk -- bash -lc 'cd /home/flowdesk && DISPLAY=:1 HOME=/home/flowdesk XDG_RUNTIME_DIR=/tmp google-chrome --no-first-run --disable-dev-shm-usage --password-store=basic https://labs.google/fx/tools/flow' &`
   - Chromium fallback: `runuser -u flowdesk -- env DISPLAY=:1 chromium --no-first-run --disable-dev-shm-usage --password-store=basic 'https://labs.google/fx/tools/flow' &`
10. Tell the user the exact URL:
   - `http://SERVER_IP:6080/vnc.html?host=SERVER_IP&port=6080`

## Apt key/signature troubleshooting pattern

If apt reports a missing public key for a third-party repo, e.g. Docker:

- Explain simply: apt is refusing to update because a package source is missing its security key.
- Install/check tools: `apt-get install -y ca-certificates curl gnupg`
- Create keyring dir: `install -m 0755 -d /etc/apt/keyrings`
- Add the vendor key to `/etc/apt/keyrings/<vendor>.gpg`.
- Update that repo's source line to include `signed-by=/etc/apt/keyrings/<vendor>.gpg`.
- If the third-party repo is not needed for the task and keeps blocking apt, temporarily disable its source file by renaming it to `.disabled` rather than deleting it.
- Modern Ubuntu/Debian apt may store repos as `.sources` files, not `.list` files. If `sed ... /etc/apt/sources.list.d/*.list` says `No such file or directory`, run `grep -R "download.docker.com" /etc/apt/sources.list /etc/apt/sources.list.d/ || true`, then disable the actual matching file (for example `docker.sources`).

For Docker Ubuntu repo specifically:

```bash
install -m 0755 -d /etc/apt/keyrings
rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
sed -i 's|deb https://download.docker.com/linux/ubuntu|deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu|g' /etc/apt/sources.list.d/*.list
apt-get update
```

Temporary disable fallback — works for `.list` or `.sources` files:

```bash
# Show the exact Docker source file first
grep -R "download.docker.com" /etc/apt/sources.list /etc/apt/sources.list.d/ || true

# Disable whichever matching file exists; examples:
mv /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/docker.list.disabled 2>/dev/null || true
mv /etc/apt/sources.list.d/docker.sources /etc/apt/sources.list.d/docker.sources.disabled 2>/dev/null || true

apt-get update
```

## References

- `references/google-flow-contabo-vps.md` records a concrete Contabo/Google Flow troubleshooting session, including Docker apt key repair and beginner wording.

## VNC startup crash troubleshooting

If `vncserver :1 ...` exits with `The X session exited with status 1!` or suggests `tigervncserver -xstartup /usr/bin/xterm`:

1. Do not keep repeating the same start command. Read the VNC log next:
   - `ls -la /home/flowdesk/.vnc/`
   - `tail -100 /home/flowdesk/.vnc/*.log`
2. Check that the desktop user and xstartup file exist and are executable:
   - `id flowdesk`
   - `ls -l /home/flowdesk/.vnc/xstartup`
3. Install a minimal fallback terminal if needed: `apt-get install -y xterm`.
4. Test with a minimal session:
   - `runuser -u flowdesk -- vncserver -kill :1 || true`
   - `runuser -u flowdesk -- vncserver :1 -geometry 1280x1700 -depth 24 -localhost yes -xstartup /usr/bin/xterm`
5. If xterm works but XFCE fails, fix XFCE/dbus startup; if xterm also exits, the `.vnc/*.log` is the source of truth.

## Launching a browser after an xterm fallback

If XFCE crashes but `-xstartup /usr/bin/xterm` works, the user may only see a small white xterm window in noVNC. For beginners, do not force them to paste long commands into that white terminal. Prefer launching the browser from the root SSH terminal into display `:1`.

First discover which browser is available. Prefer `google-chrome` / `google-chrome-stable` when present, because it is more likely to preserve the user's previous Google Flow login and avoids Ubuntu Snap Chromium VNC issues:

```bash
command -v google-chrome || command -v google-chrome-stable || command -v firefox || command -v firefox-esr || command -v chromium || command -v chromium-browser
```

Google Chrome launch:

```bash
runuser -u flowdesk -- bash -lc 'cd /home/flowdesk && DISPLAY=:1 HOME=/home/flowdesk XDG_RUNTIME_DIR=/tmp google-chrome --no-first-run --disable-dev-shm-usage --password-store=basic https://labs.google/fx/tools/flow' &
```

Chromium fallback:

```bash
runuser -u flowdesk -- bash -lc 'cd /home/flowdesk && DISPLAY=:1 HOME=/home/flowdesk XDG_RUNTIME_DIR=/tmp chromium --no-first-run --disable-dev-shm-usage --password-store=basic https://labs.google/fx/tools/flow' &
```

Fallback binary name:

```bash
runuser -u flowdesk -- bash -lc 'cd /home/flowdesk && DISPLAY=:1 HOME=/home/flowdesk XDG_RUNTIME_DIR=/tmp chromium-browser --no-first-run --disable-dev-shm-usage --password-store=basic https://labs.google/fx/tools/flow' &
```

If Chromium prints Snap errors such as `/run/user/0/bus: permission denied`, `cannot start document portal`, or `not a snap cgroup`, stop trying Snap Chromium and use `google-chrome` or Firefox if available. If a foreground browser command appears to do nothing and no prompt returns, explain that the browser may still be running; use `Ctrl+C` only if it clearly failed to open in noVNC and you need to recover the terminal. Avoid giving a second long launch command while the first is still printing output, because beginners can accidentally paste into the middle of the command and create a broken `chromium-brow&...` line.

## Verification

- Check VNC is listening locally: `ss -ltnp | grep 5901`.
- Check noVNC is listening publicly: `ss -ltnp | grep 6080`.
- Seeing multiple `websockify` PIDs on 6080 usually means several background starts were attempted; clean up with `pkill -f 'websockify.*6080' || true` and start one fresh if connection behavior is confusing.
- Check HTTP response: `curl -I http://127.0.0.1:6080/vnc.html`.
- Check Chromium process in the VNC display: `pgrep -a chromium`.
- If port 6080 works locally but not from the user's browser, suspect VPS firewall/provider firewall and ask the user to allow TCP 6080.

## Pitfalls

- A root-run setup script created in an agent sandbox path may not exist in the user's root SSH session. If so, provide a pasteable script or have the user create it under `/root/`.
- Heredoc paste can appear to “do nothing” until the final `EOF` line is entered exactly, alone, with no spaces.
- Commands like `install -d`, `chmod`, `sed -i`, and successful key setup often print nothing; tell beginners this is normal.
- When a user reports noVNC connect failed, distinguish the two surfaces: the noVNC web page loading means port 6080 is reachable, but VNC may still be down behind it. Verify `5901` before restarting websockify.
- Beginners may paste `http://.../vnc.html` into the VPS terminal. Explain: commands go in the VPS terminal; website links go in their normal browser address bar.
- A shell job error like `[2]+ Exit 127 http://...` is usually leftover from a URL pasted into the terminal, not evidence about noVNC.
- If the user is stuck in the white xterm inside noVNC and cannot paste/type reliably, stop giving xterm paste instructions. Tell them to leave noVNC open and use the black/root SSH terminal to launch apps into `DISPLAY=:1`.
- If copy/paste into a noVNC browser field fails, tell the user to open the noVNC side drawer/clipboard panel, paste the text there first, then click the web app field and press `Ctrl+V`. This is often the easiest way to paste long Google Flow prompts.
- For Hermes `computer-use` inside Docker controlling a VPS/noVNC desktop: installing `cua-driver` is not enough. Add `/opt/data/home/.local/bin` to `PATH`, start `cua-driver serve`, then run doctor. If doctor reports `X11 is not reachable`, try `DISPLAY=:1` only if the Hermes runtime can access the VNC/X11 session; otherwise the agent container cannot inspect/inject into the host VNC display without additional host display/socket exposure or running Hermes in the same host session.
- If Docker Hermes cannot reach host VNC but the user's goal is Telegram-to-Google-Flow browser automation, install/run Hermes on the VPS host (for example via `uv tool install hermes-agent`) and run it with `DISPLAY=:1` plus `XAUTHORITY=/home/flowdesk/.Xauthority`. Start `cua-driver serve` with those env vars, then verify `hermes computer-use doctor` reports both `ax_capability` and `screen_capture_capability` OK before switching the Telegram gateway to the host Hermes.
- If root gets `Authorization required, but no authorization protocol specified` when starting `cua-driver` against the `flowdesk` VNC display, set `XAUTHORITY=/home/flowdesk/.Xauthority` and restart the daemon: `export DISPLAY=:1; export XAUTHORITY=/home/flowdesk/.Xauthority; cua-driver serve &`.
- Do not claim installation succeeded unless verified by command output or user confirmation.
