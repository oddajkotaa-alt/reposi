# VPS noVNC / Google Flow / Telegram Gateway Recovery Pattern

Use when Google Flow is open in a VPS noVNC desktop, but a Telegram/gateway Hermes session cannot see the desktop or reports `computer_use` capture as empty/0x0.

## Symptoms

- noVNC/VNC desktop works for the user, but Telegram bot cannot continue Flow automation.
- Telegram/gateway session says it is running from a container or another Hermes instance and cannot see `DISPLAY=:1`.
- `computer_use` or cua-driver reports no usable screen from Telegram, while host-side `cua-driver health_report` passes.
- Multiple gateway processes are present, often one container gateway and one host/root gateway competing for the same Telegram token.

## Fix pattern

1. Verify the actual desktop session on the VPS host:
   - VNC display usually `:1`.
   - `XAUTHORITY=/home/flowdesk/.Xauthority`.
   - `cua-driver serve` should run as the desktop user (`flowdesk`) with the same DISPLAY/XAUTHORITY.

2. Stop the gateway that cannot see the desktop, but do not kill unrelated sessions unless needed:
   - For s6/container gateway, stop only the `gateway-default` service/process.
   - For host systemd gateway, stop the user gateway service if it was launched without DISPLAY/XAUTHORITY.

3. Start the gateway on the host with the same Hermes home/config as the user-facing bot, plus desktop env:

```bash
export HERMES_HOME=/root/hermes-host-data
export DISPLAY=:1
export XAUTHORITY=/home/flowdesk/.Xauthority
export PATH="/root/.local/share/uv/tools/hermes-agent/bin:/root/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
nohup /root/.local/share/uv/tools/hermes-agent/bin/hermes gateway run --replace >/root/host-hermes-gateway.log 2>&1 &
```

4. If host Hermes looks for the cua-driver socket under `$HERMES_HOME/home/.cache/...`, bridge it to the desktop user's socket:

```bash
mkdir -p /root/hermes-host-data/home/.cache
rm -rf /root/hermes-host-data/home/.cache/cua-driver
ln -s /home/flowdesk/.cache/cua-driver /root/hermes-host-data/home/.cache/cua-driver
```

5. Verify from a host Hermes chat that `computer_use` can capture before telling the user Telegram can continue.

## User-experience rule

If the user is stuck copy/pasting through noVNC and reports clipboard spacing corruption, stop giving long commands. Either take over via SSH after one short access-enabling step, or provide tiny single-line commands only. Prefer raw paste-host links (e.g. paste.rs raw response) over URL shorteners that may return HTML.
