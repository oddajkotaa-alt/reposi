# Approved 10-book reference set workflow

Use this when the user sends a replacement set of book photos and says they are the correct references for future 5-book or 10-book slideshow/generation tasks.

## Durable rule

- Old book reference folders are unsafe even if they look relevant. Never use folders/files marked `DO_NOT_USE`.
- If the user explicitly provides a new approved 10-book set, save and verify it once, then reuse that approved set for those exact books in later tasks.
- For a 10-book task, use all 10 approved references. For a 5-book task, select 5 from the approved set or ask which 5 if the choice matters.

## Preferred saved locations

Agent-visible stable folder:

```text
/opt/data/book_references/current/
```

Host/Flow-side folder may also exist for Google Flow uploads:

```text
/home/flowdesk/flow-uploads/current-books
```

If host `/home/flowdesk` is not visible from the current Hermes/container, do not claim it was modified. Give the user short host-terminal commands instead.

## Save and verify pattern

1. Find the just-uploaded Telegram images in the cache or attachment directory available to the current session.
2. Require exactly 10 images before marking the set approved.
3. Move any previous `/opt/data/book_references/current` to a timestamped backup, then copy the new images into:

```text
/opt/data/book_references/current/book_01.ext
...
/opt/data/book_references/current/book_10.ext
```

4. Write `manifest.json` containing count, source paths if available, SHA256 hashes, and the rule: use these approved current 10 book images for these exact books; never use DO_NOT_USE old refs.
5. Verify dimensions/count with a deterministic command or script.
6. If possible, make a contact sheet and visually verify it shows 10 separate book images before confirming.

## Known bad host folders from this session

The user identified these old/wrong reference folders on the Flow host. They should remain ignored/quarantined:

```text
/home/flowdesk/DO_NOT_USE_book-2027-chatgpt-10refs
/home/flowdesk/DO_NOT_USE_book-2027-chatgpt-refs
/home/flowdesk/DO_NOT_USE_old_wrong_book_refs
```

Also treat similarly named old generated-output folders as outputs, not as source references, unless the user explicitly says to analyze an output image.

## User-facing wording

When finished, confirm with concrete counts and paths, e.g.:

```text
Saved 10 approved book references to /opt/data/book_references/current and wrote manifest.json. For 10-book generations I will use all 10; for 5-book generations I will choose/request 5 from this approved set. DO_NOT_USE folders stay ignored.
```
