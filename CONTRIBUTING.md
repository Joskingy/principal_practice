# Development, review, and promotion

This is a public portfolio project with local-only execution. Do not publish raw
inventory reports, state, secrets, or personal infrastructure identifiers.

## Branches

`feature/*` branches merge into `dev` through a PR. A release PR promotes reviewed
work from `dev` to `main`. Environment directories are configuration boundaries,
not branch aliases. Promotion never deploys AWS resources.

After the first reviewed local commit, create the integration and learner branch:

```powershell
git branch dev main
git switch -c feature/phase-1a dev
```

If those branches already exist, inspect them rather than recreating them. A
separate worktree is useful for a genuinely concurrent assignment, not required
for every change. From the repository root, after `dev` exists:

```powershell
git worktree add .worktrees/network-review -b feature/network-review dev
git worktree list
```

The ignored worktree directory is not a security boundary. Later runners must use
distinct state directories and Compose project names for each worktree. Remove a
worktree only after checking its uncommitted work; do not use force removal.

## Checks and PR review

Current check: `pwsh -NoProfile -File ./scripts/Test-Foundation.ps1`.
The Foundation workflow uses a verified immutable checkout revision (v4.2.2),
standard Ubuntu, read-only repository access, and no persisted checkout credential.
This is an explicit compatibility pin, not a claim that v4.2.2 is the latest release.
Review action updates before Phase 1C.

Before publishing: inspect `git diff`, inspect staged files, complete the security
checklist, and remove personal reports. Do not assume `.gitignore` removes files
that have already been tracked. Add Gitleaks before accepting implementation PRs.

Protect `main` and `dev` against deletion and force pushes, require PRs and the
`Foundation / foundation` check, and resolve review conversations. A solo author
records a written review; do not require an approval the author cannot provide.
Protection is a remote setting and is not established by adding this document.

## Phase 1C extension

Add formatting, backend-disabled validation, TFLint, Trivy, Gitleaks (files and Git
history), mock-provider module tests, and three-environment composition tests.
Pin executable versions/checksums and provider lockfiles. Download dependencies
before offline execution. Public fork PRs must not receive emulator tokens.
Do not use `pull_request_target` to execute contributed code or self-hosted runners
for public contributions. No AWS credentials or OIDC token permission.

## Release record

Record the commit, environment changes, exact evidence, known gaps, migration and
rollback strategy, and outstanding risks. Never label a locally tested configuration
as AWS-deployment-qualified. State and module migrations are Phase 6 exercises.

## Sources

- [GitHub protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)
- [GitHub secure workflow use](https://docs.github.com/en/actions/reference/security/secure-use)
- [Pinned checkout revision](https://github.com/actions/checkout/commit/11bd71901bbe5b1630ceea73d27597364c9af683)
