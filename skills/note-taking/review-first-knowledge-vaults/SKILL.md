---
name: review-first-knowledge-vaults
description: Use when setting up or maintaining an Obsidian-style note vault from chat history, preferences, workflows, prompts, or session summaries. Saves clean, user-reviewed knowledge instead of dumping raw chats.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [obsidian, memory, notes, knowledge-vault, session-summary, review-first]
    related_skills: [obsidian]
---

# Review-First Knowledge Vaults

## Overview

Use this skill when the user wants Obsidian or Markdown notes to help the agent remember work across chats. The goal is not to archive every message. The goal is to create a clean, searchable knowledge vault: durable preferences, reusable workflows, working prompts, decisions, and next steps.

Default to a **review-first** workflow: uncertain or old information goes into an inbox note first. The user reviews it before it becomes permanent knowledge.

## When to Use

Use when the user asks to:

- set up an Obsidian vault or Markdown note vault
- save information from the current chat
- remember workflows, prompts, or decisions in notes
- create session summaries
- use notes to reduce repeated explanations in future sessions
- review what the agent plans to save before saving it permanently

Do not use for:

- secrets, API keys, passwords, cookies, billing details, or private tokens
- raw automatic logging of every message
- stale one-off task progress that will be irrelevant soon
- facts that belong in compact Hermes memory instead of long notes

## Core Rules

1. **Do not save raw chat dumps by default.** Save clean summaries and actionable knowledge.
2. **Stage uncertain information first.** Put old, inferred, or possibly stale facts into `Inbox/Review Before Saving.md`.
3. **Show the user what will be saved.** Ask what to keep, edit, or delete before moving staged notes into permanent files.
4. **Separate stable facts from session history.** Preferences and reusable workflows go in topic notes; chronological summaries go in session notes.
5. **Never store secrets.** Redact or omit keys, tokens, auth headers, cookies, credit cards, and passwords.
6. **Prefer concise notes.** The vault should make future work faster, not become another context dump.

## Recommended Vault Shape

For a VPS-accessible vault, use a path like:

```text
/opt/data/ObsidianVault
```

Starter folders:

```text
Hermes/
Google Flow/
TikTok Shop/
Prompt Examples/
Inbox/
```

Starter files:

```text
Hermes/README.md
Hermes/Session Summaries.md
Inbox/Review Before Saving.md
```

Optional later files:

```text
Google Flow/Automation Workflow.md
TikTok Shop/Style Rules.md
Prompt Examples/Winning Prompts.md
Hermes/Important Decisions.md
```

## Workflow

### 1. Create the vault

Create the folder structure using file tools or shell commands. Completion criterion: the vault root and starter folders exist.

### 2. Create a README

Write a short README explaining:

- the vault is for clean notes, not raw logs
- questionable information goes to inbox first
- permanent notes require user review or approval

Completion criterion: `Hermes/README.md` explains the review-first policy.

### 3. Stage current known information

Put uncertain or old facts in:

```text
Inbox/Review Before Saving.md
```

Use headings such as:

```markdown
## Possible preferences
## Possible workflow notes
## Possible setup notes
## Things to confirm before making permanent
```

Phrase these as review candidates, not final truth.

### 4. Ask for review

Show the user the high-level contents and ask what to keep, edit, or delete. Do not silently promote staged notes.

Completion criterion: user has a chance to correct stale or unwanted information.

### 5. Promote approved information

Move approved content into topic notes. Examples:

- style rules → `TikTok Shop/Style Rules.md`
- Flow process → `Google Flow/Automation Workflow.md`
- reusable prompts → `Prompt Examples/Winning Prompts.md`
- session result → `Hermes/Session Summaries.md`

Completion criterion: permanent notes contain only approved or clearly current content.

## What Belongs Where

| Content | Destination |
|---|---|
| Stable user preference | Hermes memory + relevant topic note if detailed |
| Reusable task procedure | Skill first; vault note can hold examples/details |
| Long session summary | `Hermes/Session Summaries.md` |
| Prompt that worked | `Prompt Examples/Winning Prompts.md` |
| Setup details likely to change | `Inbox/Review Before Saving.md` until confirmed |
| Secrets/API keys | Do not save |

## User Preference Pattern From Prior Use

Some users specifically want to see what the agent is saving because older chat-derived information may be stale. For those users, keep all inferred or historical content in the inbox note first and explicitly label it as not permanent.

See `references/review-first-vault-example.md` for a concrete VPS vault pattern.

## Common Pitfalls

1. **Saving everything.** This creates clutter and makes future searches worse. Save summaries and useful knowledge only.
2. **Treating old context as truth.** Old setup details may have changed. Stage them for review.
3. **Mixing secrets into notes.** Never preserve API keys or credentials.
4. **Using Obsidian as a replacement for skills.** Procedures that should change agent behavior belong in skills; notes can store examples and session-specific detail.
5. **Forgetting the user cannot see VPS files directly.** Summarize what was created and provide paths.

## Verification Checklist

- [ ] Vault root exists
- [ ] Starter folders exist
- [ ] README explains review-first policy
- [ ] Staged information is clearly marked as not final
- [ ] Permanent notes do not contain secrets
- [ ] User was shown what will be saved before permanent promotion
- [ ] Future retrieval instructions are clear, e.g. “search/read Obsidian notes before working”
