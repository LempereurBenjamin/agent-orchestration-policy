# Model routing

`openai-first` is the default policy for new objectives. This reference owns
selection, binding, rotation, fallback, and verification. An active objective
remains pinned to its recorded policy bundle until explicitly migrated under
`recovery-and-learning.md`. Editing routing policy does not reroute the current run.

## Selection

The Lead selects the logical model and reasoning effort at admission, considering
complexity, uncertainty, contract clarity, architectural discretion, failure impact,
and evidence of unresolved reasoning difficulty. These are defaults, not fixed
assignments. Straightforward implementation may use Terra medium; difficult work may
start at max without passing through intermediate levels. Astra is available only
as an explicitly requested, scoped override. Respect explicit user model/effort
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

Record in existing Lead execution state and each dispatch: policy bundle and
`openai-first`, logical model ID, effort, selection rationale and authority, eligible
provider/account scope, effective provider/account, model and effort, verification
evidence, and any routing event. A deterministic tool node needs no model binding.
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
Preserve the selected route and counters. The runtime must prevent or stop unapproved
model/provider changes before substantive work, including automatic continuation.

Retain existing admission limits: at most three concurrent workers; Astra or unknown
worker routing reserves the single Astra/unknown slot, excluding Lead. Reconcile
capacity before each launch or transition. Selection does not expand budgets.

## Quota fallback and recovery

The policy pre-authorizes DeepSeek fallback without another user approval only when
confirmed quota exhaustion prevents the selected route on **all eligible OpenAI
accounts**, after eligible account rotation. Unknown eligibility or quota is not
confirmation. Temporary rate limits, network failures, authentication/configuration
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
and reconcile uncertain work first. Prefer OpenAI for new dispatches after quota
recovers; do not interrupt running DeepSeek tasks or oscillate within a worker.
