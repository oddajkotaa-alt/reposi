User's VPS Google Flow setup uses noVNC/websockify on port 6080 connected to TigerVNC display :1 as user flowdesk; Google Chrome is available at /usr/bin/google-chrome and works for Flow, while Snap Chromium caused VNC launch errors.
§
For VPS setup commands, explicitly state whether to run them inside the SSH/VPS Linux shell vs the user's local Windows Terminal; user may otherwise paste Linux-only paths locally.
§
User has an Obsidian vault at /opt/data/ObsidianVault; for TikTok Shop slideshow/faceless video tasks, especially “recreate this slideshow/image” or reference-to-prompt work, check relevant vault notes first: TikTok Shop/Recreate Slideshow Workflow.md, TikTok Shop/Style Rules.md, and Prompt Examples.
§
For TikTok Shop slideshow recreation: after creating prompts from reference images using the Obsidian workflow, the user wants Hermes to use Google Flow/Nano Banana Pro to generate the images when requested, not stop at prompt drafting.
§
For book slideshows, do not reuse saved/old book photo references or cover mappings. Require the user to upload current book cover/reference images for that task, then use only those current uploads.
§
User's VPS currently has ~4 vCPU AMD EPYC, 7.8GB RAM, no NVIDIA GPU/no nvidia-smi, ~122GB free disk; suitable only for small CPU text models (e.g., Qwen/Phi/Gemma ~1.5B–4B GGUF), not local image/video generation.
§
User wants to build a fresh Obsidian + LLM Wiki “second brain” for Hermes long-term knowledge, connected between PC Obsidian and VPS Hermes via free Syncthing; avoid adding extra memory tools like Honcho unless a clear need appears.
§
For this Hermes VPS Docker setup, the active TUI runs in container `hermes-agent`; its `/opt/data` is Docker volume `/var/lib/docker/volumes/b7c39575561de34eacce033f8462d5068ebb13f5a2ce0b53b301e357f1a4687d/_data`, so host `/opt/data/ObsidianVault` is a different folder unless symlinked.
§
User has difficulty copying long VPS paths/commands and may accidentally press Ctrl+C in terminal; prefer short one-line pasteable commands, globs/symlinks, and when recovering after interruption, paste the exact last instructions/context rather than a generic summary.