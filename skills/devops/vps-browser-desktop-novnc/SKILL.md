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
9. Launch Chromium into the VNC display:
   - `runuser -u flowdesk -- env DISPLAY=:1 chromium --no-first-run --disable-dev-shm-usage --password-store=basic 'https://labs.google/fx/tools/flow' &`
10. Tell the user the exact URL:
   - `http://SERVER_IP:6080/vnc.html?host=SERVER_IP&port=6080`

## Apt key/signature troubleshooting pattern

If apt reports a missing public key for a third-party repo, e.g. Docker:

- Explain simply: apt is refusing to update because a package source is missing its security key.
- Install/check tools: `apt-get install -y ca-certificates curl gnupg`
- Create keyring dir: `install -m 0755 -d /etc/apt/keyrings`
- Add the vendor key to `/etc/apt/keyrings/<vendor>.gpg`.
- Update that repo's source line to include `signed-by=/etc/apt/keyrings/<vendor>.gpg`.
- If the third-party repo is not needed for the task and keeps blocking apt, temporarily disable its `.list` file by renaming it to `.disabled` rather than deleting it.

For Docker Ubuntu repo specifically:

```bash
install -m 0755 -d /etc/apt/keyrings
rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
sed -i 's|deb https://download.docker.com/linux/ubuntu|deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu|g' /etc/apt/sources.list.d/*.list
apt-get update
```

Temporary disable fallback:

```bash
mv /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/docker.list.disabled
apt-get update
```

## References

- `references/google-flow-contabo-vps.md` records a concrete Contabo/Google Flow troubleshooting session, including Docker apt key repair and beginner wording.

## Verification

- Check VNC is listening locally: `ss -ltnp | grep 5901`.
- Check noVNC is listening publicly: `ss -ltnp | grep 6080`.
- Check HTTP response: `curl -I http://127.0.0.1:6080/vnc.html`.
- Check Chromium process in the VNC display: `pgrep -a chromium`.
- If port 6080 works locally but not from the user's browser, suspect VPS firewall/provider firewall and ask the user to allow TCP 6080.

## Pitfalls

- A root-run setup script created in an agent sandbox path may not exist in the user's root SSH session. If so, provide a pasteable script or have the user create it under `/root/`.
- Heredoc paste can appear to “do nothing” until the final `EOF` line is entered exactly, alone, with no spaces.
- Commands like `install -d`, `chmod`, `sed -i`, and successful key setup often print nothing; tell beginners this is normal.
- Do not claim installation succeeded unless verified by command output or user confirmation.
