# Book reference quarantine notes

Use this when the user reports that old/wrong book reference images are still present on the VPS or were accidentally used by GPT/Flow.

## Durable rule

For book slideshow/image tasks, never reuse saved book-reference folders. Use only the book cover/reference images uploaded in the current task/session.

## Known stale locations/names

Old wrong references may exist outside the Hermes container-visible `/opt/data/book_references/current` folder, especially on the host-side Flow desktop user home:

```text
/home/flowdesk/book 2027 chatgpt 10 refs
/home/flowdesk/book 2027 chatgpt refs
```

The Hermes/container environment may not see `/home/flowdesk`; do not conclude the folders are gone just because `find /opt/data` does not show them.

## Safe host-side quarantine commands

If the user can access the VPS host terminal, have them run these one at a time:

```bash
mkdir -p /home/flowdesk/DO_NOT_USE_old_wrong_book_refs
```

```bash
mv "/home/flowdesk/book 2027 chatgpt 10 refs" /home/flowdesk/DO_NOT_USE_old_wrong_book_refs/
```

```bash
mv "/home/flowdesk/book 2027 chatgpt refs" /home/flowdesk/DO_NOT_USE_old_wrong_book_refs/
```

Then verify:

```bash
ls -la /home/flowdesk/DO_NOT_USE_old_wrong_book_refs
```

If a folder name differs, ask the user for `ls -la /home/flowdesk` output and give exact quoted `mv` commands.

## Agent behavior

- Do not attach these old folders to Google Flow/Nano Banana/GPT image generation.
- Do not use old generated/reference book images as cover truth.
- If current book covers are missing, ask the user to upload them again rather than searching old folders.
- Prefer quarantining/moving old folders over deleting them, so the user can recover files if needed.