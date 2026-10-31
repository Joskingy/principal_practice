---
name: aws-security-review
description: Review this lab's architecture or infrastructure changes for threat boundaries, least privilege and accidental AWS execution.
---

# AWS security review

Read `AGENTS.md`, [ADR-0001](../../../docs/adr/0001-zero-cost-boundary.md), and the
[review checklist](../../../docs/security/review-checklist.md). This is a local
design/code review, not a request to scan an AWS account or upload code to a paid
security service.

Trace assets, actors, trust boundaries and intended data flows. Prioritize actual
paths to credential leakage, billable execution, public exposure, excess privilege,
or loss of recoverability. Relate each finding to a concrete scenario and cite the
affected configuration. Separate confirmed defects from unresolved questions.

Review backend access independently of providers. Missing endpoint overrides,
aliases, mocks, credential isolation or network restrictions invalidate the lab's
execution assurance. Never fetch secrets to prove that a secret is accessible.

For IAM, inspect generated policy structure and scope; a mocked policy output or
LocalStack Hobby success is not evidence of AWS permission enforcement. Ask the
learner to explain the attack path and propose the smallest adequate control.
Document severity, reasoning, validation evidence and remaining limitations.
