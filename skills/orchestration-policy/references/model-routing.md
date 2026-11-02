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

## Selection

The Lead selects the logical model and reasoning effort at admission, considering
complexity, uncertainty, contract clarity, architectural discretion, failure impact,
and evidence of unresolved reasoning difficulty. These are defaults, not fixed
assignments. Within OpenAI routing, straightforward implementation may use Terra
medium; difficult work may start at max without passing through intermediate levels.
Astra is available only as an explicitly requested, scoped override. Respect explicit user model/effort
instructions and existing authority and budget limits.

| Role | Standard OpenAI | Complex / critical | DeepSeek fallback |
| --- | --- | --- | --- |
| Lead / Plan | `gpt-5.6-sol` / medium | `gpt-6.1-sol` / high | high |
| Explorer | `gpt-6.1-terra` / medium | `gpt-6.1-terra` / high | low or high |
| Implementer | `gpt-6.1-terra` / high | `gpt-6.1-terra` / max | high |
| Integrator | `gpt-6.1-terra` / high | `gpt-6.1-terra` / max | high |
| Architect | `gpt-6.1-sol` / high | `gpt-6.1-sol` / high | high |
| Reviewer | `gpt-5.6-sol` / high | `gpt-6.1-sol` / high | high |
| Writer | `gpt-6.1-terra` / medium | `gpt-6.1-terra` / high | low or high |
| Validator | deterministic tools preferred | model only when necessary | deterministic tools, otherwise low or high |

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

The DeepSeek fallback effort column in the OpenAI table applies to both families.

The fallback model is DeepSeek V4.1-Flash-1017, intended through the configured
`deepseek/deepseek-flash` route. The route identifier alone does not prove the
deployed version. Verify the provider's mapping before use. For low/high alternatives,
the Lead selects based on the task; Validator defaults to low if a model is needed.

Pi's CLI accepts `low`, `medium`, `high`, and `max`; acceptance of a label by the
CLI does not establish that a particular provider/model actually supports it without
clamping. Verify each effective model/effort combination against runtime evidence.
Do not invent or silently substitute unsupported levels. If verification fails, block
the affected work or obtain an authorized selection that can be verified.

Workers cannot select, escalate, or replace their own route. The Lead may revise
selection after reconciling the task and evidence. A model or effort change never
resets attempt, correction, retry, or capacity counters, nor acceptance criteria.

## Binding and account rotation

Lead execution state owns the governing policy bundle, effective initial Lead model,
selected family, family-selection authority and recovery history. Each worker dispatch
references that governing bundle and objective state and records the selected family,
assigned logical model and effort, selection rationale and authority, eligible
provider/account scope, effective provider/account, model and effort, verification
evidence, and worker-specific routing events. Recovery must resolve the bundle and
original family decision from persisted Lead/objective state. If a dispatch cannot
reliably reference that state, report `PI_ROUTING_BLOCKED`. A deterministic tool node
needs no model binding.
Use Pi-supported selection and authoritative runtime/session evidence before
substantive work and after each routing event; prompt text is not a binding.

Orca 1.4.242 `worker-start` has one model and effort, no ordered fallback list,
and its documented launch overrides do not establish Pi worker model/effort
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
