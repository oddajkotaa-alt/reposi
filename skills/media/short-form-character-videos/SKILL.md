---
name: short-form-character-videos
description: Create/edit vertical faceless character-overlay videos from user-provided character assets, backgrounds, scripts, TTS, and FFmpeg compositing.
---

# Short-Form Character Videos

Use this skill when the user wants a TikTok/Reels/Shorts-style video with a cartoon/mascot character over backgrounds, captions, voiceover, recipe/product/story pacing, or asks to recreate the style of an uploaded video.

## Workflow

1. **Inspect the reference video first**
   - Run `ffprobe` for duration, size, fps, audio/video streams.
   - Extract frames (`fps=1` or scene changes) and make a contact sheet to understand pacing, captions, overlays, backgrounds, and character timing.
   - Describe the style and confirm the target: length, topic, character, voice, and needed assets.

2. **Inventory assets**
   - Make a contact sheet of uploaded character/background images.
   - Classify each asset: background vs character expression vs prop/product.
   - If character images have white backgrounds, use chroma/keying or preprocessed transparent PNGs.
   - If food/product assets are missing, generate them as separate vertical PNGs before editing.

3. **Script and voice**
   - Write a short scene-by-scene script sized to the content; do not force 60s unless needed.
   - Generate voiceover when requested. If user requests a copyrighted character voice, use a “gruff/cartoon-style” approximation rather than claiming an exact voice clone.
   - Measure voiceover duration and time captions/scene segments to it.

4. **Assemble video**
   - Output `9:16` MP4, usually `720x1280` or `1080x1920`.
   - Use background, character expression swaps, prop overlays, large caption blocks, optional progress bar, and voiceover.
   - Keep captions short so they do not crop in vertical contact sheets or Telegram previews.
   - Deliver the final MP4 with `MEDIA:/absolute/path.mp4`.

## FFmpeg stability pattern

Large filter graphs with many large images can get killed for memory. Avoid this by:

- Pre-scaling backgrounds/props/characters into temporary PNGs.
- Applying `colorkey` once during preprocessing for white-background character assets.
- Using `-filter_complex_threads 1` and `-preset ultrafast` for constrained environments.
- Keeping overlays at practical sizes (e.g. character ~430px wide for 720x1280 output).
- Verifying with a contact sheet before final delivery.

## Common visual style

For videos similar to the user's brownie example:

- vertical 9:16
- cozy kitchen/background
- character sticker overlay in lower half
- ingredients/product image overlays in the upper/middle area
- big bold white captions with black outline/box
- expression changes every 5–7 seconds
- simple progress bar at bottom
- generated voiceover synced to captions

## Pitfalls

- Do not ask the user to describe uploaded video content if the file path is available; inspect it.
- Do not claim the generated voice is an exact copyrighted-character voice.
- If the first FFmpeg build fails from quoting, simplify captions to avoid apostrophes or escape carefully.
- If FFmpeg is killed, change strategy: preprocess images and simplify the graph instead of retrying the same command.
- If captions are long, they will crop in previews; rewrite them shorter and regenerate.

## Support files

- `references/brownie-character-video-session.md` — details from the brownie/crab-style video session and the FFmpeg workaround.
- `scripts/build_character_overlay_video.py` — starter script for assembling a 9:16 character-overlay video from preprocessed assets.