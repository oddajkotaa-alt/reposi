# Google Flow on Contabo VPS via noVNC: session notes

Context: user wanted a Contabo VPS browser desktop for Google Flow, opened through noVNC in a normal browser. They are beginner-level with VPS/Linux.

Observed pattern:

- User expected Hermes to be root, but the active agent shell was user `hermes` and apt failed with permission denied. The user then used their own root SSH session.
- A script path created in the agent environment (`/opt/data/...`) was not visible/usable in the user's root shell, so the better approach is to have the user create `/root/setup-google-flow-novnc.sh` directly or paste small command chunks.
- User got confused when heredoc paste produced no visible output. Explain that the shell is waiting for the final `EOF` line.
- User hit apt update failure from Docker Ubuntu noble repo missing key: `NO_PUBKEY 7EA0A9C3F273FCD8`.

Useful beginner wording:

- “If it shows nothing, that is OK. Linux often means success by saying nothing.”
- “Only stop if you see words like error, failed, No such file, or Permission denied.”
- “Do not send me your password or Google 2FA code.”

Docker key repair commands used:

```bash
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
rm -f /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
sed -i 's|deb https://download.docker.com/linux/ubuntu|deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu|g' /etc/apt/sources.list.d/*.list
apt-get update
```

Fallback if Docker repo is not needed and still blocks setup:

```bash
mv /etc/apt/sources.list.d/docker.list /etc/apt/sources.list.d/docker.list.disabled
apt-get update
```
