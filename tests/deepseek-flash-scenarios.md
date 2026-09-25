# DeepSeek V4.1 Flash static scenarios

These scenarios specify required policy outcomes; the verifier checks that their
named profile, route, and block marker remain present.

| Scenario | Expected result |
| --- | --- |
| Explicit request: "Use DeepSeek Flash for this objective" | Admit `deepseek-flash`; bind its closed DeepSeek-only role table after runtime verification. |
| Existing OpenAI-backed Lead dispatches Flash workers | Reject as DeepSeek-only execution; start a Flash Lead or use an authorized, recorded active-objective migration. |
| Lead / root coordination | Bind `deepseek/deepseek-flash` at high effort; no OpenAI dependency. |
| Explorer / focused research or Writer / writing and summaries | Bind `deepseek/deepseek-flash` at low effort. |
| Implementer / coding or debugging | Bind `deepseek/deepseek-flash` at high effort. |
| Integrator | Bind `deepseek/deepseek-flash` at high effort. |
| Validator | Use a deterministic tool when sufficient; otherwise bind `deepseek/deepseek-flash` at low effort, with Lead-authorized high effort for semantic diagnosis. |
| Architect or final Reviewer | Bind `deepseek/deepseek-flash` at high effort; final review uses a fresh independent context and the exact candidate. |
| Flash unavailable, mismatched, or unverifiable after transient retries | Return `DEEPSEEK_FLASH_BLOCKED`; block and escalate without automatic Astra/Sol/Luna substitution. |
| Resume a DeepSeek Flash objective | Restore every recorded DeepSeek role binding, including Lead, worker, integration, and reviewer routes, provider, exact model, and effort, before work. |
| Flash worker requests a new model or effort | Reject worker-led rerouting; require Lead-scoped authority and runtime verification. |
| Lead Flash route blocked | Pause the objective and ask the user for direction; no OpenAI substitution. |
