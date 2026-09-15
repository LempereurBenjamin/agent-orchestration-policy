#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$repo_root"

required_files=(
  AGENTS.md
  skills/orchestration-policy/SKILL.md
  skills/orchestration-policy/references/acceptance-manifest.md
  skills/orchestration-policy/references/model-routing-gpt56.md
  skills/orchestration-policy/references/model-routing-gpt6-astra.md
  skills/orchestration-policy/references/model-routing-astra-deepseek-flash.md
  skills/orchestration-policy/references/model-routing.md
  skills/orchestration-policy/references/recovery-and-learning.md
  skills/orchestration-policy/references/worker-contracts.md
  tests/astra-deepseek-flash-scenarios.md
  tests/acceptance-gate-scenarios.md
)

for file in "${required_files[@]}"; do
  [[ -f "$file" ]] || { echo "Missing required file: $file" >&2; exit 1; }
done

rg -q '^name: orchestration-policy$' skills/orchestration-policy/SKILL.md || {
  echo 'Skill frontmatter does not name orchestration-policy.' >&2
  exit 1
}

if rg -n '2\.3\.1' --glob '*.md' .; then
  echo 'Embedded policy version marker found.' >&2
  exit 1
fi

for required_literal in \
  'astra-deepseek-flash' \
  'deepseek/deepseek-v4-flash' \
  'DEEPSEEK_FLASH_BLOCKED'; do
  if ! rg -F -q "$required_literal" \
    AGENTS.md \
    skills/orchestration-policy \
    tests/astra-deepseek-flash-scenarios.md; then
    echo "Missing required composite-routing literal: $required_literal" >&2
    exit 1
  fi
done

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
