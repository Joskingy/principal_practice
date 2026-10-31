# Sanitized setup observations

Observed 2026-10-31 from the coding agent's restricted Windows session. These are
agent observations, not the learner's worksheet answers or proof of machine-wide
configuration. Repeat denied probes in the normal user terminal.

| Check | Observation |
|---|---|
| PowerShell | 7.6.5 |
| Git | 2.45.2.windows.1 |
| Terraform | 1.10.3, windows_amd64; no infrastructure commands run |
| Docker client | 28.1.1 |
| Docker server | local Linux engine pipe unavailable from this session |
| Compose | 2.35.1-desktop.1 |
| WSL status / distribution list | access denied from this session |
| Free workspace drive space | approximately 455 GiB at inventory time |
| Physical RAM | 32 GB, reported by learner; not independently measured |
| Docker/WSL memory cap | 10 GB proposed; actual setting not inspected or changed |
| GitHub CLI | installed, not authenticated |

No tool upgrades, service startup, WSL configuration changes, credential reads,
AWS API calls, remote repository creation, or publication were performed.

The `python` command resolved to an inaccessible Windows application alias during
skill validation. An existing UV-managed interpreter and cached YAML library were
used to run the skill validator without installing anything. Python is not required
for the checked-in Phase 1A inventory or foundation scripts.

Next action belongs to the learner: interpret these findings, confirm Docker/WSL
from their own terminal, and complete the independent execution-boundary reasoning.
