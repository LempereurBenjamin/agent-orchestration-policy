# Family-aware routing static scenarios

These scenarios describe policy expectations; they are not runtime integration tests.

| Scenario | Expected outcome |
| --- | --- |
| Standard implementation | Under sol-terra, Sol leads/reviews and Terra implements at medium or high. |
| Difficult implementation | Under sol-terra, Terra max is allowed only when justified and effective support is verified. |
| Worker requests another model or effort | Escalate to Lead; no worker self-rerouting. |
| Codex account rotates to an eligible alias | Accept only the same authorized logical model and effective effort; record binding. |
| All eligible OpenAI accounts have confirmed quota exhaustion | Quota fallback is pre-authorized, subject to verified V4.1 Flash identity, effort, gate and safe handoff. |
| Temporary rate limit, auth error, unsupported model, or network failure | No quota fallback; apply applicable recovery rules. |
| Implementation or test failure | No provider fallback. |
| Lead exhausts OpenAI quota | Recover Lead on verified fallback from a reconciled checkpoint where supported; otherwise block. |
| Fallback or model change | Preserve frozen acceptance, candidate identity, correction history, and all counters. |
| Fallback gate or DeepSeek logical model identity cannot be verified | Block; do not claim automatic fallback works. Missing minor-snapshot disclosure alone does not trigger this block. |
| Orca 1.4.242 Pi worker fails without attributable quota evidence or verified fallback binding | Report `PI_ROUTING_BLOCKED`; worker output and redispatch alone do not establish fallback. |
| OpenAI quota recovers | Prefer OpenAI for new dispatches; leave running DeepSeek workers undisturbed. |

## Family selection and continuity

| Scenario | Expected outcome |
| --- | --- |
| Effective initial Lead model is OpenAI | Record OpenAI family and use its role table. |
| Effective initial Lead model is Anthropic | Record Anthropic family and use its role table; an Opus start does not force Opus workers. |
| `github-copilot/claude-opus-5.5` or `github-copilot/claude-sonnet-5.5` is the verified resolved initial model | Select Anthropic regardless of provider/account alias. |
| A virtual selection resolves to a verified effective model in another family | Classify the resolved effective model at admission; later switches do not reclassify the objective. |
| Effective initial identity is unknown or a virtual selection is unresolved | Report `PI_ROUTING_BLOCKED`; do not infer family from alias or prompt. |
| Eligible OpenAI or Anthropic account alias changes | Verify same authorized model and effective effort; retain recorded family. |
| All eligible Anthropic accounts have confirmed quota exhaustion | DeepSeek is pre-authorized subject to the same verified gate and recovery as OpenAI; family stays Anthropic. |
| DeepSeek task is running when family quota recovers | Prefer the selected family for new dispatches; do not interrupt the running task. |
| Resume occurs while DeepSeek is active | Restore the recorded family and reconcile bindings and counters. |
| Worker requests a different family or model | Escalate; no worker self-rerouting. |
| User requests a family change | Record explicit scope and decision; reconcile affected work and history before switching. |
| Anthropic route or effort is not verified | Block affected work; catalogue entries alone are not runtime proof. |
| Either family uses patterns A/B/C/D | Apply the same proportionality and execution rules. |

## Profile admission

| Scenario | Expected outcome |
| --- | --- |
| `Routing: sol-terra` | Sol Lead and Reviewer, Terra execution; verify effective bindings. |
| `Routing: sol-deepseek` | Sol Lead and Reviewer, DeepSeek execution; verify effective bindings. |
| No profile supplied | Use the documented configurable sol-terra default until a verified change. |
| sol-deepseek primary is not fallback | Use DeepSeek as primary; quota fallback has a separate gate. |
| Resume, retry or correction | Restore the recorded profile and bundle, verify binding and preserve counters. |
| Unavailable or mismatched binding | Block only affected dispatch; retain evidence, propose supported remediation. |
| Anthropic initial Lead | Anthropic family remains available under its table. |

## Subscription-first providers and transition boundaries

| Scenario | Expected outcome |
| --- | --- |
| Anthropic role admitted | Prefer official Claude Code CLI with Claude subscription; retain the Sonnet/Opus role table and effort. Verify authentication/billing, exact model, effort and Orca lifecycle before substantive work. |
| Claude CLI is unavailable or its Orca binding is unverified | Block affected work; do not silently use Pi Anthropic API/OAuth or change family/profile. Document the missing capability. |
| Claude alias, API key, gateway or automatic fallback changes model/billing | Stop affected continuation; reconcile and verify the authorized exact version, effort and subscription route. An alias or CLI flag is insufficient. |
| DeepSeek primary or an admitted cross-family quota fallback | Prefer Pi opencode-go/deepseek-v4.1-flash; verify provider-advertised V4.1 Flash identity and effective low/high effort; record the snapshot or unknown without requiring 1017. |
| Go has confirmed quota exhaustion; authorized PAYG account, privacy, V4.1 Flash identity, effort and Orca/Pi binding are verified | Lead may reconcile and hand off to DeepSeek Platform API PAYG without changing model, family or routing profile. |
| Go provider unavailability is confirmed after bounded retries and all PAYG gates pass | Same-model provider failover is permitted; provider unavailability alone never admits a cross-model/family fallback. |
| Generic 429, missing output, unknown quota, auth/configuration error or failed test | Insufficient evidence for Go-to-Platform failover; diagnose under bounded recovery. |
| Go privacy denial, unsupported model or unresolved logical model identity | Block; do not classify this as provider unavailability or silently use PAYG. |
| Go advertises V4.1 Flash and runtime binding/effort are verified, but its snapshot is unpublished | Permit standard development execution when all other gates pass; record snapshot unknown without claiming exact equivalence to 1017. |
| Eligible Go-to-Platform failover keeps V4.1 Flash and effective effort but exact snapshot equivalence is unknown | Permit the provider handoff when quota/unavailability, billing, privacy and recovery gates pass; record possible snapshot differences. |
| Provider updates a minor snapshot while still advertising V4.1 Flash | Record any published change, reverify effective binding and retain candidate-specific validation; possible behavioral differences are accepted without changing profile or counters. |
| Provider resolves to V4 Flash, V4 Pro or an unknown logical model | Block affected dispatch; the snapshot allowance does not authorize another model. |
| Task contract explicitly requires snapshot 1017 | Missing snapshot proof still blocks that task; the standard-development allowance does not override an explicit pin. |
| PAYG credentials/credit exist but billing is not authorized | Block paid failover; do not enable Go Extra Usage, auto-recharge or another billing pool. |
| Existing Go Extra Usage or Claude API credentials can bypass subscription billing | Verify effective billing and controls before work; pre-existing overflow settings do not authorize spending. |
| Go privacy permits data but Platform eligibility or ZDR renewal is unknown | Block affected route; verify each provider independently without loosening privacy controls. |
| Provider failover, model/family fallback, resume or retry | Preserve profile, family, policy bundle, objective/Goal state, budgets/counters, contracts, frozen acceptance, candidates and evidence; reconcile effects and reverify bindings. |
| Worker requests either transition | Escalate to Lead; worker cannot reroute itself. |
| Sol PR reviewer unavailable while Go/Platform is available | Block affected PR review; provider failover does not authorize replacing Sol with DeepSeek. |
