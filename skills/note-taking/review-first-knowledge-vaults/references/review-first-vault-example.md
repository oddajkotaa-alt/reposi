# Review-First Vault Example

This reference captures the practical pattern for building an Obsidian-style vault that Hermes can read and write while the user keeps control over what becomes permanent.

## VPS-local vault pattern

Use a concrete path visible to Hermes, for example:

```text
/opt/data/ObsidianVault
```

Folder structure:

```text
/opt/data/ObsidianVault/
  Hermes/
  Google Flow/
  TikTok Shop/
  Prompt Examples/
  Inbox/
```

Starter notes:

```text
Hermes/README.md
Hermes/Session Summaries.md
Inbox/Review Before Saving.md
```

## Review Before Saving note pattern

Use this note when importing facts from chat history, memory, or compressed context.

```markdown
# Review Before Saving

This note is a staging area. The items below are not final permanent notes yet.

Please review and say what to keep, edit, or delete.

## Possible preferences
- ...

## Possible workflow notes
- ...

## Possible setup notes
- ...

## Things to confirm before making permanent
- ...
```

## Promotion pattern

After the user approves content:

- Move stable creative preferences to `TikTok Shop/Style Rules.md`.
- Move browser/Flow operating steps to `Google Flow/Automation Workflow.md`.
- Move reusable working prompts to `Prompt Examples/Winning Prompts.md`.
- Append chronological summaries to `Hermes/Session Summaries.md`.

## What to avoid

- Do not dump raw transcripts.
- Do not save API keys, secrets, cookies, auth tokens, or payment information.
- Do not preserve every transient error; save reusable fixes or confirmed final setup only.
- Do not promote old context without user review.

## Recommended user-facing explanation

Tell the user:

> I created a review-first Obsidian-style vault. Old or uncertain information goes into Inbox/Review Before Saving.md first. You can review it before I move anything into permanent notes.
