---
name: containerized-desktop-automation
description: "Choose and configure Docker/container vs host-side Hermes for GUI browser automation, especially VNC/noVNC desktop workflows."
version: 1.0.0
platforms: [linux]
metadata:
  hermes:
    tags: [docker, container, desktop, browser-automation, novnc, vnc, computer-use]
    created_by: agent
---

# Containerized Desktop Automation

Use this skill when a user wants Hermes to automate a GUI browser or desktop app while Hermes may be running in Docker, on the host, or in multiple profiles/installations.

## Core principle

A skill can teach Hermes **what workflow to follow**, but it cannot by itself grant access to the real desktop. Before promising GUI automation, identify where Hermes is running and where the target browser/desktop is running.

Common split:

```text
Docker Hermes        = isolated assistant/gateway, cleaner for chat
Host desktop/browser = owns DISPLAY=:1, VNC/noVNC, Chrome, logged-in apps
```

If the assistant runs in Docker while the browser runs on the host, the container boundary may block screen capture, accessibility, keyboard/mouse routing, X11/AT-SPI, downloads, or profile access.

## Decision guide

### Option A — Host Hermes as the single main assistant

Best when the user's top goal is:

```text
Telegram/chat -> Hermes -> real VPS browser/noVNC -> app such as Google Flow
```

Pros:
- usually easiest access to `DISPLAY=:1`, VNC/noVNC, Chrome, and `computer_use`
- can reuse the browser session where the user logged in manually
- fewer cross-boundary GUI issues

Cons:
- less isolated than Docker
- settings/memory may live in a different Hermes home
- environment must be started with the right `HERMES_HOME`, `DISPLAY`, and PATH

### Option B — Docker Hermes as the single main assistant

Best when the user's top goal is:

```text
Telegram/chat, prompt writing, scripts, captions, non-GUI automation
```

Pros:
- cleaner isolation
- easy container lifecycle
- less likely to change the host system

Cons:
- often poor access to a host VNC/noVNC browser
- may not be able to see/click the already logged-in Chrome session
- adding host GUI access requires careful mounts, env vars, and permissions

### Option C — Docker main assistant + host browser worker

Best compromise when the user prefers Docker as the main bot but needs real browser control.

```text
User/Telegram -> Docker Hermes main brain -> host-side Hermes/helper -> VNC/Chrome/app
```

Pros:
- Docker remains the user's primary, cleaner chat/gateway environment
- host-side worker handles only desktop control
- avoids forcing Docker through fragile X11/desktop access

Cons:
- technically two runtimes exist
- requires clear explanation so the user does not feel they are managing two confusing assistants
- cross-runtime memory/skills/settings do not automatically sync

## User explanation pattern

For beginner users, avoid abstract container language first. Use a concrete comparison:

```text
Docker Hermes = clean box, good for chat and planning.
Host Hermes = has hands on the VPS screen, better for clicking Chrome/Flow.
```

Then explain the trade-off:

```text
Docker is not worse overall; it is just worse at controlling a browser that lives outside the container.
Host is not better overall; it is better when the job requires the real desktop session.
```

## Workflow checklist

1. Ask/inspect which Hermes is connected to the gateway/chat platform.
2. Identify the Hermes home for each runtime (`HERMES_HOME`, config, memory, sessions).
3. Identify where the browser is running: inside Docker, headless browser tool, or host VNC/noVNC desktop.
4. For GUI control, verify the runtime that will click/type can access the desktop (`DISPLAY`, `cua-driver`, accessibility/screen capture health).
5. If the user complains that one runtime “forgets,” explain that separate Hermes homes mean separate memory/skills/sessions.
6. Prefer stopping the unused runtime before deleting it. Do not remove containers or data until the user explicitly asks and the active replacement is verified.

## Pitfalls

- Do not imply that creating a skill alone makes Docker able to control the host browser.
- Do not recommend deleting the old runtime early. Stop/disable first, verify, then consider removal later.
- Do not save transient path or command failures as permanent rules. Capture the durable boundary lesson: container isolation vs host desktop access.
- Do not say “Docker cannot automate browsers” as a universal claim. Docker can automate a browser inside Docker; the hard part is controlling a host browser from inside Docker.

## References

- `references/docker-vs-host-hermes-for-browser-control.md` — concise explanation and decision matrix for Docker Hermes vs host Hermes in VNC/noVNC browser automation.
