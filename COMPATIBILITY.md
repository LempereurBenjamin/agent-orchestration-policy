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
5. The deployment can verify the effective provider/account, exact logical model,
   effort, and routing controls required by `model-routing.md`.
6. Each selected model/effort is supported by its effective account. Fallback requires
   a verified DeepSeek V4.1-Flash-1017 mapping, role effort and safe continuation.

The local Pi 1.4.0 catalogue lists the OpenAI model IDs and `deepseek/deepseek-flash`;
the CLI accepts `max`. Neither proves per-model effective effort or the deployed
DeepSeek version. The installed `pi-multi-account` documentation describes account
discovery and same-model-first rotation, but also broader failure/model failover,
optional automatic continuation and passive child modes. It does not establish the
quota-only, all-eligible-accounts gate and role-specific DeepSeek transition required
by this policy. Orca 1.4.242's worker-start contract has singular model/effort fields,
no ordered fallback list, and does not document Pi launch overrides. Its launch
validator requires an agent launch catalog; generic flags do not prove Pi binding.
The `pi-subagents` fallback list is not an Orca capability. Orca documents reading
worker output and retrying a failed task, but no reliably attributable quota verdict
for every eligible account is established. Automatic Pi worker fallback is unsupported
by the verified dispatch contract; Lead-controlled handoff remains unverified;
block affected work if enforcement and safe recovery cannot be established. No live
quota exhaustion or Orca integration test has been performed by this policy change.

Pi 1.5.0's locally installed catalogue lists `github-copilot/claude-opus-5.5`
and `github-copilot/claude-sonnet-5.5`. Its catalogue maps Opus medium/high
explicitly and the Anthropic adapter maps Sonnet medium/high to matching effort values;
both entries set `forceAdaptiveThinking`. This is local catalogue and adapter evidence,
not a live provider acceptance, account entitlement, effective effort, or Orca worker
binding verification. Other provider IDs or aliases require their own evidence.
`pi-multi-account` documents Anthropic aliases and same-model-first rotation, but its
broader switching and continuation behavior does not establish this policy's gates.
Pi documents active model and thinking level in session state, while virtual selections
can differ from the physical model answering. Resolve that distinction at admission.

## Verification on a target machine

```sh
pi --version
orca --version
pi list
pi --list-models
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
