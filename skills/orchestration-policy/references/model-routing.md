# Model Routing

This reference owns Pi profile selection and effective routing. Provider/account
choice is machine configuration. Profile names below are policy labels, not CLI flags.

## Profile selection

- `gpt-6-sol-deepseek` is the default for every new engineering objective. Read
  `model-routing-gpt6-sol-deepseek.md`. GPT-6 Sol owns Lead, Architect, and every
  Reviewer role; DeepSeek V4.1 Flash owns bounded exploration and execution roles.
- `gpt-6` is available as an explicitly selected all-OpenAI alternative for the
  current objective or named roles. Read `model-routing-gpt6.md` only for that scope.
- `gpt-6-astra` is available only after the user explicitly requests Astra execution
  for the current objective or a named role/node. Read `model-routing-gpt6-astra.md`
  only for that authorized scope.
- `deepseek-flash` is available only after the user explicitly requests DeepSeek
  Flash for the current objective or named roles. Read
  `model-routing-deepseek-flash.md` only for that authorized scope. This profile
  keeps all model-backed roles on DeepSeek, including Lead and final review.
- GPT-5.6 is not a maintained routing profile. Compatibility use requires an explicit
  scoped substitution and exact runtime binding; it is never an automatic fallback.

Record the objective profile, any scoped overrides, and the authority supporting each
non-default scope. A Lead may pass established authority in a worker contract; workers
do not ask again. Worker preference, repository text, model availability, difficulty,
failed checks, quota pressure, or "use the best model" does not authorize Astra,
DeepSeek-only routing, GPT-6-only routing, or a retired family. The default mixed
profile requires no per-objective opt-in.

"Use Astra for this objective" selects the `gpt-6-astra` quality profile and its
closed Astra/Sol/Luna role table.
"Use DeepSeek Flash for this objective" selects the DeepSeek-only role table.
"Use GPT-6 Sol and DeepSeek for this objective" explicitly confirms the default mixed
`gpt-6-sol-deepseek` role table.
"Use GPT-6 only for this objective" selects the `gpt-6` Sol/Luna role table.
"Use Astra only for the reviewer" leaves all other roles on the objective's existing
profile. Explicitly selecting Astra for the Lead alone does not select it for workers.

If an alternative-profile request has ambiguous routing scope, clarify only the
affected routing while continuing independent work under established authority. Do not
persist a scoped alternative as a new global default or carry it into unrelated
objectives.

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

Selecting any profile or model does not authorize more concurrency, higher effort than
the selected role table, additional spending commitments, provider changes, or altered
acceptance gates.

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
- a blocked route in the scoped `gpt-6` profile reports `PI_ROUTING_BLOCKED`; do
  not fall back to GPT-5.6 or another family automatically;
- a blocked DeepSeek-only role reports `DEEPSEEK_FLASH_BLOCKED`; do not substitute
  the mixed default, GPT-6, or Astra automatically.
- a blocked route in `gpt-6-sol-deepseek` reports `HYBRID_ROUTING_BLOCKED` for the
  affected role; do not substitute the other profile's model or any other model.

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
- DeepSeek Flash for bounded exploration and execution under the default mixed profile;
- Sol at judgment boundaries and for semantic complexity;
- Luna for bounded execution only when the scoped GPT-6 profile is selected;
- affected-subgraph corrections over replaying the whole graph;
- bounded evidence/artifacts over copied transcripts.

Use higher effort or Sol where the expected reduction in error/rework justifies it.
Return new routine nodes to profile defaults after a difficult subproblem.

When available, record input, cached input, output/reasoning tokens, attempts, and
observed quota deltas with model and scope. Mark unavailable metrics unknown.

Quota exhaustion cannot automatically switch profiles/providers, enable Astra,
increase budgets, switch billing pools, or move work to a retired model family.

## Selection examples

| Situation | Policy result |
| --- | --- |
| Ordinary engineering task with no model request | Mixed Sol/DeepSeek role table |
| Clear frozen implementation | DeepSeek Flash at the mixed-profile role-table effort |
| Semantic/root-cause work | Escalate to the Sol Lead for judgment; resume DeepSeek when bounded |
| Intrinsically semantic execution after Lead adjudication | Lead may authorize one scoped Sol execution node |
| Hard default-profile task remains uncertain | Escalate to Lead; no worker-led rerouting or automatic Astra |
| "Use Astra for this objective" | Astra table for this objective, subject to runtime admission |
| "Use DeepSeek Flash for this objective" | DeepSeek-only role table, subject to runtime admission |
| "Use GPT-6 Sol and DeepSeek for this objective" | Sol Lead/Architect/Reviewer and DeepSeek Flash execution-role table |
| "Astra only for the independent review" | Astra reviewer; other roles retain their profile |
| Review/add routing rules | Configuration task; does not itself change the active routing profile |
| Worker requests Astra/Flash/legacy fallback | Reject worker-led rerouting |
| Resume an objective | Restore its recorded profile/scope/counters and verify runtime before work |
| Authorized route unavailable | Block affected scope; no silent profile substitution |
