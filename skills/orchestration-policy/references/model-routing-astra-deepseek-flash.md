# Astra–DeepSeek Flash routing — explicit composite profile

Load only after an explicit user request for Astra with Flash workers. All common
authority, acceptance, graph, loop, budget, recovery, and runtime-verification rules
remain in force.

This is a specialist composite profile:
- Astra owns high-impact coordination, architecture, and final review;
- DeepSeek Flash owns only focused research, coding/debugging, and routine writing;
- GPT-6 Sol owns semantic integration and diagnosis;
- GPT-6 Luna owns bounded validation where a tool node is insufficient.

## Exact routes

| Responsibility | Route | Escalation |
| --- | --- | --- |
| Lead / root coordination | `gpt-6-astra` / medium | high for unresolved high-impact synthesis |
| Explorer / focused research | `deepseek/deepseek-v4-flash` / low | block/escalate; no automatic effort/model/profile change |
| Implementer / coding and debugging | `deepseek/deepseek-v4-flash` / high | block/escalate; no automatic effort/model/profile change |
| Writer / writing and summaries | `deepseek/deepseek-v4-flash` / low | block/escalate; no automatic effort/model/profile change |
| Integrator / integration | `gpt-6-sol` / high | xhigh for difficult cross-component interaction |
| Validator / deterministic collection | deterministic tool node when sufficient; otherwise `gpt-6-luna` / low | Luna / medium for interpretation; Sol / medium for semantic diagnosis |
| Architect / architecture | `gpt-6-astra` / high | xhigh for rare unresolved architectural adjudication |
| Reviewer / final independent review | `gpt-6-astra` / high | xhigh for subtle/high-risk invariants or conflicting evidence |

The role table is closed. In particular:
- Flash does not own integration, validation, architecture, or final independent review;
- Sol/Luna do not replace Astra at the profile's declared judgment boundaries;
- Astra does not replace Flash automatically when a Flash route fails.

A final review remains fresh and independent under the common reviewer contract.

## Admission and evidence

Bind Flash roles only through Pi as `deepseek/deepseek-v4-flash`. Bind GPT-6 roles
through Pi to the exact model/effort above.

Before substantive work, verify provider/model/effort from authoritative runtime/session
evidence for every model-backed node.

Record:
- explicit profile-selection authority and scope;
- actual route;
- runtime-verification status/evidence;
- available input/cached-input/output/reasoning token metrics when exposed.

Mark unavailable metrics unknown. Do not infer quality, savings, or quota consumption
from route selection alone.

The direct DeepSeek API is authorized only within the explicitly selected Flash scope.
This does not authorize credentials, tokens, passwords, connection strings, or opaque
secrets in worker prompts, artifacts, logs, or routing evidence.

## Failure and recovery

Use the common transient retry allowance.

For a Flash node, after retries are exhausted or whenever the Flash route is
unavailable, mismatched, or unverifiable:
- report `DEEPSEEK_FLASH_BLOCKED`;
- escalate the affected node to the Lead;
- do not substitute Astra, Sol, Luna, or another model automatically.

For an Astra/Sol/Luna node, use the common `PI_ROUTING_BLOCKED` behavior and do not
silently switch profile.

On recovery, restore each recorded provider/model/effort binding. Any changed provider,
model, effort, billing route, or role requires scoped migration and runtime verification
before further work.

DeepSeek Flash is a specialist worker route, not a global default, automatic router,
or evidence that a task is low risk. Prefer deterministic tools whenever sufficient.
