---
title: Foundation IAM Deploy Roles
publishDate: 2025-12-06 00:00:00
img: /assets/stock-1.jpg
img_alt: IAM roles and OIDC authentication for secure GitHub Actions deployment
description: |
  Creates IAM roles for GitHub Actions workflows to deploy AWS infrastructure 
  without long-lived credentials using OIDC trust policies.
tags:
  - OpenTofu
  - AWS
  - IAM
  - OIDC
repo: https://github.com/stephenabbot/foundation-iam-deploy-roles
---

## The Problem

CI/CD pipelines that deploy to AWS typically use long-lived IAM access keys stored as secrets. These keys do not expire, cannot be audited per-deployment, and require rotation procedures that teams frequently defer. One leaked key can compromise an entire AWS account.

## The Approach

Terraform-managed IAM roles configured for GitHub Actions OIDC trust. Each repository gets a scoped role that GitHub Actions can assume via short-lived token exchange — no static credentials stored anywhere. Roles are named and scoped per repository and environment.

## The Outcome

All project deployments in this portfolio use keyless OIDC authentication. Credentials last only for the duration of a workflow run and are never stored, rotated, or leaked.

## Stack

| Technology | Purpose |
|------------|---------|
| AWS IAM | Role definitions and trust policies |
| AWS OIDC | Identity federation for GitHub Actions |
| Terraform | Role provisioning and lifecycle management |
| GitHub Actions | CI/CD consumer of the OIDC roles |
| AWS SSM Parameter Store | Role ARN discovery for consuming workflows |

**Repository**: [foundation-iam-deploy-roles](https://github.com/stephenabbot/foundation-iam-deploy-roles)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Automated role provisioning; consistent naming convention across all projects
- **Security**: No long-lived credentials; short-lived OIDC tokens; least-privilege scoping per repository
- **Reliability**: Role ARNs published to SSM so consuming workflows always resolve current values
- **Performance Efficiency**: No key rotation overhead; zero-latency credential availability
- **Cost Optimization**: No additional cost beyond IAM (free) and SSM parameter reads
- **Sustainability**: Eliminates manual credential management processes

</details>
