# Hermes Synced Obsidian Vault Workflow

Session-derived pattern for the user's PC ↔ VPS ↔ Hermes Obsidian setup.

## Goal

Make a Windows Obsidian vault readable and writable by Hermes through VPS Syncthing, while keeping notes review-first and avoiding raw automatic dumps.

## Paths verified in session

- Windows Obsidian vault: `C:\Users\Admin\Documents\ObsidianVault`
- VPS/host synced folder: `/mnt/hermes-obsidian-vault`
- Hermes/container easy path: `/opt/data/ObsidianVault`
- Hermes env convention set in `.hermes/.env`: `OBSIDIAN_VAULT_PATH=/opt/data/ObsidianVault`

## Syncthing checks that proved sync worked

On the VPS host, Syncthing needed to be running and enabled:

```bash
systemctl enable syncthing@root
systemctl start syncthing@root
systemctl status syncthing@root --no-pager
```

Good status contained:

```txt
Loaded: ... enabled
Active: active (running)
```

Panel check on VPS:

```bash
curl -I http://127.0.0.1:8384
```

Good output contained `HTTP/1.1 200 OK`.

Windows SSH tunnel to view VPS Syncthing locally:

```bash
ssh -L 8390:127.0.0.1:8384 root@62.171.164.30
```

Then open:

```txt
http://127.0.0.1:8390
```

If an old port is stuck, use another local port such as `8390` instead of `8385`.

## File sync verification pattern

1. Create a note in Windows Obsidian, e.g. `hello from PC`.
2. Add body text, e.g. `test sync 123`.
3. In Hermes/container, verify with file tools at `/opt/data/ObsidianVault/hello from PC.md`.
4. If a read prints no content but no error, the note may exist but be empty; add body text and retry.

## Second-brain bootstrap created in session

- `Home.md` as the main entry point.
- `Templates/Session Summary Template.md`
- `Templates/Prompt Template.md`
- `Templates/Workflow Template.md`
- `Hermes/README.md` updated to describe the vault structure.

## Review-first saving rule

Use `Inbox/Review Before Saving.md` for proposed or uncertain long-term notes. Only move information into permanent notes once the user has approved it.
