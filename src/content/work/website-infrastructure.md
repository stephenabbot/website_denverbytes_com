---
title: Website Infrastructure
publishDate: 2025-11-01 00:00:00
img: /assets/stock-3.jpg
img_alt: Multi-domain static website hosting with S3, CloudFront, Route53, and ACM integration
description: |
  Multi-domain static website hosting infrastructure with automated SSL certificate 
  management and global content distribution using AWS managed services.
tags:
  - OpenTofu
  - AWS
  - Multi-Domain
  - CDN
---

## Scalable Website Hosting Challenge

Static websites require coordination between multiple AWS services for secure, performant hosting. Manual configuration creates inconsistency, security gaps, and operational overhead when managing multiple domains.

This project provides automated infrastructure deployment for multiple static websites with complete SSL certificate management and global content distribution through AWS managed services.

## Architecture & Implementation

### Multi-Service Orchestration

- **S3 buckets** with versioning, encryption, and public access blocks
- **CloudFront distributions** with Origin Access Control and security configurations
- **Route53 hosted zones** with A and AAAA records for IPv4/IPv6 support
- **ACM certificates** with DNS validation through Route53

### Advanced Features

- **CloudFront Functions** for directory index handling and clean URLs
- **Security headers** and compression enabled for optimal performance
- **Cost optimization** through PriceClass_100 covering US and Europe regions
- **Service discovery** via SSM Parameter Store for content projects

### Current Deployments

Successfully hosting multiple domains with consistent infrastructure patterns:

- **stephenabbot.com** - Professional portfolio
- **denverbites.com** - Local content platform
- **denverbytes.com** - Technical blog (planned)
- **denverbytes.com** - Development staging

## The Scalability Story

This isn't just website hosting - it's **infrastructure that scales with business needs**. The dynamic domain discovery through filesystem scanning means adding new domains requires minimal configuration changes.

### Operational Excellence

- **Automated deployment** through GitHub Actions with OIDC authentication
- **Idempotent operations** supporting multiple executions without conflicts
- **Comprehensive resource tagging** for cost allocation and operational visibility
- **Loose coupling** between infrastructure and content projects

### Performance & Security

- **Global CDN distribution** reducing latency worldwide
- **SSL/TLS certificates** with automatic DNS validation and renewal
- **Origin Access Control** restricting S3 access to CloudFront only
- **Error page handling** redirecting client errors to homepage

This infrastructure demonstrates how to build **enterprise-grade hosting solutions** that are both cost-effective and operationally efficient, serving as a foundation for any organization's web presence.

**Repository**: [website-infrastructure](https://github.com/stephenabbot/website-infrastructure)
