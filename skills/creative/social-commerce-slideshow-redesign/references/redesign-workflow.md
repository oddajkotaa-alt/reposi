# Redesign Workflow Reference

## Analysis Template

For each reference slide, capture:

- Slide number
- Role in sequence: hook / problem / proof / reveal / demo / benefit / CTA / other
- Core selling idea
- Product language used
- Visual category
- Surface details that can change
- Environment type
- Subject/action
- Text overlay exact wording
- Text style and font feel
- Text placement
- Composition
- Photo style and realism level
- Emotional trigger
- What to preserve
- What to redesign
- Safety/claim notes

## Core Concept vs Surface Details

Always separate:

- **Core concept** — should usually stay.
- **Product truth** — must stay.
- **Surface details** — should usually change.

Example:

```text
Surface detail: white kitchen, product left, text top right.
Core concept: messy kitchen problem solved by product.
Product truth: product helps with kitchen organization/cleanup.
Redesign: different coherent kitchen, new props, improved text placement, same problem-solution logic.
```

## Redesign Blueprint Template

For each new slide:

- New slide number
- Based on reference slide(s)
- Role
- Product message
- Redesigned visual concept
- Environment continuity group
- Background redesign
- Subject/action
- Product appearance
- Text overlay
- Text placement
- Font/text style
- Composition
- Why this change improves or differentiates from the reference

## Environment Continuity

If multiple slides share an environment type, define a continuity group before writing prompts.

Use this pattern for any repeated environment:

```yaml
continuity_groups:
  vanity_main:
    environment_type: vanity/cosmetics setup
    actual_place: redesigned coherent vanity area, not copied from reference
    visual_constants:
      - same lighting direction
      - same surface/material palette
      - same repeated natural props
      - same realism level
    allowed_variation:
      - camera angle
      - crop distance
      - product position
      - hand/action
      - text placement when visually better
```

Do not over-literalize examples. A kitchen example means “same environment type when appropriate, redesigned actual place,” not “always make a new apartment kitchen.”

## Prompt Construction

Each slide prompt should include:

1. Shared style block
2. Continuity group block
3. Product-language block
4. Slide-specific scene
5. Text overlay instructions
6. Composition notes
7. Negative rules

## Output Self-Review Checklist

For each generated image, check:

- Does it match the intended slide role?
- Is the product natural and realistic in scale?
- Are character, hands, and body believable?
- Is the background natural?
- Is the environment consistent with the continuity group?
- Is the text readable and well placed?
- Does it preserve product truth without inventing claims?
- Does it feel redesigned rather than copied?
- Would it fit in a TikTok/social-commerce slideshow?

If a slide fails, regenerate only that slide with a targeted correction prompt.