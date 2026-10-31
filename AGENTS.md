# AWS engineering apprenticeship

## AWS Agent Settings

- Always use AWS profile `brewmaster` when an AWS-compatible local client is needed.
- Execute toolkit commands using the local AWS profile mapping. In this repository
  that means an isolated, disposable mapping with dummy credentials, never the
  workstation's existing AWS configuration. The mapping is not implemented in 1A.
- Do not use AWS execution connectors, AWS login, actual AWS endpoints, or cloud
  resource discovery. Official documentation access is allowed.

## Current assignment and ownership

Read `docs/progress/tracker.md` and the active exercise before changing code.
The active milestone is Phase 1A. Preserve the incremental apprenticeship: do not
generate future infrastructure modules or fill in the learner's answers. Explain
the problem, invite a prediction, review the learner's work, and offer progressively
more specific hints. A request for a focused example may authorize that example.

## Execution boundary

- No real AWS credentials, public AWS API traffic, AWS apply, cloud backend,
  credential mount, or cloud deployment automation.
- Terraform tests are not intrinsically safe. Do not run them until the Phase 1B
  isolation controls and negative checks are implemented and verified.
- Keep local emulation, mocked configuration, static analysis, and actual local
  process behavior distinct in every result. Never claim AWS qualification.
- No paid trial, cloud build/offload, or paid API is a prerequisite. Recheck license
  and feature entitlement before introducing a tool.
- No credential inspection, secret values, state, plans, emulator data, or raw
  machine reports in Git. The existing host AWS profile must remain untouched.

## Workflow

Use PowerShell 7 entry points. Current check: `pwsh -NoProfile -File
./scripts/Test-Foundation.ps1`. The inventory script is read-only. Update evidence
honestly: prepared, implemented, locally verified, and learner-demonstrated are
different states. Keep `main` reviewed; integrate through `dev` and `feature/*`.
Use worktrees only when isolation is useful, with separate runtime/state directories.

Canonical skills are in `.agents/skills/`. Claude adapters delegate to those files;
do not duplicate their policy. Shared rules live here and in ADR-0001.
