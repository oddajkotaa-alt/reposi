# Session Preferences Behind Google Flow Automation

Captured from the setup and correction session where the user asked how to improve browser automation and how to write a Flow skill.

## Browser automation preference

- For normal web pages, use browser-harness/browser tools first.
- Use `computer_use` only when operating the real noVNC/Flow UI or native desktop where browser tools cannot inspect/control the page.
- Verify after each action instead of assuming clicks worked.

## Flow environment details

- User runs Hermes on a VPS while using PC/browser separately; be explicit about VPS Linux shell vs local Windows Terminal.
- Flow setup uses noVNC/websockify on port `6080`, TigerVNC display `:1`, Linux user `flowdesk`.
- Google Chrome path: `/usr/bin/google-chrome`.
- Avoid Snap Chromium for Flow/noVNC because it caused launch errors in this environment.
- Target Flow mode: Agent generation / Nano Banana Pro.
- Default output shape: `3:4`.

## Creative preference corrections

- Do not automatically add or enlarge `Shop Here` CTA. Include CTA text only when explicitly requested in the prompt.
- When the user says “my style” for realistic/photo outputs, make the result feel like a casual iPhone photo: natural, realistic, and not over-designed.
- Do not apply the iPhone realism rule to animated, cartoon, illustration, or stylized image requests.
- Preserve exact reference appearance/scale/anatomy and exact book covers.
- Avoid invented awards, reviews, author claims, certifications, and unsupported product claims.
