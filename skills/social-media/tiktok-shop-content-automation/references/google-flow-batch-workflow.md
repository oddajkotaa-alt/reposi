# Google Flow Batch Workflow for TikTok Shop Prompts

This reference captures a low-token pattern for generating TikTok Shop slideshow/video assets with a browser-based generator such as Google Flow.

## Goal

Use GPT/LLM only where it adds creative value, then let deterministic automation handle repetition.

## Architecture

```text
Product list / CSV
  → GPT prompt batch generator
  → prompts.csv
  → browser automation / Playwright / Hermes browser control
  → Google Flow generation
  → downloaded outputs organized by product
```

## CSV shape

Minimum:

```csv
prompt
"Create a 5-second vertical TikTok Shop product video..."
```

Better:

```csv
product_name,variation,scene,style,prompt,status,output_file
Portable blender,1,modern kitchen,bright realistic,"Create a 5-second vertical...",pending,
```

## Prompt template

```text
Create a [DURATION]-second vertical 9:16 TikTok Shop product video of [PRODUCT].
Scene: [SCENE].
Show the product solving [PROBLEM] for [AUDIENCE].
Style: [STYLE], realistic product-focused lighting, fast TikTok ad pacing.
Avoid text, captions, logos, watermarks, distorted hands, and unreadable labels.
Keep the product clearly visible and make the benefit obvious visually.
```

## Batch generation prompt

```text
Product: [PRODUCT]
Benefit: [BENEFIT]
Audience: [AUDIENCE]
Style: [STYLE]

Create [N] Google Flow-ready video prompts for TikTok Shop.
Requirements:
- vertical 9:16
- product-focused
- realistic commercial lighting
- fast TikTok ad pacing
- no text, captions, logos, or watermarks
Return only a numbered list of prompts. No explanation.
```

## Browser automation loop

1. Read the next row with `status=pending`.
2. Open or focus Google Flow.
3. Paste the prompt into the generation field.
4. Click generate.
5. Wait until generation completes.
6. Download or save the result.
7. Verify the file exists.
8. Mark the row `done` with `output_file` path.
9. Continue with the next prompt.

## Safety checkpoints

- If login, CAPTCHA, 2FA, payment, or permission prompts appear, stop and ask the user.
- Do not type secrets or credentials.
- Do not claim completion unless downloaded files or visible results were verified.
- Browser UI automation can break when the site layout changes; prefer official APIs if available.
