# Worker Contracts

This file owns worker handoffs. Prompts carry assignments; artifacts carry authority.

## Envelope

```text
EXECUTION MODE
WORKER. Execute only this assignment; do not orchestrate, reroute, or expand scope.

ROLE
Explorer | Implementer | Reviewer | Validator | Integrator

OBJECTIVE
<one observable outcome>

ROUTING
Pi / <profile: gpt-5.6 | gpt-6-astra> / <exact model ID> / <effort>
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

## Reviewer

Default REVIEW-ONLY, fresh independent Pi context. Model and effort come from the
selected profile's applicable review row. Using the same model family does not
make a shared context independent; use a fresh reviewer and the exact candidate.

Inputs: frozen Manifest (or allowed bounded contract), canonical authority, exact candidate, actual evidence, and
Implementation Approach only as non-contractual context when relevant.

Do not receive implementer transcript/self-assessment.
Use the finding taxonomy owned by `acceptance-manifest.md`.

Verdict: PASS | PASS WITH NON-BLOCKING FINDINGS | FAIL | BLOCKED.

A FAIL verdict may still mean worker execution DONE.
Do not edit the candidate or call self-review independent.

## Validator

Default VALIDATION-ONLY. Prefer deterministic tools without an agent when possible;
otherwise use the selected profile's Validator row.

Validate the exact candidate. Return command/procedure, environment, result,
output reference, and relevant baseline comparison.

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
