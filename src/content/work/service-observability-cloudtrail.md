---
title: Service Observability CloudTrail
publishDate: 2025-12-03 00:00:00
img: /assets/stock-2.jpg
img_alt: CloudTrail audit logging infrastructure with S3 storage and CloudWatch integration
description: |
  Opinionated logging patterns and pipelines that standardize how services emit
  structured audit trails, making issues faster to detect and diagnose. Faster
  incident response with consistent signals across accounts.
tags:
  - CloudFormation
  - AWS
  - Observability
  - Compliance
repo: https://github.com/stephenabbot/service-observability-cloudtrail
---

## The Problem

AWS accounts without CloudTrail enabled have no audit trail for API activity — no record of who changed what, when, or from where. In regulated environments, this is a compliance gap. In incident response, it means investigating blind.

## The Approach

CloudFormation-managed CloudTrail configuration establishes account-level API logging to a dedicated S3 bucket. Log file integrity validation is enabled. The deployment is automated and repeatable so it can be applied consistently across accounts.

## The Outcome

A reliable audit baseline that satisfies compliance requirements and enables post-incident forensics. Deployed as a reusable pattern that can be applied to any AWS account without manual configuration.

## Stack

| Technology | Purpose |
|------------|---------|
| AWS CloudTrail | API activity logging |
| AWS S3 | Log storage with integrity validation |
| AWS CloudFormation | Infrastructure provisioning |
| AWS KMS | Log encryption at rest |

**Repository**: [service-observability-cloudtrail](https://github.com/stephenabbot/service-observability-cloudtrail)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Automated, consistent deployment across accounts; no manual configuration
- **Security**: Full API audit trail; log file integrity validation; encryption at rest via KMS
- **Reliability**: S3 durability (99.999999999%); independent of application infrastructure
- **Performance Efficiency**: Managed service; no compute to maintain
- **Cost Optimization**: S3 Intelligent Tiering on log storage; minimal ongoing cost
- **Sustainability**: No idle compute; managed service footprint

</details>
