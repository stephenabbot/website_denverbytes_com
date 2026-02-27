---
title: Website Infrastructure
publishDate: 2025-12-05 00:00:00
img: /assets/stock-3.jpg
img_alt: Multi-domain static website hosting with S3, CloudFront, Route53, and ACM integration
description: |
  A reusable AWS stack for static websites using S3, CloudFront, and Route53, tuned for
  low cost and strong security by default. Production-ready hosting at roughly $3/month
  with global distribution and no idle compute.
tags:
  - OpenTofu
  - AWS
  - Multi-Domain
  - CDN
repo: https://github.com/stephenabbot/website-infrastructure
---

## The Problem

Static website hosting on AWS involves several interdependent resources that must be provisioned in the correct order: S3 bucket, CloudFront distribution, ACM certificate (in us-east-1 regardless of bucket region), and Route53 records. Doing this manually is error-prone and not repeatable across domains.

## The Approach

Terraform modules manage all hosting resources with consistent structure. ACM certificate validation is automated via Route53 DNS records. The same module handles multiple domains (denverbytes.com and bittikens.com) with per-domain configuration.

## The Outcome

Repeatable, version-controlled hosting infrastructure deployable to a new domain in minutes. S3 bucket versioning enables content rollback. CloudFront distribution provides global availability and HTTPS with no additional cost per request.

## Stack

| Technology | Purpose |
|------------|---------|
| Terraform | Infrastructure provisioning |
| AWS S3 | Static content storage with versioning |
| AWS CloudFront | CDN, HTTPS, custom domain |
| AWS ACM | TLS certificate management |
| AWS Route53 | DNS and certificate validation |

**Domains hosted:**
- **bittikens.com** — This website
- **denverbytes.com** — Production website
- **denverbites.com** — Redirect alias to denverbytes.com

**Repository**: [website-infrastructure](https://github.com/stephenabbot/website-infrastructure)

---

<details>
<summary>AWS Well-Architected Alignment</summary>

- **Operational Excellence**: Terraform-managed; repeatable across domains; automated certificate validation
- **Security**: S3 public access blocked; CloudFront origin access control; HTTPS enforced
- **Reliability**: S3 versioning for rollback; CloudFront multi-region edge; ACM auto-renewal
- **Performance Efficiency**: Global CDN; no origin compute; efficient static delivery
- **Cost Optimization**: Per-request pricing; no idle cost; shared infrastructure across domains
- **Sustainability**: No servers; minimal resource footprint

</details>
