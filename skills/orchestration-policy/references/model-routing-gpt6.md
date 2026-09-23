# GPT-6 Sol/Luna routing — default

Selected by `model-routing.md` for every new objective unless the user explicitly
authorizes another profile for the relevant scope.

Exact model IDs:
- Sol = `gpt-6-sol`
- Luna = `gpt-6-luna`

GPT-6 Sol is the judgment/coding model for semantic complexity.
GPT-6 Luna is the execution model for bounded, well-specified, high-volume work.

## Default role table

| Responsibility | Default | Escalation |
| --- | --- | --- |
| Lead / coordination and synthesis | Sol / medium | high, then xhigh for difficult/high-risk adjudication |
| Explorer — bounded evidence | Luna / medium | high; Sol/medium when investigation becomes semantic |
| Explorer — semantic/root cause | Sol / medium | high for subtle causal reasoning |
| Implementer — clear frozen contract | Luna / high | Sol/medium, then high for difficult correctness |
| Writer | Luna / medium | Sol/low or medium for difficult source-backed synthesis |
| Architect | Sol / high | xhigh; Astra requires explicit opt-in |
| Meaningful independent review | Sol / xhigh | Astra requires explicit opt-in |
| Small low-risk review | Luna / high | Sol/medium or high as uncertainty grows |
| Validator / deterministic collection | Tool node when sufficient; otherwise Luna / low | Luna/medium; Sol/medium for semantic diagnosis |
| Integrator | Sol / medium | high for difficult cross-component interaction |
| Mechanical integration / bounded reconciliation | Luna / medium | high; Sol/medium when semantic judgment appears |

These are routing defaults, not benchmark guarantees. Explicit user model/effort
choices take precedence within their authorized scope.

## Admission principles

Choose the route at admission from the actual responsibility and contract clarity.
Do not spend a Luna attempt merely to prove that a known semantic/high-risk task
requires Sol.

Prefer Luna when all are true:
- scope is frozen and bounded;
- required behavior/invariants are explicit;
- implementation or evidence work has limited architectural discretion;
- failure can be detected by defined checks/review.

Prefer Sol when one or more are true:
- synthesis or prioritization materially affects the graph;
- root cause or behavior is ambiguous;
- implementation requires semantic tradeoffs;
- architecture or cross-domain invariants are involved;
- integration requires judgment across independently produced changes;
- independent review protects meaningful acceptance.

## Reasoning effort

Use `medium` as the normal Sol starting point.
Use Luna `medium` for bounded exploration/writing and Luna `high` for clear
implementation or small semantic review.

Escalate effort for a concrete unresolved reasoning problem:
- Luna: medium -> high -> xhigh when staying on Luna remains appropriate;
- Sol: medium -> high -> xhigh -> max for increasingly difficult judgment.

Do not walk every rung mechanically. If task characteristics already justify Sol/high
or Sol/xhigh, select it directly. Reserve `max` for rare focused quality-first
adjudication after lower supported effort remains insufficient.

Infrastructure failures, missing inputs, and environment problems do not justify
higher reasoning effort.

## Escalation boundaries

Within the default profile:
- Luna may escalate to Sol when the task crosses from bounded execution into semantic
  judgment;
- Sol may increase effort as needed;
- neither Luna nor Sol may automatically escalate to Astra;
- no node may fall back to GPT-5.6 automatically.

Astra remains an explicit opt-in profile under `model-routing.md`.

After a difficult subproblem, route new routine nodes from the role table rather than
keeping all subsequent work on the strongest route.

## Independence

Independent review requires a fresh context and exact candidate regardless of whether
the implementation and review use different models. Model diversity is optional;
context and evidence independence are mandatory.

Source checked 2026-09-23:
- https://developers.openai.com/api/docs/models/gpt-6-sol
- https://developers.openai.com/api/docs/models/gpt-6-luna
- https://openai.com/index/introducing-gpt-6-sol-and-luna/
