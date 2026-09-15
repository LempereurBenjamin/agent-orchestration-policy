# Acceptance Manifest

This file owns baseline, ticket-boundary, freeze/unfreeze, Implementation Approach,
gate evaluation, and review-finding taxonomy.

The Manifest is a lean ticket-scoped proof contract. It projects canonical
requirements and backlog ownership; it does not replace them.

## Use

- A: normally none.
- B: default; omission requires a recorded bounded-task reason.
- C: required; may begin DRAFT.
- D: required.

States: `DRAFT`, `FROZEN`, `SUPERSEDED`.

A Pattern B omission records scope, acceptance criteria, and required evidence in
the Lead/dispatch contract. It waives the separate Manifest artifact, not the proof
obligation or any required independent review. Routing profiles belong in execution
state and worker contracts, not in product acceptance criteria.

## Baseline

Always record repository, exact base SHA, working-tree state, and relevant
pre-existing changes. Run only task-relevant baseline checks.

Prefer the same meaningful check before/after. Do not call a failure pre-existing
without baseline evidence. Unavailable checks remain BLOCKED, NOT_RUN, or NOT_APPLICABLE.

A dirty baseline is evidence, not an automatic ticket blocker. A ticket owns defects
it introduces and baseline debt it explicitly claims; it does not automatically
inherit every pre-existing defect exposed by a repository-wide check.

## Lean template

```markdown
# <TICKET> — Acceptance Manifest

Status: DRAFT | FROZEN | SUPERSEDED
Revision: <monotonic revision>
Base SHA: <sha>

## Authority
- <canonical requirement/ADR/architecture source>
- <backlog ticket defining ownership>

## Scope
IN:
- ...
OUT:
- ...

## Ownership
| Concern | Owner ticket | This ticket? |
| --- | --- | --- |
| ... | ... | YES/NO |

## Invariants / Proof
| ID | What must be true | Enforcement layer | Required proof |
| --- | --- | --- | --- |
| I1 | ... | ... | ... |

## Acceptance
| ID | Observable criterion | Authority | Required evidence |
| --- | --- | --- | --- |
| A1 | ... | ... | ... |

## Baseline
- relevant checks/known failures:

## Gates
| ID | Check | Scope | Mode | Baseline | Acceptance rule |
| --- | --- | --- | --- | --- | --- |
| G1 | ... | TICKET | ABSOLUTE | ... | ... |

## Open assumptions
- NONE
```

Keep it small. Reference evidence/logs instead of embedding them.

## Frozen identity

Do not store a manifest hash inside the manifest itself.

After finalizing FROZEN content, compute an external immutable identity, e.g.:

    git hash-object audit/<ticket>-acceptance-manifest.md

Record that identity outside the hashed content: Orca/Lead state, commit metadata,
or another non-self-referential artifact. A committed blob/commit identity may serve
directly. Do not invent canonicalization.

## Ticket boundary

Map material adjacent concerns to backlog ownership before coding.

Work owned elsewhere is excluded unless ownership was explicitly moved, approved
cross-ticket scope exists, or canonical authority proves the current boundary wrong.
Implementation convenience does not redefine ownership.

## Invariants

State WHAT must be true and HOW it must be proven.
Do not prescribe mechanism unless already ratified.

## Implementation Approach

For high-risk work, create a short non-contractual artifact such as:

    audit/<ticket>-implementation-approach.md

Use roughly 5–15 bullets: intended enforcement layer, expected components/interfaces,
evidence strategy, and key implementation risks.

It is context for design review, not part of the frozen acceptance bar. It cannot
add criteria, override authority, or prescribe unnecessary detail.

## Gate evaluation

A raw tool result and a ticket acceptance verdict are different facts. Preserve both.

### Raw check result

Use the existing mechanical states:

- `PASS`
- `FAIL`
- `BLOCKED`
- `NOT_RUN`
- `NOT_APPLICABLE`

Never rewrite a raw FAIL as PASS because the failure is inherited.

### Gate scope

Every material gate declares one scope before candidate evaluation:

- `TICKET` — contributes to acceptance of this ticket.
- `RELEASE` — contributes to merge/release readiness, not automatically ticket acceptance.
- `INFORMATIONAL` — evidence only; cannot block ticket acceptance by itself.

### Gate evaluation mode

Every material gate declares one mode before candidate evaluation:

- `ABSOLUTE` — candidate must satisfy the check absolutely.
- `NO_REGRESSION` — candidate must not introduce or worsen findings relative to baseline.
- `CHANGED_SCOPE` — files/components materially changed by this ticket must satisfy the check.
- `EVIDENCE_ONLY` — collect/report the result without using it as an acceptance condition.

Use `ABSOLUTE` when canonical authority or the ticket contract genuinely requires a
clean absolute state. A repository-wide check with a dirty baseline MUST NOT default
to an absolute TICKET gate merely because the command exists. Prefer `NO_REGRESSION`
or `CHANGED_SCOPE` unless canonical authority explicitly requires full cleanup.

Do not choose or weaken a mode after seeing the candidate result merely to obtain DONE.
Mode/scope are part of the frozen acceptance contract.

### Gate verdict

Evaluate each gate as exactly one:

- `SATISFIED`
- `SATISFIED_WITH_BASELINE_DEBT`
- `UNSATISFIED`
- `INCONCLUSIVE`
- `WAIVED`

Typical mapping:

- raw PASS and acceptance rule met -> `SATISFIED`;
- raw FAIL caused only by proven inherited debt, with the configured no-regression or
  changed-scope rule satisfied -> `SATISFIED_WITH_BASELINE_DEBT`;
- candidate introduces/worsens an in-scope violation -> `UNSATISFIED`;
- required evidence cannot establish the rule -> `INCONCLUSIVE`;
- explicit scoped exception -> `WAIVED`, while preserving the raw result.

`SATISFIED_WITH_BASELINE_DEBT` is an accepted TICKET gate verdict. The inherited debt
must remain visible in residuals and may still affect a separate RELEASE gate.

### Proving no regression

Equal counts alone are insufficient when individual findings can change. Prefer:

- normalized baseline-vs-candidate finding-set comparison proving no candidate-only
  findings; or
- a deterministic changed-scope check proving all materially changed areas satisfy
  the rule; or
- another evidence method explicitly defined by the frozen Manifest.

If the baseline has 340 findings and the candidate also has 340, do not infer no
regression unless the evidence shows the finding set is unchanged or the changed
scope is clean.

### Ticket vs release readiness

Ticket acceptance, merge readiness, and release readiness are separate decisions.
A TICKET gate may be `SATISFIED_WITH_BASELINE_DEBT` while a distinct RELEASE gate
remains `UNSATISFIED` under repository-wide policy.

Do not report the ticket itself BLOCKED solely because unchanged, out-of-scope
baseline debt remains.

## Freeze / unfreeze

Freeze only when authority, scope/ownership, invariants/proof, blocking unknowns,
and required design review are sufficient.

After freeze, acceptance does not move silently.

Change only for canonical contradiction, approved requirement/scope change, or a
disproven material assumption:

    FROZEN vN -> CONTRACT_GAP/approved change -> DRAFT vN+1
    -> review if material -> FROZEN vN+1

Preserve prior identities and evidence history.

## Finding taxonomy

Every semantic finding has exactly one classification:

- `CONTRACT_GAP` — frozen contract conflicts with canonical authority.
- `IN_SCOPE_IMPLEMENTATION_DEFECT` — candidate violates frozen in-scope truth.
- `REQUIRED_EVIDENCE_GAP` — required proof is missing/stale/invalid/wrong-candidate.
- `OUT_OF_SCOPE_FINDING` — outside frozen ticket ownership.

And one disposition:

- `BLOCKING`
- `NON_BLOCKING`
- `FOLLOW_UP`
- `INFORMATIONAL`

Blocking findings cite the exact frozen criterion/invariant or canonical authority.
For an allowed Pattern B Manifest omission, cite its recorded bounded-contract
criterion instead; review authority and the finding taxonomy are unchanged.

Format:

```text
CLASSIFICATION: ...
DISPOSITION: ...
AUTHORITY: ...
EVIDENCE: ...
REQUIRED ACTION: ...
```

OUT_OF_SCOPE_FINDING cannot fail frozen ticket acceptance. Another explicit authority
may separately block release/merge.

Reviewers do not invent criteria or block on personal architectural preference.
