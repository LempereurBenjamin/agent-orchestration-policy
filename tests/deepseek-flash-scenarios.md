# OpenAI-first routing static scenarios

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
