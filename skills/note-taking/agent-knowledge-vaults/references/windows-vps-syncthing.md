# Windows PC ↔ VPS Obsidian Vault via Syncthing

Use this when a beginner user wants their local Windows Obsidian app to use the same vault that Hermes reads/writes on a Linux VPS.

## Mental model

- Obsidian is only the viewer/editor for a folder of Markdown files.
- Hermes edits the vault files directly on the VPS.
- Syncthing keeps the Windows folder and VPS folder synchronized.
- Do not use the VPS/noVNC browser for Syncthing URLs unless the URL is explicitly for the VPS itself.

Typical target:

```text
Windows PC Obsidian folder
  ↕ Syncthing
VPS: /opt/data/ObsidianVault
  ↕ Hermes file tools
```

## Beginner setup sequence

1. On Windows, run `syncthing.exe` or SyncTrayzor.
   - PC dashboard: `http://127.0.0.1:8384`
   - If the user downloaded a zip/folder, have them open the folder and double-click `syncthing.exe`; keep the black console window open.

2. On the VPS Linux shell, install and start Syncthing:

```bash
apt update
apt install -y syncthing
syncthing
```

If not root, use `sudo` before `apt` commands.

3. From Windows, create an SSH tunnel to the VPS dashboard:

```bash
ssh -L 8385:127.0.0.1:8384 root@YOUR_VPS_IP
```

Use the actual SSH user if it is not `root`.

4. Open the VPS dashboard in the **Windows PC browser**, not the VPS browser:

```text
http://127.0.0.1:8385
```

5. Pair devices by copying each Syncthing Device ID into the other dashboard.

6. Share the VPS vault folder to the PC:

```text
Folder Label: ObsidianVault
Folder ID: obsidian-vault
Folder Path: /opt/data/ObsidianVault
```

7. Accept the share on Windows and choose a local folder such as:

```text
C:\Users\YOUR_WINDOWS_NAME\Documents\ObsidianVault
```

8. In Obsidian on Windows, choose **Open folder as vault** and select that synced folder.

## Common beginner confusion

### `127.0.0.1` means “this computer”

- `http://127.0.0.1:8384` in Windows browser = Windows Syncthing dashboard.
- `http://127.0.0.1:8385` in Windows browser = tunneled VPS Syncthing dashboard.
- Opening `http://127.0.0.1:8385` inside the VPS browser usually fails because the SSH tunnel is on the Windows PC, not inside the VPS browser.

### Windows CMD vs VPS shell

Before SSH, Windows shows a prompt like:

```text
C:\Users\Name>
```

Do not run Linux `apt` commands there. First SSH:

```bash
ssh root@YOUR_VPS_IP
```

After login, the VPS prompt usually looks like:

```text
root@server:~#
```

Run Linux install/start commands there.

### SSH password appears invisible

When SSH asks for a password, typed characters do not show as dots. The user should type the password and press Enter.

### If `root@IP` fails

Try the provider’s actual username (`ubuntu`, `debian`, `admin`, `hermes`, etc.) or check whether the VPS requires an SSH key instead of password login. Never ask the user to paste their password.

## Safety

- Do not sync API keys/secrets into Obsidian.
- Avoid editing the same note from Hermes and PC Obsidian at the exact same time; Syncthing may create conflict files.
- For GitHub backups, require explicit user approval and a private repository if private notes may be included.
