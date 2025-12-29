---
title: Foundation IAM Deploy Roles
publishDate: 2025-09-01 00:00:00
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
---

## Secure CI/CD Authentication Challenge

GitHub Actions workflows require AWS credentials to deploy infrastructure, but managing these credentials creates security risks and operational overhead. Traditional approaches use long-lived access keys stored as secrets, creating credential sprawl and rotation complexity.

This project eliminates credential management through OIDC trust relationships that allow GitHub repositories to assume AWS roles directly.

## OIDC-Based Security Architecture

### Repository-Scoped Authentication
- **IAM roles** with repository-scoped OIDC trust policies for secure authentication
- **Dynamic policy generation** from JSON configuration files
- **Least privilege access** patterns through configurable deployment policies
- **Role ARN publishing** to SSM Parameter Store for service discovery

### Operational Automation
- **Automated prerequisite validation** prevents deployment failures
- **Project creation scripts** streamline new repository onboarding
- **Comprehensive deployment automation** handles backend configuration and role assumption
- **Resource listing capabilities** enable infrastructure visibility

### Enterprise Integration
- **Consistent naming conventions** with `gharole-{project}-{environment}` pattern
- **Comprehensive resource tagging** for cost allocation and ownership tracking
- **Git repository validation** ensures deployment metadata accuracy
- **Self-deployment prevention** mechanisms avoid circular dependencies

## Strategic Security Value

This isn't just credential management - it's **enterprise-grade security automation**. By eliminating long-lived credentials, organizations reduce their attack surface while enabling scalable CI/CD practices.

### Security Benefits
- **Zero credential storage** in GitHub secrets or local environments
- **Repository-scoped access** prevents unauthorized cross-project deployments
- **Automatic credential rotation** through AWS STS temporary credentials
- **Audit trail integration** with CloudTrail for complete access logging

### Operational Excellence
- **Service discovery** enables consuming projects to find deployment roles automatically
- **Standardized deployment patterns** across all infrastructure projects
- **Reduced operational overhead** through automated role and policy management

This foundation enables **secure, scalable CI/CD workflows** that align with enterprise security requirements while maintaining developer productivity.

**Repository**: [foundation-iam-deploy-roles](https://github.com/stephenabbot/foundation-iam-deploy-roles)
