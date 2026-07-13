# Brownie character video session notes

Session class: vertical faceless cartoon/mascot cooking video similar to a user-provided 60s TikTok reference.

## Reference analysis pattern

- Uploaded video: `720x1280`, `30fps`, about `60s`, H.264 + AAC.
- Used `ffprobe` to inspect streams and `ffmpeg -vf fps=1` to extract frames.
- Built a contact sheet from sampled frames to identify style:
  - cozy kitchen background
  - cartoon character sticker overlay in lower half
  - ingredient/product cutouts in upper/middle area
  - bold captions
  - expression changes and simple motion/position changes
  - cooking-step pacing

## Asset handling

User supplied multiple character expression images with white backgrounds plus one cozy kitchen background. Useful procedure:

1. Make a contact sheet of supplied assets.
2. Classify expressions by emotion/use:
   - happy/excited intro
   - worried/thinking for recipe steps
   - pointing/teaching for instructions
   - arms-up celebration for reveal
3. Preprocess each character image:
   - scale to target width (example: 430px wide for 720x1280 output)
   - `colorkey=0xFFFFFF:0.25:0.08`
   - save as transparent PNG

## Voice and timing

- The user asked for a Mr. Krabs-like voice for personal use. Safer delivery: describe/produce it as a gruff/cartoon-style voice; do not claim exact voice cloning.
- The first generated script produced a ~44.55s voiceover, which worked better than forcing 60s.
- Captions were shortened after preview because long captions cropped in the contact sheet/preview.

## FFmpeg lessons

A first all-in-one FFmpeg filter graph with many large looped images was killed (SIGKILL). The working pattern was:

1. Pre-render `bg720.png`, `ing.png`, `fin.png`, and `ch0.png..ch5.png`.
2. Use `-filter_complex_threads 1`.
3. Overlay props only during their time windows.
4. Swap character PNGs every ~6s.
5. Add short `drawtext` captions and a bottom progress bar.
6. Use `libx264 -preset ultrafast -crf 25 -pix_fmt yuv420p`.

## Caption style that previewed well

Short captions worked best:

- `RICH BROWNIES`
- `MELT CHOCOLATE`
- `ADD EGGS + VANILLA`
- `WHISK IT GOOD`
- `DO NOT OVERMIX`
- `ADD CHOCOLATE CHIPS`
- `BAKE UNTIL FUDGY`
- `GUARD THE PLATE`

## Verification

After building:

- Run `ffprobe` to confirm `720x1280`, duration, and audio.
- Build a contact sheet from the final MP4.
- Check character is visible, captions are readable, props appear in intended segments, and audio is present.
