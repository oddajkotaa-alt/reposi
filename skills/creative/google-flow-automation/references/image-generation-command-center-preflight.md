# Image Generation Command Center + PRE-FLIGHT Pattern

Session-derived workflow for this user's Google Flow / Nano Banana Pro image generation, especially book/product slideshow work.

## Problem this prevents

The agent was mixing old folders, duplicated references, stale Obsidian notes, and overlapping skills. The user wants prompt-quality instructions preserved, but wants one hard source of truth and a required validation step before generation.

## Durable rule

Before any Flow image generation, especially book slideshows, read the user's Obsidian command-center note when available:

```txt
/opt/data/ObsidianVault/TikTok Shop/Image Generation Command Center.md
```

Then run a PRE-FLIGHT CHECK in the conversation before generating.

## Required PRE-FLIGHT shape

```txt
PRE-FLIGHT CHECK
Task type:
Requested output count:
Aspect ratio:
Reference source/folder:
Actual file count:
Actual files:
Duplicate check:
Old/archive folders used?: no
Missing references?: yes/no
Prompt/template to use:
Ready to generate?: yes/no
```

Rules:

- If file count does not match the task, `Ready to generate` must be `no`.
- If references are duplicated, stale, or unclear, stop and wait for the correct files.
- Do not fill missing references from old folders, memory, screenshots, or guessed titles.
- Do not generate first and validate later.

## Preserve prompt quality

Centralization must not mean weaker prompts. Keep these prompt fields:

1. Task and exact output count.
2. Reference mapping per slide/image.
3. Exact product/book preservation wording.
4. Realistic scene, lighting, props, camera feel, and background variation.
5. Exact overlay text, position, and typography style.
6. Hard negatives: no watermark, no fake UI, no collage, no invented claims, no wrong covers/products.
7. QC target: one separate 3:4 image per requested slide.

## Book-reference source of truth pattern

For the active book job, use only the active folder the user identifies (current known pattern: `/home/flowdesk/flow-uploads/current-books`). Count real image files and list them before generating.

If the user sends new references on Telegram, first save/copy them into the active folder, remove stale marker/readme files from counts, then re-run PRE-FLIGHT.

## QC after generation

Before saying done, verify count, dimensions/aspect ratio, exact book/product identity, text spelling and placement, background variation, no invented claims, and that rejects are separated from accepted finals.
