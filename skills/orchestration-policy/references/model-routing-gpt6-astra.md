# GPT-6 Astra quality routing — explicit opt-in only

Load for an explicitly authorized `gpt-6-astra` objective or role after selection
by `model-routing.md`. All common authority, acceptance, graph, loop, budget, and
runtime-verification rules remain in force.

This is a quality-first GPT-6 profile, not an "Astra on every node" profile.
Concentrate Astra on judgment boundaries and use GPT-6 Sol/Luna where they are the
better execution route.

## Role table

Exact model IDs used by this profile:
- Astra = `gpt-6-astra`
- Sol = `gpt-6-sol`
- Luna = `gpt-6-luna`

| Responsibility | Default | Escalation |
| --- | --- | --- |
| Lead / root coordination and synthesis | Astra / medium | high for unresolved high-impact synthesis; xhigh only when justified |
| Explorer | Sol / high | xhigh for subtle causal/semantic investigation |
| Implementer | Sol / medium | high for difficult correctness; xhigh for rare high-risk implementation reasoning |
| Writer | Luna / medium | Sol / medium for difficult source-backed synthesis |
| Architect | Astra / medium | high for unresolved architectural adjudication; xhigh for rare frontier cases |
| Meaningful independent review | Astra / medium | high for subtle/high-risk invariants; xhigh when evidence remains materially ambiguous |
| Small low-risk review | Sol / high | Astra / medium when the review becomes architecture/high-impact judgment |
| Validator / deterministic collection | Tool node when sufficient; otherwise Luna / low | Luna / medium for interpretation; Sol / medium for semantic diagnosis |
| Integrator | Sol / high | xhigh for difficult cross-component interaction |

These are routing defaults, not benchmark, quota, or cost guarantees. Explicit user
model/effort selections take precedence within their authorized scope.

## Routing intent

Use Astra where errors in judgment have the highest downstream cost:
- objective decomposition and high-impact synthesis;
- architectural adjudication;
- final independent review of meaningful changes.

Use Sol where substantial semantic engineering still benefits from strong reasoning
but does not require frontier judgment:
- exploration/root cause;
- implementation;
- integration;
- small semantic review.

Use Luna for bounded, well-specified work:
- routine writing;
- deterministic or lightly interpretive validation.

Do not route a task to Astra merely because the objective is important. Route Astra
to the judgment boundary that controls the important decision.

## Reasoning effort

Astra starts at `medium` in this profile rather than `low`. The profile is
explicitly selected for additional quality at judgment boundaries.

Escalate for a concrete unresolved reasoning problem:
- Astra: medium -> high -> xhigh -> max;
- Sol: medium/high -> xhigh as the role table indicates;
- Luna: low -> medium before moving semantic diagnosis to Sol.

Do not walk every rung mechanically. Known high-risk work may start at the justified
effort directly. Infrastructure failures, missing inputs, and environment problems do
not justify stronger reasoning.

Reserve Astra `max` for rare focused quality-first adjudication after lower supported
effort remains insufficient.

## Profile boundary

Selecting `gpt-6-astra` authorizes this closed quality profile for the named scope.
It does not mean every model-backed node must use Astra.

Do not substitute DeepSeek Flash or another external model inside this profile without
a separate scoped authorization. Do not fall back to GPT-5.6.

Deterministic nodes should remain tools rather than model calls where possible.

## Work instructions

State observable outcome, ownership, invariants, required evidence, and stopping
condition. Allow workers to choose local implementation mechanisms that are not
already ratified.

Continue through required validation and bounded correction until the contract is
satisfied or an actual policy boundary is reached. Preserve independent review and
all common attempt/correction budgets.

Source checked 2026-09-23:
- https://developers.openai.com/api/docs/models/gpt-6-astra
- https://developers.openai.com/api/docs/models/gpt-6-sol
- https://developers.openai.com/api/docs/models/gpt-6-luna
