---
name: tiktok-shop-slideshows
description: Create and iterate TikTok Shop slideshow image sets for products/books using the user's preferred visual systems, prompt structure, and review workflow.
---

# TikTok Shop Slideshows

Use this skill when the user asks to create, regenerate, critique, or iterate TikTok Shop slideshow images, especially product/book slideshows with reference images.

## Core defaults

1. **Format**: generate in true `3:4` whenever possible. Verify dimensions after generation when delivering final sets.
2. **Flow**: default story arc is:
   - hook / problem / lifestyle setup
   - tips or context
   - product/book reveal
   - proof/result
   - final CTA
3. **First slide**: usually **do not show the product/book on slide 1** unless the user explicitly asks. Slide 1 should be a hook/lifestyle visual.
4. **Preserve references**:
   - product/book covers should stay recognizable
   - pets/people should keep consistent scale/anatomy/identity
   - avoid oversized products unless requested
   - avoid unprovided claims
5. **Backgrounds**: vary backgrounds across slides so the set does not feel repetitive.
6. **CTA**: final `Shop Here ↓` should be bottom-left and a bit larger/more visible than normal body text.

## User's visual style

When the user says **"my style"**, this means:

- match the example slides' typography, colors, and stylization — not just the concept
- big bold black serif-style headline
- yellow brush/highlighter swipe behind the key phrase
- simple TikTok slideshow layout
- 3:4 ratio
- strong first-slide hook
- natural iPhone-like realism
- not polished AI/editorial unless explicitly requested

Avoid accidentally replacing the user's style with a new premium/editorial design. If proposing a new style, say it is new and keep the user's visual rules as the base.

## Realism rules learned from user corrections

The user strongly prefers images that look like ordinary high-quality phone photos, not cinematic AI renders.

Prompt for:

- `ordinary iPhone-style photo realism`
- `natural daylight / normal exposure`
- `slightly imperfect camera-roll framing`
- `realistic shadows`
- `not cinematic, not glossy, not editorial`
- `no dramatic color grading`
- `no polished Pinterest/model photoshoot look`

Avoid:

- cinematic lighting
- glossy editorial scenes
- dramatic moody film look
- plastic AI skin
- fake/uncanny faces
- deformed hands or paws
- over-perfect studio staging

For people, prefer cropped/no-face detail shots unless the user specifically asks to show a whole person. If using a 2x2 hook collage and the user requests a whole person, put the whole person in the requested panel only, not across the whole slide.

## Hook slide patterns

### Product slideshows

Use problem/lifestyle hooks before showing the product. Examples:

- overheated pet before a cooling mat
- lifestyle routine before book reveal
- pain point before solution

For pet-care/carousel work, a useful pattern is **educational illustrations first, UGC product photos later**:

- slides 1–6: semi-realistic 2D cel-shaded cartoon illustrations for tips/context
- slide 7: iPhone-style product reveal/photo with product details
- slide 8: iPhone-style CTA/proof photo with pet on product

Keep the transition intentional: tips are friendly educational visuals; product slides are real-looking TikTok Shop proof. If the user supplies a long structured JSON prompt, preserve exact on-slide text and critical constraints, but compress the prompt for the image tool without dropping reference use, no-product timing, colors, typography, or avoid-list items.

Before generating reference-critical slides, ensure the cat/product/book reference images are available in the current session. If reference files are gone, ask the user to resend them instead of generating from memory.

### Book slideshows

For women's book slideshows:

- 2x2 lifestyle collage can work well
- no books on slide 1 unless requested
- natural self-improvement visuals: planner, coffee, gym bag, skincare, outfit, walking shot
- use black serif + yellow highlight; pink script accent can be used for feminine concepts

For men's book slideshows:

- masculine 2x2 lifestyle hook can include gym, desk/work setup, suit/watch/keys, walking/full-body panel
- no books on slide 1 unless requested
- dark red script accent can replace pink when the concept is masculine
- keep it realistic and phone-like, not a movie poster unless requested

## Product/book information placement

- Put most product/book feature information on one dedicated reveal/info slide.
- Do not repeat the same feature list on multiple slides.
- Make feature subjects explicit: use `this mat is...`, `the book teaches...`, or `mat features...` so viewers know what the claim refers to.
- Do not add medical, temperature, financial, or performance claims that were not in the source/reference.

## Engagement tips/copy

The user likes copy that invites comments/debate while staying safe. Do not over-explain the controversy in the slide; leave room for viewers to comment.

Example pattern:

- `tip 1: ice cube in the water bowl`
- `mine drinks more when the water feels colder`

This invites comments without saying too much like `some people disagree`.

## Iteration workflow

1. Analyze user-provided references for:
   - product/book details
   - visual style
   - exact text/tips to preserve
   - what the user dislikes
2. Generate slowly one-by-one if the user asks for time gaps between generations.
3. After each set, verify:
   - 3:4 ratio
   - text readability
   - product/book visibility
   - no product on hook slide when required
   - consistent scale/identity
4. If the user corrects the concept, apply the exact correction immediately; do not defend the previous design.
5. If only one slide is wrong, regenerate only that slide unless the user asks for the whole slideshow.

## Common pitfalls

- **Mistaking composition for product display**: When the user references a hook collage, they may want the same type of composition, not the book/product shown.
- **Copying too directly**: Use references for structure/style, but make original scenes.
- **Over-cinematic output**: The user may say "iPhone quality"; this means realistic phone photo, not polished cinematic.
- **Inconsistent animals/products**: Explicitly prompt for the same identity, scale, body size, and product size across slides.
- **CTA too small**: Make `Shop Here ↓` noticeably larger and easy to see.

## Reference notes

See `references/session-2026-07-slideshow-preferences.md` for detailed lessons from the book, pet cooling mat, and men's/women's slideshow iterations.