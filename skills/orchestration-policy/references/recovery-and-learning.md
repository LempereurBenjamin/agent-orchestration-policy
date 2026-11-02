# Recovery, Exceptions, and Learning

This file owns abnormal paths.

## Checkpoint

Retain only state needed to resume safely:
- objective/canonical authority;
- frozen Manifest and candidate identities;
- policy bundle identity;
- active/uncertain dispatches;
- policy, selected logical model and effort, rationale, authority, and eligible accounts;
- effective provider/account, model and effort, verification, routing events and controls;
- capacity/attempt/correction counters;
- pending decisions;
- evidence/review references;
- approvals/waivers.

Store references, not transcripts or private reasoning.

## Recovery

After restart, compaction, timeout, interrupted mutation, or uncertain side effect:

1. stop new launches;
2. recover pinned policy/Manifest identities;
3. inspect actual Orca task/dispatch/session state;
4. reconcile workers, capacity, counters, and prior side effects;
5. verify candidate/evidence identities;
6. resume only reconciled work.

Restore the recorded bundle, route selections, effective bindings and authority;
verify each before substantive work. Apply account rotation and quota fallback,
including Lead recovery, under `model-routing.md`. Preserve the checkpoint, candidate
identities, contracts, evidence and cumulative counters. Do not use the current
model picker as evidence of the recorded route.

Conversation memory alone is not authority to retry or accept.
Inspect before repeating potentially non-idempotent effects.

## Non-convergence

Track corrections by the underlying acceptance problem, not task ID.
At the configured limit, stop automatic correction and either obtain bounded
continuation or report PARTIAL/BLOCKED.

Renaming tasks, changing workers/models, or starting another Run does not reset it.
Transient execution failures use their separate retry limit.
Do not weaken criteria/tests to obtain DONE.

## Approvals and exceptions

Before asking the user, reuse an existing approval only if it covers the exact action,
scope, environment, and material consequence. Reopen when those facts change.

An exception records the rule/check being excepted, actual result/deviation, scope,
reason/risk, approval evidence, and remaining obligation.

A waived FAIL remains FAIL + waiver, not PASS.
Exceptions do not automatically compose across validation, routing, security,
deployment, concurrency, or other dimensions.

## Policy migration

Do not silently migrate an active objective to a new bundle.
New user stop/safety restrictions apply immediately.

For approved migration, record old/new identities, preserve counters, reconcile active
contracts/Manifest compatibility, and rerun only evidence invalidated by the change.

A policy-authorized routing event within the recorded bundle is not a bundle
migration. Reconcile affected active work and prior side effects, preserve routing and
evidence history, and apply the verification and fallback conditions in
`model-routing.md`. Migration and routing events do not reset attempt, retry,
correction, or capacity counts. Revocation stops affected launches and pauses affected
workers through the supported lifecycle protocol before rerouting.

## Learning

Success, failure, or blockage may yield a learning candidate:

- NONE
- ISSUE/TASK
- DOCS
- ADR
- AGENTS.md
- ORCHESTRATION POLICY

Persist only stable, evidenced knowledge in the canonical destination.
Do not automatically persist speculation, task history, one-off detail, or global
policy changes.
