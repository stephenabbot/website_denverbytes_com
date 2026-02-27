# Prerequisites

## System Requirements

### Required Tools

- **Node.js** (version 18 or higher)
- **npm** (comes with Node.js)
- **Git** (for version control)
- **AWS CLI** (configured with appropriate credentials)
- **jq** (for JSON processing)

### AWS Requirements

- AWS account with appropriate permissions
- AWS CLI configured with credentials that can:
  - Read from SSM Parameter Store
  - Access S3 buckets
  - Create CloudFront invalidations
  - Assume deployment roles (if using OIDC)

### GitHub Requirements (for automated deployment)

- GitHub repository with Actions enabled
- GitHub CLI (`gh`) installed and authenticated (for local development)
- Repository variable `AWS_ACCOUNT_ID` configured

## Installation

### Install Node.js and npm

Visit [nodejs.org](https://nodejs.org/) and install the LTS version.

### Install AWS CLI

Follow the [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

### Install jq

- **macOS**: `brew install jq`
- **Ubuntu/Debian**: `sudo apt-get install jq`
- **Windows**: Download from [jqlang.github.io](https://jqlang.github.io/jq/download/)

### Install GitHub CLI (optional, for local development)

Follow the [GitHub CLI installation guide](https://cli.github.com/).

## Configuration

### AWS Credentials

Configure AWS credentials using one of these methods:

1. **AWS CLI**: `aws configure`
2. **Environment variables**: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`
3. **IAM roles** (recommended for EC2/ECS)

### GitHub Authentication (for local development)

```bash
gh auth login
```

## Verification

Run the prerequisite verification script:

```bash
./scripts/verify-prerequisites.sh
```

This script checks all requirements and provides specific guidance for any missing components.
