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
Governing policy bundle and objective state: <resolvable references>
Pi / <recorded family and OpenAI profile if applicable> / <logical model ID> / <effort>
Selection rationale and authority: <reason, scope, and any explicit override>
Eligible provider/accounts: <scope and evidence>
Effective binding: <provider/account, model, effort, verification evidence/status>
Routing controls: <rotation/fallback and continuation controls>
Worker routing events: <events and evidence>

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
All roles apply the shared AGENTS.md rule on credible versus speculative risk and
tautological tests; escalate proposed scope expansion to the Lead rather than silently
adding it. Routine choices within the contract remain autonomous.

The Lead selects and verifies each route under `model-routing.md`. A worker cannot
select, escalate, or replace its own route. Record routing changes and actual evidence
without credentials or request payloads.

## Explorer

Default READ-ONLY. Model and effort come from the Lead-selected Explorer row.

Return concrete evidence, facts separated from inference, useful falsifiers, and the
smallest next experiment when needed. Investigate the assigned question and stop when
sufficient evidence exists; do not implement speculative fixes or absorb adjacent scope.
Independent Explorers do not receive one another's initial conclusions.

## Implementer

An outcome-oriented contract authorizes in-scope investigation, implementation,
focused testing, troubleshooting, correction and revalidation without a separate
dispatch for each activity. Respect frozen decisions, ownership, routing and side
effects; escalate material contradictions or genuine non-convergence.

Default WRITE OWNER. Model and effort come from the Lead-selected Implementer row.

Read/verify the frozen Manifest (or bounded Pattern B contract), base/worktree,
and ownership before editing. Implement only its in-scope requirements. Choose
unratified mechanisms yourself and explain only material choices against invariants.
Prefer existing repository patterns, standard libraries and platform features,
with the smallest complete, readable diff. Add focused tests for changed logic
and credible regressions. Avoid speculative abstractions, adjacent refactoring,
extra test matrices and documentation unless the contract, risk or established
project conventions require them. Never remove required safety or data protections.
Before requesting a push, run task-relevant proof required by repository
policy in an approved local or isolated remote environment. Where mandated and
reproducible, validate the affected real-infrastructure journey. Report unavailable
prerequisites as missing evidence, never as E2E PASS.

Return exact candidate identity, changed artifacts, required evidence actually
produced, and residual risks.

Do not reopen settled architecture without contradictory evidence. Escalate material
contradictions and genuine blockers; stop affected work for a canonical contradiction.
Do not change acceptance to fit code.

## Writer

Default WRITE OWNER for scoped authored artifacts; otherwise READ-ONLY when producing
a summary or draft. Model and effort come from the Lead-selected Writer row.

Return the exact artifact, its required evidence, and residual risks. Do not turn a
summary or draft into a change of authority, acceptance, or implementation scope.
Recommend additions only for a concrete requirement or credible risk.

## Architect

Default READ-ONLY. Model and effort come from the Lead-selected Architect row.

Analyze canonical authority, boundaries, invariants, and evidence strategy. Return a
bounded decision or approach grounded in evidence; respect settled decisions and do not
introduce speculative complexity or alter acceptance.

## Reviewer

Default REVIEW-ONLY, fresh independent Pi context. Model and effort come from the
Lead-selected Reviewer route. Using the same model family does not
make a shared context independent; use a fresh reviewer and the exact candidate.

Inputs: frozen Manifest (or bounded Pattern B contract), canonical authority,
exact candidate and actual evidence; the Implementation Approach is non-contractual
context when relevant.

Do not receive implementer transcript/self-assessment.
Use the finding taxonomy owned by `acceptance-manifest.md`.

Review the exact candidate against its contract and applicable invariants. Distinguish
contractual defects, credible risks and optional improvements; blocking findings must
explain an actionable, credible failure mode. Do not invent criteria or turn preferences
into requirements. Request tests only for a plausible regression or required gate.
Review gate verdicts and semantic criteria while preserving raw check outcomes.
A raw repository-wide FAIL that is proven unchanged from baseline does not become
a semantic defect merely because the command exits non-zero.
For a narrow correction to a reviewed candidate, independently assess its changed
delta, impacted invariants and retained evidence, then issue a fresh exact-candidate
verdict. Expand review only if the correction invalidates broader assumptions or
mandatory gates; never inherit an earlier PASS automatically.

Verdict: PASS | PASS WITH NON-BLOCKING FINDINGS | FAIL | BLOCKED.

A FAIL verdict may still mean worker execution DONE.
Do not edit the candidate or call self-review independent.

## Validator

Default VALIDATION-ONLY. Prefer deterministic tools without an agent when possible;
otherwise use the Lead-selected Validator row.

Validate the exact candidate with the smallest checks sufficient for frozen gates
and credible change-related risks. Prefer deterministic, focused checks; broader
integration/full suites remain required where impact, ticket authority or release
policy warrants them. Avoid tautological or duplicate tests, speculative matrices and
repeated broad suites without new evidence or a mandatory gate. An unrun required check
remains NOT_RUN, never PASS.

Return:
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
For failed checks, isolate the observable failure against the relevant baseline
and smallest reproducible path before proposing another costly remote run.
Escalate semantic diagnosis through the coordinator under the recorded route.

## Integrator

Default WRITE OWNER of a dedicated integration candidate. Model and effort come
from the Lead-selected Integrator row.

Combine approved in-scope inputs, resolve mechanical conflicts, escalate semantic
incompatibilities, run integrated evidence, and return one exact candidate. Keep fixes
within the contract and escalate material contradictions or speculative expansion.

No implied authority to merge default/main, push, or publish.

## Handoff

Prefer manifest/candidate identities, raw or structured evidence, approved decisions,
and unresolved questions. Avoid transcripts, repeated context, confidence statements,
or a new evidence framework created only for formatting.
