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

## Mobile readability and truth-in-advertising rules

- Text must be readable on a phone screen.
- Prefer no more than: 1 headline + 1 accent + 1 short body line.
- Spec/product reveal slides should use 3 short callouts unless the user explicitly asks for a dense spec slide.
- Keep product recognizable quickly, but **do not exaggerate product size, thickness, padding, scale, or premium-ness**. If the product reference looks small/thin/simple, preserve that. Avoid instructions like “fill 60% of the frame” when they could misrepresent the item.
- Product claims must stay limited to facts the user already provided. Do not add compliance-sensitive claims such as “vet approved,” “non-toxic,” “waterproof,” “anti-scratch,” exact temperature drops, medical/therapeutic benefits, or guaranteed results unless the user explicitly provides proof and asks to use them.
- Avoid crowding text into top/bottom safe areas.
- Leave clean negative space behind text.

## Slide-structure corrections from user feedback

- Do not create a “show all tips at once” slide if the carousel is structured as one tip per slide. Use separate slides for separate tips.
- Hook copy must make plain sense to a shopper. Avoid vague or clever lines that sound visually interesting but logically weak (e.g. a hook that does not clearly connect to the product/problem).
- For pet cooling-mat style carousels, a safer 7-slide arc is: hook/problem → tip 1 → tip 2 → tip 3/product solution → product reveal → proof/close-up → CTA.
- For short 3-slide pet cooling-mat regenerations, use: **Slide 1 = heat/problem hook with no cooling mat visible**; Slide 2 = product introduced; Slide 3 = proof/comfort/CTA. The user explicitly prefers not to show the cooling mat on the first slide.
- For pet heat/problem hooks, make the problem visually obvious, not merely a normal cute pet pose. Use strong but safe cues such as sprawled flat posture, head low to the floor, droopy/half-closed eyes, relaxed ears, visible tongue out/light panting, warm sunlight, water bowl nearby, and heat-color grading. Avoid making the animal look injured, dead, horror-like, or medically distressed.
- Vary backgrounds between slides so the carousel does not feel repetitive: e.g. outdoor patio/garden for problem hook, living room for product discovery, bedroom/hallway/window area for comfort proof. Make scene variety explicit in each JSON prompt.
- When the user supplies exact overlay copy, reproduce it exactly and quality-check spelling/casing before finalizing.
- When revising prompts, preserve the same product information and improve only visual clarity, hook strength, flow, background variety, and readability unless the user asks for new claims.

## Direct ChatGPT Image 2 generation workflow

Use this when the user asks Hermes to generate the images directly instead of only preparing Google Flow prompts:

1. Analyze all reference images first: source slideshow style examples, pet/person reference, and product reference.
2. Build a separate compact JSON prompt for each slide, including `task`, `style_settings`, `composition`, `reference` blocks, `text_overlay`, and `negative_prompt`.
3. Generate slides **one by one** with `image_generate`, passing the relevant style image as `image_url` and cat/product references as additional references when needed.
4. If the user asks to avoid rate/limit issues, wait roughly 60–90 seconds between generations rather than firing all image generations at once.
5. For this user's preferred slideshow format, do not trust the prompt alone for 3:4. After each direct image generation, verify actual pixel dimensions; accept only ratios where `width * 4 == height * 3`. If a slide comes back 9:16/tall, regenerate with explicit wording like `TRUE 3:4 portrait`, `not 9:16`, and `product-card/slideshow frame`.
6. After generation, run a visual quality check: correct animal/product, product absent/present as intended, varied background, readable overlay text, exact requested copy, and no obvious misspellings or watermarks.

## Google Flow Agent workflow for this user

- The user often uses Google Flow **Agent generation**, not normal single-prompt generation, because they paste all slide prompts in one block and let the agent generate the carousel.
- Preferred automation target sequence: New project → Agent generation → Agent → model “Nano Banana Pro” → aspect ratio 3:4 → upload exactly two references (cat + product) → paste one full prompt block.
- Structure one-block prompts as: task, reference image mapping, global rules, claim-safety rules, then Slide 1…Slide N. Include “generate each slide as a separate 3:4 portrait image; do not combine into one collage.”
- Be clear that browser automation can assist normal authorized use, but do not help bypass CAPTCHA/login/payment/access controls or stealth/bot-detection systems.

## Image-receipt/debugging pattern

- When the user says they sent images via Telegram, check all common cached image extensions (`.jpg`, `.jpeg`, `.png`, `.webp`, `.heic`) and sort by modified time. Do not only search `.jpeg`; Telegram may save new photos as `.jpg`.
- If images are found, identify them visually and copy them into a stable product folder such as `tiktok-products/<product>/references/cat_reference.jpg` and `product_reference.jpg` before building prompts/automation.

## Common pitfalls to avoid

- Generator returns landscape even though prompt says 3:4: repeat 3:4 in `aspect_ratio`, `format_lock`, and scene description; also remind user to select 3:4 in the generator UI if available.
- Text-heavy product reveal slides feel like catalogs: shorten to punchy sales copy and 3 key benefits.
- Product too low/small: specify natural visibility, but not unrealistic scale.
- Product too large/too premium-looking: explicitly preserve real product proportions, thickness, material, and scale from the reference.
- UGC slides look too polished: add instruction that it should feel like a candid home TikTok creator photo with editorial overlay.
- Product mismatch: keep the reference-critical block high in the prompt and in `quality.include`/`quality.avoid`.
