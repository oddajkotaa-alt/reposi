---
name: llm-wiki-vault-maintenance
description: "Maintain the user's Obsidian LLM Wiki second brain: ingest raw sources, query linked wiki pages, lint structure, and back up the vault safely."
platforms: [linux]
---

# LLM Wiki Vault Maintenance

Use this skill when working with the user's Obsidian LLM Wiki, including ingest, query, lint, cleanup, or backup.

See `references/video-parity-automation.md` for the session-captured automation shape where the user wants useful chat knowledge saved automatically without having to say “save this.”

## Paths

- Vault: `/opt/data/ObsidianVault`
- LLM Wiki: `/opt/data/ObsidianVault/LLM Wiki`
- Schema: `/opt/data/ObsidianVault/LLM Wiki/SCHEMA.md`
- Index: `/opt/data/ObsidianVault/LLM Wiki/index.md`
- Log: `/opt/data/ObsidianVault/LLM Wiki/log.md`
- Inbox review note: `/opt/data/ObsidianVault/Inbox/Review Before Saving.md`

## Required first step

Read:

1. `LLM Wiki/SCHEMA.md`
2. `LLM Wiki/index.md`
3. relevant notes found by `search_files`

## Operations

### Ingest

Use when new source material should become reusable knowledge.

1. Keep raw sources unchanged under `LLM Wiki/raw/`.
2. Extract durable facts, concepts, entities, comparisons, and reusable answers.
3. Create/update linked markdown pages under:
   - `LLM Wiki/entities/`
   - `LLM Wiki/concepts/`
   - `LLM Wiki/comparisons/`
   - `LLM Wiki/queries/`
4. Update `LLM Wiki/index.md` for important new pages.
5. Append a concise entry to `LLM Wiki/log.md`.

### Query

Use when the user asks a question that the wiki may answer.

1. Read schema and index.
2. Search relevant pages.
3. Answer from the vault, noting uncertainty.
4. If the answer becomes reusable, save it under `LLM Wiki/queries/` when appropriate.

### Lint

Use to keep the wiki healthy.

Check for:

- broken or missing wikilinks
- orphan/unindexed pages
- stale claims
- contradictions
- duplicate/overlapping pages
- raw sources not processed

Do not delete files or do large rewrites without explicit user approval.

### Backup

The vault is initialized as a local git repository at `/opt/data/ObsidianVault`.

- Local git commits are safe.
- GitHub push requires a private repo remote and user approval.
- Never push secrets.

## Safety rules

Do not save:

- passwords
- API keys
- cookies
- tokens
- payment info
- raw chat dumps
- old book references not provided in the current task
- unverified product/book claims

If uncertain, draft in `Inbox/Review Before Saving.md`.

## Automation currently expected

- Daily raw ingest cron: processes new non-README raw sources into linked wiki pages when safe.
- Daily chat auto-save cron: reviews recent Hermes conversations so the user does not need to remember to say “save this”; save only durable useful knowledge, redact secrets, and send uncertain items to Inbox.
- Weekly lint report cron: audits links, stale pages, duplicates, orphan/unindexed notes, and raw sources not processed.
- Nightly local git backup cron: commits vault changes locally and pushes only after a private GitHub remote is authenticated.

In TUI/local Hermes sessions, cron output is local-only and saved in cron history; it is not delivered live to the chat.

## GitHub token setup pitfall

For a private GitHub backup, do not ask the user to paste tokens into chat. Tell them to generate a token with only the repo access needed, then paste it directly into the VPS terminal when `git push` prompts for the HTTPS password. If long paths break from clipboard spacing, use the short mounted path first:

```bash
cd /mnt/hermes-obsidian-vault
git config credential.helper store
git push -u origin main
```
