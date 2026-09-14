# Compatibility contract

## Initial baseline

This bundle was prepared against Pi `0.85.1` and Orca `1.4.201` on macOS. These are
tested baseline versions, not a claim that every later version is compatible.

## Required capabilities

The policy is compatible only when the deployment provides all of the following:

1. Pi loads the global `~/.pi/agent/AGENTS.md` instruction file.
2. Pi discovers or explicitly loads the linked skill directory at
   `~/.pi/agent/skills/orchestration-policy/`.
3. Orca accepts `orca skills get orchestration --full` and provides the current
   installed orchestration guide before an Orca mutation.
4. Orca supports supervised worker dispatch, task/dispatch status inspection,
   lifecycle messaging, and recovery inspection required by the policy.
5. The deployment can verify the effective Pi provider, exact model, reasoning
   effort, and model-switch controls required by the selected routing profile.

If a required capability is absent, the affected work is blocked. The policy does
not authorize substituting a harness, provider, model family, or lifecycle mechanism.

## Verification on a target machine

```sh
pi --version
orca --version
test -f "$HOME/.pi/agent/skills/orchestration-policy/SKILL.md"
orca skills get orchestration --full
```

Record the Pi/Orca versions and the observed capability results with the objective
when the policy requires orchestration. Confirm runtime routing using the procedure
in `skills/orchestration-policy/references/model-routing.md`; requested CLI options
alone are not sufficient evidence.

## Compatibility changes

Any change to this contract, required capability, or installation layout is a
reviewed policy change. Test it against the affected Pi and Orca versions, update
this document, and preserve the prior bundle identity for active objectives.
