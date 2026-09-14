# GPT-6 Astra routing — explicit opt-in only

Load for an explicitly authorized Astra objective or role after selection by
`model-routing.md`. All common authority, acceptance, graph, loop, and budget rules
remain in force.

## Model and role table

Verified model ID: `gpt-6-astra`. Do not invent Astra Sol/Terra/Luna variants or
interpret "GPT-6 family" as permission to use an unverified future model.

| Responsibility | Default | Escalation |
| --- | --- | --- |
| Lead / synthesis | Astra / low | medium for unresolved synthesis or high-risk adjudication |
| Explorer | Astra / low | medium for subtle semantic investigation |
| Implementer | Astra / low | medium for difficult correctness |
| Writer | Astra / low | medium for difficult source-backed synthesis |
| Architect | Astra / low | medium for unresolved adjudication |
| Meaningful independent review | Astra / low | medium for subtle invariants or conflicting evidence |
| Small low-risk review | Astra / low | medium for demonstrated uncertainty |
| Validator / deterministic collection | Tool node when sufficient; otherwise Astra / low | medium for semantic diagnosis |
| Integrator | Astra / low | medium for difficult interaction |

These are local routing defaults, not measured performance or cost guarantees.
Use low as the local starting point for this profile. It is not a universal
performance benchmark or a claim about comparable quota consumption. Do not copy
GPT-5.6 effort labels onto Astra: use low when selecting a new Astra route unless
the user explicitly requests another effort or task-specific evidence justifies
escalation.

Escalate low -> medium -> high for a concrete unresolved reasoning problem, not
for missing inputs, infrastructure failures, or routine review formalities.
Known exceptional complexity may justify a higher initial effort with a recorded
reason; an artificial failed attempt is not required. Reserve xhigh/max for rare
focused adjudication where high remains insufficient. After the hard subproblem,
return new routine nodes to low. Existing pinned objectives use the migration
procedure rather than silently changing effort. Do not use none/minimal.
Bind only effort values supported by the actual Pi provider; API support alone
does not prove harness support.

Astra is the only model in this profile. Using GPT-5.6 helpers is a mixed-profile
override that must be included in the user's scope; it is not an automatic cost
fallback. Prefer deterministic tools for deterministic nodes.

## Work instructions

State the observable outcome, ownership, invariants, required evidence, and stopping
condition in the worker contract. Allow the worker to choose local implementation
steps. Continue through required validation and correction until the contract is
satisfied or an actual policy boundary is reached. Preserve loop budgets and
independent review; do not stop merely because a first implementation exists.

Source checked 2026-09-13: [OpenAI GPT-6 Astra model documentation](https://developers.openai.com/api/docs/models/gpt-6-astra)
lists low, medium, high, xhigh, and max reasoning effort. Runtime binding still
requires the common verification procedure.
