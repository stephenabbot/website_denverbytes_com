---
title: Foundation Terraform Bootstrap
publishDate: 2025-12-01 00:00:00
img: /assets/stock-1.jpg
img_alt: CloudFormation foundation infrastructure with S3, DynamoDB, and OIDC components
description: |
  CloudFormation foundation for Terraform backend infrastructure and OIDC authentication.
  Creates shared S3 state storage, DynamoDB locking, and GitHub Actions OIDC provider.
tags:
  - CloudFormation
  - AWS
  - Infrastructure
  - OIDC
---

## The Foundation Problem

Every Terraform or OpenTofu project needs three foundational components: remote state storage, state locking, and CI/CD authentication. Creating these manually for each project leads to inconsistency, security risks, and operational overhead.

This project solves the circular dependency problem - you can't use Terraform to create Terraform's own backend resources. By using CloudFormation for the foundation, we establish the infrastructure that all subsequent Terraform projects depend on.

## What This Project Delivers

### Core Infrastructure
- **S3 bucket** for Terraform state storage with versioning and encryption
- **DynamoDB table** for state locking with point-in-time recovery
- **OIDC provider** for GitHub Actions authentication without long-lived credentials
- **IAM roles** for secure deployment workflows

### Service Discovery
- **SSM Parameter Store** integration publishes backend configuration at predictable paths
- **Automatic discovery** enables consuming projects to find resources without hardcoding
- **Consistent naming** and tagging patterns across all deployed resources

### AWS Well-Architected Alignment
This foundation demonstrates all six pillars of the AWS Well-Architected Framework:
- **Security**: OIDC authentication, encryption, least privilege access
- **Reliability**: Multi-region support, versioning, point-in-time recovery
- **Performance**: S3 Intelligent Tiering, DynamoDB on-demand billing
- **Cost Optimization**: Automated lifecycle policies, shared infrastructure
- **Operational Excellence**: Infrastructure as code, comprehensive documentation
- **Sustainability**: Serverless managed services, automated resource management

## The Strategic Value

This isn't just infrastructure - it's the **foundation for scalable DevOps practices**. Every subsequent project builds on this base, creating a consistent, secure, and cost-optimized deployment pipeline.

By establishing this foundation first, teams can focus on building applications rather than wrestling with backend configuration and credential management. It's the difference between starting from scratch every time versus building on proven, reusable patterns.

**Repository**: [foundation-terraform-bootstrap](https://github.com/stephenabbot/foundation-terraform-bootstrap)
