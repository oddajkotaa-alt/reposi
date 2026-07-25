# Slideshow Recreation Memory

Use this reference when the user sends a long ChatGPT-style setting/prompt for recreating TikTok Shop slideshows.

## Intake pattern

If the user says the file is long, ask them to send it as:

```text
SLIDESHOW SETTINGS PART 1/?
...
SLIDESHOW SETTINGS PART 2/?
...
DONE - save to Obsidian
```

or upload/send it as a file if supported.

## Save target

After receiving the complete settings, save a cleaned version to:

```text
/opt/data/ObsidianVault/TikTok Shop/Recreate Slideshow Workflow.md
```

If any part is old, confusing, or conflicts with current preferences, do not silently save it as truth. Put the uncertain parts in:

```text
/opt/data/ObsidianVault/Inbox/Review Before Saving.md
```

and ask the user what to keep/edit/delete.

## Trigger phrases for future use

When the user later says any of these, load the Obsidian workflow note before drafting:

- recreate this slideshow
- make similar slideshow
- copy this slideshow style
- analyze this slideshow and recreate
- TikTok Shop slideshow recreation
- use the recreate slideshow settings

## Non-negotiable current preferences

- CTA text like `Shop Here` is conditional: only add/enlarge it if the user's prompt explicitly asks for it.
- `My style` for realistic/photo outputs means casual iPhone-style realism: natural, believable, not glossy/overdesigned.
- The iPhone realism rule does not apply to animated/cartoon images.
- Preserve exact product/book cover/reference appearance and avoid invented claims.

## Output format for recreation tasks

Prefer concise slide-by-slide output:

```markdown
## Slide 1
Purpose:
Overlay text:
Visual prompt:
Reference/product constraints:

## Slide 2
...
```

End with a short verification checklist: CTA rule, product/reference preservation, unsupported claims removed, aspect ratio/format checked.
