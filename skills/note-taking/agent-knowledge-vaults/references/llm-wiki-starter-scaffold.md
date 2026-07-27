# LLM Wiki Starter Scaffold

Use this when a user wants to follow the “Obsidian + Hermes + LLM Wiki second brain” pattern from a video/tutorial, but they are still early in setup and may redo paths later.

## What counts as done

A minimal LLM Wiki core is done only when the vault has:

```text
LLM Wiki/
├── SCHEMA.md
├── index.md
├── log.md
├── raw/
│   ├── transcripts/
│   ├── articles/
│   ├── product-research/
│   ├── tiktok-examples/
│   ├── google-flow/
│   └── assets/
├── entities/
├── concepts/
├── comparisons/
└── queries/
```

Add small `README.md` files inside empty subfolders so Syncthing/Obsidian show them reliably.

## What is NOT done yet

Do not imply the full video/tutorial is complete until these are also implemented or intentionally skipped:

- first manual ingest from a raw source
- query workflow tested against the wiki
- lint workflow for broken links/orphans/stale claims/contradictions
- maintenance skill or explicit prompt for ingest/query/lint
- optional private GitHub backup
- optional cron jobs for backup/ingest/lint
- optional read-only/query-only profiles

## Beginner-safe rollout

Recommended order:

1. Confirm PC ↔ VPS ↔ Hermes can see the same Obsidian vault.
2. Create the LLM Wiki scaffold and schema.
3. Link `LLM Wiki/index` and `LLM Wiki/SCHEMA` from `Home.md`.
4. Manually ingest one small source, such as a transcript or workflow note.
5. Run one query from the wiki.
6. Add lint checks.
7. Only then discuss GitHub/private backup and cron jobs.

## User-editable / temporary setup wording

If the user says they may redo the current settings later, record paths/setup as temporary notes, not permanent decisions. Reassure them that everything is normal `.md` text and can be edited, moved, deleted, or copied to a new vault later.

## Starter SCHEMA.md contents

The schema should define:

- raw sources are immutable originals
- wiki pages are cleaned linked notes
- `SCHEMA.md`, `index.md`, and `log.md` govern maintenance
- operations: ingest, query, lint
- folder rules for raw/entities/concepts/comparisons/queries
- safety: never save secrets/API keys/passwords/tokens
- review-first rule for uncertain/private information

## Good first starter pages

For this user’s TikTok Shop / Google Flow work, useful starter pages include:

```text
concepts/tiktok-hook-patterns.md
concepts/casual-iphone-realism.md
concepts/slideshow-formulas.md
comparisons/obsidian-memory-vs-hermes-memory.md
```

These should link back to the user’s existing workflow notes when available, such as TikTok Shop style rules and Google Flow workflow notes.
