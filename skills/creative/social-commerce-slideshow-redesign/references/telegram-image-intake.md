# Telegram Image Intake for Slideshow References

Use this when the user sends slideshow/reference images via Telegram while also continuing work in TUI/CLI.

## Goal

The user prefers uploading images through Telegram, but may continue planning and analysis in the TUI. The useful state is not necessarily the exact same session ID; it is enough that Telegram and TUI write into the same Hermes home/session database so the TUI agent can find the Telegram image paths.

## Workflow

1. Ask the user to send a short marker message in Telegram before or after uploading images, e.g.:

```text
slideshow inspiration batch
```

2. In the TUI, search/read recent Telegram sessions in the same Hermes home and look for messages containing image attachments.

3. Extract paths like:

```text
/opt/data/cache/images/img_....jpg
```

4. Build a contact sheet for multi-image batches before detailed analysis. This helps classify realistic vs graphic slides and reduces the chance of missing slide-level patterns.

5. Analyze the batch as style-learning input unless the user explicitly says it is a direct product/reference slideshow.

## User-specific interpretation

When the user sends “some are realistic some are animated,” classify before prompting:

- realistic/natural UGC photo slides: use casual iPhone/natural smartphone quality in future prompts
- animated/graphic/educational slides: simple flat backgrounds and designed illustration/diagram layouts are acceptable

## Pitfalls

- Do not assume `/handoff telegram` always connects the live TUI session to Telegram; it may invoke a handoff-document skill depending on the environment.
- Do not over-focus on making Telegram and TUI the identical session ID. For this workflow, same Hermes home/database plus accessible `/opt/data/cache/images/...` paths is sufficient.
- Do not analyze only the product category in inspiration slides. The user often sends beauty/skincare examples only for typography, color, composition, and slideshow language.
