# GPT-6 Sol / DeepSeek routing — explicit opt-in only

Load only after the user explicitly selects `gpt-6-sol-deepseek` for the current
objective. All common authority, acceptance, graph, loop, budget, recovery, and
runtime-verification rules remain in force. This profile does not change the default.

The Lead and all architecture and review judgments stay on GPT-6 Sol. DeepSeek V4.1
Flash handles bounded exploration and execution roles. Prefer deterministic tools for
validation when they provide sufficient evidence.

## Exact routes

- GPT-6 Sol = `gpt-6-sol`
- DeepSeek V4.1 Flash = `deepseek/deepseek-flash`

| Responsibility | Route | Escalation |
| --- | --- | --- |
| Lead / root coordination and synthesis | GPT-6 Sol / medium | high, then xhigh for difficult/high-risk adjudication |
| Explorer / bounded evidence and research | DeepSeek Flash / low | high only with Lead authorization; no model/profile change |
| Implementer / coding and debugging | DeepSeek Flash / high | block/escalate; no automatic model/profile change |
| Writer / writing and summaries | DeepSeek Flash / low | block/escalate; no automatic model/profile change |
| Architect / architecture | GPT-6 Sol / high | xhigh for difficult/high-risk adjudication |
| Reviewer / every independent review | GPT-6 Sol / xhigh for meaningful review; high for small low-risk review | increase effort only for a concrete unresolved judgment |
| Validator / deterministic collection | deterministic tool node when sufficient; otherwise DeepSeek Flash / low | high only after Lead-authorized semantic diagnosis |
| Integrator / integration | DeepSeek Flash / high | block/escalate; no automatic model/profile change |

The table is closed. Do not route Lead, Architect, or Reviewer to DeepSeek. Do not
route Explorer, Implementer, Writer, or Integrator to Sol under this profile. A
validator uses a model only when deterministic evidence is insufficient. The Lead
retains coordination and acceptance responsibility regardless of worker model.

A final review uses a fresh independent context and the exact candidate. Using Sol
for both Lead and Reviewer does not weaken context or evidence independence.

## Admission and evidence

Select this profile before substantive work and bind each model-backed role through
Pi to the exact provider, model, and effort above. Verify effective routing from
authoritative runtime/session evidence for the Lead and every model-backed node.
Establish that automatic routing cannot escape the assigned role route between checks.

Record:
- the explicit profile-selection authority and objective scope;
- each role's requested and effective provider/model/effort;
- runtime-verification status and evidence;
- available DeepSeek input, cached-input, output, and reasoning token metrics.

Mark unavailable metrics unknown. Do not infer quality, savings, or quota consumption
from route selection alone. The direct DeepSeek API is authorized only within this
explicitly selected profile scope. Never place credentials, tokens, passwords,
connection strings, or opaque secrets in contracts, artifacts, logs, or evidence.

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
