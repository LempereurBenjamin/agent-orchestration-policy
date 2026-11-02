#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

required_files=(
  AGENTS.md
  COMPATIBILITY.md
  package.json
  skills/orchestration-policy/SKILL.md
  skills/orchestration-policy/references/acceptance-manifest.md
  skills/orchestration-policy/references/model-routing.md
  skills/orchestration-policy/references/recovery-and-learning.md
  skills/orchestration-policy/references/worker-contracts.md
  tests/model-routing-scenarios.md
  tests/acceptance-gate-scenarios.md
)

for file in "${required_files[@]}"; do
  [[ -f "$file" ]] || { echo "Missing required file: $file" >&2; exit 1; }
done

node -e '
const fs = require("node:fs");
const pkg = JSON.parse(fs.readFileSync("package.json", "utf8"));
if (pkg.name !== "agent-orchestration-policy" || pkg.private !== true ||
    !pkg.pi || Object.keys(pkg.pi).length !== 1 ||
    !Array.isArray(pkg.pi.skills) || pkg.pi.skills.length !== 1 ||
    pkg.pi.skills[0] !== "./skills/orchestration-policy" ||
    pkg.scripts || pkg.dependencies || pkg.devDependencies) {
  throw new Error("Pi package must expose only the orchestration-policy skill without install scripts or dependencies");
}
'

rg -q '^name: orchestration-policy$' skills/orchestration-policy/SKILL.md || {
  echo 'Skill frontmatter does not name orchestration-policy.' >&2
  exit 1
}

if rg -n '2\.3\.1' --glob '*.md' .; then
  echo 'Embedded policy version marker found.' >&2
  exit 1
fi

require_literal() {
  local file=$1
  local literal=$2

  if ! rg -F -q -- "$literal" "$file"; then
    echo "Missing required literal '$literal' in $file" >&2
    exit 1
  fi
}

require_literal skills/orchestration-policy/SKILL.md 'orca skills get orchestration'
require_literal skills/orchestration-policy/SKILL.md '--reference references/<file>.md'
require_literal skills/orchestration-policy/SKILL.md 'use `--full` once as a compatibility'
require_literal COMPATIBILITY.md 'orca skills get orchestration'
require_literal COMPATIBILITY.md '--reference references/<file>.md'
require_literal COMPATIBILITY.md '`--full` compatibility'
routing=skills/orchestration-policy/references/model-routing.md
for literal in \
  '| Lead / Plan | `gpt-5.6-sol` / medium | `gpt-6.1-sol` / high | high |' \
  '| Explorer | `gpt-6.1-terra` / medium | `gpt-6.1-terra` / high | low or high |' \
  '| Implementer | `gpt-6.1-terra` / high | `gpt-6.1-terra` / max | high |' \
  '| Integrator | `gpt-6.1-terra` / high | `gpt-6.1-terra` / max | high |' \
  '| Architect | `gpt-6.1-sol` / high | `gpt-6.1-sol` / high | high |' \
  '| Reviewer | `gpt-5.6-sol` / high | `gpt-6.1-sol` / high | high |' \
  '| Writer | `gpt-6.1-terra` / medium | `gpt-6.1-terra` / high | low or high |' \
  '| Validator | deterministic tools preferred | model only when necessary | deterministic tools, otherwise low or high |' \
  'Workers cannot select, escalate, or replace their own route.' \
  'account actually provides the same authorized model and effective effort.' \
  'resets attempt, correction, retry, or capacity counters, nor acceptance criteria.' \
  'after eligible account rotation.' \
  'and reconcile uncertain work first.' \
  'existing checkpoint, frozen contract, candidate and dispatch identities, and counters,' \
  'on **all eligible accounts of the selected family**' \
  'failures are not quota exhaustion and do not trigger fallback.' \
  'The route identifier alone does not prove the' \
  'report `PI_ROUTING_BLOCKED`' \
  'automatic Pi worker fallback is unsupported by the verified' \
  'not on `--retry-of` alone.' \
  'This applies to the Lead as well as workers.'; do
  require_literal "$routing" "$literal"
done
for literal in \
  'An initial OpenAI model selects OpenAI routing; an initial Anthropic model selects' \
  'DeepSeek fallback and later model switches. Resume restores the recorded family' \
  'The normalized IDs `claude-opus-5.5` and `claude-sonnet-5.5` select Anthropic.' \
  '`github-copilot/claude-opus-5.5` selects Anthropic' \
  '`github-copilot/claude-sonnet-5.5` selects Anthropic' \
  'A user-requested family change requires an explicit scoped routing decision' \
  'If identity or family cannot be established, report' \
  'The common patterns A/B/C/D, proportionality budgets' \
  '| Implementer | Claude Sonnet 5.5 / high | Claude Opus 5.5 / high |' \
  'These are preferences, not proof of an executable provider binding.'; do
  require_literal "$routing" "$literal"
done
require_literal skills/orchestration-policy/references/recovery-and-learning.md 'Restore the recorded bundle and family'
require_literal skills/orchestration-policy/references/worker-contracts.md 'Pi / <recorded family> / <logical model ID> / <effort>'
require_literal skills/orchestration-policy/references/worker-contracts.md 'Governing policy bundle and objective state: <resolvable references>'
require_literal tests/model-routing-scenarios.md '`github-copilot/claude-opus-5.5` or `github-copilot/claude-sonnet-5.5`'
require_literal COMPATIBILITY.md 'not a live provider acceptance'
require_literal tests/model-routing-scenarios.md 'Worker requests a different family or model'
# Guard the presence of the cross-role policy and its concrete boundary scenarios.
require_literal AGENTS.md 'Do not silently expand scope for theoretical robustness'
require_literal AGENTS.md 'A tautological test'
require_literal skills/orchestration-policy/SKILL.md 'Existing cumulative limits remain'
require_literal skills/orchestration-policy/SKILL.md 'Once approved acceptance criteria, mandatory validation gates, and required independent'
require_literal skills/orchestration-policy/references/worker-contracts.md 'All roles apply the shared AGENTS.md rule'
require_literal tests/acceptance-gate-scenarios.md '## 17. Speculative robustness and test selection'
require_literal tests/acceptance-gate-scenarios.md '## 18. Proportionality budget exceeded'

require_literal tests/model-routing-scenarios.md 'not runtime integration tests'
require_literal COMPATIBILITY.md 'no ordered fallback list'
require_literal COMPATIBILITY.md 'The `pi-subagents` fallback list is not an Orca capability.'
require_literal tests/model-routing-scenarios.md 'worker output and redispatch alone do not establish fallback.'

if rg -n 'model-routing-(gpt6|deepseek)' --glob '*.md' --glob '*.sh' .; then
  echo 'Obsolete routing profile reference remains.' >&2
  exit 1
fi
if compgen -G 'skills/orchestration-policy/references/model-routing-*.md' > /dev/null; then
  echo 'Obsolete routing profile remains.' >&2
  exit 1
fi

for required_literal in \
  'SATISFIED_WITH_BASELINE_DEBT' \
  'NO_REGRESSION' \
  'CHANGED_SCOPE'; do
  if ! rg -F -q "$required_literal" \
    skills/orchestration-policy/SKILL.md \
    skills/orchestration-policy/references/acceptance-manifest.md \
    skills/orchestration-policy/references/worker-contracts.md \
    tests/acceptance-gate-scenarios.md; then
    echo "Missing required baseline-aware acceptance literal: $required_literal" >&2
    exit 1
  fi
done

for prohibited in \
  auth.json \
  models.json \
  models-store.json \
  pi-multi-account-proxy-oauth.json \
  provider-failover.json \
  provider-failover-state.json \
  provider-failover-debug.log \
  'sessions/**' \
  'reviews/**' \
  '*.jsonl' \
  '*.log' \
  'npm/**'; do
  if git ls-files -- "$prohibited" | grep -q .; then
    echo "Prohibited runtime file is tracked: $prohibited" >&2
    exit 1
  fi
done

echo 'Policy repository verification passed.'
