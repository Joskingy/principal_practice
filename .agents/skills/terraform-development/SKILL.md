---
name: terraform-development
description: Develop and review this lab's Terraform assignments with staged learner ownership and explicit module contracts.
---

# Terraform development

Read the repository's `AGENTS.md`, active exercise and
[progress tracker](../../../docs/progress/tracker.md). Respect the active phase;
do not supply the learner's solution unless a focused worked example is requested.

Begin with the architectural contract and a prediction of Terraform's behavior.
Review input types, validation, output semantics, stable resource addressing and
dependency relationships. Compare alternatives with the learner before expanding
scope. Use the [reference architecture](../../../docs/architecture/reference.md)
to align module boundaries and avoid circular dependencies.

Do not run host Terraform against AWS-shaped configuration. The isolated runner
must first satisfy [ADR-0001](../../../docs/adr/0001-zero-cost-boundary.md).
In Phase 1A, only the foundation check and inventory are available. Later tests
must clearly state whether they use mocks or local API emulation.

Review a learner patch for correctness and rationale, then assign a small revision
or diagnostic exercise. Do not replace the whole module to fix one mistake.
Record tests actually run and outstanding verification gaps.
