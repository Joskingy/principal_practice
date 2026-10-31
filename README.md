# AWS Three-Tier Engineering Lab

A self-paced engineering apprenticeship: design, implement, test, troubleshoot,
and defend a production-oriented AWS architecture without provisioning AWS resources.

**Current milestone: Phase 1A — workstation inventory and execution-boundary design.**
The repository contains the apprenticeship foundation. It does not yet contain
Terraform resources, a running emulator, or a verified isolated Terraform runner.
No AWS deployment is available. No cloud infrastructure has been tested.

## Start here

1. Read the [first assignment](docs/exercises/phase-1a.md).
2. Run the read-only workstation inventory from PowerShell 7:

   ```powershell
   pwsh -NoProfile -File ./scripts/Get-LabInventory.ps1
   ```

   It prints JSON; it does not install tools, start Docker, inspect credentials,
   or change machine settings. Local results can be saved outside Git:

   ```powershell
   New-Item -ItemType Directory -Force .lab/reports | Out-Null
   pwsh -NoProfile -File ./scripts/Get-LabInventory.ps1 > .lab/reports/inventory.json
   ```

3. Complete the [learner worksheet](docs/exercises/phase-1a-response.md) in your own words.
4. Validate the foundation:

   ```powershell
   pwsh -NoProfile -File ./scripts/Test-Foundation.ps1
   ```

This check verifies document links, PowerShell syntax, the tool catalog, and the
absence of premature infrastructure files. It does **not** run Terraform, TFLint,
Trivy, or Gitleaks. Those gates belong to Phase 1B/1C.

## Design and evidence

- [AWS reference architecture and module contracts](docs/architecture/reference.md)
- [Testing distinctions and resource coverage](docs/architecture/evidence-matrix.md)
- [Eight-phase roadmap and completion criteria](docs/roadmap.md)
- [Tool versions, licenses, and official sources](docs/tooling.md)
- [Execution-boundary decision](docs/adr/0001-zero-cost-boundary.md)
- [Git, worktrees, reviews, and promotion](CONTRIBUTING.md)
- [Progress and evidence tracker](docs/progress/tracker.md)
- [Security review checklist](docs/security/review-checklist.md)
- [Workstation troubleshooting](docs/runbooks/workstation.md)

The workload will be a small Python order service with PostgreSQL and a later
DynamoDB idempotency exercise. The reference architecture spans two Availability
Zones. Local containers share a workstation and cannot prove AWS AZ resilience.

## Non-negotiable boundary

No AWS credentials, AWS login, real AWS API calls, cloud backends, or live AWS
apply. Free Tier and budget alerts are not the protection mechanism. Later runners
must combine disposable credentials, explicit local endpoints, and network isolation.

The required profile name is `brewmaster`. Future lab commands will map it to a
dedicated local-only configuration. Your existing profile and credentials remain
untouched. The mapping has not yet been created.

Public GitHub hosting and standard public-repository runners are the planned CI
platform. The included `Foundation` workflow runs only for public repositories,
uses read-only permissions, and has no deployment steps, secrets, artifact uploads,
or caches. Hosted execution and branch protection remain unverified until publication.

## How learning works

Problem → alternatives → prediction → learner implementation → review → injected
failure → explanation → interview questions. Each completed milestone requires
both technical evidence and your explanation. Future modules are added only when
their assignment begins; empty module trees and generated solutions are deliberately
not included.

AI agents start with [AGENTS.md](AGENTS.md). Canonical skills live in
`.agents/skills/`; Claude Code has thin adapters in `.claude/skills/`.
