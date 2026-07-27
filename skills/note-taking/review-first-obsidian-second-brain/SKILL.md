---
name: review-first-obsidian-second-brain
description: Use when building or maintaining the user's Hermes + Obsidian second brain with synced PC/VPS vaults, review-first saving, templates, and clean note organization.
---

# Review-First Obsidian Second Brain

Use this skill when the task involves the user's Obsidian vault as a Hermes-readable second brain: setting it up, organizing notes, writing proposed notes, creating templates, checking sync paths, or deciding where knowledge should be saved.

## Core rule

Keep the vault clean. Do not dump raw chat logs, private data, secrets, or uncertain long-term claims straight into permanent notes. Draft questionable or user-specific knowledge in `Inbox/Review Before Saving.md`, show the user, and only move it into permanent notes after approval or edits.

## Known vault paths

Use concrete paths; do not pass environment-variable strings into file tools.

- Hermes/container path: `/opt/data/ObsidianVault`
- VPS/host Syncthing path: `/mnt/hermes-obsidian-vault`
- Windows Obsidian path: `C:\Users\Admin\Documents\ObsidianVault`

If the path is uncertain, verify with file/search tools before writing.

## Preferred vault structure

Maintain a small, navigable structure:

- `Home.md` — main entry point linking to important areas
- `Hermes/` — setup notes, session summaries, decisions
- `Google Flow/` — Flow/noVNC workflow notes
- `TikTok Shop/` — style rules, ad structure, product rules
- `Prompt Examples/` — prompts that worked well
- `Inbox/` — temporary notes waiting for review
- `Templates/` — reusable note templates

Useful templates:

- `Templates/Session Summary Template.md`
- `Templates/Prompt Template.md`
- `Templates/Workflow Template.md`

## Workflow

1. Resolve the vault path, usually `/opt/data/ObsidianVault`.
2. Search relevant existing notes before creating new knowledge.
3. For a new permanent note, write a clean summary rather than a transcript.
4. For uncertain or sensitive material, write a draft section in `Inbox/Review Before Saving.md` and ask the user to approve.
5. Link related notes with Obsidian wikilinks, e.g. `[[Hermes/Setup Notes]]`.
6. After writing, verify by reading the note back or searching for a distinctive line.

## TikTok Shop / Google Flow notes

For slideshow, faceless video, prompt recreation, or Google Flow tasks, check vault notes first, especially:

- `TikTok Shop/Recreate Slideshow Workflow.md`
- `TikTok Shop/Style Rules.md`
- `Prompt Examples/Prompt Examples.md`
- `Google Flow/Workflow.md`

Do not stop at drafting if the user asked for generation; use the relevant generation/browser workflow after reading the notes.

## Pitfalls

- Do not use shell `cat`, `find`, or `grep` for ordinary note work; prefer `read_file` and `search_files`.
- Do not write secrets or API keys to Obsidian.
- Do not assume grey/blue file coloring in Obsidian is an error; files and folders may be styled differently.
- If a Syncthing test note exists but `cat` prints nothing, the file may simply be empty; verify by writing body text and reading it back.

## Reference

See `references/hermes-synced-vault-workflow.md` for the session-derived setup and verification pattern.
