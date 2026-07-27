---
name: product-slideshow-redesign
description: Use when creating, recreating, redesigning, analyzing, or generating API image prompts for product/TikTok-style slideshow carousels from reference slides, inspiration accounts, product information, or requests like “recreate this slideshow”, “make slides like this”, “analyze this carousel”, “generate JSON prompts”, or “make product slideshow images”.
version: 0.1.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [product-slideshow, tiktok-shop, carousel, image-generation, json-prompts, redesign, api-generation]
---

# Product Slideshow Redesign

Use this for product slideshow/carousel work where the user provides reference slides, inspiration slides from another creator, product info/images, or wants API-ready prompts and generated images.

## Core Principle

Use the reference slideshow as a **creative brief**, not a pixel template.

Preserve:
- Product truth and the way the reference describes the product.
- Selling angle, emotion, hook logic, and sequence structure.
- Transferable visual language: fonts, text hierarchy, palette logic, composition rhythm, photo/graphic style.

Redesign:
- Exact background, props, camera angle, subject placement, text placement, and scene details.
- The actual place/environment while keeping the environment type when it fits the product.
- Weak composition, awkward text placement, repetitive scenes, and unnatural product scale.

Never copy a slideshow 1:1 unless the user explicitly asks for exact replication.

## Required First Step: Check Source-of-Truth Notes When Available

For this user, future approved style/workflow rules may live in Obsidian. When accessible and the task is about recreating/redesigning/generating product slideshows, check relevant Obsidian notes before final prompts or generations.

Expected locations may include:

```text
/opt/data/ObsidianVault/TikTok Shop/Recreate Slideshow Workflow.md
/opt/data/ObsidianVault/TikTok Shop/Style Rules.md
/opt/data/ObsidianVault/TikTok Shop/Prompt Examples.md
/opt/data/ObsidianVault/TikTok Shop/API Slideshow Redesign System.md
```

If notes are missing or unapproved, continue from the user's current instructions and say the approved source note was not available.

## Operating Modes

### Mode A — Reference Slideshow Redesign

When the user sends a slideshow to recreate or adapt:
1. Analyze each slide: role, hook, product message, text, font, palette, background, subject/action, composition, photo/animation style, emotional trigger.
2. Separate core concept from surface details.
3. Build a redesigned blueprint slide-by-slide.
4. Define continuity groups for repeated environments or style worlds.
5. Generate one JSON prompt per slide using the required schema.
6. Generate images through API when requested.
7. Self-review outputs and regenerate only weak slides.

### Mode B — Product-Only Slideshow

When the user gives only product information/images:
1. Use approved notes/examples if available.
2. Choose a proven sequence: hook → problem/context → product reveal → benefit/use case/proof → CTA if requested.
3. Build a coherent visual world and palette.
4. Generate JSON prompts and then images.

### Mode C — Inspiration From Another Niche

When the user sends strong slideshows from another creator/account, e.g. skincare/girls cosmetics:
- Ignore the inspiration product, claims, and exact scenes.
- Extract transferable design intelligence only:
  - font system and text hierarchy
  - palette logic and accent colors
  - background simplicity/detail level
  - photo vs animated/graphic treatment
  - pacing and hook structure
  - product reveal timing
  - composition rhythm
  - natural CGC/UGC feel
- Create a different palette for the user's system; do not copy the creator's exact colors.
- Apply the design language to any product category using the target product's true use case.

## Environment Redesign Rule

If the reference uses an environment type and that type fits the product, keep the type but redesign the actual place.

Examples:
- kitchen reference → different coherent kitchen, not necessarily a “new apartment” kitchen.
- bathroom reference → different coherent bathroom.
- bedroom reference → different coherent bedroom.
- vanity/cosmetics reference → different coherent vanity/beauty setup.
- car reference → different coherent car/interior.
- pet/home reference → different coherent lived-in home.
- outdoor reference → different coherent outdoor scene.

Do not randomly change environment type if it weakens product logic. If multiple slides share an environment, make them feel like the same redesigned place through repeated lighting, palette, surfaces, and props.

## Natural vs Animated Styles

Classify references before prompting:

### Natural photo slides
Use for normal realistic product slideshows. Prompts must include language like:
- casual iPhone photo
- natural iPhone photo quality
- believable handheld smartphone photo
- native social-commerce photo, not polished catalog photography

Keep backgrounds believable and natural unless the chosen style intentionally uses simple backgrounds.

### Animated / graphic slides
Do not add photographic realism language. Simple or flat backgrounds can be correct if that is the style. Describe the illustration/animation system instead: flat vector, cel-shaded, soft painterly, cutout, etc.

## Required JSON Prompt Format

Every generated slide prompt must be valid JSON and use the exact top-level schema from the user's prior JSON prompt generator:

```json
{
  "prompt": {
    "scene": {
      "description": "",
      "subject": "",
      "setting": "",
      "action": ""
    },
    "style": {
      "primary": "",
      "rendering_quality": "",
      "surface_textures": "",
      "lighting": ""
    },
    "technical": {
      "camera": {
        "focal_length": "",
        "aperture": "",
        "depth_of_field": "",
        "angle": ""
      },
      "resolution": "",
      "rendering": "",
      "physics_accuracy": ""
    },
    "materials": {
      "skin": "",
      "fabric": "",
      "surfaces": "",
      "transparency": ""
    },
    "environment": {
      "atmosphere": "",
      "time": "",
      "particles": ""
    },
    "composition": {
      "perspective": "",
      "framing": "",
      "subject_placement": "",
      "ui_elements": ""
    },
    "quality": {
      "include": [],
      "avoid": [],
      "reference_standard": ""
    }
  }
}
```

Omit irrelevant subsections only when truly irrelevant, but do not invent a different schema. Validate JSON before output.

## Product and Claim Safety

- Do not invent fake reviews, awards, certifications, popularity claims, medical/financial/legal claims, or unsupported before/after proof.
- Preserve exact product packaging/cover/reference when the user provides product images.
- If product reference images are available, prompts should say to use the attached product photo reference rather than over-describing packaging from memory.
- CTA such as “Shop Here” is conditional; include only if the user asks for it or the approved workflow says it belongs in that concept.

## Output Procedure

For a serious redesign task, provide:
1. Short analysis of the reference/inspiration style.
2. Slide structure/blueprint.
3. Palette and typography system.
4. One valid JSON prompt per slide.
5. Image generation when requested.
6. Self-review of generated images against: naturalness, product scale, text readability, continuity, product truth, and redesigned-not-copied quality.

See `references/json-prompt-schema.md` for the exact prompt schema rules and `references/style-learning-rules.md` for inspiration-account analysis rules.
