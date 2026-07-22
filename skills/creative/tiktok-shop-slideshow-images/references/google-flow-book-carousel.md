# Google Flow book carousel prompt workflow

Session-derived notes for Flow/Nano Banana book slideshow work.

## Trigger

Use when the user says any of:

- “FLOW TEST”
- “ready flow test”
- “Generate Google Flow prompts”
- “Use the book images I send / recreate slideshow style from examples”

## Flow setup to include

- Model: `Nano Banana Pro` / best available image model.
- Format: `3:4 portrait`.
- Style references: upload the user’s example slideshow screenshots.
- Book references: upload the book images the user sends.
- Hook slide: style references only; no book unless the example requires it.
- Single-book slides: style references + exactly the matching book reference.
- Final CTA/bundle: style references + all included book references.

## Style extraction pattern

Before prompts, summarize the style from screenshots. Example from this session:

- realistic iPhone-style TikTok Shop book slideshow
- book held close to camera or placed naturally, cover large in lower half
- premium apartment / balcony / car / bedroom / lounge settings
- blue-hour evening light mixed with warm lamp/interior light
- large elegant gold serif quote text
- simple emotional copy, not dense paragraphs
- no text box, no brushstroke, no TikTok UI, no watermark, no collage, no screenshot frame

## Prompt skeleton

```text
Create a 3:4 portrait TikTok Shop book slide using the attached [BOOK NAME] image as the exact product reference.

Recreate the style of the provided slideshow screenshots: realistic iPhone-style photo, book held close to camera or naturally placed, premium [setting] lifestyle background, blue-hour evening light mixed with warm lamp light, large elegant gold serif quote text, no text box, no TikTok UI, no watermark.

Scene: [specific scene]. Keep the book cover recognizable: [cover details]. The book fills the lower half.

Text in large gold serif font:
[short emotional quote]
```

## Book subset selection

If the user asks to “only use books that fit,” select a thematic subset and make all downstream prompts/CTA count match the subset. For the emotional “lessons people are scared to learn” carousel, the fitting 5-book subset was:

1. Atomic Habits
2. The Let Them Theory
3. The Courage To Be Disliked
4. Don’t Believe Everything You Think
5. The Psychology of Money

Avoid carrying over prior “10 books” CTA text when the new set only uses 5.

## Common pitfalls corrected by user

- If screenshots are provided after an initial prompt pack, update the prompt pack to match those screenshots, not the earlier imagined style.
- Do not treat “dark emotional field/house” as the style if the user’s screenshots show phone-photo book slides with gold serif text.
- Keep prompts beginner-friendly and directly usable in Flow; avoid lengthy JSON unless the user explicitly asks for JSON.