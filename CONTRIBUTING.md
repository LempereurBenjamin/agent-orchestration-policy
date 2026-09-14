# Contributing

Policy changes must preserve the distinction between authority, acceptance,
repository evidence, and execution constraints. Keep guidance concise, use the
existing references for conditional material, and avoid adding runtime-specific
claims without evidence.

Before opening a change:

1. Keep runtime state out of the repository.
2. Update `COMPATIBILITY.md` when installation or required Pi/Orca capability changes.
3. Run `scripts/verify-policy.sh` and `git diff --check`.
4. Review the final candidate independently when the policy requires it.

Do not add embedded bundle version markers to policy documents. Use reviewed Git
commits and release tags as the bundle identity. Changes affecting active objectives
require the policy migration procedure in `recovery-and-learning.md`.
