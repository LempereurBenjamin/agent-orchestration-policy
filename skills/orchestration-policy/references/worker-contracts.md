# Worker Contracts

This file owns worker handoffs. Prompts carry assignments; artifacts carry authority.

## Envelope

```text
EXECUTION MODE
WORKER. Execute only this assignment; do not orchestrate, reroute, or expand scope.

ROLE
Explorer | Implementer | Writer | Architect | Reviewer | Validator | Integrator

OBJECTIVE
<one observable outcome>

ROUTING
Pi / <profile: gpt-5.6 | gpt-6-astra | astra-deepseek-flash> / <exact model ID> / <effort>
Selection authority: <default or user request reference + authorized scope>
Runtime verification: <evidence/status; exact-model failover controls>

AUTHORITY
Manifest: <path + frozen external identity, when applicable>
Bounded contract: <scope/criteria/evidence reference for an allowed Manifest omission>
Canonical issue/spec: <reference>

INPUT
Base SHA:
Candidate identity, when applicable:

OWNERSHIP
READ-ONLY | WRITE OWNER | REVIEW-ONLY | VALIDATION-ONLY
Writable scope:
Explicit exclusions:

TASK-SPECIFIC NOTES
<only information not already available in authoritative artifacts>

DELIVERABLE
<result, candidate/artifacts, actual evidence, residual risks>

STOP / ESCALATE
Contract contradiction, ownership conflict, routing mismatch, exceeded bounds,
or decision outside approved scope.

PROTOCOL
Follow injected Orca task/dispatch/heartbeat/question/completion instructions.
```

Do not paste whole manifests, ADRs, issues, transcripts, private reasoning, or
persuasive worker summaries when the worker can read authoritative artifacts directly.

For `astra-deepseek-flash`, bind every contract to the exact route in its composite
role table. Flash contracts record available token/cache metrics and terminal failure
status without including credentials or request payloads. A worker cannot select,
escalate, or replace its own route.

## Explorer

Default READ-ONLY. Model and effort come from the selected profile's Explorer row.

Return concrete evidence, facts separated from inference, useful falsifiers, and the
smallest next experiment. Do not implement speculative fixes or absorb adjacent scope.
Independent Explorers do not receive one another's initial conclusions.

## Implementer

Default WRITE OWNER. Model and effort come from the selected profile's Implementer row.

Read/verify the frozen Manifest (or allowed bounded contract), base/worktree, and
ownership before editing. Implement only its in-scope requirements. Choose unratified mechanisms yourself
and explain only material choices against invariants.

Return exact candidate identity, changed artifacts, required evidence actually
produced, and residual risks.

A canonical contradiction stops affected work; do not change acceptance to fit code.

## Writer

Default WRITE OWNER for scoped authored artifacts; otherwise READ-ONLY when producing
a summary or draft. Model and effort come from the selected profile's Writer row.

Return the exact artifact, its required evidence, and residual risks. Do not turn a
summary or draft into a change of authority, acceptance, or implementation scope.

## Architect

Default READ-ONLY. Model and effort come from the selected profile's Architect row.

Analyze canonical authority, boundaries, invariants, and evidence strategy. Return a
bounded decision or approach; do not implement speculative changes or alter acceptance.

## Reviewer

Default REVIEW-ONLY, fresh independent Pi context. Model and effort come from the
selected profile's applicable review row. Using the same model family does not
make a shared context independent; use a fresh reviewer and the exact candidate.

Inputs: frozen Manifest (or allowed bounded contract), canonical authority, exact candidate, actual evidence, and
Implementation Approach only as non-contractual context when relevant.

Do not receive implementer transcript/self-assessment.
Use the finding taxonomy owned by `acceptance-manifest.md`.

Review ticket acceptance against gate verdicts and semantic criteria, while preserving
raw check outcomes. A raw repository-wide FAIL that is proven unchanged from baseline
does not become a semantic defect merely because the command exits non-zero.

Verdict: PASS | PASS WITH NON-BLOCKING FINDINGS | FAIL | BLOCKED.

A FAIL verdict may still mean worker execution DONE.
Do not edit the candidate or call self-review independent.

## Validator

Default VALIDATION-ONLY. Prefer deterministic tools without an agent when possible;
otherwise use the selected profile's Validator row.

Validate the exact candidate. Return:
- the raw command/procedure result and exit status where applicable;
- environment and evidence/output reference;
- relevant baseline result;
- normalized baseline-vs-candidate delta when the gate mode is `NO_REGRESSION`;
- changed-scope findings when the gate mode is `CHANGED_SCOPE`;
- candidate-only findings, or an explicit reason they cannot be established.

Do not collapse raw check result into ticket acceptance. The Validator reports facts;
the Lead evaluates the gate using the frozen Manifest's scope, mode, and acceptance rule.

Equal finding counts alone do not prove no regression when individual findings can
change. Prefer finding-set comparison or deterministic changed-scope evidence.

Do not silently fix, weaken tests, or hide earlier failures.
Escalate semantic diagnosis through the coordinator using the selected profile.

## Integrator

Default WRITE OWNER of a dedicated integration candidate. Model and effort come
from the selected profile's Integrator row.

Combine approved in-scope inputs, resolve mechanical conflicts, escalate semantic
incompatibilities, run integrated evidence, and return one exact candidate.

No implied authority to merge default/main, push, or publish.

## Handoff

Prefer manifest/candidate identities, raw or structured evidence, approved decisions,
and unresolved questions. Avoid transcripts, repeated context, confidence statements,
or a new evidence framework created only for formatting.
