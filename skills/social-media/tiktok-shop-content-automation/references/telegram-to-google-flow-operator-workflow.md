# Telegram to Google Flow operator workflow

Use this when the user wants Hermes to operate Google Flow from Telegram, not rewrite their prompt style.

## Goal

The user's preferred end state is:

1. User sends a Telegram message with a ready GPT-made Google Flow prompt and reference images.
2. Hermes receives/analyzes the attachments only as needed for routing and verification.
3. Hermes copies the relevant images into the VPS browser upload folder.
4. Hermes operates the authenticated VPS/noVNC Google Flow browser: upload refs, paste the user's prompt, click generate, wait, download/organize outputs, send results back.

Do not keep inventing prompt style if the user says they already has their own GPT instructions. Treat Hermes as the Flow operator unless asked to write or improve prompts.

## Recommended Telegram command shape

Ask the user to send something structured but simple:

```text
FLOW RUN
Prompt:
[paste the user's ready GPT/Flow prompt]
Refs:
latest
```

Then attach images. If several image roles are needed, have the user label them with nearby messages:

```text
book refs
example slideshow
my style refs
```

## VPS/container file path pattern

Telegram images may be saved inside the Hermes Docker container at:

```text
/opt/data/cache/images/
```

The VPS Google Flow browser file picker needs files on the host under the desktop user, e.g.:

```text
/home/flowdesk/flow-uploads/books
```

If Hermes is running inside the container and cannot write `/home/flowdesk`, ask the user to run host commands from the VPS/root shell. Use `docker cp` from the Hermes container to the host folder, for example:

```bash
mkdir -p /home/flowdesk/flow-uploads/books && docker exec hermes-agent sh -lc 'ls -1t /opt/data/cache/images/* 2>/dev/null | head -20' | nl -w2 -s' ' | while read n p; do ext="${p##*.}"; docker cp "hermes-agent:$p" "/home/flowdesk/flow-uploads/books/telegram-reference-$n.$ext"; done && chown -R flowdesk:flowdesk /home/flowdesk/flow-uploads/books && ls -l /home/flowdesk/flow-uploads/books
```

If the container name differs, have the user run:

```bash
docker ps --format '{{.Names}}'
```

## Google Flow reliability lessons

- When Flow Agent is given many product refs plus style refs and asked for a whole carousel, it may create a grid/collage, include 5-6 books in one image, or use the wrong book.
- For reliable outputs, automate a loop of one slide at a time: one product/book ref + one or two style refs + one prompt saying `Create exactly ONE image only`.
- Keep style/example references separate from product references when possible.
- If using noVNC and copy/paste into Flow fails, use the noVNC side-panel Clipboard: paste text there, click into Flow, then press Ctrl+V.
- Flow policy blocks can be intermittent for benign ad/slideshow prompts; safe workaround is to retry or reword claims neutrally, not to bypass policy.

## Automation build order

1. Make Telegram image intake reliable and identify newest images.
2. Copy/upload images to a stable Flow upload folder on the VPS.
3. Save or parse the user's ready prompt from Telegram.
4. Drive the browser/noVNC session to upload references and paste prompt.
5. Generate one slide at a time when product/reference accuracy matters.
6. Download/organize outputs and deliver results back to Telegram.
