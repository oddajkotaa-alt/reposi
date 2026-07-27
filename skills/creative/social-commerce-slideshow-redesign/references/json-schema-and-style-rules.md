# JSON Schema and Style Rules for Social-Commerce Slideshow Prompts

Use this when generating image prompts from reference slideshows or inspiration slideshows.

## Exact JSON prompt schema

Every slide prompt must use this top-level shape:

```json
{
  "prompt": {
    "scene": {},
    "style": {},
    "technical": {},
    "materials": {},
    "environment": {},
    "composition": {},
    "quality": {}
  }
}
```

Do not replace it with a flat prompt string or a different carousel schema. For multi-slide work, output one complete JSON prompt per slide.

Recommended section contents:

- `scene`: dense stand-alone description including subject, action, setting, mood, palette, product, and all visible typography/text overlay.
- `style`: photorealistic/illustrated/graphic mode, rendering quality, surface textures, and lighting.
- `technical`: camera, focal length, aperture, depth of field, angle, resolution, rendering notes.
- `materials`: product/package materials, surfaces, props, fabric, skin/hair/hand texture if relevant.
- `environment`: room/place type, background continuity details, atmosphere, time of day.
- `composition`: framing, crop, text placement, safe areas, product scale, negative space.
- `quality`: include/avoid rules.

## Natural iPhone quality rule

For photo-style slides, add natural smartphone language in `style`, `technical`, or `quality`, e.g.:

- casual iPhone photo
- natural iPhone photo quality
- believable handheld smartphone photo
- native social-commerce photo, not polished catalog photography

Use this to avoid fake studio/catalog results. Do not add it to explicitly animated, illustrated, or graphic slides.

## Redesign-not-copy rule

Reference slideshow = concept, sequence logic, product message, and visual language.

New slideshow = redesigned scene/background/composition with the same sense. Preserve product truth and product wording style; change exact props, backgrounds, camera angles, and text placement when it improves the design.

## Environment continuity rule

If multiple slides share an environment type, make them feel like the same coherent place. Kitchen is only an example; apply to bathroom, bedroom, vanity table, car interior, pet/home, outdoor, office, etc. Keep the environment type only when it fits the product, and redesign the actual place.

## Inspiration slideshow rule

For strong inspiration slideshows from another niche, such as skincare/cosmetics, ignore the source product and claims. Extract typography, palette, pacing, hook style, background simplicity, photo/graphic mode, and composition patterns. Create a new original palette; do not copy exact colors.
