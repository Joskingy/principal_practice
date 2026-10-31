# Self-paced milestone roadmap

Current assignment: [Phase 1A](exercises/phase-1a.md). Each substantial topic ends
with design defense and Senior/Principal interview questions. Completion requires
implementation evidence **and** the learner's independent explanation.

| Phase | Deliverables and independent exercise | Completion evidence | Career signal |
|---|---|---|---|
| 1 Engineering foundation | 1A inventory/safety reasoning; 1B isolated runner and learner's first mocked VPC; 1C public GitHub, branches/worktrees, CI and shared skills | fresh checkout checks; offline mock success; unmocked fixture blocked; deliberate defect fails CI; learner explains boundaries | reproducibility and secure automation |
| 2 Networking | network/access modules; address/route diagrams; NAT/endpoints ADR; fix wrong-AZ route and wrong SG | six subnets, invalid routes/rules rejected, request/return/egress paths explained | failure domains and segmentation |
| 3 Compute/application | ALB, launch template, ASG, profile, scaling; local proxy and two app instances; break health checks | module composition passes; local instance-loss recovery measured and explained | resilient delivery and diagnosis |
| 4 Data | RDS/DynamoDB, access patterns, encryption, backup/secrets design; restore PostgreSQL and interrupt cross-store writes | verify restored data and duplicate prevention; defend consistency, RTO/RPO and retention | data integrity and recoverability |
| 5 Security/observability | IAM/KMS/audit/WAF models, threat model, telemetry, alarms/runbooks; diagnose incident and narrow policy | local detection, evidence-based diagnosis, policy checks and remediation record | least privilege and operations |
| 6 Production Terraform | reusable contracts, promotion/drift/state/migration strategy; import local resource, moved refactor, recover state | no unintended replacement, detected drift, successful recovery, all environment fixtures pass | lifecycle ownership and governance |
| 7 Advanced platform | kind/EKS comparison first; then Lambda/EventBridge; then DNS/CDN design; drain node and test policies/events | actual local allow/deny, recovery and HPA response; AWS gaps recorded | platform judgment |
| 8 Portfolio/interviews | final README/diagrams/ADRs/runbooks/case study; unfamiliar incident and changed requirements | fresh checkout reproduction and independent defense of tradeoffs | technical leadership |

## Terraform concepts introduced when useful

- Phase 1: required versions/providers, variables, types, validation, outputs,
  provider mocks, planned/computed values, and lockfiles.
- Phase 2: `locals`, stable `for_each`, `count` address changes, subnet math and
  dependency graph reasoning. Do not generate keys from unknown computed values.
- Phase 3: implicit dependencies, selective `depends_on`, `dynamic` blocks versus
  explicit configuration, lifecycle/rollout consequences.
- Phase 4: data sources, sensitive values and state, encryption and secret references.
- Phase 6: aliases, module/provider contracts, import, `moved`, state manipulation,
  backend locking, drift, directory-based environments versus workspaces.

## Implementation gates

Introduce actual tool installations only after inventory review. Phase 1B creates
the runner and independently proves its restrictions; document inability to verify
Docker rather than silently running Terraform on the host. Phase 1C adds the full
format/validate/lint/security/mock/composition suite. The current Foundation workflow
does not stand in for those checks.

Each future module includes positive and negative tests, a documented contract,
an ADR for meaningful tradeoffs, and a troubleshooting exercise. Future directories
are created when work begins. Do not implement EKS, CloudFront, or serverless
resources to make the repository look more complete.

Use local state initially. Phase 6 models encrypted/versioned production S3 state
with native lockfiles and exercises only local resources. DynamoDB state locking
is deprecated in [Terraform's S3 backend](https://developer.hashicorp.com/terraform/language/backend/s3).

Phase 7 selects kind with Cilium for NetworkPolicy enforcement; reverify supported
versions and image digests before installation using the
[official kind integration](https://docs.cilium.io/en/stable/installation/kind/).
Multiple local nodes still share one physical host.

## Topic review rubric

Assess maintainability, security, reliability, high availability, scalability,
observability, cost, testability, automation and operational simplicity. Record the
alternatives considered, your choice, the failure mode, and what would make you
change your decision. A green test without an explanation does not complete a topic.
