# Docker Hermes + Host Syncthing Obsidian mismatch

Use when PC/VPS Syncthing appears correctly paired but Obsidian files seen by Hermes differ from files seen in the VPS SSH shell.

## Symptom pattern

- Hermes file tools see notes under `/opt/data/ObsidianVault` such as `TikTok Shop`, `Google Flow`, `Hermes`, `Prompt Examples`.
- VPS SSH shell as `root` sees `/opt/data/ObsidianVault` as mostly empty, often only `.obsidian`, `.stfolder`, or a new untitled note.
- Syncthing on the VPS host says the folder is up to date but only counts a few files.
- `docker ps` shows `nousresearch/hermes-agent:latest` / `hermes-agent` running.

## Root cause

The active Hermes chat may be inside Docker. The path `/opt/data/ObsidianVault` inside the container is not the same path as `/opt/data/ObsidianVault` on the VPS host. Host Syncthing is syncing the host folder while Hermes is writing the Docker volume.

Flow/noVNC/Chrome can still be host-side at the same time; that does not prove Hermes chat is host-side. Browser automation may have been moved to the host while the active Hermes agent remains Dockerized.

## Diagnostics

From the VPS SSH shell:

```bash
docker ps
docker inspect hermes-agent | grep -A 20 '"Mounts"'
```

Find the mount whose `Destination` is `/opt/data`. Its `Source` is the host-side data directory. The real vault is:

```text
<SOURCE>/ObsidianVault
```

Verify with a short glob if copying the long volume ID is unreliable:

```bash
ls -la /var/lib/docker/volumes/b7c395*/_data/ObsidianVault
```

Only use a glob after it has been verified to match the intended Docker volume.

## Safe backup before changing Syncthing

For paste-fragile noVNC/browser sessions, avoid long paths and use short verified globs:

```bash
mkdir -p /root/hermes-backups
tar -czf /root/hermes-backups/obsidian-vault-before-syncthing-reset.tar.gz -C /var/lib/docker/volumes/b7c395*/_data ObsidianVault
ls -lh /root/hermes-backups/obsidian-vault-before-syncthing-reset.tar.gz
```

Successful `mkdir -p` and `tar` may print nothing; tell the user this is normal and verify with `ls -lh`.

## Short path for Syncthing

If the user cannot paste the long Docker volume path into Syncthing, create a bind mount:

```bash
mkdir -p /mnt/hermes-obsidian-vault
mount --bind /var/lib/docker/volumes/<verified-volume>/_data/ObsidianVault /mnt/hermes-obsidian-vault
ls -la /mnt/hermes-obsidian-vault
```

Then in VPS Syncthing:

1. Remove the wrong `ObsidianVault` folder from Syncthing configuration only.
2. Do **not** select any option like “delete files from disk”.
3. Add folder again.
4. Use `Folder Path` = `/mnt/hermes-obsidian-vault`.
5. Share it with the PC device.

## Communication notes for this user

- Use Polish if the setup gets confusing.
- Give one or two commands at a time.
- Avoid long copied paths; use variables, verified globs, or bind mounts.
- Clearly label: VPS SSH shell vs PC browser Syncthing vs VPS Syncthing through `127.0.0.1:8385`.
