---
name: tiktok-shop-slideshow-images
description: Create sales-optimized TikTok Shop slideshow image sets from product and pet/person references, using realistic UGC/product-photo generation and iterative user style corrections.
tags:
  - tiktok-shop
  - slideshow
  - image-generation
  - ugc-ads
  - product-photos
---

# TikTok Shop Slideshow Images

Use this skill when the user wants TikTok Shop slideshow images, product-ad prompts, or regenerated slides from product/reference photos.

## Core workflow

1. **Analyze references first**
   - Identify the product's exact visible details: color, shape, pattern, material, texture, fold seams, border, size relationship, and any claims shown in reference slides.
   - Identify the subject reference: species/person, pose, expression, fur/skin/clothing details, and identity details to preserve.
   - Extract text style from the user's sample slides: font feel, white labels, highlight colors, arrows/callouts, CTA placement, and background style.

2. **Build the slideshow story**
   - Preferred TikTok Shop flow: **problem → engagement/debate tip → useful tips → product solution → proof/result → CTA**.
   - Do not show the product on the first problem/hook slide unless the user explicitly asks.
   - If product info is repeated across slides, consolidate it onto one product-information slide and keep the final CTA slide clean.

3. **Generate one-by-one**
   - Generate images slowly one at a time if the user requests it; short waits between generations can reduce provider friction.
   - After generating, verify ratio, legibility, product visibility, and whether the requested text actually appears.
   - If the provider outputs the wrong ratio, regenerate or explicitly crop only if the user approves.

4. **Use truthful product information**
   - Use only details visible in user-provided references or explicitly provided by the user.
   - Avoid unprovided claims: medical benefits, exact temperature reduction, electricity-free claims, vet claims, or guaranteed outcomes.
   - If a nickname is used for navigation (e.g. "yellow pineapple mat"), do **not** necessarily use that name in customer-facing slide text.

## User style preferences learned

- The user prefers realistic TikTok Shop/UGC product photos over cartoon or overly polished editorial images unless asked otherwise.
- When the user says **"my style"**, match the provided example slides' **visual styling**, not just the concept: big bold black serif-style headlines, black text, yellow brush-stroke highlights, simple pale/white backgrounds, clean TikTok Shop layout, and minimal labels. Avoid switching to premium editorial cards, blue pill labels, or a completely different design language unless the user explicitly asks for a new style.
- If the user asks for a **new style** *and* says **use my style**, change the concept/backgrounds/composition while preserving the signature typography and yellow brush highlight system.
- Use **3:4 portrait** for slideshow images and verify dimensions when possible.
- Keep backgrounds varied between slides so the slideshow does not feel repetitive, but keep the product/subject scale consistent.
- For pet cooling products, the first slide should show the problem clearly (e.g. overheated/exhausted cat) and should not include the cooling mat.
- Make the problem visually obvious when requested: change the animal posture/expression, not only the text. Example: sprawled flat, tired eyes, tongue out/panting, warm sunlight, water bowl nearby.
- The user may write rough English; improve the text into natural ad copy that makes sense, but keep the intended meaning.
- Avoid over-explaining controversy in the slide text. Leave room for comments. Example: write "ice cube in the water bowl" rather than spelling out every opposing view.
- CTA preference for final slides: **"Shop Here ↓"** at the **bottom left**, with the arrow pointing down. Avoid "tap to shop the mat" if the user asked for Shop Here.
- Avoid white product-info squares/cards on final proof/CTA slides if the user says they dislike them.

## Prompting patterns

### Consistency rule for multi-slide sets

Add an explicit global consistency block to every prompt when the same subject/product appears across slides:

- Keep the same subject identity, adult/child/animal body size, face, proportions, and key markings/clothing across every slide.
- Keep the product the same scale relative to the subject: do not make it huge in one slide and small in another.
- For animals, prefer natural poses over extreme/dramatic poses unless the user insists; extreme prompts often create AI-looking bodies, paws, or faces.
- Negative prompt examples: `different cat`, `fat cat`, `skinny cat`, `kitten`, `distorted paws`, `unnatural body`, `oversized product`, `wrong product scale`.

### Problem hook slide
- No product visible.
- Show the pet/person experiencing the problem.
- Add a strong hook and a short highlight line.
- Example pet heat hook:
  - Main: `cats hide overheating better than you think`
  - Highlight: `these tiny changes helped mine cool down`

### Comment-bait tip slide
- Use tips that invite disagreement or personal stories, but phrase safely.
- Good pattern:
  - Main: `tip 1: ice cube in the water bowl`
  - Highlight: `mine drinks more when the water feels colder`
- Do not write too much like "some people disagree" every time; users can say that in comments.

### Product information slide
- Put main product details here instead of repeating them everywhere.
- Make it explicit that features describe the **product**, not the pet/person or vague scene. Use wording like `this mat is…`, `mat features…`, or `the mat that finally worked`.
- Use callouts/arrows to product details.
- Keep claims grounded in references.
- Example for a yellow patterned self-cooling pet mat:
  - Main: `the mat that finally worked`
  - Highlight: `this mat is self-cooling, waterproof + non-toxic`
  - Small label/callout: `scratch + bite resistant mat`

### Final proof/CTA slide
- Show the subject happily using the product.
- Keep text minimal.
- Example:
  - Main: `he went straight to the cool spot`
  - CTA bottom-left: `Shop Here ↓`
- No repeated product-info card unless requested.

## Book / digital-product bundle slideshows

Do **not** reuse any saved book-photo references or old book-cover mappings. The user reported this caused wrong book references.

For any book slideshow:

- Use only book images provided in the **current task/session**.
- If the current task does not include the needed book photos/covers, ask the user to resend them before generating.
- Do not infer book covers from memory, old notes, previous sessions, or saved reference files.
- Preserve exact current uploaded covers when the user provides them; avoid invented awards, reviews, author claims, or unsupported claims.
- Do not make every slide use the same background. If the references/current outputs lean into one repetitive look such as Rome/classical stone, keep a related premium/lifestyle feel but create varied backgrounds across the set.
- For Flow/Nano Banana prompts, attach only the current task's relevant book reference images, never saved/old book photos.
- If a generated image has a good scene/text but the wrong book cover, download/save it anyway and run a follow-up image edit using the generated image plus the correct book reference: replace the book with the reference book while preserving the scene, typography, lighting, and composition.
- If Flow blocks a prompt for policy/privacy reasons, remove the book title/author and book reference, generate the same scene with a blank white book placeholder, download it, then image-edit the blank book into the exact current book reference.
- Keep typography consistent across every slide. Default requested typography: Cooper Black Italic style, black fill, thick white outline/stroke, subtle black shadow/second outline, similar sizes and hierarchy. For hook/editorial/feminine luxury references, copy the reference typography closely: Didot/Bodoni/Playfair-style high-contrast serif, oversized bold italic key words, upright serif support text, small light italic subtitle, tight clean spacing, premium fashion-magazine balance, no sans/rounded/handwritten/script fonts.
- CTA text such as `Shop Here` should only be added/enlarged if the user explicitly asks for it in the prompt.

### Saving replacement / approved book references

When the user sends a new replacement set of book photos, especially through Telegram, actively save the actual image files into a stable current-reference folder and verify the count before confirming. Preferred convention:

```text
/opt/data/book_references/current/
  book_01.ext ... book_10.ext
  manifest.json
```

The manifest should list each original attachment path, saved path, label/title if known, and hash. Do not confuse deleting old reference notes/mappings with deleting actual image files. If a prior Telegram-side assistant claimed to save images but the stable folder is missing in the current session, re-copy from the Telegram attachment cache before answering.

If the user explicitly provides an approved 10-book set and says it should be reused, save and verify exactly 10 images, then reuse that approved current set for those exact books in future 5-book or 10-book tasks. For a 10-book generation use all 10; for a 5-book generation select/request 5 from the approved set. Continue to ignore all old or `DO_NOT_USE` folders.

Known old host-side folders that must not be used as references include `DO_NOT_USE_book-2027-chatgpt-10refs`, `DO_NOT_USE_book-2027-chatgpt-refs`, and `DO_NOT_USE_old_wrong_book_refs` under `/home/flowdesk` when present.

See `references/current-book-reference-handling.md` for the detailed workflow and pitfalls. See `references/approved-10-book-reference-set.md` for the approved-set save/verify pattern and user-facing confirmation wording.

## Verification checklist

Before delivering:

- [ ] Ratio is 3:4 when requested.
- [ ] Text is readable and matches requested wording closely.
- [ ] Product details match reference and are not exaggerated.
- [ ] First slide does not show product if it is a problem-first slideshow.
- [ ] Product info is not duplicated awkwardly across slides.
- [ ] Final CTA placement matches the user's preference.
- [ ] Backgrounds vary across slides.
- [ ] Style is realistic if the user asked for realistic photos.

See `references/pet-cooling-mat-session.md` for concrete examples from the cat cooling mat workflows.
See `references/user-style-and-consistency-notes.md` for the user's `my style` visual system, consistency pitfalls, product-info wording, and book-bundle workflow notes.
See `references/book-reference-quarantine.md` for the host-side old/wrong book-reference folder quarantine pattern, including `/home/flowdesk` folders that may not be visible from the Hermes container.
Do not use saved book-reference notes or old book-photo mappings; require current uploads for book covers/photos.