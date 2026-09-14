# Astra–DeepSeek Flash static scenarios

These scenarios specify required policy outcomes; the verifier checks that their
named profile, route, and block marker remain present.

| Scenario | Expected result |
| --- | --- |
| Explicit request: "Use Astra with Flash workers for this objective" | Admit `astra-deepseek-flash`; bind its closed role table after runtime verification. |
| Explorer / focused research or Writer / writing and summaries | Bind `deepseek/deepseek-v4-flash` at low effort. |
| Implementer / coding or debugging | Bind `deepseek/deepseek-v4-flash` at high effort. |
| Integrator, Validator needing interpretation, Architect, or final Reviewer | Bind Astra at the table's medium/high effort; use a deterministic validator where sufficient. |
| Flash unavailable, mismatched, or unverifiable after transient retries | Return `DEEPSEEK_FLASH_BLOCKED`; block and escalate without an automatic GPT-5.6 or Astra worker fallback. |
| Resume a composite objective | Restore the recorded Astra/Flash role binding, provider, exact model, and effort before work. |
| Flash worker requests a new model or effort | Reject worker-led rerouting; require Lead-scoped authority and runtime verification. |
