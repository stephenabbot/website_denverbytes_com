# Troubleshooting Guide

## Common Issues

### Deployment Failures

#### OIDC Authentication Errors

**Error**: `Could not assume role with OIDC: Request ARN is invalid`

**Solution**: 
1. Verify `AWS_ACCOUNT_ID` repository variable is set correctly
2. Run `gh variable list` to check the value
3. If missing, run `./scripts/bootstrap.sh` locally

#### S3 Access Denied

**Error**: `Access Denied` when uploading to S3

**Solution**:
1. Verify the website infrastructure is deployed
2. Check deployment role has S3 permissions
3. Confirm bucket name matches domain configuration

#### CloudFront Invalidation Failures

**Error**: `InvalidDistributionId` or access denied for CloudFront

**Solution**:
1. Verify CloudFront distribution exists
2. Check deployment role has CloudFront permissions
3. Confirm distribution ID is correct in SSM Parameter Store

### Build Issues

#### Node.js Version Mismatch

**Error**: Build fails with Node.js compatibility errors

**Solution**:
1. Upgrade to Node.js 18 or higher
2. Clear `node_modules`: `rm -rf node_modules package-lock.json`
3. Reinstall dependencies: `npm install`

#### Missing Dependencies

**Error**: Module not found errors during build

**Solution**:
1. Run `./scripts/bootstrap.sh` to install dependencies
2. If issues persist, clear cache and reinstall:
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   ```

### Infrastructure Issues

#### Missing Infrastructure Parameters

**Error**: Infrastructure not found for domain

**Solution**:
1. Deploy the website-infrastructure project first
2. Verify domain configuration matches project naming
3. Check SSM Parameter Store for required parameters

#### Role Assumption Failures

**Error**: Cannot assume deployment role

**Solution**:
1. Verify the foundation-iam-deploy-roles project is deployed
2. Check role exists: `aws iam get-role --role-name gharole-website_denverbytes_com-prd`
3. Verify OIDC trust policy allows your repository

### GitHub Actions Issues

#### Workflow Permissions

**Error**: Insufficient permissions in GitHub Actions

**Solution**:
1. Verify workflow has `id-token: write` and `contents: read` permissions
2. Check repository settings allow Actions to run

#### Variable Configuration

**Error**: AWS_ACCOUNT_ID not available in workflow

**Solution**:
1. Run `./scripts/bootstrap.sh` locally with admin permissions
2. Verify variable is set: `gh variable list`

## Diagnostic Commands

### Check AWS Configuration

```bash
aws sts get-caller-identity
aws ssm get-parameter --name "/deployment-roles/website_denverbytes_com/role-arn" --region us-east-1
```

### Check Infrastructure

```bash
aws ssm get-parameter --name "/static-website/infrastructure/denverbytes.com/bucket-name" --region us-east-1
aws ssm get-parameter --name "/static-website/infrastructure/denverbytes.com/cloudfront-distribution-id" --region us-east-1
```

### Check GitHub Configuration

```bash
gh variable list
gh auth status
```

## Getting Help

If issues persist:

1. Run `./scripts/verify-prerequisites.sh` for detailed diagnostics
2. Check GitHub Actions logs for specific error messages
3. Verify all foundation projects are deployed correctly
4. Ensure domain configuration matches project naming conventions
