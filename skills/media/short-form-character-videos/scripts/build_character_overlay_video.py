#!/usr/bin/env python3
"""
Starter: build a 9:16 character-overlay video from preprocessed assets.

Expected working directory contains:
  bg720.png              720x1280 background
  prop1.png, prop2.png   optional props/food/product overlays
  ch0.png..ch5.png       transparent character expression PNGs
  voice.ogg              voiceover

Edit paths, captions, and timing before running.
"""
import subprocess
from pathlib import Path

BASE = Path.cwd()
OUT = BASE / "character_video.mp4"
DURATION = 45.0
AUDIO = BASE / "voice.ogg"

# Inputs: background, prop1, prop2, character PNGs, audio.
imgs = ["bg720.png", "prop1.png", "prop2.png"] + [f"ch{i}.png" for i in range(6)]
inputs = []
for im in imgs:
    inputs += ["-loop", "1", "-t", str(DURATION), "-i", str(BASE / im)]
inputs += ["-i", str(AUDIO)]

fc = []
fc.append("[0:v]format=rgba[bg]")
fc.append("[1:v]format=rgba[prop1]")
fc.append("[2:v]format=rgba[prop2]")
for i in range(6):
    fc.append(f"[{3+i}:v]format=rgba[ch{i}]")

# Example prop windows.
fc.append("[bg][prop1]overlay=x=35:y=165:enable='between(t,4,14)'[v1]")
fc.append("[v1][prop2]overlay=x=35:y=165:enable='between(t,31,45)'[v2]")

# Character swaps.
segments = [(0,6,0),(6,12,1),(12,18,2),(18,24,3),(24,31,4),(31,38,5),(38,45,0)]
prev = "[v2]"
for idx, (a, b, ch) in enumerate(segments):
    outv = f"[v{idx+3}]"
    x = 250 if idx % 2 == 0 else 220
    y = 610 if idx == 4 else 640
    fc.append(f"{prev}[ch{ch}]overlay=x={x}:y={y}:enable='between(t,{a},{b})'{outv}")
    prev = outv

captions = [
    (0,5.5,"RICH BROWNIES"),
    (5.5,11,"MELT CHOCOLATE"),
    (11,16.5,"ADD EGGS + VANILLA"),
    (16.5,22,"WHISK IT GOOD"),
    (22,28,"DO NOT OVERMIX"),
    (28,34,"ADD CHOCOLATE CHIPS"),
    (34,39.5,"BAKE UNTIL FUDGY"),
    (39.5,45,"GUARD THE PLATE"),
]
font = "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"
cur = prev
for i, (a, b, text) in enumerate(captions):
    outv = f"[txt{i}]"
    fc.append(
        f"{cur}drawtext=fontfile={font}:text='{text}':"
        f"x=(w-text_w)/2:y=72:fontsize=42:fontcolor=white:"
        f"borderw=5:bordercolor=black:box=1:boxcolor=black@0.35:"
        f"boxborderw=16:enable='between(t,{a},{b})'{outv}"
    )
    cur = outv

fc.append(
    f"{cur}drawbox=x=0:y=1266:w=720:h=8:color=black@0.45:t=fill,"
    f"drawbox=x=0:y=1266:w='720*t/{DURATION}':h=8:color=yellow@0.95:t=fill[vout]"
)

cmd = [
    "ffmpeg", "-y", "-filter_complex_threads", "1",
    *inputs,
    "-filter_complex", ";".join(fc),
    "-map", "[vout]", "-map", "9:a",
    "-t", str(DURATION), "-r", "30",
    "-c:v", "libx264", "-preset", "ultrafast", "-crf", "25",
    "-pix_fmt", "yuv420p",
    "-c:a", "aac", "-b:a", "128k",
    "-movflags", "+faststart",
    str(OUT),
]
subprocess.run(cmd, check=True)
print(OUT)
