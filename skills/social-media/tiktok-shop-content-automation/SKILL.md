---
name: tiktok-shop-content-automation
description: "Build low-token TikTok Shop content workflows: prompt batches, slideshow/video generation, Google Flow browser automation, and product-ad templates."
version: 1.0.0
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [tiktok-shop, ecommerce, automation, google-flow, prompts, browser-automation]
    category: social-media
---

# TikTok Shop Content Automation

Use this skill when the user wants help creating TikTok Shop slideshow/video content, product ad prompts, batch prompt generation, or automation that moves prompts into a browser-based generator such as Google Flow.

## Core principle

Separate the creative model work from the repetitive browser work:

1. **LLM/GPT does creative generation only** — product hooks, prompt batches, ad angles, scripts, variants.
2. **Automation handles repetition** — paste prompt, click generate, wait, download/save output, repeat.
3. **Reusable templates reduce token use** — do not ask GPT to regenerate full prompt structure every time if a template with variables will work.

This is especially important when the user is worried about GPT limits or cost.

## Recommended workflow

For this user's TikTok Shop slideshow image prompts, also consult `references/tiktok-shop-json-carousel-system.md` for the preferred JSON carousel structure, 3:4 format lock, reference-product accuracy block, pet/beauty arcs, and mobile readability rules.

1. **Collect product inputs**
   - Product name
   - Main benefit/problem solved
   - Audience
   - Visual style
   - Required format, usually vertical 3:4 for this user's slideshow images unless they ask otherwise
   - Number of variations needed

2. **Generate prompt batch once**
   - Ask the model for a numbered list or CSV-ready list.
   - Keep outputs clean: no explanation, no markdown table unless requested.
   - Include constraints like: no text, no captions, no logos, product-focused, realistic lighting.

3. **Save prompts to a structured file**
   - Preferred simple format: CSV with a `prompt` column.
   - Optional columns: `product_name`, `variation`, `scene`, `style`, `status`, `output_file`.

4. **Automate Google Flow or another generator**
   - If an API exists, prefer API automation.
   - If no API exists, use browser automation or Playwright/Selenium.
   - Browser automation loop: open tool → paste prompt → generate → wait → download/save → mark row done.

5. **Verify outputs**
   - Confirm files actually downloaded.
   - Organize by product name and variation.
   - Do not claim generation succeeded unless the file/result is visible or saved.

## Token-saving guidance

- For many similar products, create a prompt template once and fill variables instead of asking GPT for each full prompt.
- Use GPT for high-value creative choices: hooks, angles, scene variety, benefit framing.
- Use scripts for mechanical browser actions.
- Avoid using an AI model for every click when a deterministic browser script can do the same job.

## Safety and account boundaries

- Do not type passwords, 2FA codes, API keys, payment details, or other private secrets.
- If Google Flow or any browser tool shows login, CAPTCHA, payment, or permission prompts, stop and ask the user to handle it.
- Warn that website UI automation can break if the layout changes.

## Useful support files

- `references/google-flow-batch-workflow.md` — practical outline for batching prompts into Google Flow while saving GPT usage.
