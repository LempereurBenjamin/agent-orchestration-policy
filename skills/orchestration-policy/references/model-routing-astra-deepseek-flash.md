# Astra–DeepSeek Flash routing — explicit composite profile

Load only after an explicit user request for Astra with Flash workers. All common
authority, acceptance, graph, loop, budget, and recovery rules remain in force.

## Exact routes

| Responsibility | Route | Escalation |
| --- | --- | --- |
| Lead / root coordination | `gpt-6-astra` / medium | high for a concrete unresolved synthesis problem |
| Explorer / focused research | `deepseek/deepseek-v4-flash` / low | block/escalate; no automatic effort or profile change |
| Implementer / coding and debugging | `deepseek/deepseek-v4-flash` / high | block/escalate; no automatic effort or profile change |
| Writer / writing and summaries | `deepseek/deepseek-v4-flash` / low | block/escalate; no automatic effort or profile change |
| Integrator / integration | `gpt-6-astra` / medium | high for difficult interaction |
| Validator / validation | deterministic tool node when sufficient; otherwise `gpt-6-astra` / medium | high for semantic diagnosis |
| Architect / architecture | `gpt-6-astra` / high | block/escalate if high remains insufficient |
| Reviewer / final independent review | `gpt-6-astra` / high | block/escalate if high remains insufficient |

The role table is closed for the initial rollout. In particular, Flash does not own
integration, validation, architecture, or final independent review. A final review
remains fresh and independent under the common reviewer contract.

## Admission and evidence

Bind Flash roles only through Pi as `deepseek/deepseek-v4-flash`. Before substantive
work, verify the exact provider, model, and effort from authoritative runtime/session
evidence. Record the objective's explicit selection authority, actual route, and
available input, cached-input, output, and reasoning token metrics. Mark unavailable
metrics unknown; do not infer cost, savings, or quality from the selected route.

The direct DeepSeek API is authorized for current work. This does not authorize
placing credentials, tokens, passwords, connection strings, or opaque secrets in
worker prompts, artifacts, logs, or routing evidence.

## Failure and recovery

Use the common transient retry allowance. After it is exhausted, or whenever the
Flash route is unavailable, mismatched, or unverifiable, report
`DEEPSEEK_FLASH_BLOCKED` and escalate the affected node. Do not substitute an Astra or default GPT-6 Sol/Luna worker automatically.

On recovery, restore the recorded Flash provider, exact model, and effort. A changed
provider, model, effort, billing route, or role requires scoped migration and runtime
verification before further work.

DeepSeek Flash is a direct-API worker route, not a global default, automatic router,
or evidence that a task is low risk. Prefer deterministic tools where they suffice.
