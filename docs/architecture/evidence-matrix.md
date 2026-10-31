# Evidence and service coverage

Every claim must state its evidence category, tool version, command, observed
result, and remaining gap. Currently no resource-level test has been run.

| Category | Establishes | Does not establish |
|---|---|---|
| Static | syntax, types, selected policy and configuration relationships | deployment or runtime success |
| Terraform mock | expression/graph behavior, settings, contracts and assertions with synthetic outputs | AWS API semantics, IAM enforcement, actual routing or failover |
| Local API | selected requests and lifecycle behavior against an emulator | full AWS compatibility, service scale or managed durability |
| Local runtime | actual local processes, requests, faults, recovery and persistence | AWS service internals or independent AZ resilience |

All planned resources receive static and mock configuration checks. The following
matrix describes additional candidates, not verified emulator integration coverage.

| Resources | Hobby API candidate | Local runtime / unverified behavior |
|---|---|---|
| VPC, subnets, route tables/routes, IGW, NAT, SG, endpoints | Selected EC2 CRUD representations | container segmentation; AWS routing/enforcement unverified |
| EC2, launch template, EBS | Selected CRUD only | app containers; no EC2 boot/IMDS/EBS proof |
| ASG and scaling policies | unavailable | replica failure; later HPA is a different controller |
| ALB, listeners, target groups, health checks | unavailable | local reverse proxy |
| RDS and DB subnet group | unavailable | PostgreSQL transaction/restore/failure drills |
| DynamoDB table/index | selected API/data tests | no managed throughput/durability proof |
| IAM role/policy/instance profile | representations, no enforcement | static review and threat model |
| KMS key/alias and Secrets Manager | selected APIs | retrieval/error handling; no AWS authorization/crypto assurance |
| CloudWatch metrics/logs/alarms | selected APIs | local telemetry; AWS alarm execution unverified |
| CloudTrail and VPC Flow Logs | trail unavailable; flow delivery not relied on | synthetic evidence |
| S3 audit/state storage and SNS | selected APIs | no managed durability/delivery proof |
| WAF and ACM | WAF unavailable; selected ACM APIs | local TLS/input/rate-limit exercises |
| Route 53 and CloudFront | selected DNS APIs; CloudFront unavailable | local DNS/cache; no global behavior |
| EKS | unavailable | kind; no EKS/AWS CNI/managed-node equivalence |
| Lambda and EventBridge | selected APIs/execution candidates | local event behavior; quotas/scaling/delivery unverified |

Sources reviewed 2026-10-31: [LocalStack entitlements](https://docs.localstack.cloud/aws/licensing/)
and [EC2's CRUD-only Hobby behavior](https://docs.localstack.cloud/aws/services/ec2/).
Before each emulator exercise, check its exact operations and pinned version.

Mocked data sources can fabricate the result being asserted. In particular, a
mocked IAM-policy-document output is not proof that a generated policy is correct.
Prefer inspecting the actual policy expressions/JSON and independently reviewing
actions, resources, principals and conditions.

`terraform test` defaults to apply and may provision real resources. An explicit
mock and an isolated runner are both needed. Plan-based assertions are the initial
default; later mock applies require the same boundary. Unknown/computed values
must be handled deliberately, not replaced with fixtures that hide real defects.

Sources: [mocking](https://developer.hashicorp.com/terraform/language/tests/mocking),
[test execution](https://developer.hashicorp.com/terraform/language/tests).

## Required future negative scenarios

- Overlapping CIDRs, missing AZ, database internet route, wrong-AZ NAT route.
- Public app/database ingress, missing encryption, inadequate backups.
- Wrong health-check path/port and a missing IAM resource restriction.
- Missing provider mock/alias, public backend, or absent local endpoint.
- Changed `for_each` key causing replacement; migration with `moved` instead.
- Duplicate order request, database outage, and interruption between stores.

Fixtures must live outside normal environments, declare an expected failure, and
fail the suite if they unexpectedly pass. Synthetic incident evidence must be
labeled as such. Do not run broken configurations against AWS.
