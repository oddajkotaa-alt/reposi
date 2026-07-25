# Docker vs Host Hermes for Browser Control

Use this reference when a user has two Hermes runtimes and is choosing which one to keep for GUI browser automation.

## Quick comparison

| Runtime | Better at | Worse at |
|---|---|---|
| Docker Hermes | isolated chat/gateway, prompt work, scripts, clean lifecycle | controlling a browser/desktop that runs on the host |
| Host Hermes | using the real VPS desktop, VNC/noVNC, `DISPLAY=:1`, Chrome sessions, `computer_use` | isolation, clean rollback, avoiding host-level setup mess |
| Docker main + host worker | keeping Docker as the user-facing bot while delegating GUI clicks to the host | conceptual simplicity; still two runtimes exist |

## Key lesson

A browser automation skill improves the procedure but does not solve the access layer. If Docker Hermes cannot see/click the host browser, adding a skill will not grant that access. The agent must either:

1. run where the target desktop is available,
2. automate a browser inside the container, or
3. delegate browser control to a host-side worker.

## Beginner-friendly phrasing

Use this wording when the user is deciding which Hermes to keep:

```text
Docker Hermes is like a clean box. It is safer and cleaner for chatting, captions, and scripts.
Host Hermes is like the one with hands on the VPS screen. It is better when you need Hermes to click Chrome/noVNC/Google Flow.
```

If the user prefers Docker but still wants Flow/browser automation:

```text
You can keep Docker as the main assistant, but use the host Hermes only as the browser-control hand. You would still talk to Docker; the host helper only clicks the VPS browser.
```

## Memory/settings explanation

Separate Hermes homes mean separate settings:

```text
Docker Hermes home != Host Hermes home
```

They may have different:

- Telegram gateway settings
- model/provider config
- enabled tools
- memory/user profile
- skills
- sessions

If one “forgets,” check whether the user is talking to a different Hermes home/profile rather than assuming memory is broken.

## Safety recommendation

When consolidating runtimes:

1. Stop the runtime that should be inactive.
2. Verify the intended runtime still replies and can perform the needed task.
3. Keep the stopped runtime as backup for a while.
4. Delete containers/data only after explicit user approval.
