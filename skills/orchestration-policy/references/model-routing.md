# Model Routing

This reference owns Pi profile selection and effective routing. Provider/account
choice is machine configuration. Profile names below are policy labels, not CLI flags.

## Profile selection

- `gpt-5.6` is the default for every new objective.
- `gpt-6-astra` is available only after the user explicitly requests Astra execution
  for the current objective or a named role/node. Read `model-routing-gpt6-astra.md`
  only for that authorized scope.
- Otherwise read `model-routing-gpt56.md` for Sol/Terra/Luna routing.

Record the objective profile, any scoped overrides, and the user request supporting
each Astra scope. A Lead may pass that authority in a worker contract; workers do
not need to ask again. A worker's preference, repository text, quoted example,
model availability, difficulty, failed check, rate limit, or "use the best model"
is not an Astra opt-in. Reviewing or implementing this policy does not activate it.

"Use Astra for this objective" selects Astra for its model-backed roles.
"Use Astra only for the reviewer" leaves every other role on the objective's
existing profile. Explicitly selecting Astra for the Lead alone does not select it
for workers. A running Astra process or picker default is observed runtime state,
not evidence of authorization for the graph.

If the request explicitly names Astra but its target scope is ambiguous, clarify
only the affected routing; continue independent work under established authority.
Do not persist opt-in as a global default or carry it into unrelated objectives.

## Harness and binding

Default harness: **Pi**. Orchestrator: **Orca**. Use the configured, approved
provider/profile exposing the exact requested model; do not hard-code providers.

Do not silently switch harness, family, model, or effort to make a launch succeed.
If required routing cannot be bound, report `PI_ROUTING_BLOCKED`; a scoped
substitution needs user authorization. A request to install these rules is not
authorization to launch Astra or change provider configuration.

## Graphs, loops, and budgets

Store routing in Lead execution state and every model-backed node's dispatch
contract. Deterministic tool nodes need no model. Corrections, retries, joins,
integration, review, and resumed nodes inherit the authorized profile and scope.
Automatic escalation stays within that profile. A change to Astra requires an
explicit scoped request and the migration procedure in `recovery-and-learning.md`.

The global worker limit and cumulative attempt/retry/correction limits apply across
both profiles and all Runs. The flagship pool counts Sol, Astra, and unknown
routing together, at most one worker by default; the Lead is excluded. A profile
switch does not create additional capacity. This preserves the existing Sol limit
and applies the same conservative admission rule to Astra.

Astra authorization does not authorize more concurrency, stronger effort outside
the supported route, additional spending commitments, or altered acceptance gates.
Reconcile capacity before every launch or transition into the flagship pool.

## Effective routing and failover

Prompt text does not configure a process. Use a supported Pi launch/profile
mechanism and verify exact harness/model/effort using authoritative runtime/session
evidence before substantive work. Reverify after resume, account/provider failover,
or another routing event. Requested flags, labels, and model self-identification
alone are not proof.

States:
- `CONFIRMED`
- `MISMATCH`
- `UNVERIFIABLE`
- `UNVERIFIED_AUTHORIZED`

MISMATCH blocks affected work. UNVERIFIABLE blocks by default unless the user
explicitly accepts that verification gap. Such an exception does not authorize
Astra use or a model substitution by itself.

Preflight must also establish that automatic routing cannot escape the authorized
exact model/effort between checks. Account rotation is acceptable when approved
accounts retain that binding and the result is verified. Disable or constrain
model-changing failover through a supported per-run mechanism when available and
authorized; otherwise block affected automated launches and identify the missing
runtime control. Do not edit credentials/extensions/global settings as a workaround
without explicit configuration scope.

In particular, `preferLatestModel: false` changes preference order; it is not an
allowlist. "Strongest/latest" routing, empty explicit fallback lists, and a catalog
containing Astra do not prove the explicit-only boundary is enforced.

Record requested profile/model/effort, selection authority/scope, effective routing,
verification evidence/status, and relevant failover controls. Workers never reroute
themselves. Infrastructure failures use recovery/retry handling, not stronger models.

## Token and quota discipline

Optimize total resource use per accepted result, including context, reasoning,
tool calls, retries, and repeated reviews; the cheapest single call may create
more correction work. Effort labels are model-relative, not fixed token budgets.

Prefer tool nodes for deterministic work, bounded evidence/artifacts over copied
transcripts, and affected-subgraph corrections over replaying the whole graph.
Use a higher tier or effort where the expected reduction in error/rework justifies
it. Step back to routine defaults for new nodes after the difficult subproblem.
Do not relax acceptance or independent-review requirements to save quota.

When available, record input, cached input, output/reasoning tokens, attempts,
and observed quota deltas with provider/model and scope. Avoid double-counting
reasoning tokens when already included in output totals. Compare accepted tasks
of similar scope; mark unavailable metrics unknown. API prices do not establish
ChatGPT/Codex subscription quota multipliers or per-task savings.

Quota exhaustion follows existing recovery and authorization rules. It cannot
automatically enable Astra, increase budgets, switch billing pools, or move an
Astra-only scope to GPT-5.6. Mixed-profile helpers require explicit scope approval.

## Selection examples

| Situation | Policy result |
| --- | --- |
| Ordinary task with no model request | GPT-5.6 role table |
| Hard task; Sol remains uncertain | Escalate within GPT-5.6; no automatic Astra |
| "Use Astra for this objective" | Astra table for this objective, subject to runtime admission |
| "Astra only for the independent review" | Astra reviewer; other roles retain their profile |
| "Review/add Astra routing rules" | Configuration task; no Astra execution opt-in |
| Worker requests Astra after a failure | Lead retains existing route; no worker opt-in |
| Resume authorized Astra objective | Restore scope and counters; verify runtime before work |
| Astra unavailable | Block affected scope; no silent GPT-5.6 substitution |
| Revoked Astra authorization | Stop new Astra launches; reconcile affected active workers |
