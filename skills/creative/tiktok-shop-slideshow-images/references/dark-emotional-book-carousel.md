# Dark emotional book carousel lessons

Session pattern: user supplied a 9-slide carousel concept around painful life lessons and asked to use only the books that fit the theme. This is still a book/product carousel, but the first slides are symbolic emotional hooks rather than product shots.

## Workflow

1. **Choose a thematic subset**
   - Do not automatically include every reference the user uploaded.
   - For “lessons people are scared to learn,” the fitting 5-book set was:
     - The Let Them Theory
     - Atomic Habits
     - Don’t Believe Everything You Think
     - The Psychology of Money
     - The Courage to Be Disliked
   - Exclude unrelated dark-power/seduction/strategy books unless the requested theme is about power, status, seduction, or strategy.

2. **Keep hook slides symbolic and product-free**
   - Slides 1–3 used dark navy emotional scenes: dissolving memory figure, fading home window, glowing empty chair.
   - No products/books on those hooks.
   - Use deep navy + warm white + pale yellow typography, generous negative space, and no text boxes.

3. **Improve generated hook text proactively**
   - Long sentences often render poorly or feel clunky.
   - Convert hooks into short stacked lines with one highlighted phrase:
     - `YOU THINK YOU HAVE` / `MORE TIME` / `UNTIL SOMEONE BECOMES` / `A MEMORY.`
     - `HOME FEELS` / `ORDINARY` / `UNTIL THERE IS` / `NOWHERE TO RETURN.`
     - `SILENCE FEELS` / `PEACEFUL` / `UNTIL IT IS ALL` / `THEY LEAVE BEHIND.`
   - Use warm white for setup lines and pale yellow for the key emotional phrase.

4. **Product slides should become grounded realism**
   - Keep the deep navy / cream / pale yellow visual system, but make the book scenes ordinary and believable.
   - Good settings: late-night train seat, concrete stairwell before a run, bedside table at night, ordinary kitchen budgeting table, hilltop bench before sunrise.
   - Prompt visible page thickness, slight cover bend/flex, paper edges, contact shadows, believable scale, and subtle wear.

5. **Final CTA for subset bundles**
   - If only 5 books are used, final text must say 5 books, not 10.
   - Attach the 5 selected book references to the final prompt.
   - If the generator outputs 2:3 instead of 3:4 on multi-reference final slides, crop only when it does not damage important content; otherwise regenerate.

## Pitfalls

- Overusing “cinematic editorial / luxury penthouse / hyperrealistic commercial finish” can create AI-looking hooks. When the user says “normal,” switch to casual iPhone realism in an ordinary room.
- The user may like the concept but dislike text; regenerate only the hook slides with improved typography rather than rebuilding the whole carousel.
- For image models, exact baked text is fragile. Prefer fewer words, more line breaks, and high contrast.
