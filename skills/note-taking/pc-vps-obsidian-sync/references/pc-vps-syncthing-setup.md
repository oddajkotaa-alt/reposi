# PC ↔ VPS Syncthing setup reference

Use this reference for Syncthing setup between Windows PC Obsidian and a Hermes VPS vault.

## Known-good mental model

```text
PC Syncthing GUI:  http://127.0.0.1:8384  opened in PC browser
VPS Syncthing GUI: http://127.0.0.1:8385  opened in PC browser through SSH tunnel
VPS vault folder:  /opt/data/ObsidianVault
PC vault folder:   C:\Users\NAME\Documents\ObsidianVault
```

The `8385` URL is not meant for the VPS browser when the tunnel was created in Windows. It is a Windows-local tunnel endpoint.

## Setup sequence

1. Start Syncthing on PC and verify PC GUI at `http://127.0.0.1:8384`.
2. SSH to VPS and install/start Syncthing there.
3. In a second Windows terminal, run:
   `ssh -L 8385:127.0.0.1:8384 root@VPS_IP`
4. Verify VPS GUI in PC browser at `http://127.0.0.1:8385`.
5. On PC GUI, `Actions → Show ID`; copy the long Device ID.
6. On VPS GUI, `Add Remote Device`; paste PC Device ID; name `My PC`.
7. On VPS GUI, `Actions → Show ID`; copy VPS Device ID.
8. On PC GUI, `Add Remote Device`; paste VPS Device ID; name `Hermes VPS`.
9. Wait until devices connect.
10. On VPS GUI, edit folder `/opt/data/ObsidianVault`, Sharing tab, check PC device, Save.
11. On PC GUI, accept the folder invite and choose the local Obsidian vault path.
12. Open the local path in Obsidian.

## UI labels and Polish equivalents

- Remote Devices = Urządzenia zdalne
- Add Remote Device = Dodaj urządzenie zdalne
- Folders = Foldery
- Add Folder = Dodaj folder
- Edit = Edytuj
- Sharing = Współdzielenie
- Save = Zapisz
- Remove = Usuń
- Disconnected = Rozłączone
- Connected = Połączone

## Common mistake: typing a label in the wrong place

If the user typed `My PC` in a folder Sharing field or got a device named `Actions → Show ID`, do not panic.

- If it appears as a checkbox in folder Sharing, it may be the device label. Check it and save.
- If no folder invite appears and devices stay disconnected, remove the bad remote device on both GUIs and re-add using actual long Device IDs.

## Safe reset for disconnected devices

Use when both sides show disconnected and no folder invite appears.

1. On PC GUI (`8384`), remove the disconnected/incorrect remote device.
2. On VPS GUI (`8385`), remove the disconnected/incorrect remote device.
3. Re-add using the exact sequence: PC ID → VPS, then VPS ID → PC.
4. Wait 30–60 seconds and refresh both GUIs.
5. Share the VPS vault folder again.

Removing a Syncthing remote device removes only the pairing, not the Obsidian files. Still reassure the user before the step.

## If accepting a folder “disconnects” the user

Determine what disconnected:

- Does PC GUI `8384` still open?
- Does VPS GUI `8385` still open? If not, restart the Windows SSH tunnel.
- Does the PC now show `ObsidianVault` under Folders?
- Are devices still disconnected or syncing?

Ask these as short yes/no questions instead of giving a full reset immediately.
