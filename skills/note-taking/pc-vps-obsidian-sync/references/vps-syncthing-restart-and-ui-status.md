# VPS Syncthing restart and UI status troubleshooting

Session-derived notes for Windows PC ↔ VPS Obsidian sync via Syncthing.

## Symptoms

- After VPS restart, Windows tunnel URL such as `http://127.0.0.1:8385` does not load.
- User has a Dockerized Hermes environment, so checking `systemctl` from inside Hermes can fail or inspect the wrong namespace.
- VPS Syncthing folder details do not literally say “Up to Date”; Polish UI shows counts instead.
- Test note appears gray/white rather than blue, causing user to think sync is wrong.

## Durable fix pattern

Run these in the **VPS SSH shell** where the prompt is like `root@vmi3420187:~#`:

```bash
systemctl status syncthing@root --no-pager
```

If status shows inactive/disabled:

```bash
systemctl enable syncthing@root
systemctl start syncthing@root
systemctl status syncthing@root --no-pager
```

Success indicators:

```text
Loaded: ... enabled
Active: active (running)
```

Then verify local web UI on VPS:

```bash
curl -I http://127.0.0.1:8384
```

Success indicators:

```text
HTTP/1.1 200 OK
```

or:

```text
HTTP/1.1 302 Found
```

If VPS local UI works but PC browser still fails, debug only the Windows SSH tunnel. Use an alternate local port if needed:

```bash
ssh -L 8390:127.0.0.1:8384 root@VPS_IP
```

Open on Windows PC browser:

```text
http://127.0.0.1:8390
```

## Interpreting Syncthing folder details

In Polish Syncthing UI, detail rows like this are healthy:

```text
Stan globalny   14  6  ~30,5 KiB
Stan lokalny    14  6  ~30,5 KiB
Rodzaj folderu  Wyślij i odbierz
Współdzielony z My PC
```

Equal global/local counts mean the local VPS folder matches the global folder state, even if the UI does not display the exact words “Up to Date”.

## File vs folder color confusion

A Markdown note such as `PC Sync Test.md` is a file, not a folder. It may appear gray/white while folders appear blue. That is normal.

If `cat` fails but the user says they can see the note, find the exact path/name first:

```bash
find /mnt/hermes-obsidian-vault -type f
```

Then quote the exact full path returned:

```bash
cat "/mnt/hermes-obsidian-vault/path/from/find/PC Sync Test.md"
```

Avoid guessing paths when spaces or subfolders are involved.
