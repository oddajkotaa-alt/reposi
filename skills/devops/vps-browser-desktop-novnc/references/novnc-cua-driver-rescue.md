# noVNC + cua-driver rescue notes

Use when the user is on a VPS/noVNC Linux desktop and repeated pasted SSH commands are failing or the user is frustrated.

## Workflow preference

- Recover recent context and resend exact short commands, not a generic summary.
- Label every command location clearly: **VPS SSH terminal** vs **local/PC browser**.
- If noVNC is reachable, open/inspect it yourself. If it is on the Connect/password screen, ask the user only to enter the VNC password/credentials; after they say the desktop is unlocked, operate the remote desktop yourself instead of making them paste more commands.
- Avoid long quoted `runuser -- bash -lc '...'` commands when noVNC/terminal copy-paste is corrupting spaces or quotes.

## Durable troubleshooting patterns

### X11 authorization

Symptoms:

```text
Authorization required, but no authorization protocol specified
xdpyinfo: unable to open display ":1"
```

Pattern:

```bash
export DISPLAY=:1
export XAUTHORITY=/home/<desktop-user>/.Xauthority
xdpyinfo | head -5
```

If running as another user/root:

```bash
sudo -u <desktop-user> env DISPLAY=:1 XAUTHORITY=/home/<desktop-user>/.Xauthority xdpyinfo | head -5
```

### PATH loss under sudo/runuser

Symptoms:

```text
env: 'hermes': No such file or directory
```

Pattern: resolve paths as the shell user before switching users, then invoke those paths:

```bash
HER=$(command -v hermes)
CUA=$(command -v cua-driver)
echo "$HER"; echo "$CUA"
```

Then use `"$HER"` / `"$CUA"` in the command, or paste the full path if variables will not survive the interaction.

### Log permission problems

Symptoms:

```text
/tmp/cua-driver-flowdesk.log: Permission denied
```

Pattern: redirect logs into the desktop user's home instead of `/tmp`, or remove/chown the old log. Example:

```bash
rm -f /home/<desktop-user>/cua-driver.log
sudo -u <desktop-user> env DISPLAY=:1 XAUTHORITY=/home/<desktop-user>/.Xauthority /full/path/to/cua-driver serve >/home/<desktop-user>/cua-driver.log 2>&1 &
```
