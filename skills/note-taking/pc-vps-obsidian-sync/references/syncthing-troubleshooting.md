# Syncthing troubleshooting for PC ↔ VPS Obsidian

Use this reference when a Windows PC Obsidian vault is synced with a Hermes/VPS markdown vault using Syncthing.

## Address rules

- `http://127.0.0.1:8384` = Syncthing GUI on the current machine.
- If Windows opens the tunnel:
  ```bash
  ssh -L 8385:127.0.0.1:8384 root@VPS_IP
  ```
  then `http://127.0.0.1:8385` must be opened in the **Windows PC browser**, not in the VPS/noVNC browser.

## Device setup rules

- `Actions → Show ID` only displays the current device's long Device ID.
- Add devices under `Remote Devices → Add Remote Device`.
- The friendly name (`My PC`, `Hermes VPS`) belongs in the Device Name field.
- The long ID belongs in Device ID.
- Do not type a friendly name into lock/password/encryption fields.

## Encryption consistency error

Error:

```txt
Failed to verify encryption consistency ... remote expects to exchange plain data, but is configured to be encrypted
```

Cause: one side was configured as encrypted/receive-encrypted while the other expects plain files.

Fix:

1. On the PC Syncthing GUI, remove the bad `ObsidianVault` folder from Syncthing configuration only.
2. If asked whether to delete files from disk, choose **No**.
3. On the VPS Syncthing GUI, edit the shared folder and clear any lock/encryption password field in Sharing.
4. Re-share the folder to the PC.
5. Accept on PC as normal Send & Receive/plain files.
6. Do not use encrypted receive for Obsidian because Obsidian needs readable `.md` files.

## Up to Date but Obsidian shows empty vault

Symptom: Syncthing says “Aktualny / Up to Date,” but Obsidian or File Explorer only shows `.obsidian` and an empty Untitled note.

Check in this order:

1. PC Syncthing → folder details → exact Folder Path. Open this exact path in File Explorer and Obsidian.
2. PC and VPS Folder ID must match.
3. Compare Global State / Local State file counts on both sides.
4. Run Rescan on both sides.
5. On the VPS Linux shell where Syncthing runs, verify the vault files:
   ```bash
   ls -la /opt/data/ObsidianVault
   whoami
   pwd
   ```
6. If Hermes sees files under `/opt/data/ObsidianVault` but the VPS shell/Syncthing sees only a few files, Hermes and Syncthing are likely in different environments/containers or using different mounts. Sync the folder visible to Hermes or run Syncthing in the same environment.

## Beginner phrasing

When the user is stuck, switch from long instructions to one checkpoint at a time. In Polish, keep it direct, e.g.:

- “Otwórz to w przeglądarce na PC, nie w VPS browser.”
- “Nie wpisuj `My PC` w pole z kłódką — to jest szyfrowanie.”
- “Usuń tylko konfigurację folderu w Syncthing, nie pliki z dysku.”
