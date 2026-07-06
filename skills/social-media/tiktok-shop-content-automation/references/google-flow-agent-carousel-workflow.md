# Google Flow Agent Carousel Workflow

Use this when the user wants to generate TikTok Shop carousel images in Google Flow by sending one big prompt block to the Flow Agent instead of generating slide-by-slide.

## Core workflow

1. Create or collect product references:
   - `product_reference` — exact product photo.
   - `cat_reference`, `character_reference`, or other lifestyle subject reference when needed.
2. Create one full Google Flow Agent prompt block:
   - Task: generate N separate carousel images.
   - Reference mapping: Image 1 = subject reference, Image 2 = product reference.
   - Global rules: format, style, typography, product-claim safety, reference accuracy.
   - Slide-by-slide instructions with exact visible text.
   - Final checklist: separate images, 3:4 portrait, same references, no extra claims.
3. In Google Flow:
   - Start a new project.
   - Choose Agent generation / Agent mode if that is the user's working mode.
   - Set the intended model and aspect ratio manually in the UI when available.
   - Upload only the required reference images once.
   - Paste the entire prompt block once.
4. Review generated images and repair only failed slides, not the whole carousel, unless the visual system failed globally.

## Important Google Flow prompt rules

- If using Agent mode, prefer a single clear instruction package over many disconnected JSON blobs.
- Explicitly say: `Generate each slide as a separate image. Do not create one collage. Do not combine slides into one image.`
- Repeat the aspect ratio at the task level, global rules, and final checklist: `vertical 3:4 portrait full-bleed`.
- Map references plainly: `Image 1 = cat reference. Image 2 = product reference.`
- Add a strict product-claim safety block for TikTok Shop: only use product facts provided by the user; do not invent compliance-sensitive claims such as vet approved, non-toxic, waterproof, temperature-drop numbers, medical benefits, guarantees, etc.
- Add a product scale lock when product photos might exaggerate size: match reference proportions and do not make the product bigger, thicker, plusher, or more premium than the reference.

## User-style lessons from carousel prompt work

- The user wants sales-focused TikTok Shop prompts, but product facts must stay exactly within provided claims to avoid listing/ad violations.
- Do not add new product information even if it sounds helpful.
- Avoid weak or illogical hook copy. Hook visuals can change, but hook text must make immediate buyer sense.
- Do not preview all tips on one slide when the carousel arc is one tip per slide; keep each slide's job unique.
- Product reveal slides should not make the product look oversized or more premium than the reference image.
- For 3:4 slides, prompt text alone may be ignored by generators; put the format in multiple places and set the UI ratio manually.

## Automation reality check

- Hermes can control Google Flow only in the browser environment it can access.
- If Hermes runs on a VPS and Google Flow is open on the user's PC, direct browser/computer-use automation cannot reach the PC browser.
- Workable setups:
  1. Run Hermes on the same PC as Google Flow.
  2. Run Chrome/Chromium + desktop/noVNC on the VPS, let the user log into Google Flow there, then automate that VPS browser.
  3. Use Hermes browser tool in the VPS, but Google login may block progress; the user must handle login/2FA/CAPTCHA/security prompts.
- Do not type or request passwords, 2FA codes, API keys, or cookies. If login/security/payment/CAPTCHA appears, stop and ask the user to handle it.

## File intake pitfall

When checking whether Telegram-uploaded images arrived, search common image extensions and sort by modification time. Do not only search `.jpeg`; Telegram or gateways may save photos as `.jpg`, `.png`, `.webp`, or `.heic`.

## VPS noVNC setup pitfalls

When the user chooses VPS-hosted browser automation for Google Flow, prefer a browser container the user can log into manually through an SSH tunnel. Give one-line Docker commands when the user is copy/pasting into a shell; multi-line commands with backslashes often fail if whitespace is added after `\` or if a line is missed.

Key notes:

- The safer tunnel pattern is binding the container web UI to localhost on the VPS, then forwarding it from the user's PC with SSH.
- Kasm Chrome commonly serves the noVNC web UI over **HTTPS on port 6901**, not `6080`. Test with `curl -k -I https://127.0.0.1:6901`.
- LinuxServer Firefox uses a simpler web UI for many users; its internal web ports are commonly `3000`/`3001`, so map `127.0.0.1:6080:3000` for browser access.
- If `docker ps --filter name=...` only prints the table header, the container is not running. Ask for the exact `docker run` error, or check `docker ps -a` and `docker logs` if the container was created.
- If a tool shell inside Hermes says it cannot connect to `/var/run/docker.sock`, do not assume the user's SSH shell has the same limitation. Explain that the Hermes runtime may be containerized/restricted and ask the user to run the Docker command directly on the VPS host.
- Never request Google passwords, 2FA codes, cookies, or account secrets. The user logs in through noVNC; Hermes only automates after the authenticated browser is ready.

Example one-line LinuxServer Firefox command:

```bash
docker rm -f hermes-browser 2>/dev/null || true; docker run -d --name hermes-browser -p 127.0.0.1:6080:3000 -p 127.0.0.1:6081:3001 -v /opt/data/tiktok-products:/config/tiktok-products lscr.io/linuxserver/firefox:latest; docker ps --filter name=hermes-browser
```

User-side tunnel:

```bash
ssh -L 6080:127.0.0.1:6080 USER@VPS_IP
```

Then open `http://127.0.0.1:6080` on the user's PC.
