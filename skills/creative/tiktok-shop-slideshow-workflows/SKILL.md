---
name: tiktok-shop-slideshow-workflows
description: Use when creating, recreating, analyzing, or adapting TikTok Shop slideshows/faceless videos for this user. Loads user-approved Obsidian notes first, preserves product/reference accuracy, and applies the user's slideshow/style rules without inventing claims.
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [tiktok-shop, slideshow, ecommerce, creative, obsidian, google-flow]
    related_skills: [obsidian, tiktok-shop-slideshows, tiktok-shop-slideshow-images, google-flow-automation]
---

# TikTok Shop Slideshow Workflows

## Overview

Use this skill for TikTok Shop slideshow and faceless-video work for this user: creating new slide concepts, recreating an existing slideshow, adapting a competitor structure, drafting prompts, writing short ad copy, or preparing assets for Google Flow / image generation / MP4 assembly.

The key behavior change: **check the user's Obsidian vault for approved slideshow rules before finalizing output.** Do not rely only on chat memory when a stable note exists.

## When to Use

Use when the user says things like:

- "recreate this slideshow"
- "make similar slideshow"
- "copy this slideshow style"
- "TikTok Shop slideshow"
- "faceless video"
- "make slides for this product/book"
- "use my style" in a TikTok Shop or product-ad context
- asks for prompts or image-generation instructions for TikTok Shop slides

Do not use for general video editing unless the output is a TikTok Shop slideshow/faceless ad.

## Required First Step: Check Obsidian Notes

Before producing final prompts/copy for a slideshow task, check the Obsidian vault if available:

```text
/opt/data/ObsidianVault/TikTok Shop/Style Rules.md
/opt/data/ObsidianVault/TikTok Shop/Recreate Slideshow Workflow.md
/opt/data/ObsidianVault/Prompt Examples/Prompt Examples.md
```

If a relevant note is empty or says `Pending review`, say that no approved note exists yet and continue using memory/user-provided instructions.

For the user's longer slideshow recreation settings, use the support reference in this skill as the process scaffold:

```text
references/slideshow-recreation-memory.md
```

## Core Rules

1. **Preserve references.** Keep product/book cover/reference appearance, scale, anatomy, and important visual identity. Do not invent awards, reviews, author claims, product certifications, or unsupported claims.

2. **CTA is conditional.** Do not automatically add or enlarge `Shop Here`. Add CTA text only when the user's prompt explicitly asks for it.

3. **"My style" means casual iPhone realism for realistic outputs.** When the user says "my style" for realistic/photo images, make photos feel like casual iPhone photos: natural lighting, imperfect real-life framing, realistic backgrounds, and non-overdesigned composition. Do **not** apply this rule to animated/cartoon/non-realistic images.

4. **TikTok Shop structure defaults.** Unless overridden, use strong hook first, then problem → solution → proof/credibility, and introduce the product/book after the hook. Avoid showing the product in the first slide unless user specifically requests it.

5. **Encourage safe engagement.** Copy can invite comments/debate, but stay platform-safe and avoid deceptive or medical/financial/legal overclaims.

## Recreating an Existing Slideshow

When the user provides an existing slideshow, video, or screenshots:

1. Extract the structure first: hook, number of slides/scenes, visual pattern, text placement, pacing, product reveal timing, proof elements, CTA usage.
2. Separate **transferable pattern** from **specific claims/assets**. Reuse the structure and style logic, not unverified claims.
3. Ask for missing product/reference assets only if they are necessary and cannot be inferred safely.
4. Draft slide-by-slide output with: visual prompt, overlay text, purpose, and any generation constraints.
5. Verify that CTA/product/reference rules are respected before final response.

## Google Flow / Browser Automation Note

If the task requires operating Google Flow, prefer browser-harness/browser tools for normal web-page inspection and computer-use/noVNC only for the real Flow UI. For Flow generation, use the user's Flow defaults when applicable: Agent generation, Nano Banana Pro, and 3:4 aspect ratio.

## Common Pitfalls

1. **Forgetting Obsidian.** For slideshow work, check relevant vault notes before final output.
2. **Forcing CTA.** Never add `Shop Here` just because previous examples used it.
3. **Over-designing "my style."** The user's iPhone realism preference is casual and realistic, not glossy ad-design. Only apply it to realistic photo outputs.
4. **Inventing proof.** Do not create fake reviews, awards, before/after results, or author/product claims.
5. **Installing/saving too much.** Long user-provided slideshow settings should be saved as an Obsidian note or skill reference, not scattered through memory.

## Verification Checklist

- [ ] Checked Obsidian notes or noted they were empty/unapproved.
- [ ] Preserved product/reference accuracy.
- [ ] CTA included only if explicitly requested.
- [ ] "My style" interpreted correctly for realistic outputs only.
- [ ] Slide order has a clear hook and conversion logic.
- [ ] Unsupported claims removed or marked as needing user proof.
