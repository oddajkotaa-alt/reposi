# Current Book Reference Handling

Use this reference when the user sends book cover/reference photos from Telegram and asks Hermes to save or use them for a TikTok Shop book slideshow.

## Durable workflow

1. Treat book references as **current-task assets**, not reusable style memory.
2. If the user sends new book photos in Telegram and asks whether they were received, verify by finding the actual attached file paths and then copy them into a stable folder such as:

```text
/opt/data/book_references/current
```

3. Save a `manifest.json` beside the copied files with:
   - count
   - source attachment path
   - saved path
   - short title/label when known
   - sha256 hash
4. Confirm the exact count to the user only after the files exist in the stable folder.
5. For future book Flow prompts/slides, use only these current saved paths unless the user sends newer references and explicitly replaces them.

## Pitfalls from this session

- Do not confuse deleting old **reference notes/mappings** with deleting actual image files.
- Do not claim images are saved based only on Telegram/session text; verify the files exist after copying.
- If a previous save happened in a different Hermes process/profile/session, the file paths may not exist in the current TUI process. Re-copy from the Telegram attachment cache when possible.
- Keep the user's wording simple: “I saved 10 new book references here: …” is better than a long explanation.

## Current saved folder convention

```text
/opt/data/book_references/current/
  01-<book-label>.<ext>
  02-<book-label>.<ext>
  ...
  manifest.json
```

This folder is for the **current replacement set**, not an evergreen library of all books. If the user sends a new replacement set later, replace or archive the previous `current` set before saving the new one.