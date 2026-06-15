# Professional Website Platform

## Static website demonstrating enterprise infrastructure integration

This project creates a professional website using Astro and TypeScript that serves as the capstone demonstration of how foundation infrastructure projects integrate to deliver complete, production-ready solutions. The website showcases enterprise deployment patterns through live infrastructure while providing content management capabilities for blog posts, portfolio items, and professional experience.

Repository: [website_denverbytes_com](https://github.com/stephenabbot/website_denverbytes_com)

## What Problem This Project Solves

Professional websites require more than just content management - they need enterprise-grade infrastructure, security, and deployment workflows that demonstrate technical capabilities while maintaining modern web development practices.

- Static websites require coordination between multiple AWS services for secure, performant hosting
- Manual infrastructure configuration creates inconsistency, security gaps, and operational overhead
- Demonstrating technical capabilities requires live integration of multiple infrastructure components
- Content management needs type-safe development with automated deployment workflows
- Professional portfolios need to show working solutions rather than theoretical knowledge

## What This Project Does

Provides a complete professional website platform that integrates all foundation infrastructure projects while demonstrating enterprise deployment patterns through live implementation.

- Creates static website content using Astro framework with TypeScript schema validation
- Integrates with foundation infrastructure projects for backend state management and OIDC authentication
- Deploys content to multi-domain website infrastructure with automated SSL and global CDN
- Implements automated CI/CD pipeline using GitHub Actions with secure OIDC authentication
- Demonstrates complete software development lifecycle from infrastructure foundation through application delivery
- Provides content collections for blog posts, portfolio projects, and professional experience with type safety

## What This Project Changes

Enables professional website hosting with complete enterprise infrastructure integration while establishing the capstone demonstration of foundation project capabilities.

### Resources Created/Managed

- Astro static website with TypeScript content collections and schema validation
- GitHub Actions workflows for automated deployment with OIDC authentication
- Content management system for blog posts, work portfolio, and experience timeline
- Integration with S3 static hosting and CloudFront CDN distribution managed by website-infrastructure project
- Automated deployment scripts with comprehensive error handling and rollback support

### Functional Changes

- Enables professional website hosting with enterprise-grade deployment workflows
- Provides type-safe content management with automated validation and build processes
- Implements secure CI/CD authentication without long-lived credentials through foundation projects
- Demonstrates complete integration of foundation infrastructure components through live implementation
- Establishes patterns for content deployment separate from infrastructure management

## Quick Start

```bash
# Bootstrap project for local development
./scripts/bootstrap.sh

# Start development server
npm run dev

# Deploy to AWS infrastructure
./scripts/deploy.sh
```

For detailed setup information, see [prerequisites documentation](docs/prerequisites.md). For deployment troubleshooting, see [troubleshooting guide](docs/troubleshooting.md). For operational procedures, see [operations guide](docs/operations.md). For SEO implementation status, see [SEO documentation](docs/SEO_STATUS.md).

## AWS Well-Architected Framework

This project demonstrates alignment with the AWS Well-Architected Framework through integration with foundation infrastructure:

### Security
- HTTPS enforcement with automatic SSL certificate management through website-infrastructure project
- OIDC authentication eliminating long-lived credentials via foundation-iam-deploy-roles project
- S3 bucket policies and CloudFront origin access controls restricting unauthorized access
- Comprehensive security headers via CloudFront Response Headers Policy

### Reliability
- Global CDN distribution for availability and fault tolerance through CloudFront
- S3 versioning and automated backup of deployment artifacts
- Automated deployment rollback capabilities with backup and restore functionality
- Error handling and recovery mechanisms in deployment scripts

### Performance Efficiency
- CloudFront edge locations for global performance optimization
- Static site generation for optimal loading performance
- Responsive images and modern formats for efficient content delivery
- Caching strategies to minimize origin requests and improve response times

### Cost Optimization
- S3 static hosting minimizes compute costs compared to server-based solutions
- Pay-per-use pricing for CloudFront and Route53 services
- Automated lifecycle policies for efficient resource utilization
- Shared infrastructure patterns reducing per-project overhead

### Operational Excellence
- Infrastructure as Code through automated deployment scripts and GitHub Actions workflows
- Automated CI/CD pipeline with comprehensive error handling and monitoring capabilities
- CloudFront access logs and deployment monitoring for operational visibility
- Comprehensive documentation and operational procedures

## Technologies Used

| Technology | Purpose | Implementation |
|------------|---------|----------------|
| **Kiro CLI with Claude** | Primary development tool | AI-assisted development, code generation, and problem-solving throughout project lifecycle |
| **Astro 5** | Static site generation | Framework for building static websites with TypeScript integration and content collections |
| **TypeScript** | Type-safe development | Compile-time validation, schema definitions for content collections, and enhanced developer experience |
| **GitHub Actions** | CI/CD automation | Automated deployment workflows with OIDC authentication and comprehensive error handling |
| **AWS S3** | Static website hosting | Primary hosting infrastructure with versioning, encryption, and lifecycle policies |
| **AWS CloudFront** | Global content distribution | CDN for performance optimization, security headers, and global availability |
| **AWS Route53** | DNS management | Domain management with health checks and automated SSL certificate validation |
| **AWS Certificate Manager** | SSL certificate management | Automated certificate provisioning, validation, and renewal for HTTPS enforcement |
| **AWS SSM Parameter Store** | Configuration management | Service discovery for infrastructure parameters and deployment role ARNs |
| **AWS IAM** | Access control | OIDC-based authentication roles for secure GitHub Actions deployment without long-lived credentials |
| **Node.js** | Build environment | JavaScript runtime for Astro build process and npm package management |
| **npm** | Package management | Dependency management and build script execution for development and deployment |
| **Git** | Version control | Source code management with automated deployment triggers and change tracking |
| **Bash** | Automation scripting | Deployment scripts, prerequisite validation, and operational automation |
| **Markdown** | Content authoring | Structured content creation with frontmatter for blog posts and portfolio items |
| **CSS3** | Styling and design | Responsive design implementation with dark/light theme support and accessibility compliance |

## Copyright

© 2025 Stephen Abbot - MIT License
