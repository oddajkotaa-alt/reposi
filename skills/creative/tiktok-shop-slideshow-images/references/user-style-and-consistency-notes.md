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
4. Suggested backgrounds by slide: bundle flat-lay, morning desk, finance desk, bedside wellness setup, cafe/reading nook, self-care desk, final bundle CTA.
5. Use `Shop Here ↓` bottom-left on final CTA when appropriate.
