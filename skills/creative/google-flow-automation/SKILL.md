---
name: google-flow-automation
description: "Use when operating Google Flow/Nano Banana Pro for the user via browser, noVNC, or desktop automation: prompt entry, reference uploads, 3:4 TikTok Shop visuals, generation monitoring, and result download/return."
version: 1.0.0
author: Hermes Agent
license: MIT
metadata:
  hermes:
    tags: [google-flow, browser-automation, novnc, nano-banana-pro, tiktok-shop, image-generation]
    related_skills: [browser-harness, computer-use, tiktok-shop-slideshows, tiktok-shop-slideshow-images]
---

# Google Flow Automation

## Overview

This skill governs repeatable Google Flow work for the user: opening or controlling Flow through browser/noVNC, selecting the right generation mode, applying the user's TikTok Shop/image-reference defaults, monitoring the run, and returning the produced files.

Prefer structured browser automation first. Use desktop/computer-use only when the real VPS/noVNC UI is required or browser DOM automation cannot operate the page.

## When to Use

Use this skill when the user asks to:

- operate Google Flow, Nano Banana Pro, or Flow Agent generation
- automate noVNC/Chrome for Flow
- upload image references into Flow
- create TikTok Shop slideshow images or faceless-video assets through Flow
- generate 3:4 realistic product/book/lifestyle visuals with references
- troubleshoot Flow automation reliability

Do not use for generic image prompting when Flow is not involved; use the relevant TikTok/image-generation skill instead.

## Default Environment Assumptions

Known setup for this user:

- VPS/noVNC is used for Flow access.
- noVNC/websockify typically runs on port `6080`.
- TigerVNC display is `:1` as Linux user `flowdesk`.
- Use Google Chrome at `/usr/bin/google-chrome`.
- Avoid Snap Chromium for Flow/noVNC automation because it previously caused launch errors.
- Flow target mode: Agent generation / Nano Banana Pro.
- Default aspect ratio: `3:4`.

Treat these as starting assumptions, not immutable facts. Verify live state before acting.

## Automation Order

1. **Verify the real Flow surface before generating.**
   - The user expects generation to happen in their logged-in Google Flow/noVNC Chrome profile, not in Hermes' separate headless browser or a fallback image tool.
   - Before starting generation, confirm which surface is being used: real noVNC/Chrome/Flow, browser headless Flow, or a non-Flow image backend.
   - If the user asked for Flow/Nano Banana Pro, do **not** silently substitute another image generator. Report the blocker and wait for access to the real Flow surface unless the user explicitly approves fallback generation.
   - When the user asks to see the process/profile, first show/describe the visible Flow account/profile state before clicking Generate.

2. **Use browser-harness/browser tools first for web interaction.**
   - Navigate, inspect page state, extract text/links, and click by stable page structure when possible.
   - Remember that `browser_navigate` uses an isolated/headless browser and may not share the user's logged-in Google profile. If it shows Google login, that does not prove the user's noVNC Chrome is logged out.
   - Completion: the target Flow page or noVNC page is open and visible, or a clear blocker is identified.

3. **Use `computer_use` for real noVNC/Flow UI control.**
   - Start with `capture(mode="som", app="Firefox"/"Chrome")` where possible.
   - Click by element index rather than raw coordinates.
   - Re-capture after every state-changing action.
   - Completion: the selected UI state is visually verified, not assumed.

4. **Stop at auth/payment/security prompts.**
   - Do not type passwords, API keys, 2FA codes, payment details, or credentials.
   - Do not click purchase/upgrade/payment/permission prompts unless the user explicitly instructs that exact action.
   - Completion: either the user resolves the prompt or the task is paused with a concise blocker.

## Flow Generation Procedure

1. Prepare a clean product/job workspace before opening Flow when references are involved. Prefer the product library + current Flow job pattern in `references/product-library-and-flow-jobs.md` so Flow only sees the current job's `references/`, `prompts/`, and `outputs/` folders.
2. Open the Flow/noVNC environment and verify Chrome is usable. If display access or automation is stuck around `DISPLAY=:1`/Xauthority, use `references/flow-vnc-xauthority-recovery.md`.
3. If the request comes via Telegram and Telegram Hermes cannot see the Flow desktop while host noVNC works, use `references/telegram-host-gateway-flow-desktop.md` before continuing generation.
4. Navigate to Google Flow and confirm the user is logged in.
5. Select Agent generation / Nano Banana Pro when available.
6. Set aspect ratio to `3:4` unless the prompt says otherwise.
7. **Run PRE-FLIGHT before generation.** For image/reference jobs, especially book slideshows, read `/opt/data/ObsidianVault/TikTok Shop/Image Generation Command Center.md` when available and follow `references/image-generation-command-center-preflight.md`. List actual reference files, counts, duplicates, expected output count, and `Ready to generate: yes/no` before uploading/generating.
8. Upload reference images only from the current job/reference set, not old product folders. If the reference count is wrong, duplicated, or unclear, stop and wait for corrected files; do not fill gaps from memory or old folders.
9. Paste the final prompt. Preserve the quality instructions: exact reference mapping, realistic scene/lighting/camera feel, typography/text placement, hard negatives, and QC targets. Do not silently add claims or CTA text.
10. Before starting generation, verify that the visible UI is the user's intended Google Flow profile/session. If using noVNC and it asks for a VNC password, stop and ask the user to connect it themselves; never request or type the password.
11. Start generation.
12. Wait and monitor progress with periodic captures; avoid blind repeated clicking.
13. When results appear, inspect them for prompt compliance.
14. Run QC before saying done: count, dimensions/aspect ratio, exact product/book identity, text spelling/placement, background variation, no invented claims, and rejects separated from finals.
15. Download/export outputs and return file paths or media to the user.

Completion requires either returned output files that passed QC or a specific blocker with evidence.

## User Creative Defaults

Apply these defaults for this user unless the prompt overrides them:

- TikTok Shop/slideshow aspect ratio: `3:4`.
- Strong first-slide hook.
- Do not show the product on the first slide unless requested.
- Structure: problem → solution → proof.
- Introduce product/books after the hook.
- Preserve exact book covers, product appearance, scale, and anatomy.
- Do not invent awards, reviews, author claims, certifications, or product claims.
- Avoid oversized products unless explicitly requested.
- Vary backgrounds.

### CTA rule

Do **not** automatically add or enlarge `Shop Here` or any CTA text. Add CTA text only when the user explicitly asks for it in the prompt.

### “My style” rule

When the user says “my style” for realistic/photo outputs, make the image feel like a casual iPhone photo: natural, believable, not over-designed. Apply this only to realistic/photo images. Do not force iPhone realism onto animated, cartoon, illustration, or stylized outputs.

## Prompt Handling Rules

- Preserve the user's requested wording and intent.
- Correct rough English into natural ad copy when asked or when preparing a final generation prompt.
- Keep claims safe: if a proof/review/award is not provided, do not invent it.
- If reference images are provided, prioritize preservation over decorative redesign.
- If the user asks for “my style,” apply the iPhone realism rule only where it fits the output type.

## Common Pitfalls

1. **Using desktop clicks when browser tools can inspect the page.** Start with browser-harness/browser tools; switch to computer-use only when needed.
2. **Assuming a click worked.** Always re-capture or inspect state after a click.
3. **Adding CTA text by habit.** `Shop Here` is conditional; never add it unless explicitly requested.
4. **Over-applying realism.** “My style” means casual iPhone realism only for realistic/photo images, not animations or cartoons.
5. **Forgetting VPS vs local PC clarity.** When giving commands, state whether they run inside the VPS/Linux shell or on the user's local Windows PC.
6. **Changing paid settings.** Stop and ask before credits, purchases, upgrades, or payment UI.
7. **Letting many old product folders accumulate in Flow's file picker.** For multi-product workflows, use a product library plus per-job `current` folder; copy only the active references into the current job before upload.
8. **Treating `DISPLAY=:1`/Xauthority failures as Flow failures.** If noVNC/Chrome exists but computer-use/Telegram automation cannot access it, run the Xauthority/VNC recovery in `references/flow-vnc-xauthority-recovery.md` instead of restarting the whole creative workflow.
9. **Skipping reference validation because prompts are detailed.** High-quality prompt instructions do not replace file/count validation. Always do PRE-FLIGHT first; detailed prompts are used after references are proven correct.
10. **Centralizing instructions by deleting quality rules.** The user's goal is fewer contradictory instruction sources, not weaker prompts. Preserve scene, lighting, camera feel, typography, reference-mapping, hard-negative, and QC detail in the central workflow.
11. **Telegram routed through a container that cannot see host Flow.** If Telegram says computer-use has no screen while host noVNC works, apply `references/telegram-host-gateway-flow-desktop.md` so the gateway handling Telegram runs with host `DISPLAY=:1` access.

## Verification Checklist

- [ ] Correct environment/page is open.
- [ ] If reference images are involved, active product manifest and current job folders were verified.
- [ ] Flow mode is Agent generation / Nano Banana Pro when requested.
- [ ] Aspect ratio is `3:4` unless overridden.
- [ ] Reference images are uploaded and visible.
- [ ] Prompt does not include unrequested CTA text or invented claims.
- [ ] “My style” was applied only to realistic/photo outputs.
- [ ] Generation completed or a clear blocker was reported.
- [ ] Outputs were downloaded/returned with paths or media handles.

## References

- See `references/session-preferences.md` for the session-specific preferences that motivated this skill.
- See `references/product-library-and-flow-jobs.md` for the scalable product-reference library and per-job workspace pattern.
- See `references/flow-vnc-xauthority-recovery.md` for recovering noVNC/TigerVNC `DISPLAY=:1` Xauthority/cua-driver failures.
- See `references/image-generation-command-center-preflight.md` for the central Obsidian Command Center + mandatory PRE-FLIGHT pattern that preserves prompt quality while preventing stale/duplicate reference mistakes.
- See `references/telegram-host-gateway-flow-desktop.md` for rerouting Telegram Hermes to the host Flow desktop when a container gateway cannot see noVNC/Chrome.
