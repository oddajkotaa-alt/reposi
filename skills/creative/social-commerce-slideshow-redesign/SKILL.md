---
name: social-commerce-slideshow-redesign
description: Use when recreating, redesigning, analyzing, or generating TikTok Shop / social-commerce slideshow images from reference slideshows, product information, product images, or inspiration slideshows; especially when the user asks to “recreate this slideshow,” “make slides like this,” “use this style,” or generate product carousel images through an image API.
version: 0.1.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [slideshow, social-commerce, tiktok-shop, image-generation, prompt-engineering, redesign]
    platform: [hermes]
---

# Social-Commerce Slideshow Redesign

## Core Principle

Use the reference slideshow as a **creative brief**, not a pixel template.

Do **not** copy slides 1:1. Extract the concept, sales logic, product language, visual style, font/text behavior, and slide structure, then redesign the images so they keep the same sense while looking new, coherent, and natural.

## Load Source-of-Truth Notes First

When the user asks to recreate/redesign/generate slideshow images, first check the user’s Obsidian/source-of-truth notes if available and relevant. Prioritize notes about:

- recreate slideshow workflow
- TikTok Shop / social-commerce style rules
- photo style rules
- font and text-overlay rules
- prompt examples
- product-specific safety rules

If the notes are unavailable, continue from the user-provided references and say that the saved notes were not available.

## Workflow

1. **Gather inputs**
   - Reference slideshow images/video frames.
   - Product info and product reference images.
   - Optional inspiration slideshow from another niche.
   - Optional old working Claude/GPT prompt/skill system.

2. **Analyze the reference**
   - Identify each slide’s role: hook, problem, proof, reveal, demo, benefit, CTA, etc.
   - Extract product language: how the product is described, positioned, and framed.
   - Extract visual language: photo style, lighting, background type, characters/hands, product scale, text placement, font feel, color palette, and composition.
   - Separate **core concept** from **surface details**.

3. **Redesign, don’t copy**
   - Preserve product truth, sales angle, sequence logic, and overall visual taste.
   - Change exact scene details, props, framing, camera angles, background specifics, and text placement when it improves the design.
   - Keep the same environment type only when it fits the product, but redesign the actual place.

4. **Build continuity groups**
   - If multiple slides use the same type of location, they should feel like the same coherent world.
   - This applies to every environment, not only kitchens: bathroom, bedroom, vanity/cosmetics setup, car interior, pet room, outdoor scene, office, etc.
   - Example: a reference kitchen can become a different coherent kitchen, not necessarily a new apartment kitchen. The point is “redesigned but consistent,” not “always make it modern apartment.”

5. **Create API-ready prompt pack**
   - Define shared style block.
   - Define continuity groups.
   - Write slide-specific prompts.
   - Include text overlay instructions and safe-zone placement.
   - Include negative rules: no fake claims, no warped anatomy, no oversized product, no random background changes.

6. **Generate images through API**
   - Use image-generation tools/API directly when requested.
   - Prefer review mode for the first test: show analysis + prompt pack before generation.
   - After the workflow is trusted, fast mode can generate immediately.

7. **Self-review and regenerate weak slides**
   - Check naturalness, product scale, character/hands, background coherence, text readability, and whether the result feels redesigned rather than copied.
   - Regenerate only weak slides with targeted correction prompts.

## Naturalness Rules

Images should look believable and native to social commerce:

- natural backgrounds
- believable characters, hands, faces, and body proportions
- realistic product scale
- product integrated into the scene rather than pasted on top
- casual social-photo realism unless the reference clearly calls for graphic/ad style
- no sterile catalog look unless explicitly requested

## Product-Language Rules

Preserve the way the reference talks about the product.

- Keep the same type of product description across slides.
- Do not rebrand the product randomly between slides.
- Do not invent awards, reviews, medical claims, guarantees, or unsupported performance claims.
- If product packaging/book cover/reference image is provided, preserve its appearance and scale.

## Inspiration Slideshows From Other Niches

When the user sends someone else’s strong slideshow from another niche, use it for design inspiration only.

Extract transferable design intelligence:

- pacing
- text hierarchy
- font feel
- hook framing
- product reveal timing
- emotional rhythm
- contrast
- background consistency
- natural photo feel

Do not copy niche-specific claims, exact scenes, exact product language, or exact compositions if they do not fit the target product.

## References

- `references/redesign-workflow.md` — detailed slide analysis, redesign blueprint, continuity, and review templates.
- `templates/prompt-pack.json` — starter JSON shape for API-ready slideshow prompt packs.
