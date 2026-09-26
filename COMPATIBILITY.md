# Compatibility contract

## Initial baseline

This bundle was prepared against Pi `0.85.1` and Orca `1.4.201` on macOS. These are
tested baseline versions, not a claim that every later version is compatible.
Git-package registration was separately verified with Pi `0.87.1`; that check does
not establish supervised Orca dispatch compatibility.

## Required capabilities

The policy is compatible only when the deployment provides all of the following:

1. Pi loads the global `~/.pi/agent/AGENTS.md` instruction file.
2. Pi discovers the package-provided `orchestration-policy` skill through its Git
   package manifest, or discovers/explicitly loads a manual installation at
   `~/.pi/agent/skills/orchestration-policy/`. One bundle supplies the skill for
   each objective; package and manual copies are not mixed.
3. Orca accepts `orca skills get orchestration` and provides the compact,
   version-matched orchestration guide before an Orca mutation. At a conditional
   action gate, the deployment supports either targeted
   `--reference references/<file>.md` loading or the `--full` compatibility
   fallback documented by the installed guide.
4. Orca supports supervised worker dispatch, task/dispatch status inspection,
   lifecycle messaging, and recovery inspection required by the policy.
5. The deployment can verify the effective Pi provider, exact model, reasoning
   effort, and model-switch controls required by the selected routing profile.
6. For `deepseek-flash`, Pi exposes the exact direct-API route
   `deepseek/deepseek-flash` (DeepSeek V4.1 Flash) with supported low and high
   reasoning efforts for every model-backed role, including Lead and Reviewer.

If a required capability is absent, the affected work is blocked. The policy does
not authorize substituting a harness, provider, model family, or lifecycle mechanism.

## Verification on a target machine

```sh
pi --version
orca --version
pi list
pi --list-models deepseek
orca skills get orchestration
```

For a manual installation, also check
`~/.pi/agent/skills/orchestration-policy/SKILL.md`. Pi Git package installation
does not merge or replace the global `~/.pi/agent/AGENTS.md`; review and merge it
separately. Record the Pi/Orca versions and observed capability results with the
objective when the policy requires orchestration. Confirm runtime routing using the procedure
in `skills/orchestration-policy/references/model-routing.md`; requested CLI options
alone are not sufficient evidence.

Keep the DeepSeek API key in local Pi credential configuration. Never add it, other
credentials, request payloads, or session output to this repository.

## Compatibility changes

Any change to this contract, required capability, or installation layout is a
reviewed policy change. Test it against the affected Pi and Orca versions, update
this document, and preserve the prior bundle identity for active objectives.
