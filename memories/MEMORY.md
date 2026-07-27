User's VPS Google Flow setup uses noVNC/websockify on port 6080 connected to TigerVNC display :1 as user flowdesk; Google Chrome is available at /usr/bin/google-chrome and works for Flow, while Snap Chromium caused VNC launch errors.
§
For VPS setup commands, explicitly state whether to run them inside the SSH/VPS Linux shell vs the user's local Windows Terminal; user may otherwise paste Linux-only paths locally.
§
User has an Obsidian vault at /opt/data/ObsidianVault; for TikTok Shop slideshow/faceless video tasks, especially “recreate this slideshow/image” or reference-to-prompt work, check relevant vault notes first: TikTok Shop/Recreate Slideshow Workflow.md, TikTok Shop/Style Rules.md, and Prompt Examples.
§
For TikTok Shop slideshow recreation: after creating prompts from reference images using the Obsidian workflow, the user wants Hermes to use Google Flow/Nano Banana Pro to generate the images when requested, not stop at prompt drafting.
§
For book slideshows, never use old/DO_NOT_USE refs. User may provide an approved current 10-book photo set; once saved and verified, reuse it for those exact books, selecting 5 or 10 as requested.
§
User's VPS currently has ~4 vCPU AMD EPYC, 7.8GB RAM, no NVIDIA GPU/no nvidia-smi, ~122GB free disk; suitable only for small CPU text models (e.g., Qwen/Phi/Gemma ~1.5B–4B GGUF), not local image/video generation.
§
User wants an Obsidian + LLM Wiki second brain synced PC↔VPS via Syncthing; prefers video-style automation: auto-save clearly useful chat knowledge, ingest raw folder, lint/backup; avoid Honcho unless needed.
§
Hermes VPS Obsidian sync currently works but user treats settings as editable/not final. Active TUI/container can read synced vault at `/opt/data/ObsidianVault`; host/VPS Syncthing path is `/mnt/hermes-obsidian-vault`; Windows vault path is `C:\Users\Admin\Documents\ObsidianVault`.
§
User has difficulty copying long VPS paths/commands and may accidentally press Ctrl+C in terminal; prefer short one-line pasteable commands, globs/symlinks, and when recovering after interruption, paste the exact last instructions/context rather than a generic summary.