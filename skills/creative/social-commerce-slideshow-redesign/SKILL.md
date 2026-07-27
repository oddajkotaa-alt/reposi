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

When the user asks to recreate/redesign/generate slideshow images, first check the user’s Obsidian/source-of-truth notes if available and relevant. The approved current notes live under `/opt/data/ObsidianVault/TikTok Shop/`:

- `Recreate Slideshow Command Checklist.md`
- `Slideshow Recreation System.md`
- `Account Palette System.md`
- `JSON Prompt Schema for Slideshows.md`
- `Slideshow Typography and Visual Style.md`
- `Book Slideshow Reference Workflow.md` when product is books
- `API Image Generation Notes.md` when generating images/API outputs

Prioritize notes about recreate workflow, account palette, photo/graphic style rules, font/text-overlay rules, prompt schema, examples, and product-specific safety/reference rules. If the notes are unavailable, continue from the user-provided references and say that the saved notes were not available.

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
   - Prompts must use the user’s exact JSON prompt schema: top-level `prompt` with `scene`, `style`, `technical`, `materials`, `environment`, `composition`, and `quality` sections. Do not substitute a different schema.
   - For photo-style slides, include casual-natural quality language such as “casual iPhone photo,” “natural iPhone photo quality,” or “believable handheld smartphone photo”; skip this for explicitly animated/graphic slides.
   - When product reference photos are provided, use them as the visual source of truth and avoid over-describing the product/package/cover. Prompt lightly: “Use the attached product photo reference for the exact book cover/design/scale. Do not redesign or invent the cover.”
   - If the reference slideshow has a strong theme/world (Roman stoicism, dark academia, nursery, kitchen routine, car interior, etc.), preserve that theme in redesigned form. Apply the account palette as an influence, not a replacement that erases the topic.
   - Include text overlay instructions and safe-zone placement.
   - Include negative rules: no fake claims, no warped anatomy, no oversized product, no random background changes.

6. **Generate images through API**
   - Use image-generation tools/API directly when requested.
   - Prefer review mode for the first test: show analysis + prompt pack before generation.
   - After the workflow is trusted, fast mode can generate immediately.

7. **Self-review and regenerate weak slides**
   - Check naturalness, product scale, character/hands, background coherence, text readability, and whether the result feels redesigned rather than copied.
   - Regenerate only weak slides with targeted correction prompts.

## Account-Wide Palette Rules

The user wants one recognizable color system for the whole account, not a different palette for every product. The default account identity should be universal rather than beauty/feminine-specific.

Default direction:

- warm cream, oat beige, soft greige, light mushroom, warm off-white
- natural environment colors: light oak, cream walls, stone counters, warm white ceramic, linen, muted sage decor
- primary text: deep espresso brown or soft charcoal
- emphasis text: muted burnt terracotta / warm clay
- optional secondary accent: muted sage olive or muted golden beige

Use two-color typography: normal words in deep espresso/soft charcoal, key emotional words in muted terracotta. Violet/berry/plum is optional for beauty/women-focused campaigns but should not be the default account-wide accent.

For full palette details, read `references/account-palette-system.md`.

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
- natural vs animated/graphic style category
- background simplicity level
- palette system: background colors, text colors, accent colors, contrast, warm/cool balance, and repeated color relationships

Do not copy niche-specific claims, exact scenes, exact product language, exact palettes, or exact compositions if they do not fit the target product. If the inspiration account has recognizable colors, create an original palette system with different colors but similar consistency.

## Natural vs Graphic Style Split

Classify reference slides before prompting:

- **Natural photo slideshows:** use believable lived-in backgrounds, realistic product scale, natural hands/characters, and casual iPhone/social-photo quality. Simple backgrounds can still work, but they should feel real rather than empty AI studio space.
- **Animated / graphic slideshows:** simple flat color backgrounds, stylized text/background relationships, and designed compositions are acceptable when that is the intended style. Do not force these into realistic rooms.

## Telegram / Cross-Session Image Intake

When the user sends slideshow images through Telegram while continuing in TUI/CLI, the exact same session ID is not required. What matters is that Telegram and TUI share the same Hermes home/database and that image paths under `/opt/data/cache/images/...` are accessible. Ask for a marker message, find the recent Telegram messages with image attachments, extract local paths, and build a contact sheet for multi-image inspiration batches before detailed analysis.

For the detailed intake pattern and pitfalls, read `references/telegram-image-intake.md`.

## References

- `references/redesign-workflow.md` — detailed slide analysis, redesign blueprint, continuity, and review templates.
- `references/json-schema-and-style-rules.md` — exact JSON prompt schema, casual iPhone photo-quality rule, redesign-not-copy rule, environment continuity, and inspiration/palette guidance.
- `references/account-palette-system.md` — account-wide warm neutral + muted terracotta palette rules and niche adjustments.
- `references/product-reference-and-themed-redesign.md` — handling separate product reference photos, avoiding over-description, and preserving strong slideshow themes while applying account colors.
- `references/telegram-image-intake.md` — workflow for finding Telegram-uploaded reference images from a TUI session and analyzing batches.
- `templates/prompt-pack.json` — starter JSON shape for API-ready slideshow prompt packs.
