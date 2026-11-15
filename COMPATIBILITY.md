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
   a verified provider-advertised DeepSeek V4.1 Flash identity, role effort and safe
   continuation; an unpublished minor snapshot is not by itself a blocker.

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

Keep provider API keys in local Pi credential configuration. Never add credentials,
request payloads, or session output to this repository.

## Compatibility changes

Any change to this contract, required capability, or installation layout is a
reviewed policy change. Test it against the affected Pi and Orca versions, update
this document, and preserve the prior bundle identity for active objectives.

## Goal and profile compatibility

`@narumitw/pi-goal` 0.54.15 is the reference target, not a verified installation
or compatibility claim. Single Goal lifecycle, `goal_wait` wake-up from an Orca
worker, and continuation between tickets are **UNVERIFIED** until supervised on the
target installation. Do not wait without an established external wake source.
The `sol-terra` and `sol-deepseek` tables specify intended routing; neither a model
catalogue nor requested effort proves effective provider/account/model/effort. Verify
these for each deployed Pi/Orca combination. Runtime smoke tests and independent Sol
review binding are not established by static policy scenarios. Normal Pi/Orca use
without pi-goal remains supported under the existing capability requirements above.

## Subscription-first routing verification (2026-11-15)

These are source/CLI checks, not live execution proof. No credentials, provider
settings, privacy controls or billing settings were changed; no provider inference
smoke test ran.

| Capability | Evidence and status |
| --- | --- |
| Claude subscription via official CLI | [Claude Code authentication](https://code.claude.com/docs/en/authentication) documents subscription login and `/status`; API credentials can select different billing. The official CLI was not found on the inspected shell PATH. Local login, subscription entitlement and effective billing are **UNVERIFIED**. Pi Anthropic API/OAuth is not a substitute for subscription authentication. |
| Claude exact version and effort | [Model configuration](https://code.claude.com/docs/en/model-config) documents Sonnet/Opus 5.5 and medium/high effort; aliases, effort caps and automatic fallback can change the effective result. Preserve the existing role table and resolve provider-specific IDs to its exact versions. Local version/effort binding and fallback controls are **UNVERIFIED**. |
| Orca official Claude worker | Installed Orca `1.4.257` worker-start help documents Claude model/effort overrides. Its runtime reports `not_running`; no official CLI worker, lifecycle or recovery smoke test ran. CLI support is documented; subscription-backed execution is **UNVERIFIED**. |
| Pi OpenCode Go provider | Installed Pi `1.1.0` includes `opencode-go/deepseek-v4.1-flash`, `openai-completions`, the `https://opencode.ai/zen/go/v1` base URL, and low/high thinking mappings. Its adapter emits DeepSeek thinking/effort and adds `x-opencode-session` when supplied a session ID. [OpenCode's Pi guide](https://opencode.ai/docs/console/harnesses/pi/) documents the Go provider; [Go docs](https://opencode.ai/docs/console/go/) list Pi as a validated client and publish the newer inference endpoint. Acceptance of the installed endpoint, actual session headers, account entitlement and effective effort are **UNVERIFIED**. |
| DeepSeek identity and snapshot disclosure | [DeepSeek Platform's model table](https://api-docs.deepseek.com/quick_start/pricing/) maps `deepseek-flash` to DeepSeek-V4.1-Flash-1017. Go lists `deepseek-v4.1-flash`, but the inspected Go documentation/catalogue does not establish its exact 1017 snapshot. Exact snapshot equivalence remains **UNVERIFIED** and is not required for standard development orchestration: verify the provider-advertised V4.1 Flash identity and effective runtime binding, record the snapshot or unknown, and accept possible minor-snapshot behavioral differences. Missing snapshot disclosure alone is not a blocker; an explicit task pin still applies. |
| Orca Pi worker and provider failover | Orca `1.4.257` still has singular model/effort fields, no ordered fallback list, and no documented Pi launch overrides. Neither Go binding nor Go-to-Platform failover was exercised. Automatic Pi provider failover and Lead-controlled handoff remain **UNVERIFIED**; existing unsupported automatic Pi model/family fallback limitations remain. |
| Privacy and billing eligibility | Go documents workspace region restrictions for DeepSeek and a monthly ZDR agreement (currently through 2026-11-30), plus optional Extra Usage charging a PAYG balance. Recheck these terms at dispatch. Claude subscription privacy depends on plan and data controls ([data usage](https://code.claude.com/docs/en/data-usage)); it is not API privacy equivalence. Actual workspace/data eligibility, current ZDR coverage and authorized billing for Go extra usage or DeepSeek Platform PAYG are **UNVERIFIED**. Never infer authorization from credentials or credit. |

Provider failover preserves the authorized logical model and effort, with the DeepSeek
snapshot allowance above, and follows the Go quota/unavailability plus authorized-billing
gate in `model-routing.md`. Other model/version requirements remain unchanged.
Model/family fallback retains its separate all-eligible-accounts quota gate.
Neither a privacy denial nor a generic error proves provider unavailability; neither
transition changes profiles, objective state, budgets, contracts or candidates.
Static policy checks cannot establish live routing or Orca worker compatibility.
