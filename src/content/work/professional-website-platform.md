---
title: Professional Website Platform
publishDate: 2025-12-04 00:00:00
img: /assets/at-work.jpg
img_alt: Professional website platform with Astro, TypeScript, and AWS infrastructure
description: |
  Astro-based website with GitHub Actions CI/CD, OIDC authentication, and automated
  CloudFront deployment. Integrates foundation-terraform-bootstrap and foundation-iam-deploy-roles.
tags:
  - Astro
  - TypeScript
  - AWS Integration
  - Foundation Integration
  - Portfolio
repo: https://github.com/stephenabbot/website_denverbytes_com
---

## The Problem

A professional portfolio site needs to be fast, cheap to host, easy to deploy, and fully under version control — including the infrastructure. Most hosting platforms introduce ongoing cost, vendor lock-in, or a deployment process that requires manual steps.

## The Approach

Astro-based static site with GitHub Actions CI/CD. Deployment uses OIDC authentication (no stored secrets), automated CloudFront cache invalidation, and full infrastructure as code. The entire platform — site, infrastructure, and deploy pipeline — lives in two Git repositories.

## The Outcome

Production hosting at approximately $3/month (S3 + CloudFront + Route53). Deploys automatically on push to main.

## Stack

| Technology | Purpose |
|------------|---------|
| Astro 5.x | Static site framework |
| GitHub Actions | CI/CD pipeline |
| AWS OIDC | Keyless deploy authentication |
| AWS S3 | Static asset hosting |
| AWS CloudFront | CDN and HTTPS termination |
| AWS Route53 | DNS management |
| Terraform | Infrastructure provisioning |

**Repository**: [website_denverbytes_com](https://github.com/stephenabbot/website_denverbytes_com)
**Live Site**: [denverbytes.com](https://denverbytes.com)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Full IaC; automated deploy and invalidation; no manual steps
- **Security**: OIDC keyless auth; no secrets stored in GitHub; CloudFront HTTPS enforcement
- **Reliability**: S3 11-nine durability; CloudFront multi-edge availability
- **Performance Efficiency**: Static generation; global CDN distribution; no server-side compute
- **Cost Optimization**: ~$3/month for production hosting; scales to millions of requests without cost change
- **Sustainability**: No idle compute; serverless architecture

</details>
