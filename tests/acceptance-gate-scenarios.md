# Acceptance Gate Scenarios

These scenarios exercise baseline-aware ticket acceptance. They are policy evals,
not executable repository tests.

## 1. Dirty formatter baseline, unchanged candidate

Baseline:
- `dotnet format --verify-no-changes` -> FAIL
- 340 normalized whitespace findings

Candidate:
- raw result -> FAIL
- normalized finding set identical to baseline
- candidate-only findings -> 0

Frozen gate:
- scope: TICKET
- mode: NO_REGRESSION

Expected:
- raw check result: FAIL
- gate verdict: SATISFIED_WITH_BASELINE_DEBT
- ticket outcome may be DONE when all other criteria/gates pass
- 340 findings remain explicit residual baseline debt
- no unrelated mass-formatting is required

## 2. Dirty formatter baseline, candidate adds one finding

Baseline:
- 340 normalized findings

Candidate:
- 341 findings
- candidate-only finding set contains one in-scope finding

Frozen gate:
- scope: TICKET
- mode: NO_REGRESSION

Expected:
- raw result: FAIL
- gate verdict: UNSATISFIED
- candidate requires correction before normal ticket acceptance

## 3. Equal counts but different findings

Baseline:
- 340 findings

Candidate:
- 340 findings
- 10 baseline findings removed
- 10 new candidate findings introduced

Frozen gate:
- scope: TICKET
- mode: NO_REGRESSION

Expected:
- equal counts are insufficient evidence
- new candidate findings make the gate UNSATISFIED
- do not report SATISFIED_WITH_BASELINE_DEBT solely from counts

## 4. Changed-scope cleanliness with repository debt

Baseline:
- repository-wide formatter FAIL
- unrelated legacy violations exist

Candidate:
- all files materially changed by the ticket are clean
- unrelated baseline violations remain

Frozen gate:
- scope: TICKET
- mode: CHANGED_SCOPE

Expected:
- raw repository-wide command may remain FAIL
- changed-scope gate verdict: SATISFIED_WITH_BASELINE_DEBT
- inherited debt is residual, not a ticket blocker

## 5. Baseline PASS, candidate FAIL

Baseline:
- build -> PASS

Candidate:
- build -> FAIL

Frozen gate:
- scope: TICKET
- mode: ABSOLUTE

Expected:
- gate verdict: UNSATISFIED
- ticket cannot be normally accepted

## 6. Required evidence unavailable

Frozen gate:
- scope: TICKET
- mode: ABSOLUTE
- required device/environment is unavailable

Expected:
- raw result: BLOCKED or NOT_RUN, as appropriate
- gate verdict: INCONCLUSIVE
- ticket outcome may be BLOCKED when acceptance cannot be determined and no valid waiver exists

## 7. Ticket passes while release gate remains red

Baseline:
- repository-wide formatting debt exists

Candidate:
- no candidate-only formatting findings
- all ticket criteria pass

Gates:
- ticket formatting gate: TICKET / NO_REGRESSION
- organization release formatting gate: RELEASE / ABSOLUTE

Expected:
- ticket gate: SATISFIED_WITH_BASELINE_DEBT
- ticket acceptance: DONE
- release readiness: blocked/unsatisfied under the independent release authority
- final report must distinguish ticket acceptance from release readiness

## 8. Out-of-scope defect discovered

Candidate satisfies all frozen ticket criteria.
Reviewer discovers an unrelated pre-existing defect outside ticket ownership.

Expected:
- classify as OUT_OF_SCOPE_FINDING
- cannot fail frozen ticket acceptance
- may create a follow-up
- may affect release only if another explicit authority makes it release-blocking
