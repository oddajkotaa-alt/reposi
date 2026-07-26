---
name: pc-vps-obsidian-sync
description: Set up and troubleshoot Windows PC Obsidian syncing with a Hermes VPS vault using Syncthing; use for PC↔VPS Obsidian connection, Syncthing device pairing, 127.0.0.1 tunnel confusion, and beginner sync troubleshooting.
platforms: [linux, windows]
---

# PC ↔ VPS Obsidian Sync

Use this skill when the user wants to connect Obsidian on a Windows PC to a vault that Hermes reads/writes on a VPS.

Goal:

```text
Windows PC Obsidian folder ↔ Syncthing ↔ VPS vault folder used by Hermes
```

Typical VPS vault path for this user is `/opt/data/ObsidianVault`, but verify before acting.

## Beginner workflow

1. **Label locations clearly.** Say whether each step is done on the Windows PC, Windows CMD/PowerShell, the VPS SSH shell, or the PC browser.
2. **PC Syncthing:** start Syncthing on Windows and open in the PC browser:
   `http://127.0.0.1:8384`
3. **VPS Syncthing:** install/start Syncthing on the VPS. It listens on the VPS at `127.0.0.1:8384`.
4. **Tunnel from Windows:** in a separate Windows CMD/PowerShell window:
   `ssh -L 8385:127.0.0.1:8384 root@VPS_IP`
5. **Open VPS GUI from PC browser:**
   `http://127.0.0.1:8385`
6. **Pair devices both ways** using long Device IDs.
7. **Share only the main vault folder** from VPS, e.g. `/opt/data/ObsidianVault`. Do not separately share subfolders like `LLM Wiki`; subfolders sync automatically.
8. **Accept folder on PC** and choose a local path like `C:\Users\NAME\Documents\ObsidianVault`.
9. **Open local folder in Obsidian** via “Open folder as vault”.

## Explain localhost every time

For this class of task, beginners often open the URL in the wrong browser.

- `127.0.0.1:8384` in the **PC browser** = PC Syncthing.
- `127.0.0.1:8385` in the **PC browser** = VPS Syncthing through the SSH tunnel.
- Opening `127.0.0.1:8385` inside the **VPS browser** usually means “the VPS itself” and will not show the Windows-created tunnel.

## Device ID vs device name pitfall

Syncthing pairing requires the long Device ID, not a friendly label.

- `Actions → Show ID` only displays/copies the current device’s long ID. Do not type into this screen.
- `Add Remote Device` is where the long Device ID is pasted.
- A label like `My PC` belongs only in `Device Name`.
- Folder `Edit → Sharing` should show device checkboxes. If there is no checkbox, the remote device has not been added correctly yet.

If the user accidentally names a device something odd like `Actions → Show ID`, it can still work. Rename later under `Remote Devices → Edit → Device Name` rather than restarting everything.

## If devices show disconnected or folder invite does not appear

Use the safe reset pattern from `references/pc-vps-syncthing-setup.md`.

Important: removing a remote device from Syncthing removes the pairing only; it does not delete Obsidian files. Still reassure the user before removal.

## Troubleshooting style

When the user is confused, do not repeat a long full setup. Switch to one or two steps at a time. If the user asks in Polish or says Polish is easier, continue in concise Polish.

Ask for exact visible labels/status such as:

```text
Czy działa 8384? Tak/Nie
Czy działa 8385? Tak/Nie
Czy urządzenie jest Connected/Disconnected?
Czy folder ObsidianVault jest w Folders?
```

## Related skills

- `obsidian` for reading/writing vault files once sync is set up.
- `llm-wiki` for creating a structured long-term wiki inside the synced vault.
