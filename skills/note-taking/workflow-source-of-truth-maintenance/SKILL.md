---
name: workflow-source-of-truth-maintenance
description: Clean up confusing Obsidian/workflow instruction sprawl by creating a single source-of-truth note, updating entrypoint notes to point at it, archiving stale references/duplicate skills, and syncing host-visible copies when Hermes runs across container/VPS boundaries.
version: 1.0.0
platforms: [linux]
metadata:
  hermes:
    tags: [obsidian, workflow-docs, source-of-truth, cleanup, skills, vps]
---

# Workflow Source-of-Truth Maintenance

Use this skill when the user says their Obsidian notes, prompt workflows, or skill instructions are unclear, contradictory, or causing agents to use old references.

## Principle

Do not add yet another narrow note or one-session skill unless necessary. Reduce ambiguity by choosing one canonical source of truth and making other entrypoints point to it.

## Cleanup workflow

1. Search the vault and skill library for all notes/skills that mention the confusing topic.
2. Create or choose one canonical note with:
   - exact approved path(s), files, or workflow steps;
   - hard do-not-use rules for stale references;
   - a short prompt/instruction block future agents can paste or follow.
3. Patch high-level entrypoint notes to link to the canonical note first.
4. Archive stale duplicate folders/skills instead of deleting them permanently unless the user explicitly asks for irreversible deletion.
5. If Hermes has both container-visible and host-visible vault paths, copy/sync the updated notes to the path used by the active gateway/session before declaring the fix complete.
6. Tell the user whether a `/reset` or new Telegram message is needed so the active agent reloads updated notes/skills.

## User-specific pitfalls from VPS/Flow work

- The user may be frustrated by repeated wrong references; act proactively to remove ambiguity rather than giving another explanation.
- For book slideshow work, maintain one explicit source-of-truth note for the approved book reference folder and exact file count.
- Archive old/example/DO_NOT_USE reference folders out of active upload paths so agents cannot accidentally choose them.
