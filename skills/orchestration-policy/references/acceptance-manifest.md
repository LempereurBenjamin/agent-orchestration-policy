# Acceptance Manifest

This file owns baseline, ticket-boundary, freeze/unfreeze, Implementation Approach,
and review-finding taxonomy.

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

## Required gates
- ...
- independent semantic review: YES/NO

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
