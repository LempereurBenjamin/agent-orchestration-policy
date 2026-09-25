# DeepSeek V4.1 Flash routing — explicit independent profile

Load only after an explicit user request for DeepSeek Flash execution. All common
authority, acceptance, graph, loop, budget, recovery, and runtime-verification rules
remain in force.

This profile is self-contained for objectives that must not depend on OpenAI
availability. DeepSeek V4.1 Flash owns every model-backed role. Deterministic tool
nodes remain preferred when sufficient. The Lead retains coordination, architecture,
acceptance, and final judgment responsibility; model identity does not transfer
those responsibilities to a worker.

Select this profile before launching the objective's Lead under Pi. An OpenAI-backed
Lead cannot become DeepSeek-only merely by dispatching Flash workers. For an active
objective, change the Lead route only through the recorded policy migration and
recovery procedure; preserve existing work and counters.

## Exact routes

| Responsibility | Route | Escalation |
| --- | --- | --- |
| Lead / root coordination | `deepseek/deepseek-flash` / high | stop and ask for a scoped decision if the route is insufficient |
| Explorer / focused research | `deepseek/deepseek-flash` / low | block/escalate; no automatic effort/model/profile change |
| Implementer / coding and debugging | `deepseek/deepseek-flash` / high | block/escalate; no automatic effort/model/profile change |
| Writer / writing and summaries | `deepseek/deepseek-flash` / low | block/escalate; no automatic effort/model/profile change |
| Integrator / integration | `deepseek/deepseek-flash` / high | block/escalate; no automatic effort/model/profile change |
| Validator / deterministic collection | deterministic tool node when sufficient; otherwise `deepseek/deepseek-flash` / low | high only after Lead-authorized semantic escalation |
| Architect / architecture | `deepseek/deepseek-flash` / high | block/escalate; no automatic effort/model/profile change |
| Reviewer / final independent review | `deepseek/deepseek-flash` / high | block/escalate; no automatic effort/model/profile change |

The role table is closed. No role, including Lead, integration, architecture, or
final review, requires an OpenAI model. No automatic substitution to Astra, Sol,
Luna, or another provider is permitted when Flash is unavailable or inadequate.

A final review remains fresh and independent under the common reviewer contract.

## Admission and evidence

Bind every model-backed role through Pi as `deepseek/deepseek-flash` at the
role-approved effort above. This is the current V4.1 Flash catalog identifier.

Before substantive work, verify provider/model/effort from authoritative runtime/session
evidence for every model-backed node.

Record:
- explicit profile-selection authority and scope;
- actual route;
- runtime-verification status/evidence;
- available input/cached-input/output/reasoning token metrics when exposed.

Mark unavailable metrics unknown. Do not infer quality, savings, or quota consumption
from route selection alone.

The direct DeepSeek API is authorized only within the explicitly selected profile scope.
This does not authorize credentials, tokens, passwords, connection strings, or opaque
secrets in worker prompts, artifacts, logs, or routing evidence.

## Failure and recovery

Use the common transient retry allowance.

For any model-backed node, after retries are exhausted or whenever the Flash route is
unavailable, mismatched, or unverifiable:
- report `DEEPSEEK_FLASH_BLOCKED`;
- escalate the affected node to the Lead;
- do not substitute Astra, Sol, Luna, or another model automatically; if the Lead
  route itself is blocked, pause the objective and ask the user for direction.

On recovery, restore each recorded provider/model/effort binding. Any changed provider,
model, effort, billing route, or role requires scoped migration and runtime verification
before further work.

DeepSeek Flash is an explicit full-objective route, not a global default, automatic
router, or evidence that a task is low risk. Preserve independent review through a
fresh reviewer context and the exact candidate, even though Lead and Reviewer use
the same model. Prefer deterministic tools whenever sufficient.
