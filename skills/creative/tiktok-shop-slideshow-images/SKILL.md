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

Use the same slideshow discipline for book bundles and other non-pet products:

- Extract each title/cover from the user's reference photo and preserve recognizability; book titles may not be perfect, but covers should be close and not warped.
- Avoid fake phone screenshot borders when regenerating; output clean 3:4 images.
- If source images look bad, improve realism by changing backgrounds while keeping the same tips/copy.
- Vary backgrounds by theme: morning desk, finance desk, calm bedside, cafe/reading nook, self-care desk, final bundle flat-lay.
- Keep the user's visual style: black serif headline + yellow brush highlight. Do not switch to unrelated collage/fantasy imagery.
- For final bundle slides, show all products at consistent physical size and include `Shop Here ↓` bottom-left if a CTA is needed.

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