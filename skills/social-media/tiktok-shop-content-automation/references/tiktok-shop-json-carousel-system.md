# TikTok Shop JSON Carousel Prompt System

Use this reference when the user wants sales-focused TikTok Shop slideshow/carousel image prompts, especially when they attach product photos and expect JSON prompts for image generation.

## Default assumptions for this user

- Default output is a full slide-by-slide JSON prompt set, not a loose prose prompt, unless the user asks otherwise.
- Default aspect ratio is **3:4 portrait full-bleed**. Put this in the top-level `aspect_ratio`, in the scene description, and in a format lock to reduce landscape failures.
- Slide 1 should always be the strongest hook/scroll-stopper.
- Product photos are usually attached as references. Prompt must preserve the exact product appearance.
- The main goal is sales/conversions, not just attractive images.
- Product category may change: pet products now, but also beauty/skincare/haircare, gadgets, home, etc.

## Recommended JSON shape

```json
{
  "carousel": {
    "product": "...",
    "version": "...",
    "palette": {},
    "slides": [
      {
        "slide": 1,
        "label": "Hook",
        "prompt": {
          "format_lock": {},
          "scene": {},
          "style": {},
          "technical": {},
          "materials": {},
          "environment": {},
          "composition": {},
          "quality": {
            "include": [],
            "avoid": [],
            "reference_standard": ""
          }
        },
        "aspect_ratio": "3:4 portrait full-bleed"
      }
    ]
  }
}
```

## Format lock block

Add this or equivalent to each slide:

```json
"format_lock": {
  "aspect_ratio": "vertical 3:4 portrait full-bleed",
  "must_not_generate": [
    "landscape image",
    "wide horizontal layout",
    "square format",
    "letterboxing",
    "extra canvas on left or right"
  ],
  "composition_rule": "Design the image for phone-screen vertical viewing. All important subjects and text must fit inside a 3:4 portrait frame."
}
```

## Product/reference accuracy block

For product slides:

> PRODUCT REFERENCE CRITICAL: Do not build the product from this text. Look at the attached product reference photo and reproduce the product exactly as it appears there — every shape, proportion, color, material, texture, pattern, label, logo placement, and visible component must match precisely. Do not invent, remove, redesign, recolor, re-label, or add components not visible in the reference photo.

For pets/characters:

> REFERENCE CRITICAL: Do not build the pet/person from this text. Match the attached reference exactly — markings, colors, fur/hair texture, body shape, facial features, skin texture, nails/hands, and visible details must be reproduced precisely.

## Visual modes

Use two primary modes:

1. **Illustrated explainer slides**
   - Semi-realistic 2D cel-shaded, Pixar-adjacent.
   - Best for problem education, diagrams, comparisons, before/after logic, exaggerated pet emotion.
   - Clean flat backgrounds, readable annotations, no grain.

2. **Real iPhone UGC photo slides**
   - Candid iPhone-style, natural window light, lived-in home, imperfect framing.
   - Best for product reveal, proof, use-case, how-to, result, CTA.
   - Should feel like a real TikTok creator photo with clean editorial text, not a polished ecommerce poster.

## Sales carousel arcs

Pet product default 7-slide arc:
1. Hook/problem moment.
2. Problem education or warning.
3. Behavior proof / comparison / timeline.
4. Discovery or relatable UGC moment.
5. Solution/product introduction.
6. Product reveal/spec/callout.
7. CTA with product in use.

Beauty/skincare/haircare default 6-slide arc:
1. Multi-problem or transformation hook.
2. Product reveal.
3. Why it works / ingredient or feature callouts.
4. How to use.
5. After/result/social proof.
6. CTA.

Never pad slides. Every slide needs a unique narrative job.

## Typography and palette rules from the user's examples

Common pet/home palette:
- Alice Blue `#F6FAFF`
- Naples Yellow `#FFDE70`
- Powder Blue `#A3C4EB`
- Yale Blue `#173B64`
- Charcoal `#1A1A1A`

Common beauty/haircare palette:
- Powder Blue `#A3C4EB`
- Charcoal Navy `#1F2937`
- Yale Blue `#173B64`
- Powder Blush `#F2C4CE`
- Alice Blue `#F6FAFF`

Typography:
- Headline: large bold chunky/serif charcoal or charcoal-navy, usually lowercase, no background.
- Accent: italic serif Yale Blue on a rough hand-painted brushstroke.
- Labels/callouts: small italic serif charcoal or Yale Blue, no boxes/pills.
- Arrows: thin hand-drawn Yale Blue. Avoid red arrows.

## Mobile readability rules

- Text must be readable on a phone screen.
- Prefer no more than: 1 headline + 1 accent + 1 short body line.
- Spec/product reveal slides should use 3 short callouts unless the user explicitly asks for a dense spec slide.
- Keep product large enough to recognize in one second; often 45–60% of frame height.
- Avoid crowding text into top/bottom safe areas.
- Leave clean negative space behind text.

## Common pitfalls to avoid

- Generator returns landscape even though prompt says 3:4: repeat 3:4 in `aspect_ratio`, `format_lock`, and scene description; also remind user to select 3:4 in the generator UI if available.
- Text-heavy product reveal slides feel like catalogs: shorten to punchy sales copy and 3 key benefits.
- Product too low/small: explicitly specify size and centrality.
- UGC slides look too polished: add instruction that it should feel like a candid home TikTok creator photo with editorial overlay.
- Product mismatch: keep the reference-critical block high in the prompt and in `quality.include`/`quality.avoid`.
