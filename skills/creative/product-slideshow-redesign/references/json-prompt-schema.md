# JSON Prompt Schema Rules

Use these rules when generating prompts for product slideshow images.

## Exact Required Shape

Every generated slide prompt must be valid JSON with this top-level structure:

```json
{
  "prompt": {
    "scene": {},
    "style": {},
    "technical": {},
    "materials": {},
    "environment": {},
    "composition": {},
    "quality": {}
  }
}
```

Do not replace this with a custom `slides` array or alternative schema unless the user explicitly requests a different output format. For a carousel, output one full JSON prompt per slide.

## Required Sections

### scene
- `description`: one dense standalone paragraph with subject, action, setting, mood, palette, text overlay, product handling, and redesign instruction.
- `subject`: primary subject/product/person details.
- `setting`: redesigned environment type that fits the product/reference concept.
- `action`: what is happening or static description.

### style
For natural/photo slides, always include wording such as:
- casual iPhone photo
- natural iPhone photo quality
- believable handheld smartphone photo
- native social-commerce photo, not polished catalog photography

For animated/illustrated slides, do **not** use iPhone/photo realism wording.

### technical
Keep camera language realistic and not over-engineered. Suggested defaults:
- 24–35mm: wide/environmental smartphone feel
- 50mm: normal perspective
- 85–200mm: compressed/telephoto feel
- f/2.8–f/4: moderate soft background
- f/5.6–f/8: mostly sharp natural scene

### materials
Include only relevant visible material details: skin, fabric, product surfaces, transparent materials.

### environment
Use for real environments or atmospheric details. For repeated locations, include continuity notes.

### composition
Must include `ui_elements` when there is text. Spell out exact overlay text, font style, weight, color, alignment, and position. Text should be readable, crop-safe, and not cover the product/key action unless intentional.

### quality
Always include tailored arrays:
- `include`: 8–12 positive qualities specific to the image.
- `avoid`: 6–10 failure modes specific to the image.
- `reference_standard`: the photography, design, or illustration standard being targeted.

## Required Redesign Language

For reference-based work, include in the prompt that the output is a redesigned interpretation, not a 1:1 copy. Preserve the concept, product message, typography/palette logic, and sequence role while changing scene details, background, props, angle, and composition.
