# Pet Cooling Mat Slideshow Session Notes

This reference captures concrete patterns learned from a TikTok Shop slideshow workflow for cat cooling mats.

## Blue cooling mat example

Product details extracted from reference:

- Light blue pet cooling mat
- Rounded rectangle shape
- Bubble/circular quilted texture
- Darker blue stitched border
- Soft thin padded/flexible look
- For cats and dogs

Useful structure:

1. **Hook/problem slide** — overheated cat, no cooling mat visible.
   - Text used: `Cats rn because of heat 🥵`
   - Bottom text: `watch how fast he cooled down`
   - Visual correction: if the cat looks normal, explicitly prompt for sprawled flat posture, half-closed tired eyes, tongue out/light panting, warm tiles, water bowl, no product.
2. **Product intro slide** — cat on mat.
   - Text improved from vague `the simple swap` to: `I got him this cooling mat` / `and he’s already so chill 🧊`.
   - Add product info here if the final slide is clean.
3. **Proof/CTA slide** — relaxed cat on mat.
   - Avoid repeated product info.
   - CTA: `Shop Here ↓` bottom-left.

Pitfalls observed:

- `aspect_ratio: portrait` may produce 9:16 unless the prompt strongly asks for true 3:4; verify dimensions after generation.
- A generated cat can look too normal even with "overheated" text. The prompt must change posture/expression and environment.
- Repeating the same background across slides feels weak; vary patio/living room/bedroom/window/kitchen/balcony.

## Yellow patterned self-cooling mat example

Internal navigation name used in chat: "yellow pineapple mat". Do **not** use that name in customer-facing slide text unless the user asks.

Product details extracted from references:

- Yellow patterned self-cooling pet mat
- Fun pineapple/fruit emoji pattern with green leaves
- Fold seam down the middle
- Soft padded/foldable look
- Waterproof
- Non-toxic
- Scratch + bite resistant

Realistic 7-slide concept used:

1. Hook: `cats hide overheating better than you think` / `these tiny changes helped mine cool down`
2. Comment-bait tip: `tip 1: ice cube in the water bowl` / `mine drinks more when the water feels colder`
3. Practical tip: `tip 2: move their bed out of direct sun` / `that cosy window spot gets hot fast`
4. Practical tip: `tip 3: brush out loose summer fur` / `less trapped fur = more airflow`
5. Surface tip: `tip 4: cool the surface they lie on` / `cats cool down through their belly and paws`
6. Product info: `tip 5: use a self-cooling mat` with callouts `waterproof`, `non-toxic`, `scratch + bite resistant`, and highlight `made for hot summer naps`
7. Final CTA: `he went straight to the cool spot` plus bottom-left `Shop Here ↓`

Comment-bait guidance:

- The user wants tips that make people comment, but not by over-explaining the debate in the slide. Example: ice cubes in cat water works because viewers will argue/share their experience.
- Use controversy sparingly. One or two slides can invite debate; the rest should be useful and natural.

Style guidance:

- User rejected uncertain editorial styling as possibly not TikTok Shop enough. Default back to realistic UGC/product-photo style.
- Product info belongs on one slide; final CTA should be clean and not contain a white product-info square/card.
- User confirmed that **"my style"** means the original sample-slide styling: realistic photo base, large bold black serif headline, yellow brush-stroke highlight behind the supporting line, simple pale/white TikTok Shop composition, black text, and CTA such as `Shop Here ↓` bottom-left. Do not interpret "my style" as a new premium/editorial design.

## New 4-slide yellow mat concept that matched the user's style

Concept: **the 3pm heat crash**.

1. Hook/problem, no product: `the 3pm heat crash is real` / `my cat literally melts in this weather`.
2. Tip, no product: `first thing I do: block the sun` / `that cute window spot turns into an oven`.
3. Product reveal/info: `so I made him a cool spot` / `self-cooling, waterproof + non-toxic`; small label `scratch + bite resistant`.
4. Proof/CTA: `he claimed it in 5 minutes` / `now this is his afternoon spot`; bottom-left `Shop Here ↓`.
