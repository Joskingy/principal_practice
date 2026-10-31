# ADR-0001: Keep all executable infrastructure local

Date: 2026-10-31. Status: design accepted in the apprenticeship plan;
**execution controls not yet implemented or verified**.

## Context

The learner already has AWS experience and an existing `brewmaster` profile.
The lab must incur no AWS charges and must not depend on real AWS credentials.
Production-style configuration alone does not justify actual AWS deployment.

## Decision

Use four explicit evidence categories: static, Terraform mock, local API emulation,
and local runtime behavior. No AWS qualification claims. No AWS execution connector
or account discovery, even for seemingly harmless setup.

Phase 1A contains documentation and fixed read-only inventory commands only.
Phase 1B must establish these controls before any Terraform test:

1. Prepare verified tool/provider dependencies in a separate download stage.
2. Execute mock tests with network disabled, no host credentials, no Docker socket,
   and only the reviewed project files available.
3. Map profile `brewmaster` to an isolated disposable config containing dummy local
   credentials; never read, copy, or overwrite the real workstation profile.
4. Reject non-mocked AWS providers/aliases, external commands, and provisioners.
5. Reject cloud backends; provider and backend configurations are independent.
6. For later emulator runs, expose only the intended local service network to clients,
   explicitly configure service endpoints, and block public AWS egress. Missing
   endpoint mappings must fail rather than use AWS defaults.
7. Keep emulator licensing traffic separate from client execution. Disable cloud
   forwarding/replication and never attach actual AWS credentials to the emulator.
8. Give hosted CI no AWS credentials, login step, OIDC permission, or deployment path.

Dummy credentials are not a firewall. Endpoint overrides are not a guarantee that
every service or backend is redirected. Provider skip-validation flags are not
isolation. The layered controls must be exercised with negative tests.

## Alternatives

Free Tier, credits, budget alarms, and quick destroy do not enforce zero charges.
Running the whole architecture in LocalStack is not viable on the selected free
plan and would not prove AWS equivalence anyway. Mocks alone do not exercise
application behavior. Combining explicit evidence categories provides useful
coverage while keeping limitations visible.

## Consequences and acceptance

No live AWS deployment or drift check is supported. Local state is disposable and
gitignored; production state strategy remains a documented design until a local
backend exercise is introduced. No secret/state values in evidence.

Before marking 1B complete, demonstrate that mocks work offline, a real-provider
fixture is rejected, a missing alias fails, and host credentials cannot be read.
Before emulator execution, demonstrate fail-closed endpoints and isolated traffic.
Do not infer any of these outcomes from the existence of this ADR.

The learner records their own explanation in the
[Phase 1A worksheet](../exercises/phase-1a-response.md). That explanation remains
an independent assignment; this document is the agreed design baseline.
