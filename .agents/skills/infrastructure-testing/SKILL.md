---
name: infrastructure-testing
description: Design and assess this lab's static, mocked, emulated and local-runtime tests without overstating AWS coverage.
---

# Infrastructure testing

Read `AGENTS.md`, the active exercise, and the
[evidence matrix](../../../docs/architecture/evidence-matrix.md).
Choose tests for a behavioral contract or realistic failure, not implementation
mirroring. Ask for the learner's predicted outcome before executing a new Terraform
operation. Do not fill the learner's prediction worksheet.

Classify each result as static, Terraform mock, local API or local runtime evidence.
Check that a negative fixture fails for the intended reason. An unexpected pass or
an unrelated setup failure does not demonstrate the intended protection.

Before Terraform runs, verify all providers and aliases are mocked or explicitly
local, backend access is controlled, and the runner prevents AWS traffic and host
credential access. Read [ADR-0001](../../../docs/adr/0001-zero-cost-boundary.md).
In Phase 1A, the available foundation check is structural only.

Report exact checks run, versions, results and gaps. Distinguish fixtures fabricated
by mocks from independently tested outputs. Keep raw reports, state and plans out
of Git. Update progress only for observed evidence, never assumed success.
