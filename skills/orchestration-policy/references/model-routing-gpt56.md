# GPT-5.6 routing — default

Selected by `model-routing.md` unless the user explicitly requests another profile
for the relevant scope.

Exact model IDs: Sol = `gpt-5.6-sol`, Terra = `gpt-5.6-terra`,
Luna = `gpt-5.6-luna`.

## Defaults

| Responsibility | Default | Escalation |
| --- | --- | --- |
| Lead / routine coordination and synthesis | Terra / medium | Sol/high for difficult synthesis, conflicting evidence, or high-risk adjudication; xhigh only if justified |
| Explorer | Terra / medium | high for subtle semantic investigation |
| Implementer | Terra / medium | high/xhigh for difficult correctness |
| Meaningful independent review | Sol / high | xhigh for high-risk invariants |
| Small low-risk review | Terra / medium | high/Sol as uncertainty grows |
| Validator / deterministic collection | Tool node when sufficient; otherwise Luna / low | Luna/medium for nontrivial interpretation; Terra/medium for semantic diagnosis |
| Integrator | Terra / medium | high for difficult interaction |
| Architecture/spec documentation | Terra / medium | high/Sol for adjudication |

Use `medium` as the routine engineering baseline. Increase reasoning only when task
difficulty or measured quality justifies it. Reserve `max` for rare focused,
quality-first adjudication after high/xhigh remains materially uncertain.

Choose Sol/high at admission when the objective already requires difficult synthesis
or high-risk adjudication; do not spend an unnecessary Terra attempt to prove that
known requirement. Routine scheduling, joins over established facts, and reporting
do not require a flagship Lead. Meaningful independent review retains Sol/high:
reduce orchestration overhead before weakening the review that protects acceptance.
Explicit user model/effort selections take precedence within the authorized scope.

Escalate effort or tier first; change both only with a concrete reason.
Astra is not an automatic escalation or failure fallback from this profile.
Admission and effective routing are owned by `model-routing.md`.
