# noVNC clipboard corruption and SSH handoff rescue

Use this when the user is exhausted by repeated VPS/noVNC paste failures and asks the agent to take over.

## Problem pattern

- noVNC/browser clipboard corrupts long commands: spaces disappear, paths get truncated/ellipsized, or shell quoting breaks.
- The user may accidentally press `Ctrl+C` and lose the current instruction context.
- Long `authorized_keys`, `runuser`, or `sudo -u flowdesk env ...` commands become unreliable when pasted through noVNC.

## Preferred rescue sequence

1. Stop giving long commands. Acknowledge the paste problem and switch to an agent-takeover path.
2. Try direct SSH from the agent environment with `BatchMode=yes`. If it fails, do not ask for passwords.
3. Generate an ephemeral SSH key locally and give the user a very short key-install path.
4. If the public key command is still too long, host a tiny shell script that appends the key. `paste.rs` worked as a simple script host when `transfer.sh` was unreachable.
5. Give the user only a short command such as `curl -L paste.rs/<id> | bash` and wait for confirmation.
6. After SSH works, perform diagnosis/fixes directly; do not return to long noVNC paste instructions unless unavoidable.
7. Offer to remove the temporary key when the task is complete.

## VPS Flow/cua-driver checks once SSH is available

- Discover binaries and processes:
  - `command -v hermes || true`
  - `command -v cua-driver || true`
  - `ps -ef | egrep "Xtigervnc|websockify|novnc|google-chrome|cua-driver" | grep -v grep || true`
- `flowdesk` may not be able to run Hermes from `/root/...` even if root can; use full paths only when permissions allow.
- To verify the desktop automation layer without depending on Hermes PATH, run direct `cua-driver` diagnostics as `flowdesk`:
  - `sudo -u flowdesk env DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority cua-driver doctor`
  - or `sudo -u flowdesk env DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority cua-driver call health_report`
- Healthy output includes `overall: ok`, `ax_capability: pass`, and `screen_capture_capability: pass`.

## Log and XAUTHORITY pitfalls

- If `/tmp/cua-driver-flowdesk.log` returns permission denied, write logs to a user-owned path instead: `/home/flowdesk/cua-driver-flowdesk.log`.
- If root sees `Authorization required, but no authorization protocol specified`, include `XAUTHORITY=/home/flowdesk/.Xauthority` with `DISPLAY=:1`.
- Start `cua-driver` as `flowdesk` against the VNC display:

```bash
pkill -9 cua-driver 2>/dev/null || true
sudo -u flowdesk env DISPLAY=:1 XAUTHORITY=/home/flowdesk/.Xauthority cua-driver serve >/home/flowdesk/cua-driver-flowdesk.log 2>&1 &
```

## Communication rule

When the user says they cannot copy commands correctly, do not keep reformatting the same long command. Convert the workflow into a short fetch-and-run script or take over via SSH. Keep any required user action short enough to type by hand.
