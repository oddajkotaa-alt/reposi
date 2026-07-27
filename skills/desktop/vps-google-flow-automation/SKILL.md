---
name: vps-google-flow-automation
description: Operate and troubleshoot Google Flow/Nano Banana Pro automation on a VPS noVNC desktop, including host-vs-container Hermes gateway routing, cua-driver DISPLAY setup, and low-friction recovery for users who struggle with long command pastes.
version: 1.0.0
platforms: [linux]
metadata:
  hermes:
    tags: [google-flow, novnc, vps, cua-driver, telegram-gateway, desktop-automation]
---

# VPS Google Flow Automation

Use this skill when the user wants Hermes to operate Google Flow/Nano Banana Pro in a VPS browser/noVNC desktop, especially when work is coordinated through Telegram but Flow is open on the VPS desktop.

## Core workflow

1. Confirm Google Flow is open in the VPS noVNC desktop and the user is logged in. Do not handle passwords, 2FA, CAPTCHA, or Google security prompts.
2. Confirm the VNC desktop display env:
   - `DISPLAY=:1`
   - `XAUTHORITY=/home/flowdesk/.Xauthority`
   - desktop user usually `flowdesk`
3. Run `cua-driver serve` inside that same desktop session as `flowdesk`, not from an unrelated container/session.
4. Verify with `cua-driver health_report` or a real `computer_use` capture before claiming automation is ready.
5. If Telegram is supposed to continue the work, ensure the Telegram gateway process is the host Hermes instance that can see the VNC desktop, not a container gateway without the desktop socket.

## User-experience rule

This user struggles with long VPS/noVNC copy-paste: noVNC may corrupt spaces, truncate commands, or paste ellipsized paths. Avoid long multi-line commands. Prefer doing the work directly over SSH once access is available. If the user must paste something, make it one short line and clearly label it **VPS SSH terminal**.

## Important references

- `references/vps-novnc-flow-gateway.md` — recovery pattern when Telegram/gateway Hermes cannot see the Flow desktop.
