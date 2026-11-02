# Family-aware routing static scenarios

These scenarios describe policy expectations; they are not runtime integration tests.

| Scenario | Expected outcome |
| --- | --- |
| Standard implementation | Lead selects Terra high; straightforward work may use medium. |
| Difficult implementation | Lead may start Terra max when its effective support is verified. |
| Worker requests another model or effort | Escalate to Lead; no worker self-rerouting. |
| Codex account rotates to an eligible alias | Accept only the same authorized logical model and effective effort; record binding. |
| All eligible OpenAI accounts have confirmed quota exhaustion | Quota fallback is pre-authorized, subject to verified version, effort, gate and safe handoff. |
| Temporary rate limit, auth error, unsupported model, or network failure | No quota fallback; apply applicable recovery rules. |
| Implementation or test failure | No provider fallback. |
| Lead exhausts OpenAI quota | Recover Lead on verified fallback from a reconciled checkpoint where supported; otherwise block. |
| Fallback or model change | Preserve frozen acceptance, candidate identity, correction history, and all counters. |
| Fallback gate or DeepSeek version cannot be verified | Block; do not claim automatic fallback works. |
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
