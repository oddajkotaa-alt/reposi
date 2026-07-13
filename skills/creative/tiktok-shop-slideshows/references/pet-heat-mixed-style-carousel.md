# Pet heat carousel mixed-style pattern

Use when the user supplies long structured prompts for a pet-care TikTok Shop carousel and wants GPT Image 2.0 generation.

## Durable pattern

A high-performing pet cooling mat carousel can mix **educational cartoon tips** with **realistic UGC product proof**:

1. Hook — cartoon illustration, no product. Overheated cat, warm home, strong question hook.
2. Context — cartoon illustration, no product. Subtle signs + water bowl; keep educational but not clinical.
3. Tip 1 — cartoon illustration, no product. Close curtains / shade.
4. Tip 2 — cartoon illustration, no product. More water stations.
5. Tip 3 — cartoon illustration, no product. Lightly damp cloth on outer ears only.
6. Tip 4 — cartoon illustration, no product. Fan circulates air indirectly; never blast directly.
7. Product reveal — realistic iPhone UGC photo, product only, with feature/spec block.
8. CTA/proof — realistic iPhone UGC photo, cat on product, promotional CTA.

## Prompt preservation rules

When the user provides verbose JSON-style prompts:

- Preserve exact on-slide text.
- Preserve slide numbering and no-product timing.
- Preserve color names/hex codes when specified, especially highlight/arrow/brush colors.
- Preserve explicit safety constraints (`outer ear only`, `no dripping water`, `fan not aimed at face`).
- Preserve `single yellow brushstroke` and `no boxes/pills/handles` constraints.
- Compress prose for the image tool only where necessary; do not drop the user’s reference-critical requirements.

## Reference handling

- If a cat/product reference path is stale or missing, ask the user to resend before generating. Do not recreate from memory when the prompt says exact markings/product pattern matter.
- For slides 1–6, pass the cat reference as the main image input; do not include the product reference if the slide forbids the product.
- For slide 7, pass the product reference as the main image input and no cat reference.
- For slide 8, pass cat as main image and product as an additional reference.

## Verification

After generation, verify all slides are true 3:4 and spot-check:

- Slide 1 has no product and the cat looks overheated.
- Slide 7 has product only, no cat/hands.
- Slide 8 has cat on product and visible CTA.
