User's VPS Google Flow setup uses noVNC/websockify on port 6080 connected to TigerVNC display :1 as user flowdesk; Google Chrome is available at /usr/bin/google-chrome and works for Flow, while Snap Chromium caused VNC launch errors.
§
For VPS commands, label SSH/VPS Linux vs local Windows Terminal; user may otherwise paste Linux paths locally.
§
User has an Obsidian vault at /opt/data/ObsidianVault; for TikTok Shop slideshow/faceless video tasks, especially “recreate this slideshow/image” or reference-to-prompt work, check relevant vault notes first: TikTok Shop/Recreate Slideshow Workflow.md, TikTok Shop/Style Rules.md, and Prompt Examples.
§
For TikTok Shop image/slideshow generation, user may choose API for convenience, but wants Google Flow/noVNC when API cost matters; test Flow automation with reset/simplified UI before saving workflows.
§
For book/Telegram Flow slideshows, never use old/DO_NOT_USE refs. Use approved set /opt/data/product_references/books-current-10 for those exact books, selecting 5 or 10 as requested; check Obsidian before prompts when asked.
§
User's VPS currently has ~4 vCPU AMD EPYC, 7.8GB RAM, no NVIDIA GPU/no nvidia-smi, ~122GB free disk; suitable only for small CPU text models (e.g., Qwen/Phi/Gemma ~1.5B–4B GGUF), not local image/video generation.
§
User wants an Obsidian + LLM Wiki second brain synced PC↔VPS via Syncthing; prefers video-style automation: auto-save clearly useful chat knowledge, ingest raw folder, lint/backup; avoid Honcho unless needed.
§
Hermes can read synced Obsidian at `/opt/data/ObsidianVault`; host/VPS Syncthing path `/mnt/hermes-obsidian-vault`; Windows path `C:\Users\Admin\Documents\ObsidianVault`. User treats setup as editable.
§
User’s active Hermes/Telegram setup should use Docker container `hermes-agent` with `HERMES_HOME=/opt/data`; Telegram images should land in `/opt/data/cache/images`. Avoid/disable old root host gateway `/root/.local/share/uv/tools/hermes-agent/bin/hermes gateway run` and old `/root/hermes-host-data`, which caused duplicate bot/image-cache mismatch. User struggles with VPS/noVNC recovery; prefer direct checks and concise pasteable commands.