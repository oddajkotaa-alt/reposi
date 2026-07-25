# SkillClaw + Hermes Proxy Integration Notes

Use these notes when a user wants SkillClaw installed/activated for Hermes.

## Durable lessons

- SkillClaw is not just a passive skill pack. When active, it runs a local OpenAI-compatible proxy and may rewrite Hermes model routing so requests flow `Hermes -> SkillClaw proxy -> upstream model`.
- Treat activation as a config-changing integration, not a normal `hermes skills install` action.
- Always back up the active Hermes config before starting SkillClaw integration.
- Verify the active Hermes config location before assuming `~/.hermes/config.yaml`. Some Hermes deployments run with `HERMES_HOME` or a profile/workdir where the active config is elsewhere.
- SkillClaw's Hermes adapter expects `~/.hermes/config.yaml` and `~/.hermes/skills`. If the active Hermes setup uses another config/skills path, align paths deliberately after backup, then verify with `skillclaw doctor hermes`.
- A healthy `/healthz` only proves the proxy process is up. It does not prove the upstream model authentication works. Always test `/v1/chat/completions` or a short Hermes request before leaving Hermes pointed at the proxy.
- SkillClaw needs an upstream that behaves like an OpenAI-compatible API with API-key auth. Hermes providers that rely on OAuth/internal adapters (for example OpenAI Codex / ChatGPT backend auth) may not work when copied directly into SkillClaw, even if they work inside Hermes. Configure SkillClaw with OpenRouter, OpenAI API, or another standard API-key endpoint instead.
- If the upstream test fails, stop SkillClaw and restore the original Hermes model config immediately so the user's main Hermes remains usable.

## Safe activation sequence

1. Back up active Hermes config and SkillClaw config.
2. Confirm active Hermes config path and skills directory.
3. Configure SkillClaw for `claw_type=hermes`, existing skills dir, shared storage off for first run, and PRM off unless the user explicitly wants scoring/evolution cost.
4. Start SkillClaw daemon.
5. Check `skillclaw status` and `curl http://127.0.0.1:<port>/healthz`.
6. Run `skillclaw doctor hermes`.
7. Test the proxy with a minimal chat completion or `hermes chat -Q -m skillclaw-model -q ...`.
8. Only leave Hermes routed through SkillClaw if the real model call succeeds.
9. If it fails, restore backup and stop SkillClaw.
