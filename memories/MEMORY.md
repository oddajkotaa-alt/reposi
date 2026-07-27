User's VPS Google Flow setup uses noVNC/websockify on port 6080 connected to TigerVNC display :1 as user flowdesk; Google Chrome is available at /usr/bin/google-chrome and works for Flow, while Snap Chromium caused VNC launch errors.
§
For VPS setup commands, explicitly state whether to run them inside the SSH/VPS Linux shell vs the user's local Windows Terminal; user may otherwise paste Linux-only paths locally.
§
User has an Obsidian vault at /opt/data/ObsidianVault; for TikTok Shop slideshow/faceless video tasks, especially “recreate this slideshow/image” or reference-to-prompt work, check relevant vault notes first: TikTok Shop/Recreate Slideshow Workflow.md, TikTok Shop/Style Rules.md, and Prompt Examples.
§
For TikTok Shop slideshow recreation: after creating prompts from reference images using the Obsidian workflow, the user wants Hermes to use Google Flow/Nano Banana Pro to generate the images when requested, not stop at prompt drafting.
§
For book/Telegram Flow slideshows, never use old/DO_NOT_USE refs. Use approved set /opt/data/product_references/books-current-10 for those exact books, selecting 5 or 10 as requested; check Obsidian before prompts when asked.
§
User's VPS currently has ~4 vCPU AMD EPYC, 7.8GB RAM, no NVIDIA GPU/no nvidia-smi, ~122GB free disk; suitable only for small CPU text models (e.g., Qwen/Phi/Gemma ~1.5B–4B GGUF), not local image/video generation.
§
User wants an Obsidian + LLM Wiki second brain synced PC↔VPS via Syncthing; prefers video-style automation: auto-save clearly useful chat knowledge, ingest raw folder, lint/backup; avoid Honcho unless needed.
§
Hermes can read synced Obsidian at `/opt/data/ObsidianVault`; host/VPS Syncthing path `/mnt/hermes-obsidian-vault`; Windows path `C:\Users\Admin\Documents\ObsidianVault`. User treats setup as editable.
§
User has difficulty copying VPS/noVNC commands: may press Ctrl+C accidentally, noVNC clipboard corrupts/truncates text and can insert/remove spaces. Prefer doing VPS work directly via SSH when available; otherwise use very short manually typed commands or tiny bootstrap scripts, and restore exact last instructions after interruptions.