# Recovery, Exceptions, and Learning

This file owns abnormal paths.

## Checkpoint

Retain only state needed to resume safely:
- objective/canonical authority;
- frozen Manifest and candidate identities;
- policy bundle identity;
- active/uncertain dispatches;
- objective routing profile, scoped role overrides, and selection authority;
- requested/effective model and effort, verification, and model-switch controls;
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

Restore the recorded routing profile and its user authorization, not the current
model picker or latest available model. For a composite objective, restore each
recorded Astra/Flash role binding, including provider, exact model, and effort. If
an Astra or Flash scope cannot be established, pause affected launches and recover
its authority; do not invent consent or silently substitute another profile. New
objectives without a profile request default to GPT-5.6.

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

Changing the routing family of active work is a scoped migration. An explicit Astra
or Flash request covers only its named objective or roles; propagate it to affected
future dispatches after reconciliation. Preserve prior worker routing and evidence
history. Revocation stops new affected launches immediately and pauses further
substantive work by affected active workers through the supported lifecycle protocol
before rerouting. After the configured transient retry allowance, an unavailable,
mismatched, or unverifiable Flash role reports `DEEPSEEK_FLASH_BLOCKED`; it does not
fall back automatically. Neither migration nor revocation resets attempt, retry,
correction, or capacity counts.

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
