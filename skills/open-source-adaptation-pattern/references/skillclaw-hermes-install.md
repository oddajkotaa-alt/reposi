# SkillClaw ↔ Hermes install notes

Use when a user asks to install AMAP-ML/SkillClaw or similar skill-evolution/proxy integrations for Hermes.

## What SkillClaw is

SkillClaw is not a single Hermes `SKILL.md`; it is a Python package plus local proxy/service that can integrate with Hermes and manage/evolve the Hermes skills directory. Its setup can rewrite Hermes config to point model traffic through the SkillClaw proxy, so treat setup/start as a larger integration step, not just a harmless skill install.

## Safe install pattern used

1. Clone/update the repo into a dedicated directory, e.g. `/opt/data/SkillClaw`.
2. Read `README.md`, `scripts/install_skillclaw.sh`, and `pyproject.toml` before running anything.
3. Install into its own venv from the repo:
   ```bash
   cd /opt/data/SkillClaw
   bash scripts/install_skillclaw.sh --extras evolve,sharing,server
   ```
4. Add a small launcher if the venv binary is not on PATH:
   ```bash
   mkdir -p ~/.local/bin
   cat > ~/.local/bin/skillclaw <<'SH'
   #!/usr/bin/env bash
   exec /opt/data/SkillClaw/.venv/bin/skillclaw "$@"
   SH
   chmod +x ~/.local/bin/skillclaw
   ```
5. Verify without changing Hermes config:
   ```bash
   skillclaw --help
   skillclaw status
   /opt/data/SkillClaw/.venv/bin/python - <<'PY'
   import importlib.metadata as m
   print(m.version('skillclaw'))
   PY
   ```

## Boundary before setup

Do **not** automatically run `skillclaw setup` or `skillclaw start --daemon` in a beginner/user-owned Hermes setup unless the user explicitly agrees. `skillclaw setup` asks for provider/model, agent integration, skills directory, shared storage, and PRM/evolution settings; choosing Hermes can cause SkillClaw to rewrite `~/.hermes/config.yaml` to use the local proxy.

Suggested safe defaults to explain before setup:

- CLI agent: `hermes`
- local skills directory: Hermes skills folder
- shared storage: disabled initially
- PRM/evolution: disabled initially for cheapest first pass
- run local-only first; add shared/evolve server later if needed

## Reporting style for this user

Say clearly what was installed, where it lives, and what was verified. Separate “installed package” from “configured integration” so the user understands that setup/start is a second step.