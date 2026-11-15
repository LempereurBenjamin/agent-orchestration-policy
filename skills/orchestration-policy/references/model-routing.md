# Model routing

This shared policy owns family selection, binding, rotation, fallback, and verification
for new objectives. An active objective remains pinned to its recorded policy bundle until explicitly migrated under
`recovery-and-learning.md`. Editing routing policy does not reroute the current run.

## Objective admission and family

At admission read the effective model/provider from the actual Pi Lead session, not
the prompt, author, previous objective, or configured default. Pi documents the active
selection and effective thinking level through session state; RPC `get_state` and
extension `ctx.model` / `ctx.thinkingLevel` are available where applicable. Session
`model_change` entries identify selections; virtual selections may differ from the
physical model recorded on assistant messages. Resolve the effective initial model's
identity using authoritative session and model evidence before classification.
The resolved effective logical model ID takes precedence over a virtual or model-alias
selection. If it cannot be resolved and verified, report `PI_ROUTING_BLOCKED`.

The normalized IDs `claude-opus-5.5` and `claude-sonnet-5.5` select Anthropic.
For example, `github-copilot/claude-opus-5.5` selects Anthropic, and
`github-copilot/claude-sonnet-5.5` selects Anthropic. The same applies to equivalent
verified provider aliases resolving to those exact IDs; the provider/account alias
does not determine the family. These mappings do not establish route availability.

An initial OpenAI model selects OpenAI routing; an initial Anthropic model selects
Anthropic routing. Classify model identity, not a provider alias: account aliases may
represent the same family. If identity or family cannot be established, report
`PI_ROUTING_BLOCKED`; do not default an unknown model to either family. Record the
selected family, initial model, effective provider/account and model/effort binding,
verification evidence, family-selection authority and policy bundle in existing Lead
execution state. Preserve family-selection and recovery history there.

The selected family stays fixed for the objective through account rotation and
DeepSeek fallback and later model switches. Resume restores the recorded family, not
the current model picker.
A user-requested family change requires an explicit scoped routing decision and
reconciliation under `recovery-and-learning.md`; do not automatically migrate active
objectives. The initial model chooses a family, not every subsequent role model.
The common patterns A/B/C/D, proportionality budgets and all other execution,
review, acceptance and recovery rules apply equally to both families.

## OpenAI profile selection

For an OpenAI-family objective, at admission select exactly one profile: `Routing: sol-terra` or
`Routing: sol-deepseek`. The documented configurable default when unspecified is
`sol-terra`; change that deployment default only after verifying the selected route.
Prefer `sol-deepseek` after its live runtime binding has been verified. Record the
profile, default or explicit selection authority, and bundle in Lead execution state
and every worker contract. Profile selection is distinct from initial Lead family
classification. Anthropic remains a separate available family and does not select
an OpenAI profile. Do not silently change
profiles during corrections, retries, recovery, Goal continuation, or quota events.
A user-authorized routing change uses the recovery procedure and preserves counters.

| Role | sol-terra | sol-deepseek |
| --- | --- | --- |
| Lead | GPT-6.1 Sol | GPT-6.1 Sol |
| Architect, if needed | GPT-6.1 Sol | GPT-6.1 Sol |
| Explorer | GPT-6.1 Terra | DeepSeek V4.1-Flash-1017 |
| Implementer | GPT-6.1 Terra | DeepSeek V4.1-Flash-1017 |
| Integrator | GPT-6.1 Terra | DeepSeek V4.1-Flash-1017 |
| Writer | GPT-6.1 Terra | DeepSeek V4.1-Flash-1017 |
| Reviewer | GPT-6.1 Sol | GPT-6.1 Sol |
| Validator | deterministic tools preferred | deterministic tools preferred |

Sol defaults to medium, high for difficult or critical work. Terra uses medium or
high according to complexity, max only when justified and supported. DeepSeek uses
low for simple/mechanical work, high for substantial implementation or difficult
diagnosis. Verify actual effective effort; a requested CLI level is not proof.
DeepSeek is the primary execution route in `sol-deepseek`, not a quota fallback.
The quota fallback below remains distinct and subject to its existing admission rules.

### Anthropic logical preferences

These are preferences, not proof of an executable provider binding. Verify the exact
model and effective effort before dispatch. The Lead may choose Opus directly for
difficult work or select another supported effort within the chosen family; no failed
Sonnet attempt is required.

| Role | Standard Anthropic | Complex / critical |
| --- | --- | --- |
| Lead / Plan | Claude Sonnet 5.5 / high | Claude Opus 5.5 / high |
| Explorer | Claude Sonnet 5.5 / medium | Claude Opus 5.5 / high |
| Implementer | Claude Sonnet 5.5 / high | Claude Opus 5.5 / high |
| Integrator | Claude Sonnet 5.5 / high | Claude Opus 5.5 / high |
| Architect | Claude Opus 5.5 / high | Claude Opus 5.5 / high |
| Reviewer | Claude Sonnet 5.5 / high | Claude Opus 5.5 / high |
| Writer | Claude Sonnet 5.5 / medium | Claude Sonnet 5.5 / high |
| Validator | deterministic tools preferred | Claude Sonnet 5.5 only if necessary |

### Subscription-first execution

For Anthropic roles, prefer the **official Claude Code CLI with the Claude
subscription**, rather than Pi Anthropic API/OAuth. Keep the Sonnet/Opus versions,
role preferences and efforts above. This is a harness/provider preference, not a
family/profile change or permission to use a different model. This is the scoped
exception to the Pi harness default: record the actual Claude Code harness in the
existing dispatch envelope instead of its literal Pi prefix. A Lead handoff must
retain the initial Pi family decision and reconcile the checkpoint under recovery;
it does not admit or reclassify the objective again. Verify subscription
entitlement, workload/privacy eligibility, active authentication/billing, exact version
and effective effort. Use Claude Code `/status` to verify active authentication
and billing, and authoritative session evidence for exact model and effort; Pi
session fields do not verify a Claude Code process.
API credentials, gateways, aliases and automatic model fallback must not silently
replace the subscription route. A Pi Anthropic route is not subscription-equivalent;
using it requires an explicitly authorized route and billing scope. Before claiming
execution works, verify installed Orca support for the official CLI, launch binding,
worker lifecycle and recovery. Otherwise report `PI_ROUTING_BLOCKED` for affected
work; document the unsupported/unverified capability rather than inventing a wrapper.

For every DeepSeek role (primary execution or admitted model/family fallback), prefer
Pi's compatible **OpenCode Go** provider with
`opencode-go/deepseek-v4.1-flash`. Retain the logical target
DeepSeek V4.1-Flash-1017 and role effort. The route identifier alone does not prove the
served snapshot: establish exact version equivalence before use, including across
providers. Do not treat V4 Flash, V4 Pro, or an unverified V4.1 alias as equivalent.

**DeepSeek Platform API PAYG** through `deepseek/deepseek-flash` is the secondary
provider only after confirmed OpenCode Go quota exhaustion or provider unavailability,
and only with applicable authorized billing and budget. Record the provider's quota
verdict or availability evidence after bounded retries; a bare worker failure, generic
429, unknown quota, authentication/configuration error, privacy denial, model mismatch,
or failed test is insufficient. Verify PAYG account eligibility, exact version,
effective effort and Orca/Pi binding before a reconciled Lead-controlled handoff.
An API key or available credit does not authorize spending. Do not enable Go Extra
Usage, auto-recharge, or another paid pool without applicable billing authorization.
Inspect existing overflow settings too: subscription execution must not consume an
unauthorized paid balance, even when Extra Usage was enabled before this objective.

Both providers require workload/privacy eligibility: permitted data, region, training
and retention terms, including any expiring ZDR agreement. Go eligibility does not
establish DeepSeek Platform eligibility. Do not loosen privacy controls to make a
route available. If version, effort, binding, privacy, billing or safe continuation
cannot be verified, block affected work and record what remains unverified.

### Provider failover versus model/family fallback

Provider failover keeps the exact logical model/version and effective effort; for
DeepSeek it follows the subscription-to-PAYG gate above. It does not authorize a
model/family fallback. Cross-model/family fallback to DeepSeek still requires the
separate all-eligible-accounts quota gate below; provider unavailability alone does
not satisfy that gate. In particular, an unavailable Claude Code route does not
authorize Pi Anthropic or DeepSeek automatically. Workers never select either
transition themselves.

For either transition preserve the routing profile, selected family, policy bundle,
objective/Goal state, budgets and cumulative counters, contracts, frozen acceptance,
candidates, evidence and recovery history. Record the reason, authority and old/new
harness, provider/account, billing pool, exact version and effective effort in existing
Lead state and dispatch bindings. Reconcile side effects and reverify before substantive
work, resume or automatic continuation. Use supported handoff/recovery only; add no
custom middleware or routing service. Changing provider does not reset the objective.

For quota fallback in either family, use DeepSeek low or high according to task complexity.
When DeepSeek is already the primary route, its failure is not a reason to treat the
same route as a fallback or silently change profile. A permitted temporary fallback
does not change the recorded profile. A temporary Lead fallback is subject to the
existing verified quota and recovery conditions; it does not change that profile.
PR reviewers under either OpenAI profile must remain Sol: if Sol is unavailable,
block the affected PR review rather than substitute DeepSeek.

The fallback model is DeepSeek V4.1-Flash-1017, using the subscription-first
provider order above. Verify each provider's mapping before use. For low/high alternatives,
the Lead selects based on the task; Validator defaults to low if a model is needed.

Pi's CLI accepts `low`, `medium`, `high`, and `max`; acceptance of a label by the
CLI does not establish that a particular provider/model actually supports it without
clamping. Verify each effective model/effort combination against runtime evidence.
Do not invent or silently substitute unsupported levels. If verification fails, block
the affected work or obtain an authorized selection that can be verified.

Workers cannot select, escalate, or replace their own route. The Lead may revise a
role selection within the recorded profile after reconciling task and evidence; a
profile change requires explicit authorization. A model or effort change never
resets attempt, correction, retry, or capacity counters, nor acceptance criteria.

## Binding and account rotation

Lead execution state owns the governing policy bundle, effective initial Lead model,
selected family and, for OpenAI, profile, selection authority and recovery history. Each worker dispatch
references that governing bundle and objective state and records the selected family and profile,
assigned logical model and effort, selection rationale and authority, eligible
provider/account scope, effective provider/account, model and effort, verification
evidence, and worker-specific routing events. Recovery must resolve the bundle and
original family decision from persisted Lead/objective state. If a dispatch cannot
reliably reference that state, report `PI_ROUTING_BLOCKED`. A deterministic tool node
needs no model binding.
Use supported Pi selection, or the official Claude Code launch for subscription-backed
Anthropic, and authoritative runtime/session evidence before substantive work and
after each routing event; prompt text is not a binding.

Orca 1.4.257 `worker-start` still has one model and effort, no ordered fallback list.
Its documented Claude launch overrides do not establish subscription authentication
or live worker support, and its overrides do not document Pi worker model/effort
binding. Do not assume `pi-subagents` `fallbackModels` applies to Orca. If a
Pi worker's effective binding cannot be verified, report `PI_ROUTING_BLOCKED`.

Logical model identity, effort, provider/account identity, account eligibility, and
effective runtime binding are distinct. `pi-multi-account` can discover accounts;
do not hardcode its alias list or implement another rotation service. An approved
rotation such as `openai-codex` to `openai-codex-account-2` is valid when the new
account actually provides the same authorized model and effective effort. Verify
compatibility and eligibility; OpenAI provider names alone do not prove equivalence.
Anthropic account aliases follow the same rule; a different route requires an explicit
Lead selection under this policy. Preserve the selected family, route and counters.
The runtime must prevent or stop unapproved model/provider changes before substantive work, including automatic continuation.

Retain existing admission limits: at most three concurrent workers; Astra or unknown
worker routing reserves the single Astra/unknown slot, excluding Lead. Reconcile
capacity before each launch or transition. Selection does not expand budgets.

## Quota fallback and recovery

This section gates model/family fallback; same-model DeepSeek provider failover
uses the separate subscription-first gate above. Neither transition authorizes billing.

The policy pre-authorizes DeepSeek fallback without another user approval only when
confirmed quota exhaustion prevents the selected route on **all eligible accounts of the selected family**,
after eligible account rotation. Unknown eligibility or quota is not confirmation. Temporary rate limits, network failures, authentication/configuration
errors, unsupported or unavailable models, and ordinary implementation or test
failures are not quota exhaustion and do not trigger fallback. Respect the existing
transient retry limits. Preserve the contract, frozen acceptance, candidate identities,
correction history and all execution counters.

Automatic fallback is permitted only where the installed runtime can enforce these
conditions, the exact fallback version and role effort, and safe continuation. The
documented `pi-multi-account` behavior also routes on non-quota failures and may
change model or family; some child processes are passive. It does not by itself prove
this policy's quota-only cross-provider gate or role-specific effort transition. If
the gate or safe continuation cannot be established, stop automatic continuation,
report `PI_ROUTING_BLOCKED`, and reconcile before a supported, recorded handoff; do
not claim automatic fallback is working. Do not introduce custom routing middleware.

For Orca 1.4.242, automatic Pi worker fallback is unsupported by the verified
dispatch contract. Worker output and failed-task redispatch exist, but they do not
establish an attributable quota verdict for every eligible account or a verified Pi
fallback binding. Treat a worker failure or missing output as insufficient evidence;
report `PI_ROUTING_BLOCKED`. A Lead-controlled handoff is conditional on independently
verified quota evidence, route binding, and reconciliation, not on `--retry-of` alone.

This applies to the Lead as well as workers. When the Lead is exhausted, a supported
same-session model switch may continue only if context, effective route, and side
effects are verified. Otherwise recover a Lead on the fallback route from the
existing checkpoint, frozen contract, candidate and dispatch identities, and counters,
using supported Pi/Orca capabilities. If these cannot be recovered, block affected
work. Never blindly replay potentially non-idempotent actions: inspect actual effects
and reconcile uncertain work first. Prefer the selected family for new dispatches
after quota recovers; do not interrupt running DeepSeek tasks or oscillate within a worker.
