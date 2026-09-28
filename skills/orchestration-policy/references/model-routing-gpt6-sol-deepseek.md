# GPT-6 Sol / DeepSeek routing — default

Selected by `model-routing.md` for every new engineering objective unless the user
explicitly authorizes another profile for the relevant scope. All common authority,
acceptance, graph, loop, budget, recovery, and runtime-verification rules remain in
force.

The Lead and all architecture and review judgments stay on GPT-6 Sol. DeepSeek V4.1
Flash handles bounded exploration and execution roles. Prefer deterministic tools for
validation when they provide sufficient evidence.

## Exact routes

- GPT-6 Sol = `gpt-6-sol`
- DeepSeek V4.1 Flash = `deepseek/deepseek-flash`

| Responsibility | Route | Escalation |
| --- | --- | --- |
| Lead / root coordination and synthesis | GPT-6 Sol / medium | high, then xhigh for difficult/high-risk adjudication |
| Explorer / bounded evidence and research | DeepSeek Flash / low | high only with Lead authorization; semantic boundary returns to Lead |
| Implementer / coding and debugging | DeepSeek Flash / high | semantic boundary returns to Lead; Lead may authorize one scoped Sol execution node |
| Writer / writing and summaries | DeepSeek Flash / low | semantic boundary returns to Lead; Lead may authorize one scoped Sol execution node |
| Architect / architecture | GPT-6 Sol / high | xhigh for difficult/high-risk adjudication |
| Reviewer / every independent review | GPT-6 Sol / xhigh for meaningful review; high for small low-risk review | increase effort only for a concrete unresolved judgment |
| Validator / deterministic collection | deterministic tool node when sufficient; otherwise DeepSeek Flash / low | high only after Lead-authorized semantic diagnosis |
| Integrator / integration | DeepSeek Flash / high | semantic incompatibility returns to Lead; Lead may authorize one scoped Sol execution node |

The table is closed for workers: Lead, Architect, and Reviewer stay on Sol; bounded
Explorer, Implementer, Writer, and Integrator work stays on DeepSeek. Workers never
self-reroute. When an execution node encounters a decision that cannot be reduced to a
bounded contract without semantic judgment, it stops and escalates to the Sol Lead.

The Lead first resolves the decision and returns the work to DeepSeek when the contract
can be bounded. Only when the execution itself remains intrinsically semantic may the
Lead authorize a narrowly scoped Sol execution node. Record the reason, exact scope,
route, and runtime verification. This exception never transfers architecture,
acceptance, or review authority to the execution worker and never becomes a new default.

A validator uses a model only when deterministic evidence is insufficient. The Lead
retains coordination and acceptance responsibility regardless of worker model.

A final review uses a fresh independent context and the exact candidate. Using Sol
for both Lead and Reviewer does not weaken context or evidence independence.

## Admission and evidence

Use this profile by default before substantive work and bind each model-backed role
through Pi to the exact provider, model, and effort above. Verify effective routing from
authoritative runtime/session evidence for the Lead and every model-backed node.
Establish that automatic routing cannot escape the assigned role route between checks.

Record:
- the profile-selection authority and objective scope, recording explicit authority
  only for scoped alternatives or Sol execution exceptions;
- each role's requested and effective provider/model/effort;
- runtime-verification status and evidence;
- available DeepSeek input, cached-input, output, and reasoning token metrics.

Mark unavailable metrics unknown. Do not infer quality, savings, or quota consumption
from route selection alone. Selecting the default mixed profile does not authorize a
direct DeepSeek provider or change provider/account configuration. Use only the
configured approved provider exposing the exact route; direct DeepSeek API access
requires separate explicit configuration authority. Never place credentials, tokens,
passwords, connection strings, or opaque secrets in contracts, artifacts, logs, or
evidence.

## Failure and recovery

Use the common transient retry allowance. If either exact route is unavailable,
mismatched, or unverifiable after retries, report `HYBRID_ROUTING_BLOCKED` for the
affected role and escalate to the Lead. Do not substitute another role's model,
DeepSeek-only or GPT-6-only routing, Astra, or a legacy model. If the Lead's Sol route
is blocked, pause the objective and ask the user for direction.

On recovery, restore the recorded route for each role, including provider, exact
model, and effort, then verify it before substantive work. A changed route requires
scoped migration and runtime verification; it does not reset attempt, retry,
correction, or capacity counts.
