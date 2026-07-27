# Product library + Flow job pattern

Use this when Flow automation gets slow or confused by many product/reference folders.

## Goal

Separate stable product references from per-generation Flow work so Flow never browses old folders or mixes references.

## Directory pattern

Hermes-visible stable library:

```text
/opt/data/product_references/<product-id>/
  references/
  manifest.json
  README.md
```

Per-generation job:

```text
/opt/data/flow-jobs/<job-id>/
  references/
  prompts/
  outputs/
  job.json
```

Current job symlink:

```text
/opt/data/flow-jobs/current -> /opt/data/flow-jobs/<job-id>
```

For host/noVNC Flow, mirror/copy only the current job inputs to a simple host-side folder if needed, e.g. `/home/flowdesk/flow-jobs/current/references`. Do not point Flow at the whole product library.

## Books example

Approved reusable book product:

```text
/opt/data/product_references/books-current-10/
  references/book_01.ext ... book_10.ext
  manifest.json
```

Rules:

- `manifest.json` must say `approved: true` and `reference_count: 10` before use.
- For a 10-book task use all 10.
- For a 5-book task select/request 5 from the approved set.
- Ignore `DO_NOT_USE*`, `book-2027-chatgpt*`, and any old saved mappings.

## Workflow

1. Identify product id and requested count/variant.
2. Read/verify product manifest and reference count.
3. Create a new job folder with `references/`, `prompts/`, `outputs/`, `job.json`.
4. Copy only the selected references into `job/references`.
5. Write finalized per-slide prompts into `job/prompts` before opening Flow.
6. Use Flow only with the current job's references.
7. Download/save outputs into `job/outputs` after each successful generation/checkpoint.

## Why this helps

- Avoids wrong reference folders in file picker.
- Keeps Telegram/Flow jobs resumable after UI freezes.
- Reduces UI decisions inside Flow.
- Scales to many products without mixing assets.
