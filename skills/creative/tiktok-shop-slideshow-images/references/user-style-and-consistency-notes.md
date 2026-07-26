# User style and consistency notes from TikTok Shop slideshow sessions

Use these notes when the user asks for `my style` or asks to regenerate slides that look fake/inconsistent.

## `My style` visual system

The user expects the visual styling from their examples, not a new design language:

- Realistic lifestyle/product photo base.
- Big bold black serif-style headline, usually in the top third.
- Yellow brush-stroke highlight behind the key phrase/subtitle.
- Simple pale/white/bright background, clean TikTok Shop layout.
- Minimal labels and callouts; avoid premium editorial cards, blue pill labels, or dense white info squares unless requested.
- 3:4 portrait output, not phone screenshots with black UI borders.

If they say `new concept` plus `use my style`, change the story/background/composition but preserve this typography/highlight system.

## Consistency pitfalls

The user notices when an AI slideshow makes the same cat/product look different:

- Cat becomes fat in one slide and slim in another.
- Product changes size or scale relative to the subject.
- Animal anatomy looks unnatural from over-dramatic pose prompts.

Add a global consistency rule to every generation prompt:

> Keep the same subject identity and normal body size across all slides: same face, proportions, markings, and realistic anatomy. Keep the product the same size/scale relative to the subject in every slide. Avoid fat/slim/kitten/different-breed changes and avoid oversized products.

For pet slides, prefer natural poses like `lying naturally on belly/side with tired eyes` over extreme phrases like `dramatically melted`, unless the user specifically wants exaggeration.

## Product-info wording

Feature text must clearly refer to the product, especially when shown near pets/people.

Good pattern:

- Main: `the mat that finally worked`
- Highlight: `this mat is self-cooling, waterproof + non-toxic`
- Small label: `scratch + bite resistant mat`

Avoid vague feature lists that could seem disconnected from the product.

## Book bundle workflow

For book/product bundles:

1. Analyze the reference photo of all items first.
2. Preserve recognizable covers/titles and consistent physical book size.
3. Keep the same tips/copy if the user asks to improve the photos, but change backgrounds and realism.
4. Avoid making every generated slide use the same setting. If the detected/reference look is too repetitive (for example, every output becomes the same Rome/classical-stone background), keep a similar premium/lifestyle visual language but deliberately vary the location, depth, props, lighting, and composition across slides. Be creative while staying in the same slideshow style.
5. Suggested varied backgrounds by slide: luxury apartment balcony, cozy bedroom/nightstand, car interior at night, cafe/reading nook, marble bathroom/vanity, hotel lobby/lounge, city window desk, garden/terrace, bookstore/library aisle, final bundle CTA flat-lay or hand-held fan.
6. If the generated photo is good but the book cover is wrong/different: still download/save the image. Then do an image-edit pass with the generated image plus the correct current book photo reference and instruct the editor: replace/change the book in this photo to match the book from the reference photo while preserving the background, pose, lighting, text, and composition.
7. If Google Flow refuses a prompt for policy/privacy reasons: remove the book title and author from the prompt, remove the book reference from the generation step, and ask for a plain/blank white book placeholder in the same scene. After downloading that image, do an image-edit pass with the correct current book photo reference and instruct: replace the blank white book with the exact book from the reference photo.
8. Preserve the user's requested typography system consistently across every slide in a set. Default common slideshow font: Cooper Black Italic style, black text fill, thick white outline/stroke, plus subtle black shadow or a second outline; keep similar size and hierarchy across slides.
9. For hook/editorial/feminine luxury reference styles, instead use the reference typography as closely as possible: elegant high-contrast fashion-editorial serif similar to Didot, Bodoni, or Playfair Display; oversized bold italic serif for key words; regular upright serif for supporting sentence; smaller light italic serif for subtitle in parentheses; tight clean line spacing; natural editorial alignment; palette-matching readable colors; no sans-serif, rounded, handwritten, or script fonts. Match italic angle, thick/thin stroke contrast, spacing, hierarchy, and luxury beauty-magazine balance.
10. Use `Shop Here ↓` bottom-left on final CTA when appropriate.
