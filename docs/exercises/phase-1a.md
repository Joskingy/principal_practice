# Phase 1A: Establish the execution boundary

Objective: explain the actual workstation state and design a boundary that prevents
AWS access before running any infrastructure tests. Timebox: one manageable session;
progress is evidence-based, not calendar-based.

## Your assignment

1. Run `pwsh -NoProfile -File ./scripts/Get-LabInventory.ps1` from the repository.
   Inspect the Docker server result separately from the installed client. If a
   command is denied here, retry it in your normal PowerShell session before
   concluding that the underlying component is broken.
2. Check available disk space and record whether a 10 GB Docker/WSL allocation is
   appropriate. Do not change settings just to satisfy an assumption.
3. Complete [your worksheet](phase-1a-response.md). Keep raw reports in `.lab/`;
   only sanitized observations belong in Git.
4. Draft your reasoning on isolation, the disposable `brewmaster` mapping, and
   failure when a mock/endpoint is absent. Do not inspect credential files.
5. Predict the behavior of validate, plan, test, and a mocked VPC assertion before
   executing them. We will compare predictions with observations in Phase 1B.

Individual read-only commands, if you prefer them to the helper:

```powershell
$PSVersionTable.PSVersion
git --version
terraform version
docker version
docker compose version
wsl --status
wsl --list --verbose
```

No Terraform infrastructure commands, installation, AWS login, or emulator startup
are part of this assignment. The helper does not configure isolation for you.

## Submit

Sanitized findings and your written reasoning, including uncertainties. Do not send
credential files, tokens, account identifiers, state, or raw environment dumps.

## Completion gate

- Explain client versus server availability and any session restrictions.
- Explain each isolation layer and how a failure will be detected.
- Distinguish the design baseline from controls actually tested.
- Provide command predictions before the next milestone.
- Mentor review records ready / revise with a concrete reason.

## Guiding and interview questions

1. Why is a zero-dollar budget alarm insufficient protection?
2. Can a read-oriented Terraform command still contact an external API?
3. If a mocked subnet assertion passes, which network questions remain unanswered?
4. What would prevent a new contributor from adding an accidental deployment path?
5. What evidence would you require before trusting the isolated profile mapping?

Next milestone, after review: build the isolated runner, then **you** implement one
VPC resource with a valid CIDR test and a rejected-input test. No full VPC solution
is supplied in this repository.
