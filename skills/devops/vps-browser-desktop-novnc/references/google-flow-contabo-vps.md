# Google Flow on Contabo VPS via noVNC: session notes

Context: user wanted a Contabo VPS browser desktop for Google Flow, opened through noVNC in a normal browser. They are beginner-level with VPS/Linux.

Observed pattern:

- User expected Hermes to be root, but the active agent shell was user `hermes` and apt failed with permission denied. The user then used their own root SSH session.
- A script path created in the agent environment (`/opt/data/...`) was not visible/usable in the user's root shell, so the better approach is to have the user create `/root/setup-google-flow-novnc.sh` directly or paste small command chunks.
- User got confused when heredoc paste produced no visible output. Explain that the shell is waiting for the final `EOF` line.
- User repeatedly had trouble knowing where to paste commands. Use explicit labels: “black VPS SSH terminal/root prompt” for commands and “normal browser/noVNC page” for links/visual checking. If the noVNC xterm is open, avoid asking beginners to paste long commands there; launch GUI apps from SSH with `DISPLAY=:1` instead.
- User hit apt update failure from Docker Ubuntu noble repo missing key: `NO_PUBKEY 7EA0A9C3F273FCD8`.
- On this VPS the Docker source was not necessarily a `.list` file; when `sed -i ... /etc/apt/sources.list.d/*.list` returned `No such file or directory`, the right next step was to `grep -R "download.docker.com" /etc/apt/sources.list /etc/apt/sources.list.d/ || true` and disable the actual matching file (often `docker.sources`).
- User pasted the noVNC URL into the root shell and got `-bash: http://...: No such file or directory`; explicitly separate “VPS terminal commands” from “normal browser links.”
- noVNC page loaded but Connect failed; this indicates port 6080/web page can be reachable while backend VNC on 5901 is not running.
- TigerVNC failed with `The X session exited with status 1!` and suggested `tigervncserver -xstartup /usr/bin/xterm`; future troubleshooting should immediately inspect `/home/flowdesk/.vnc/*.log` instead of repeating start commands.
- Minimal xterm startup succeeded with `runuser -u flowdesk -- vncserver :1 -geometry 1280x1700 -depth 24 -localhost yes -xstartup /usr/bin/xterm`, producing a white terminal inside noVNC. This is enough to launch Chromium even before XFCE is repaired.
- Launching Chromium from the noVNC xterm while in `/root` produced snap/runtime warnings such as `cannot start document portal: dial unix /run/user/0/bus: connect: permission denied` and `not a snap cgroup`. Better next step is launching from the root SSH terminal with `runuser -u flowdesk -- bash -lc 'cd /home/flowdesk && DISPLAY=:1 HOME=/home/flowdesk XDG_RUNTIME_DIR=/tmp chromium https://labs.google/fx/tools/flow' &`.

Useful beginner wording:

- “If it shows nothing, that is OK. Linux often means success by saying nothing.”
- “Only stop if you see words like error, failed, No such file, or Permission denied.”
- “Do not send me your password or Google 2FA code.”

Docker key repair commands used:

```bash
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
sed -i 's|deb https://download.docker.com/linux/ubuntu|deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu|g' /etc/apt/sources.list.d/*.list
apt-get update
```

Fallback if Docker repo is not needed and still blocks setup:

```bash
# Find the actual file first; it may be .list or .sources
grep -R "download.docker.com" /etc/apt/sources.list /etc/apt/sources.list.d/ || true

# Disable the matching file rather than deleting it
mv /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/docker.list.disabled 2>/dev/null || true
mv /etc/apt/sources.list.d/docker.sources /etc/apt/sources.list.d/docker.sources.disabled 2>/dev/null || true

apt-get update
```

VNC startup crash commands:

```bash
# If vncserver exits with status 1, inspect logs before repeating commands
ls -la /home/flowdesk/.vnc/
tail -100 /home/flowdesk/.vnc/*.log

# Minimal fallback test
apt-get install -y xterm
runuser -u flowdesk -- vncserver -kill :1 || true
runuser -u flowdesk -- vncserver :1 -geometry 1280x1700 -depth 24 -localhost yes -xstartup /usr/bin/xterm
ss -ltnp | grep 5901
```

Operator cue: if the user says noVNC “Connect failed” but the noVNC web page opens, focus on backend VNC `5901` and websockify logs, not public firewall first.
