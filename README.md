# Pi-Orca orchestration policy

This repository distributes the global Pi instructions and the `orchestration-policy`
skill used to coordinate non-trivial engineering work with Pi and Orca. The policy
defines role boundaries, bounded graphs and correction loops, candidate-specific
evidence, independent review, recovery, and closure.

## Contents

- `AGENTS.md` is the global Pi instruction baseline.
- `skills/orchestration-policy/` is the policy skill and its on-demand references.
- `package.json` exposes only that skill as a Pi Git package; it does not install
  the global `AGENTS.md`.
- `COMPATIBILITY.md` records the supported capability contract.

Git commits and release tags identify policy bundles. Do not add a bundle version
inside policy documents.

## Routing profiles

- `gpt-6` is the default Sol/Luna profile.
- `gpt-6-astra` is an explicit quality-first GPT-6 profile: Astra owns high-impact
  coordination, architecture, and review; Sol handles semantic engineering
  (exploration, implementation, integration, and small review), while Luna handles
  bounded writing and validation.
- `deepseek-flash` is an explicit DeepSeek V4.1 Flash-only profile for objectives
  that cannot depend on OpenAI availability. Flash handles every model-backed
  role, including coordination, integration, architecture, and independent review;
  deterministic validation is preferred when sufficient.

The DeepSeek profile records actual routing and available token/cache metrics, but
does not make cost, quality, or savings claims. It never falls back automatically
when Flash is unavailable; see the policy's `DEEPSEEK_FLASH_BLOCKED` rule.
Launch the Pi Lead on Flash when selecting this profile; changing workers alone
does not remove an OpenAI dependency from an existing Lead session.

## Install as a Pi Git package

After obtaining access to this private repository, install a reviewed commit or
release tag. Pi discovers the skill from the package manifest:

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

## Source boundary

This repository intentionally contains only distributable instructions and policy
references. Never commit `~/.pi/agent` wholesale. In particular, credentials,
OAuth data, provider/model state, extensions, sessions, logs, and review artifacts
remain local runtime state.

See `CONTRIBUTING.md` for policy changes and `SECURITY.md` for security reporting.
