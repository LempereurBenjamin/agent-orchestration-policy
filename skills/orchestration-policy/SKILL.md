---
name: orchestration-policy
description: >-
  Coordinate non-trivial engineering work with Pi and Orca using bounded graphs,
  worker contracts, correction loops, and candidate acceptance. Simple questions
  do not require orchestration.
metadata:
  version: "2.3.1"
---

# Orchestration Policy

## Role and priority

- **Lead** owns the user's overall objective.
- **Worker** has an Orca dispatch or explicit delegated contract.

Workers execute only their contract, repository instructions, and Orca protocol.
They do not create Runs, spawn workers, change routing, or expand scope.

The user's explicit instructions define the objective and override defaults in this
skill unless a higher-priority instruction or safety boundary requires otherwise.
A changed default is a scoped override, not permission to fabricate evidence,
silently expand scope, weaken acceptance, or perform unauthorized side effects.

## Hard invariants

- Never fabricate evidence, validation, routing, review, or state.
- Never silently expand ticket scope or backlog ownership.
- Never silently change a frozen acceptance bar.
- Workers do not self-orchestrate.
- Validation and review apply to an identified candidate.
- Worker completion is not candidate acceptance.
- External, destructive, publication, merge, or deployment actions require applicable
  authorization for the exact action, scope, and environment.
- Preserve the only copy of changes/evidence until accepted handoff.

## Defaults

User instructions may override these for the current objective:

- Pi is the harness; Orca is the orchestrator.
- Routing profile: GPT-5.6; GPT-6 Astra requires an explicit user request for its scope.
- Concurrent workers <= 3.
- Concurrent flagship workers (Sol, Astra, or unknown routing combined) <= 1, Lead excluded.
- Worker execution attempts <= 12 per objective.
- Unsuccessful substantive corrections <= 2 per acceptance problem.
- Automatic retries after an initial transient failure <= 2.
- Pattern B normally uses an Acceptance Manifest.
- Patterns C and D require one.

Changing IDs, Runs, workers, or patterns does not reset cumulative limits.

## Authority

Keep distinct:

1. requirements / architecture — what the system means;
2. backlog / ticket ownership — which ticket owns the change;
3. Acceptance Manifest — how this ticket proves completion;
4. repository evidence — what the code/system actually does;
5. this policy — execution constraints/defaults;
6. installed Orca guide — supported orchestration mechanics.

Worker opinion is evidence, not authority.

## References

Load only when needed:

- `references/acceptance-manifest.md` — baseline, ownership, manifest, approach, freeze, findings.
- `references/model-routing.md` — profile selection, admission, and runtime verification;
  then read only the selected family's routing table.
- `references/worker-contracts.md` — concise role contracts.
- `references/recovery-and-learning.md` — abnormal paths, exceptions, migration, learning.

Before Orca mutations:

    orca skills get orchestration --full

Use only installed capabilities; never invent flags or states.

## Preflight

For non-trivial work, establish before production implementation:

- canonical authority;
- backlog ownership;
- exact repository/base state;
- in/out scope;
- invariants and required proof;
- unresolved material decisions;
- whether acceptance can be frozen.

Read `acceptance-manifest.md`.

Always capture repository identity, exact base SHA, working-tree state, and relevant
pre-existing changes. Run only baseline checks that materially improve comparison
or causality. Prefer comparable before/after checks; broad suites are not ritual.

Patterns C/D require a frozen Manifest before production implementation, except
for an explicitly bounded experiment. Pattern B normally requires one; a bounded
omission must record scope, acceptance criteria, and required evidence, as defined
in `acceptance-manifest.md`. Investigation/documentation used to clarify the
contract may precede freeze.

## Patterns

Choose the smallest pattern and state the reason briefly.

### A — SOLO
Local, low-risk, low-uncertainty.

    inspect -> execute -> validate -> self-review -> report

No Orca Run. Self-review is not independent review.

### B — STANDARD
Meaningful, understood work with one bounded writer.

    preflight -> freeze -> implement -> evidence -> independent review if required -> accept

For an allowed Manifest omission, record the bounded contract at preflight instead
of freeze. Omission does not waive evidence or required review.

### C — INVESTIGATE
Material uncertainty in root cause, behavior, or contract interpretation.

    baseline -> manifest DRAFT -> independent investigation(s) -> synthesis
    -> freeze -> implement if requested -> evidence -> independent review

Use two Explorers only for genuinely independent evidence paths and keep their
initial conclusions isolated. After freeze, reopen product/domain exploration only
for a canonical contradiction or disproven material assumption.

### D — LARGE CHANGE
Independently writable bounded areas with explicit dependencies.

    preflight -> design/scope review -> freeze -> bounded work
    -> integration -> evidence -> cross-cutting independent review

One write owner per bounded area. Acceptance targets the integrated candidate.

## Graph and design

Build the smallest useful DAG. A node is not necessarily an agent.
Use deterministic tools for deterministic work.

Split by independent uncertainty, write ownership, real interfaces, and failure/
validation domains—not by title, arbitrary directory, or desire for parallelism.

Create a dependency only when the downstream node genuinely needs the predecessor's
artifact, decision, or evidence. Runtime completion alone is not policy admission.
Use deterministic joins for machine-computable facts and semantic joins for judgment.
Transfer artifacts/evidence, not transcripts.

Require independent pre-implementation design/scope review when material risk or
boundary uncertainty exists: architecture, cross-ticket ownership, concurrency,
persistence/migrations, security, cross-domain contracts, or difficult-to-detect
release-critical invariants.

Review authority, scope, ownership, ratified architecture, evidence strategy, and the
lightweight non-contractual Implementation Approach. Do not turn the Approach into
acceptance criteria. Low/medium-risk Pattern B may use Lead preflight only.

## Dispatch

Before each worker launch:

1. reconcile live/uncertain work and prior side effects;
2. verify dependency admission, ownership, candidate/manifest identity, and budget;
3. read `model-routing.md`, resolve the authorized profile and role, and bind exact Pi routing;
4. read `worker-contracts.md` and create a concise contract;
5. reserve capacity and one execution attempt;
6. launch through supervised Orca;
7. record IDs and verify effective routing and model-switch controls before substantive work.

Do not batch launches against stale capacity.

Graph nodes inherit the recorded objective profile unless an explicit user request
authorizes a narrower override. Retry, correction, and recovery nodes preserve
that scope and cumulative counters; they cannot opt into Astra themselves.

## Corrections

Correct the smallest responsible subgraph and keep correction history acyclic.
After candidate changes, rerun affected required evidence, justify retained evidence,
and review the final candidate as required. An old PASS never automatically approves
a changed candidate.

At the correction limit, stop automatic fixes and obtain bounded continuation or
report PARTIAL/BLOCKED.

## Candidate, permissions, and supervision

Each writer uses a dedicated worktree and bounded ownership. Worktrees are not
security sandboxes.

Before review/validation identify repository, base SHA, and candidate commit SHA or
immutable snapshot/patch. Verify the reviewer/validator sees that exact candidate;
do not mutate it during review.

Without applicable explicit authorization: no push, protected/default-branch merge,
history rewrite, deployment, publication, issue closure, external project/product
mutation, or destructive operation.

Use supervised Orca dispatches and injected lifecycle protocol. A review that
correctly finds a blocker may be execution DONE with verdict FAIL.

Timeout/missing heartbeat triggers inspection, not presumed termination.
Before uncertain replay, recovery, retry escalation, exceptional acceptance, policy
migration, or persistent learning, read `recovery-and-learning.md`.

Before asking the user for a decision, check whether the exact action/scope/environment
already has valid approval.

## Closure

Normal DONE requires:
- applicable frozen Manifest;
- exact final candidate;
- criteria mapped to required evidence;
- required mechanical evidence;
- required independent review of the final candidate;
- no unresolved blocker;
- explicit treatment of missing/waived/non-blocking/out-of-scope findings;
- no ambiguously active owned work;
- clear Git/external state.

A waiver does not turn FAIL/BLOCKED/NOT_RUN into PASS.
Distinguish implementation complete, ticket accepted, release ready, merged, and deployed.

Default final report is concise:

**Outcome** — DONE/PARTIAL/BLOCKED/FAILED; pattern; candidate.  
**Evidence** — relevant baseline delta, required checks, review verdict.  
**Changes** — substantive result.  
**Residuals** — risks, follow-ups, missing evidence/decisions.  
**State** — commit/push/merge/deploy/external-write status.

Include graph, worker, routing, policy, or Manifest internals only when material,
requested, or needed for audit/debugging.

Never invent tests, routing, costs, timing, readiness, or publication state.
