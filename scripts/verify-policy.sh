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
  skills/orchestration-policy/references/model-routing-gpt6.md
  skills/orchestration-policy/references/model-routing-gpt6-astra.md
  skills/orchestration-policy/references/model-routing-deepseek-flash.md
  skills/orchestration-policy/references/model-routing.md
  skills/orchestration-policy/references/recovery-and-learning.md
  skills/orchestration-policy/references/worker-contracts.md
  tests/deepseek-flash-scenarios.md
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
require_literal COMPATIBILITY.md '`--full` compatibility fallback'
require_literal skills/orchestration-policy/references/model-routing.md '`gpt-6` is the default'
require_literal skills/orchestration-policy/references/model-routing-gpt6.md 'gpt-6-sol'
require_literal skills/orchestration-policy/references/model-routing-gpt6.md 'gpt-6-luna'
require_literal skills/orchestration-policy/references/model-routing-gpt6-astra.md 'quality-first GPT-6 profile'
require_literal skills/orchestration-policy/references/model-routing-gpt6-astra.md 'gpt-6-astra'
require_literal skills/orchestration-policy/references/model-routing-gpt6-astra.md 'gpt-6-sol'
require_literal skills/orchestration-policy/references/model-routing-gpt6-astra.md 'gpt-6-luna'
require_literal skills/orchestration-policy/references/model-routing.md '`deepseek-flash` is available only after the user explicitly requests DeepSeek'
require_literal skills/orchestration-policy/references/model-routing-deepseek-flash.md 'deepseek/deepseek-flash'
require_literal skills/orchestration-policy/references/model-routing-deepseek-flash.md 'DEEPSEEK_FLASH_BLOCKED'
require_literal tests/deepseek-flash-scenarios.md 'Restore every recorded DeepSeek role binding'

flash_table=skills/orchestration-policy/references/model-routing-deepseek-flash.md
for role in Lead Explorer Implementer Writer Integrator Validator Architect Reviewer; do
  if ! rg -q "^\\| $role .*deepseek/deepseek-flash" "$flash_table"; then
    echo "DeepSeek-only profile does not bind $role to Flash." >&2
    exit 1
  fi
done
if rg -n 'gpt-[0-9]|astra-deepseek-flash|deepseek-v4-flash' "$flash_table"; then
  echo 'DeepSeek-only profile contains a legacy or OpenAI model route.' >&2
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

if [[ -e skills/orchestration-policy/references/model-routing-gpt56.md ]]; then
  echo 'Retired GPT-5.6 routing profile is still present.' >&2
  exit 1
fi

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
