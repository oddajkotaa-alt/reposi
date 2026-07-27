# Product References and Themed Slideshow Redesign

Use this when the user sends product photos separately from a reference slideshow, especially for book/product carousel generation.

## Product reference handling

When the user provides product photos before the slideshow:

1. Treat the product photos as the source of truth for product appearance.
2. Treat the later slideshow images as the creative/sequence/style reference.
3. When writing prompts for generation, do **not** over-describe the product cover/package/design from memory.
4. Instead, lightly describe the product role and explicitly instruct the model to use the product reference image:

```text
Use the attached product photo reference for the exact book cover/design/scale. Do not redesign or invent the cover.
```

For books, prefer phrasing like:

```text
A real book shown using the attached product photo reference; preserve the exact cover/design from the reference image and keep realistic book scale.
```

Avoid invented cover details, fake titles, fake badges, fake reviews, or unsupported claims.

## Theme-preserving redesign

Sometimes the reference slideshow has a strong topic/world, such as Roman stoicism, dark academia, cozy nursery, kitchen routine, car interior, etc. In that case, do **not** flatten everything into the account’s default home palette.

Instead:

- Preserve the reference topic/world when it is central to the slideshow concept.
- Redesign the exact scenes, props, layout, and palette balance so it becomes the user’s own version.
- Apply the account palette as an influence, not a replacement.

Example: if the reference is Roman/self-improvement books, keep Roman cues such as marble, columns, statues, parchment, oil lamps, and classical editorial serif type, but make it warmer and account-consistent with cream stone, espresso shadows, muted olive-gray, and muted terracotta accents.

## Account palette vs theme palette

Default account palette:

- warm cream / oat beige / soft greige / warm off-white
- deep espresso / soft charcoal text
- muted burnt terracotta / warm clay emphasis
- muted sage/olive or golden beige secondary accents

For themed slideshows:

- use the account palette where it naturally fits the theme
- keep topic-specific materials and mood
- avoid forcing a clean home wall or flat beige background if the slideshow concept depends on a stronger world
- keep text readable and consistent with the account typography system

## Generation workflow

1. Pull or identify product reference images.
2. Pull or identify slideshow reference images.
3. Map product references to the relevant slides/products.
4. Analyze the reference slideshow structure and theme.
5. Decide what to preserve:
   - product truth
   - product/reference appearance
   - core message
   - sequence logic
   - theme/world
6. Decide what to redesign:
   - exact setting details
   - prop arrangement
   - camera angle
   - text placement
   - color balance
   - background details
7. Generate images, then QA for:
   - product reference fidelity
   - readable text
   - theme consistency
   - no watermarks
   - no fake claims or invented product details
