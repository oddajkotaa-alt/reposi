# Docker volume path mismatch: Hermes vault vs host Syncthing

Use this when a Windows PC ↔ VPS Syncthing setup looks paired and “Up to Date,” but Obsidian/Hermes still do not see the same files.

## Symptom pattern

- Hermes/file tools see rich vault contents under `/opt/data/ObsidianVault`, e.g. `TikTok Shop/`, `Google Flow/`, `Hermes/`, `Prompt Examples/`.
- The user’s VPS SSH shell shows a different or nearly empty `/opt/data/ObsidianVault`, e.g. only `.obsidian`, `.stfolder`, and `Bez nazwy.md`.
- Syncthing is configured to sync `/opt/data/ObsidianVault` and reports that folder as current/up-to-date.

This means Syncthing is likely reading the host’s `/opt/data/ObsidianVault` while Hermes is reading a container-internal `/opt/data/ObsidianVault` backed by a Docker volume.

## Verify from VPS SSH shell

Ask the user to run:

```bash
docker ps
```

If there is a `nousresearch/hermes-agent:latest` container named `hermes-agent`, inspect mounts:

```bash
docker inspect hermes-agent | grep -A 20 '"Mounts"'
```

Look for a mount where:

```text
"Destination": "/opt/data"
```

The corresponding `Source` is the host-side data root. Example:

```text
"Source": "/var/lib/docker/volumes/b7c39575561de34eacce033f8462d5068ebb13f5a2ce0b53b301e357f1a4687d/_data",
"Destination": "/opt/data"
```

Then the real host-side Obsidian vault path is:

```text
/var/lib/docker/volumes/b7c39575561de34eacce033f8462d5068ebb13f5a2ce0b53b301e357f1a4687d/_data/ObsidianVault
```

Verify it:

```bash
ls -la /var/lib/docker/volumes/b7c395*/_data/ObsidianVault
```

Use a glob prefix when the volume ID is too long for the user to paste reliably. If the listing shows the folders Hermes sees, this is the correct path.

## Fix in Syncthing

In the **VPS Syncthing UI** (`http://127.0.0.1:8385` from the PC browser through SSH tunnel):

1. Open folder `ObsidianVault`.
2. Click `Edit` / `Edytuj`.
3. Change `Folder Path` from the host’s wrong path, e.g. `/opt/data/ObsidianVault`, to the Docker volume path discovered above.
4. Save.
5. If Syncthing asks to restart the folder, accept.
6. Run `Actions → Rescan`.

Do not delete the old host `/opt/data/ObsidianVault` during diagnosis. It may contain `.stfolder` or PC-created files; leave cleanup for after the user confirms sync works.

## Permissions note

Docker volume files may show numeric owner `10000 10000`. Do not immediately `chown -R` unless Syncthing reports a real permission error. First try changing the folder path and rescanning. If there is an access denied error, capture the exact Syncthing message before suggesting ownership changes.

## Communication pattern for this user

Keep steps short and location-labeled:

- “VPS SSH shell” for commands.
- “PC browser → VPS Syncthing 8385” for UI changes.
- Reassure that `Is a directory` after typing a path alone is normal; use `cd` to enter a directory and `ls -la <path>` to list it.
