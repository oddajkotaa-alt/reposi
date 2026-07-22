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

For this user's TikTok Shop slideshow image prompts, consult `references/tiktok-shop-json-carousel-system.md` for the preferred JSON carousel structure and `references/google-flow-agent-carousel-workflow.md` for the one-block Google Flow Agent workflow.

If the user says they already has their own GPT/custom instructions for prompt creation, switch to **operator mode** instead of continuing to rewrite prompts: accept their ready prompt via Telegram, handle image intake, copy/upload references to the VPS Google Flow browser, paste the prompt, generate, download, and return results. See `references/telegram-to-google-flow-operator-workflow.md`.

1. **Collect product inputs**
   - Product name
   - Main benefit/problem solved
   - Audience
   - Visual style
   - Required format, usually vertical 3:4 for this user's slideshow images unless they ask otherwise
   - Number of variations needed
   - Exact product claims allowed; do not invent new product facts for marketplace compliance

2. **Collect reference assets when generating product images**
   - Product reference photo(s) are the source of truth for color, shape, label, material, pattern, thickness, and scale.
   - Pet/person/character references are the source of truth for markings, appearance, and continuity across slides.
   - For VPS/noVNC Google Flow, the browser can only attach files that exist on the VPS, not files on the user's PC. Create a simple upload folder such as `/home/flowdesk/flow-uploads/books`, run `chown -R flowdesk:flowdesk /home/flowdesk/flow-uploads`, and have the user select files from `Home → flow-uploads → books` in the Flow upload dialog.
   - When the user mainly uses Telegram, prefer the workflow: Telegram image → Hermes cache → copy/move to `/home/flowdesk/flow-uploads/<campaign>/` → user selects it in Google Flow.
   - When checking whether Telegram-uploaded images arrived, search `.jpg`, `.jpeg`, `.png`, `.webp`, and `.heic` sorted by modification time; gateways may not use the extension you expect.
   - In Docker deployments, the VPS host may not see the Hermes cache path directly. If the host shell gets `cp: cannot stat '/opt/data/cache/images/...'`, use `docker cp hermes-agent:/opt/data/cache/images/<file> /home/flowdesk/flow-uploads/books/<name>` or the watcher script below.
   - For the user's desired Telegram-first workflow, do not make them run per-image copy commands every time. Install/run `scripts/flow-image-sync.sh` on the VPS host as root so new Telegram images automatically appear in the Flow upload folder as `telegram-reference-01.jpeg`, etc.

3. **Generate prompt batch once**
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
   - For Google Flow Agent with many book/product references, prefer generating one slide at a time. Upload/use one product reference plus one or two style references, paste a prompt that says `Create exactly ONE image only`, generate, download, then repeat. A single prompt for 5+ book slides often creates grids/collages or wrong books.

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

- Do not type passwords, 2FA codes, API keys, payment details, cookies, or other private secrets.
- If Google Flow or any browser tool shows login, CAPTCHA, payment, permission, or account-security prompts, stop and ask the user to handle it.
- Browser/computer-use automation can only control the browser environment Hermes can access. If Hermes runs on a VPS and Google Flow is open on the user's PC, direct automation cannot reach that PC browser; use local Hermes on the PC, or run a VPS browser/noVNC session that the user logs into manually.
- Warn that website UI automation can break if the layout changes.

## Useful support files

- `references/google-flow-batch-workflow.md` — practical outline for batching prompts into Google Flow while saving GPT usage.
- `references/tiktok-shop-json-carousel-system.md` — preferred JSON/one-block carousel prompt system for this user's TikTok Shop slideshow images, including 3:4 locking, reference-image accuracy, claim-safety, slide arcs, Google Flow Agent usage, and image-cache debugging.
- `references/google-flow-agent-carousel-workflow.md` — concise Google Flow Agent workflow for uploading two references once, pasting one full carousel prompt block, preserving product-claim safety, and choosing a workable browser automation setup.
- `scripts/flow-image-sync.sh` — VPS-host helper script for automatically copying Telegram-uploaded images from a Hermes Docker container into the noVNC user's Google Flow upload folder.
