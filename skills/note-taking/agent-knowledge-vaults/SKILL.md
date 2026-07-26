---
name: agent-knowledge-vaults
description: "Set up and explain beginner-friendly agent knowledge vaults: Obsidian/Markdown second brains, LLM Wiki structure, PC-to-VPS sync, and long-term ingest/query/lint workflows."
platforms: [linux, windows, macos]
---

# Agent Knowledge Vaults

Use this skill when a user wants to make Hermes or another agent remember and reuse a large body of knowledge over time using Obsidian, Markdown folders, LLM Wiki patterns, synced vaults, or “second brain” workflows.

This skill is for the **class of task**: turning folders of notes/sources into a long-term, maintainable agent knowledge base that a beginner can understand and operate.

## First principles

Explain the pieces plainly:

- **Hermes memory/profile**: small durable facts about the user and preferences.
- **Knowledge vault / LLM Wiki**: a larger organized library of Markdown files: workflows, transcripts, product research, prompt examples, decisions, troubleshooting, etc.
- **Obsidian**: a human-friendly app for browsing/editing the same Markdown files; graph view helps visualize links.
- **Hermes file tools**: the agent reads/writes the vault files directly. It usually does not need to click around inside Obsidian.
- **Sync tool**: keeps the PC Obsidian folder and VPS Hermes folder the same.

Beginner mental model:

```text
raw/        = original source box; do not edit after capture
Hermes      = librarian; reads sources and organizes knowledge
wiki pages  = cleaned knowledge with links
Obsidian    = visual notebook/graph view
lint        = cleaning day; checks the brain for rot
```

## LLM Wiki pattern

The long-term pattern has three layers:

```text
1. raw sources    = transcripts, docs, emails, product notes, examples
2. wiki pages     = agent-written linked Markdown pages
3. schema         = one rule file that tells the agent how to maintain the wiki
```

And three operations:

1. **Ingest** — add new knowledge.
   - Save raw source in `raw/`.
   - Extract important facts/patterns.
   - Create/update linked pages in `entities/`, `concepts/`, `comparisons/`, or `queries/`.
   - Update `index.md` and `log.md`.

2. **Query** — answer from the vault.
   - Read `SCHEMA.md`, `index.md`, and relevant pages.
   - Search the vault if needed.
   - Synthesize an answer from the compiled notes.
   - Save valuable reusable answers under `queries/`.

3. **Lint** — keep the vault healthy.
   - Find broken links, orphan notes, contradictions, stale pages, duplicate/noisy links, missing index entries, and tag sprawl.
   - Report or fix carefully.

Emphasize: **lint is what prevents the vault from becoming a junk drawer after a month.**

## Starter structure

For a new vault or a new LLM Wiki subfolder, prefer:

```text
LLM Wiki/
├── SCHEMA.md
├── index.md
├── log.md
├── raw/
│   ├── transcripts/
│   ├── articles/
│   ├── product-research/
│   ├── examples/
│   └── assets/
├── entities/
├── concepts/
├── comparisons/
└── queries/
```

For TikTok Shop / Google Flow style work, useful raw/source folders include:

```text
raw/transcripts/
raw/product-research/
raw/tiktok-examples/
raw/google-flow/
raw/assets/
```

Useful pages may include:

```text
concepts/tiktok-hook-patterns.md
concepts/casual-iphone-realism.md
concepts/slideshow-formulas.md
concepts/google-flow-troubleshooting.md
entities/google-flow.md
entities/nano-banana-pro.md
queries/best-book-slideshow-structure.md
```

## Beginner rollout order

Do not stack every tool at once. Recommend a staged path:

1. Create the vault/LLM Wiki folder and schema.
2. Manually ingest a few sources and query it.
3. Connect PC Obsidian to the VPS folder with sync.
4. Add a lint workflow.
5. Later add private GitHub backup if the user explicitly approves.
6. Later add cron jobs for automated ingest/lint/backup.
7. Only consider additional memory services (e.g. Honcho) if Obsidian + LLM Wiki fails to solve a real need.

## PC Obsidian ↔ VPS Hermes sync

Use Syncthing for a free beginner-friendly sync between Windows Obsidian and a Linux VPS vault.

Target shape:

```text
Windows PC Obsidian folder
  ↕ Syncthing
VPS: /opt/data/ObsidianVault or chosen wiki folder
  ↕ Hermes file tools
```

### Windows side

If the user downloads a Syncthing zip/folder instead of an installer:

1. Open the downloaded folder.
2. Double-click `syncthing.exe`.
3. Keep the black console window open.
4. Open the PC dashboard:

```text
http://127.0.0.1:8384
```

SyncTrayzor is a friendlier Windows wrapper and is acceptable for beginners.

### VPS side

Run these inside the **VPS Linux shell**, not Windows CMD before SSH:

```bash
apt update
apt install -y syncthing
syncthing
```

If not root, use `sudo`.

### SSH tunnel for VPS dashboard

From **Windows CMD/PowerShell/Terminal**, create the tunnel:

```bash
ssh -L 8385:127.0.0.1:8384 root@YOUR_VPS_IP
```

Use the actual SSH user if not `root`.

Then open the VPS dashboard in the **Windows PC browser**:

```text
http://127.0.0.1:8385
```

Do **not** open this URL inside the VPS/noVNC browser when the tunnel was created from Windows.

## Localhost and SSH pitfall

Always explain:

- `127.0.0.1` means “this computer.”
- `http://127.0.0.1:8384` in Windows = Windows Syncthing.
- `http://127.0.0.1:8385` in Windows = VPS Syncthing through the Windows SSH tunnel.
- The same URL inside the VPS browser points to the VPS itself and may fail.

SSH password notes:

- SSH passwords do not show dots while typing; type and press Enter.
- Do not ask the user to paste passwords.
- If `root@IP` fails, try the provider’s actual username or check whether SSH keys are required.

## Safety and privacy

- Do not save API keys, passwords, cookies, private tokens, or payment details in the vault.
- Ask before large deletes, GitHub pushes, public sharing, or mass rewrites.
- If using GitHub backup, require a private repository for personal/business notes.
- Avoid editing the same note simultaneously from Obsidian and Hermes; sync tools may create conflict files.
- Keep `raw/` immutable; corrections go in wiki pages.

## When to suggest alternatives

- **Obsidian Sync**: paid and good for PC/phone, but not enough by itself for a headless VPS unless Obsidian/obsidian-headless is configured there.
- **Syncthing**: free and best first choice for PC↔VPS folder sync.
- **GitHub private repo**: useful backup/history later, but do not rush if the user is still learning.
- **Honcho or other memory services**: advanced; do not install early unless there is a concrete problem Obsidian + LLM Wiki cannot solve.

## Reference

See `references/windows-vps-syncthing.md` for a condensed copy-paste setup and troubleshooting guide for Windows PC ↔ Linux VPS Syncthing setup.
