# Pi-Orca orchestration policy

This repository distributes the global Pi instructions and the `orchestration-policy`
skill used to coordinate non-trivial engineering work with Pi and Orca. The policy
defines role boundaries, bounded graphs and correction loops, candidate-specific
evidence, independent review, recovery, and closure.

## Contents

- `AGENTS.md` is the global Pi instruction baseline.
- `skills/orchestration-policy/` is the policy skill and its on-demand references.
- `COMPATIBILITY.md` records the supported capability contract.

Git commits and release tags identify policy bundles. Do not add a bundle version
inside policy documents.

## Routing profiles

- `gpt-5.6` is the default profile.
- `gpt-6-astra` is an explicit Astra-only profile.
- `astra-deepseek-flash` is an explicit composite profile: Astra coordinates,
  integrates, validates, and reviews; only focused research, coding/debugging, and
  writing/summaries use `deepseek/deepseek-v4-flash` at their documented efforts.

The composite profile records actual routing and available token/cache metrics, but
does not make cost, quality, or savings claims. It never falls back automatically
when Flash is unavailable; see the policy's `DEEPSEEK_FLASH_BLOCKED` rule.

## Setup on macOS

Pi's standard global agent directory is `~/.pi/agent`. Keep the repository clone
separate from runtime state, credentials, providers, sessions, and logs.

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
verification script, and restart Pi. An active objective stays pinned to its recorded
policy bundle until a migration is explicitly recorded under the policy's recovery
procedure; updating the clone does not silently migrate active work.

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
