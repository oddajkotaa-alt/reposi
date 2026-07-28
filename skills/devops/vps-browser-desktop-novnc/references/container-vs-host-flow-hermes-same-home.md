# Container vs host Hermes for Google Flow with shared `/opt/data`

Session lesson: for Google Flow/noVNC automation, the Telegram-connected Docker/container Hermes can have the correct skills, Obsidian vault, sessions, and Telegram cache under `/opt/data`, while still being unable to see or drive the host VNC desktop (`/home/flowdesk`, `DISPLAY=:1`).

## Durable architecture pattern

Use **one Hermes home** but, when GUI control is required, run the active gateway from the **host-side Hermes** with the same data directory:

```bash
HERMES_HOME=/opt/data \
HOME=/opt/data/home \
DISPLAY=:1 \
XAUTHORITY=/home/flowdesk/.Xauthority \
/opt/hermes/.venv/bin/hermes gateway run --replace
```

This gives the host-side gateway access to:

- the same skills: `/opt/data/skills`
- the same Obsidian vault: `/opt/data/ObsidianVault`
- the same Telegram/cache/session data: `/opt/data/...`
- the host VNC display needed for Flow: `DISPLAY=:1`

## Avoid the old split-brain setup

Do **not** solve Flow access by returning to an old separate home such as:

```text
/root/hermes-host-data
```

That recreates the old split-brain problem: one Hermes sees Flow, another sees Obsidian/skills/Telegram images. If the user says “second Hermes,” clarify that they likely mean “host-side Hermes with the same `/opt/data` home,” not a separate brain.

## Quick diagnostic

Inside the active Telegram session, check whether it can see the host desktop:

```bash
ls -ld /home/flowdesk 2>&1 || true
ps -eo pid,user,cmd | grep -E 'google-chrome|Xtigervnc|websockify|cua-driver|hermes gateway' | grep -v grep || true
```

If `/home/flowdesk` is missing and `computer_use` captures return `0x0`, the current session is probably container-side only. Do not conclude Flow is broken; conclude the active Hermes cannot reach the host display.

## User-facing explanation

Keep it short for beginners:

> This Hermes has your skills/Obsidian, but cannot see the Flow desktop. The fix is not a new brain; it is host Hermes using the same `/opt/data` brain plus `DISPLAY=:1`.
