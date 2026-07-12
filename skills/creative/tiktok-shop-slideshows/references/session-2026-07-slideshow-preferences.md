# Session notes: TikTok Shop slideshow preferences (2026-07)

This session produced durable workflow/style lessons for future TikTok Shop slideshow generation.

## Global user corrections

- When the user says **"my style"**, match the visual system from their examples:
  - big bold black serif headline
  - yellow brush/highlighter emphasis
  - simple TikTok slideshow structure
  - exact example-like text colors and styling
- Do not just copy the topic/layout; match **font, color, highlight treatment, and text placement**.
- User prefers **natural iPhone-like realism**:
  - ordinary daylight
  - normal exposure
  - realistic shadows
  - slightly imperfect phone-photo framing
  - minimal color grading
- Avoid outputs that look:
  - cinematic
  - glossy/editorial
  - Pinterest-perfect
  - studio-rendered
  - plastic/AI-polished

## Ratio and delivery

- Target `3:4` for slideshow images.
- Verify actual PNG dimensions before final delivery if possible.
- If a slide is off-ratio, regenerate or crop/fix only that slide.

## Product/pet slideshow lessons

### Blue cooling mat / orange tabby cat

User wanted a pet cooling mat story:

1. Hook/problem slide: overheated cat, **no cooling mat**.
2. Product reveal: cat discovers mat.
3. Proof/CTA: cat relaxed on mat, `Shop Here ↓` bottom-left.

Corrections:

- First slide must show a clear problem; if cat looks normal, make it visibly overheated/exhausted but still realistic.
- Do not over-repeat product info on multiple slides.
- Product info should be on one reveal/info slide.
- CTA slide should be clean, with no white product info square if user dislikes it.
- Make `Shop Here ↓` larger and bottom-left.

### Yellow patterned pet cooling mat

Internal navigation name was "yellow pineapple mat", but do **not** call it that in customer-facing slide text.

Use customer-facing names:

- self-cooling mat
- cooling pet mat
- summer cooling mat
- cooling mat for cats/dogs

Product details extracted from user slides/reference:

- yellow patterned self-cooling pet mat
- foldable, soft padded look
- waterproof
- non-toxic
- scratch + bite resistant
- fun yellow fruit/pineapple-style pattern

Engagement/copy lessons:

- User likes comment-driving tips but not over-explained controversy.
- Example: `ice cube in the water bowl` can invite debate, but avoid writing too much like `some people say...` because that says the comment for viewers.

## Book slideshow lessons

User provided five books:

- Atomic Habits — James Clear
- The Let Them Theory — Mel Robbins
- The Courage To Be Disliked — Ichiro Kishimi & Fumitake Koga
- The Psychology of Money — Morgan Housel
- Don't Believe Everything You Think — Joseph Nguyen

### Women's book slideshow

Effective style after corrections:

- first slide: no books, lifestyle hook
- 2x2 collage can work
- if user asks for a whole girl in a 2x2, put the whole girl only in the requested panel (e.g. bottom-right), not as the whole slide
- avoid clear AI faces/hands when possible; use cropped lifestyle details
- natural iPhone-like photos, not cinematic/editorial

Copy examples used:

- `HOW TO BECOME` / `a 10/10 woman` / `5 books I’d read first`
- `SOFT LIFE STARTS` / `with what you read` / `5 books I’d start with`
- `THE BOOKS THAT CHANGED MY MINDSET` / `start with these 5`

### Men's book slideshow

User supplied reference concept: `HOW TO BE unrecognisable BY 2027`, with masculine visuals and the same five books.

Adapt into user's style rather than copy exactly:

- first slide: no books, masculine 2x2 lifestyle hook
- panels can include gym shoes/gym bag, laptop/desk/watch, suit/jacket/keys, whole man walking/standing
- natural phone realism; do not overdo cinematic casino/movie-poster energy
- masculine accent can use dark red script, but still retain user's readable style

Book/tip mapping from user-provided men's slides:

1. Atomic Habits — `Build systems that actually work`
2. The Psychology of Money — `Get rich before looking rich`
3. The Courage To Be Disliked — `Gain confidence and freedom`
4. Don't Believe Everything You Think — `Learn to escape overthinking`
5. The Let Them Theory — `Focus on what u can control`

Naturalized variants used:

- `small habits, bigger results`
- `wealth is built quietly`
- `stop living for approval`
- `not every thought needs attention`
- `let them, then move on`

## Prompt phrasing that worked better

Use direct visual constraints:

```text
ordinary iPhone-style photo realism, natural daylight, normal exposure,
slightly imperfect camera-roll framing, realistic shadows,
not cinematic, not glossy, not editorial, no dramatic color grading
```

For people:

```text
realistic body/face/hands, natural pose, not model photoshoot,
no plastic AI skin, no deformed hands, no extra limbs
```

For product/book consistency:

```text
keep the cover/product recognizable, consistent scale, not warped,
no extra/missing books, no fake brand text
```

## Mixed illustration + UGC photo pet carousel

For a cat cooling-mat carousel, the user supplied long JSON-style prompts that worked as a class pattern:

- Slides 1–6: semi-realistic 2D cel-shaded cartoon illustrations, cozy UK home, charcoal-black serif text, Yale Blue accent text, Naples Yellow rough brushstroke, no boxes/pills/TikTok handle.
- Slides 1–6 should not show the product; they introduce overheating context and tips.
- Slide 7: first product reveal as natural iPhone 17 Pro UGC photo, mat only, no cat/hands, low side angle showing slim/flexible profile and feature/spec list.
- Slide 8: CTA/proof as natural iPhone UGC photo, cat stretched on mat, promotional headline, single yellow brushstroke, bottom-left CTA/arrow.
- For reference-critical prompts, do not proceed if cat/product reference images are missing from the current session; ask the user to resend them.
- When compressing user-supplied JSON prompts for the image tool, preserve exact visible text, timing of product reveal, aspect ratio, no-background text treatment, color names/hexes, and the strongest avoid constraints.

## Final reminder

When user corrects a slide, apply the precise correction. Do not infer a different composition. Examples:

- `whole girl on 2x2 grid on right down photo` means keep the 2x2 grid and put full-body girl only in bottom-right.
- `don't show product on first slide` means lifestyle hook only.
- `use my style` means font/color/highlight + iPhone realism, not a new editorial design.
