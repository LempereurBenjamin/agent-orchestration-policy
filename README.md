# Pi-Orca orchestration policy

This repository distributes the global Pi instructions and the `orchestration-policy`
skill used to coordinate non-trivial engineering work with Pi and Orca. The policy
defines role boundaries, bounded graphs and correction loops, candidate-specific
evidence, independent review, recovery, and closure. It selects the smallest sufficient
execution pattern, uses a rough proportionality budget in existing execution state, and
stops when acceptance and required gates are satisfied.

## Contents

- `AGENTS.md` is the global Pi instruction baseline.
- `skills/orchestration-policy/` is the policy skill and its on-demand references.
- `package.json` exposes only that skill as a Pi Git package; it does not install
  the global `AGENTS.md`.
- `COMPATIBILITY.md` records the supported capability contract.

Git commits and release tags identify policy bundles. Do not add a bundle version
inside policy documents.

## Routing

New objectives classify the initial Lead family, then select `sol-terra` or
`sol-deepseek` for OpenAI routing. The configurable default is `sol-terra` until
DeepSeek's live binding is verified. The recorded profile stays fixed through recovery;
Anthropic remains available. See the authoritative `model-routing.md` and
`COMPATIBILITY.md` for binding, fallback, and unverified runtime capabilities.

A single ticket can use `/goal Routing: sol-deepseek. Implement ticket S-XX,
validate, review and open a PR for human approval. Do not merge.` A bounded backlog
can use `/goal Routing: sol-terra. Implement every ticket in release X, open a
separate reviewed PR for each, continue through the backlog, and do not merge.`
One parent Goal remains active until every requested deliverable is ready.

## Install as a Pi Git package

After obtaining access to this private repository, install a reviewed commit or
release tag. The v1 baseline is `v1.0.0`; v2 is unreleased until its tag exists. Pi discovers the skill from the package manifest:

```sh
pi install git:github.com/LempereurBenjamin/agent-orchestration-policy@<reviewed-tag-or-commit>
pi list
```

Review and merge the package checkout's `AGENTS.md` into your existing
`~/.pi/agent/AGENTS.md`. Pi does not install that file for you. Preserve unrelated
local instructions and keep credentials, provider settings, sessions, and logs out
of the repository. Use `pi list` to locate the package checkout and verify its
`skills/orchestration-policy/SKILL.md`; the package does not need a symlink into
the standard global skill directory. Run `scripts/verify-policy.sh` from that
checkout before using a new bundle.

Do not load a package copy and a manually installed copy of
`orchestration-policy` for the same new objective. If migrating an existing Pi
installation, first reconcile any active objectives pinned to the manual bundle,
then retire that copy from Pi's discovery path and restart Pi for new objectives.
Do not silently migrate active work.

## Manual setup on macOS

Pi's standard global agent directory is `~/.pi/agent`. If you do not use Pi's
package manager, keep the repository clone separate from runtime state:

```sh
git clone https://github.com/LempereurBenjamin/agent-orchestration-policy.git \
  "$HOME/.pi/agent/vendor/agent-orchestration-policy"

mkdir -p "$HOME/.pi/agent/skills"
ln -s "$HOME/.pi/agent/vendor/agent-orchestration-policy/skills/orchestration-policy" \
  "$HOME/.pi/agent/skills/orchestration-policy"
```

Then review and merge this repository's `AGENTS.md` into your existing
`~/.pi/agent/AGENTS.md`. Do not overwrite an existing global instruction file;
preserve local instructions that do not conflict with this policy. The policy's
standard path remains:

```text
~/.pi/agent/skills/orchestration-policy/SKILL.md
```

Before use, verify the link resolves and the repository passes its checks:

```sh
test -f "$HOME/.pi/agent/skills/orchestration-policy/SKILL.md"
"$HOME/.pi/agent/vendor/agent-orchestration-policy/scripts/verify-policy.sh"
```

## Updating

For a new objective, update only to a reviewed commit or release tag, rerun the
verification script, and restart Pi. Pi does not advance a pinned Git package ref
with `pi update`; select a new reviewed ref through Pi package management. An active
objective stays pinned to its recorded policy bundle until a migration is explicitly
recorded under the policy's recovery procedure.

For a manual clone:

```sh
cd "$HOME/.pi/agent/vendor/agent-orchestration-policy"
git fetch --tags origin
git checkout <reviewed-tag-or-commit>
scripts/verify-policy.sh
```

## Versioning and rollback

Release identities are immutable annotated Git tags `vMAJOR.MINOR.PATCH` and
commit SHAs; `package.json` must match its release tag. Major changes break routing,
execution, lifecycle or policy contracts; minor changes add compatible capabilities;
patch changes preserve behavior. Never move a release tag. For a new installation or
upgrade, pin the desired released tag (for example `@v2.0.0` only after release).
Rollback by removing the installed package through Pi package management and
reinstalling the earlier pinned release:

```sh
pi install git:github.com/LempereurBenjamin/agent-orchestration-policy@v1.0.0
```

 Preserve active objectives on
their recorded bundle and follow the explicit migration procedure if needed. Do not
create the v2 tag until review, merge and applicable compatibility checks pass.

## Source boundary

This repository intentionally contains only distributable instructions and policy
references. Never commit `~/.pi/agent` wholesale. In particular, credentials,
OAuth data, provider/model state, extensions, sessions, logs, and review artifacts
remain local runtime state.

See `CONTRIBUTING.md` for policy changes and `SECURITY.md` for security reporting.
