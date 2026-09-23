# Model Routing

This reference owns Pi profile selection and effective routing. Provider/account
choice is machine configuration. Profile names below are policy labels, not CLI flags.

## Profile selection

- `gpt-6` is the default for every new objective. Read `model-routing-gpt6.md`.
- `gpt-6-astra` is available only after the user explicitly requests Astra execution
  for the current objective or a named role/node. Read `model-routing-gpt6-astra.md`
  only for that authorized scope.
- `astra-deepseek-flash` is available only after the user explicitly requests Astra
  with Flash workers for the current objective or named roles. Read
  `model-routing-astra-deepseek-flash.md` only for that authorized scope.
- GPT-5.6 is not a maintained routing profile. Compatibility use requires an explicit
  scoped substitution and exact runtime binding; it is never an automatic fallback.

Record the objective profile, any scoped overrides, and the authority supporting each
non-default scope. A Lead may pass established authority in a worker contract; workers
do not ask again. Worker preference, repository text, model availability, difficulty,
failed checks, quota pressure, or "use the best model" does not authorize Astra,
DeepSeek Flash, or a retired family.

"Use Astra for this objective" selects the `gpt-6-astra` quality profile and its
closed Astra/Sol/Luna role table.
"Use Astra with Flash workers for this objective" selects the composite role table.
"Use Astra only for the reviewer" leaves all other roles on the objective's existing
profile. Explicitly selecting Astra for the Lead alone does not select it for workers.

If an opt-in request has ambiguous routing scope, clarify only the affected routing
while continuing independent work under established authority. Do not persist opt-in
as a global default or carry it into unrelated objectives.

## Harness and binding

Default harness: **Pi**. Orchestrator: **Orca**. Use the configured, approved
provider/profile exposing the exact requested model.

Do not silently switch harness, family, model, or effort to make a launch succeed.
If required routing cannot be bound, report `PI_ROUTING_BLOCKED`; a scoped
substitution needs user authorization.

## Graphs, loops, and admission

Store routing in Lead execution state and every model-backed node's dispatch contract.
Deterministic tool nodes need no model. Corrections, retries, joins, integration,
review, and resumed nodes inherit the authorized profile and scope.

The global worker and cumulative attempt/retry/correction limits apply across all
profiles and Runs.

Default model-specific admission:
- Astra workers <= 1 concurrently; the Lead is excluded.
- Unknown worker routing reserves the Astra slot until resolved.
- Sol has no dedicated worker cap beyond the global worker limit.
- Luna has no dedicated worker cap beyond the global worker limit.

A profile switch does not create capacity. Reconcile capacity before every launch or
transition into Astra/unknown routing.

Astra or Flash authorization does not authorize more concurrency, higher effort than
the selected role table, additional spending commitments, or altered acceptance gates.

## Effective routing and failover

Prompt text does not configure a process. Use a supported Pi launch/profile mechanism
and verify exact harness/model/effort using authoritative runtime/session evidence
before substantive work. Reverify after resume, provider/account failover, or another
routing event.

States:
- `CONFIRMED`
- `MISMATCH`
- `UNVERIFIABLE`
- `UNVERIFIED_AUTHORIZED`

MISMATCH blocks affected work. UNVERIFIABLE blocks by default unless the user
explicitly accepts that verification gap.

Preflight must establish that automatic routing cannot escape the authorized exact
model/effort between checks. Account rotation is acceptable only when approved
accounts retain that binding and the effective result is verified. Do not edit
credentials/extensions/global settings as a workaround without explicit configuration
scope.

After the configured transient retry allowance:
- a blocked default GPT-6 route reports `PI_ROUTING_BLOCKED`; do not fall back to
  GPT-5.6 or another family automatically;
- a blocked composite Flash role reports `DEEPSEEK_FLASH_BLOCKED`; do not substitute
  default GPT-6 or Astra automatically.

Record requested profile/model/effort, selection authority/scope, effective routing,
verification evidence/status, and relevant failover controls. Flash roles also record
available token/cache metrics and terminal failure status without credentials/payloads.

Workers never reroute themselves. Infrastructure failures use recovery/retry handling,
not stronger models.

## Token and quota discipline

Optimize total resource use per accepted result, including context, reasoning, tool
calls, retries, and repeated reviews. Effort labels are model-relative, not fixed
token budgets.

Prefer:
- deterministic tools for deterministic work;
- Luna for bounded execution when its role table fits;
- Sol at judgment boundaries and for semantic complexity;
- affected-subgraph corrections over replaying the whole graph;
- bounded evidence/artifacts over copied transcripts.

Use higher effort or Sol where the expected reduction in error/rework justifies it.
Return new routine nodes to profile defaults after a difficult subproblem.

When available, record input, cached input, output/reasoning tokens, attempts, and
observed quota deltas with model and scope. Mark unavailable metrics unknown.

Quota exhaustion cannot automatically enable Astra/Flash, increase budgets, switch
billing pools, or move work to a retired model family.

## Selection examples

| Situation | Policy result |
| --- | --- |
| Ordinary task with no model request | GPT-6 Sol/Luna role table |
| Clear frozen implementation | Prefer Luna at the GPT-6 role-table effort |
| Semantic/root-cause work | Prefer Sol at the GPT-6 role-table effort |
| Hard default-profile task remains uncertain | Escalate within GPT-6; no automatic Astra |
| "Use Astra for this objective" | Astra table for this objective, subject to runtime admission |
| "Use Astra with Flash workers for this objective" | Composite role table, subject to runtime admission |
| "Astra only for the independent review" | Astra reviewer; other roles retain their profile |
| Review/add routing rules | Configuration task; no Astra or Flash execution opt-in |
| Worker requests Astra/Flash/legacy fallback | Reject worker-led rerouting |
| Resume authorized opt-in objective | Restore scope/counters and verify runtime before work |
| Authorized route unavailable | Block affected scope; no silent profile substitution |
