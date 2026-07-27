# Session Lessons: Video-Parity LLM Wiki Automation

Use this reference when the user wants the LLM Wiki setup to behave like the tutorial/video rather than staying purely manual.

## User correction captured

The user clarified they do not want to remember to type “save this to Obsidian” every time. They want useful/durable knowledge from chats to be saved automatically when it is clearly worth keeping.

## Automation shape that matched the correction

- Daily raw ingest: process non-README files under `LLM Wiki/raw/` into linked wiki pages when safe.
- Daily chat auto-save: inspect recent Hermes sessions and save high-signal durable knowledge automatically.
- Weekly lint: report/clean structure issues.
- Nightly local git backup: commit vault changes locally; push when a private GitHub remote is authenticated.

## Safety boundary

Automation still must not save secrets, passwords, API keys, tokens, cookies, payment info, raw chat dumps, or old book references not provided in the current task. Ambiguous or potentially sensitive items go to `Inbox/Review Before Saving.md`.

## GitHub backup workflow

If the user chooses token-based HTTPS auth:

1. User creates a GitHub token themselves.
2. User does not paste token into chat.
3. User pastes token directly in VPS terminal when `git push` asks for password.
4. Use short path to avoid long-copy breakage:

```bash
cd /mnt/hermes-obsidian-vault
git config credential.helper store
git push -u origin main
```

If a pasted command collapses into one line and returns `too many arguments`, split commands one by one and avoid the long Docker volume path.
