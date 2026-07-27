# LLM Wiki Safe Automation Pattern

Use this when a user wants the Obsidian/LLM Wiki pattern automated like a tutorial/video.

## First automation pass

Prefer two local-only cron jobs before GitHub/backup automation:

1. **Daily raw-ingest draft**
   - Schedule example: `0 10 * * *`
   - Scan `LLM Wiki/raw/` for non-README `.md`/`.txt` files.
   - Read `SCHEMA.md`, `index.md`, and `log.md`.
   - Avoid duplicating files already mentioned as processed/drafted in `log.md`.
   - Draft durable extracted notes into `Inbox/Review Before Saving.md`.
   - Append a short `log.md` entry saying which raw files were drafted.
   - Do not delete/move raw sources or permanently rewrite wiki pages without review.

2. **Weekly lint report**
   - Schedule example: `0 9 * * 1`
   - Check for missing `SCHEMA.md`, `index.md`, `log.md`.
   - Check likely missing wikilinks, orphan/unindexed pages, duplicate names, empty important pages, and stale structure.
   - Draft proposed fixes into `Inbox/Review Before Saving.md`.
   - Do not delete files or do large rewrites automatically.

## TUI/local delivery warning

In Hermes TUI/local sessions, cron output is saved in cron history and is not delivered live to the chat. Tell the user this explicitly. Use a gateway-connected `deliver` only if the user asks for notifications.

## Tutorial transcript rule

If a tutorial video/transcript was provided only to explain setup, do not ingest the full transcript into the wiki. Use it as a setup checklist and save only durable workflow decisions.

## GitHub backup caution

Defer GitHub backup until the user explicitly approves a private repository and understands that vault notes may contain personal/business data.
