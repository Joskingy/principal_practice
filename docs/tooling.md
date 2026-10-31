# Tool selection and version review

Review date: 2026-10-31. These are the accepted plan's **target pins**, not claims
about installed tools or tested compatibility. Machine-readable values are in
[the catalog](../config/tool-versions.json). No installer runs in Phase 1A.

| Tool | Target | License / decision | Official source |
|---|---|---|---|
| Terraform | 1.17.1 | BUSL; suitable for this educational lab | [release](https://github.com/hashicorp/terraform/releases/tag/v1.17.1), [license](https://github.com/hashicorp/terraform/blob/main/LICENSE) |
| AWS provider | 6.71.0 | MPL-2.0; pin and lock Windows/Linux checksums | [release](https://github.com/hashicorp/terraform-provider-aws/releases/tag/v6.71.0), [license](https://github.com/hashicorp/terraform-provider-aws/blob/main/LICENSE) |
| Docker Desktop | 4.97.0 | personal/educational use free; no cloud offload | [release notes](https://docs.docker.com/desktop/release-notes/), [terms](https://docs.docker.com/subscription-billing/desktop-license/) |
| Compose | 5.6.1 | Apache-2.0; primary local runtime | [release](https://github.com/docker/compose/releases/tag/v5.6.1), [license](https://github.com/docker/compose/blob/main/LICENSE) |
| LocalStack | 2026.10.0 | authenticated Hobby, non-commercial; optional selected APIs | [release](https://blog.localstack.cloud/localstack-for-aws-release-2026-10-0/), [plans](https://docs.localstack.cloud/aws/licensing/) |
| TFLint | 0.65.0 | executable bound by MPL-2.0 and BUSL | [release](https://github.com/terraform-linters/tflint/releases/tag/v0.65.0), [license](https://github.com/terraform-linters/tflint#license) |
| TFLint AWS rules | 0.49.0 | pin alongside TFLint | [release](https://github.com/terraform-linters/tflint-ruleset-aws/releases/tag/v0.49.0) |
| Trivy | 0.76.1 | Apache-2.0; selected IaC/image scanner | [release](https://github.com/aquasecurity/trivy/releases/tag/v0.76.1), [license](https://github.com/aquasecurity/trivy/blob/main/LICENSE) |
| Gitleaks CLI | 8.30.1 | MIT; files and Git-history scanning | [release](https://github.com/gitleaks/gitleaks/releases/tag/v8.30.1), [license](https://github.com/gitleaks/gitleaks/blob/master/LICENSE) |
| Checkov | 3.3.30 | Apache-2.0; alternative evaluated in Phase 5 | [release](https://github.com/bridgecrewio/checkov/releases/tag/3.3.30), [project](https://github.com/bridgecrewio/checkov) |
| kind | 0.33.0 | Apache-2.0; deferred to Phase 7 | [release](https://github.com/kubernetes-sigs/kind/releases/tag/v0.33.0), [license](https://github.com/kubernetes-sigs/kind/blob/main/LICENSE) |
| Kubernetes | upstream 1.37.1; kind image 1.37.0 | distinguish upstream patch from published kind image | [upstream](https://kubernetes.io/releases/), [kind images](https://github.com/kubernetes-sigs/kind/releases/tag/v0.33.0) |

Recheck versions, licenses and compatibility at installation, especially deferred
tools. Never invent an artifact digest or checksum. Record verified digests before
adding an image to the runner. Provider lockfiles are generated from actual signed
release metadata, not handwritten. A tool catalog is not a dependency lockfile.

For the 32 GB workstation, start with a proposed 10 GB WSL/Docker cap. Run Kubernetes
separately from the complete Compose lab. Measure usage before changing the cap;
this repository does not edit `.wslconfig` or restart WSL.

GitHub Actions uses standard Ubuntu runners only in public repositories. No larger
runners, cloud builds, paid trial, or artifacts/caches initially. Read the current
[billing terms](https://docs.github.com/en/billing/concepts/product-billing/github-actions)
before enabling additional features. No dependency on paid AI automation.

LocalStack authentication is not AWS authentication. Keep its token local and out
of public fork workflows. Never fall back to paid features to finish an exercise.
If LocalStack is unsuitable, consider DynamoDB Local for data-plane tests, documenting
its [limitations](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.UsageNotes.html).

Agent discovery sources: [Codex](https://learn.chatgpt.com/docs/build-skills),
[Cursor](https://cursor.com/docs/skills), [Claude Code](https://code.claude.com/docs/en/skills).
