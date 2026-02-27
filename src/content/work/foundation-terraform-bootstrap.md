---
title: Foundation Terraform Bootstrap
publishDate: 2025-12-07 00:00:00
img: /assets/stock-1.jpg
img_alt: CloudFormation foundation infrastructure with S3, DynamoDB, and OIDC components
description: |
  A minimal bootstrap tool that creates the S3 and DynamoDB backends needed for Terraform state,
  with sensible defaults and guardrails. Teams can adopt Terraform with a secure, versioned backend
  in hours instead of days.
tags:
  - CloudFormation
  - AWS
  - Infrastructure
  - OIDC
repo: https://github.com/stephenabbot/foundation-terraform-bootstrap
---

## The Problem

Every Terraform project needs remote state storage, state locking, and CI/CD authentication before it can deploy anything. Creating these manually per project is inconsistent and error-prone — and you cannot use Terraform to create Terraform's own backend, creating a circular dependency.

## The Approach

CloudFormation manages the bootstrap resources (S3 bucket, DynamoDB lock table, OIDC provider) because it has no dependency on Terraform. SSM Parameter Store publishes the resulting resource identifiers at predictable paths so consuming projects can discover them without hardcoded values.

## The Outcome

A reusable foundation that any subsequent Terraform project can consume immediately. Teams get consistent state management, state locking, and keyless GitHub Actions authentication from a single deployment with no manual setup.

## Stack

| Technology | Purpose |
|------------|---------|
| AWS CloudFormation | Bootstrap orchestration (no Terraform dependency) |
| AWS S3 | Terraform remote state storage with versioning |
| AWS DynamoDB | State locking with point-in-time recovery |
| AWS IAM / OIDC | Keyless GitHub Actions authentication |
| AWS SSM Parameter Store | Resource discovery for consuming projects |

**Repository**: [foundation-terraform-bootstrap](https://github.com/stephenabbot/foundation-terraform-bootstrap)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Infrastructure as code; consistent naming and tagging patterns
- **Security**: OIDC eliminates long-lived credentials; least-privilege IAM roles; encryption at rest
- **Reliability**: S3 versioning; DynamoDB point-in-time recovery; multi-region support
- **Performance Efficiency**: S3 Intelligent Tiering; DynamoDB on-demand billing
- **Cost Optimization**: Shared infrastructure across projects; automated lifecycle policies
- **Sustainability**: Serverless managed services; no idle compute

</details>
