# Progress and evidence tracker

Active milestone: **1A**. All learner demonstrations remain pending.

| Milestone | Materials / implementation | Verification | Learner gate |
|---|---|---|---|
| 1A | foundation, docs, read-only inventory and worksheet prepared | see local verification record below | awaiting inventory interpretation and independent reasoning |
| 1B | not started; no Terraform resource/runner | not run | predict and implement first mocked VPC |
| 1C | Foundation workflow prepared; full IaC CI not implemented | hosted checks and remote protections not verified | explain PR and promotion controls |
| 2–8 | curriculum documented, modules not implemented | not run | future assignments |

## Local verification record

Implementation checks are recorded by the implementing agent after execution.
Do not convert these checks into learner credit or claim AWS behavior was verified.

- Foundation structural validation: passed on Windows / PowerShell 7.6.5, 2026-10-31.
  Local links, PowerShell syntax and target version syntax checked. Seven temporary
  negative fixtures rejected: `.tf`, `.tf.json`, `.tftest.hcl`, `.tfbackend`, state,
  a local environment file, and a broken document link. No fixture was executed.
- Read-only inventory helper: ran successfully; Docker server unavailable and WSL
  probes denied in this session. See [sanitized observations](workstation-observations.md).
- Skill frontmatter/reference validation: all three canonical skills and three
  Claude adapters passed the bundled skill validator. Local links also passed.
- Foundation workflow: YAML parsed and intended permissions/runner/credential
  persistence settings checked locally. Hosted execution not run.
- Git: initialized local `main`; no commits, remote, `dev`, or feature branch yet.
  Ignore rules verified for reports, worktrees, environment files and state;
  provider lockfiles remain eligible for version control.
- GitHub publication: pending; local GitHub CLI was not authenticated at setup.

No Terraform validation/tests, security scanners, container workloads, or isolation
acceptance tests were run. Phase 1A is not complete until the learner's submission
and review. Phase 1B and the full Phase 1C pipeline remain future work.

## Evidence entry format

For each future result record: date, commit, assignment, author, command/tool version,
evidence category, expected result, observed result, remaining limitations, and review.
Raw machine reports stay in ignored `.lab/reports/`. Summaries omit credentials,
personal paths, account identifiers and tokens.
