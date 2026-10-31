# Engineering security review

Apply relevant questions to each milestone; record gaps rather than checking boxes
without evidence. Security scanning is planned for 1C and is not yet implemented.

- [ ] Execution cannot access host AWS credentials or contact AWS services.
- [ ] All AWS-compatible local commands use isolated `brewmaster` mapping.
- [ ] Backend access is evaluated separately from provider endpoints.
- [ ] Missing mocks, aliases, endpoints and forbidden execution are rejected.
- [ ] Tool licenses, free-feature availability, checksums and image pins reviewed.
- [ ] No secrets, state, plans, raw reports or actual identifiers in commits.
- [ ] CI has minimal permissions, no AWS credentials/OIDC, no deployment path.
- [ ] External contributor code cannot receive tokens or run on a personal runner.
- [ ] Relevant network boundaries and permitted traffic are explicit.
- [ ] IAM actions/resources/principals/conditions reflect the workload's needs.
- [ ] Encryption, secret lifecycle, backups and recovery have explicit owners.
- [ ] Detection and response are backed by appropriate evidence.
- [ ] Suppressions identify reason, owner and review date; no blanket ignore.
- [ ] Availability, scalability, cost and operational complexity tradeoffs explained.

Threat modeling starts with assets, actors, trust boundaries and data flows. Consider
credential leakage, accidental cloud execution, public exposure, privilege escalation,
dependency compromise, duplicate transactions, loss of state and absent telemetry.
Distinguish a configuration policy check from tested runtime enforcement.
