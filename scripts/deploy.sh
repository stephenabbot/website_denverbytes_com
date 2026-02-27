#!/bin/bash
# scripts/deploy.sh - Deploy website content to S3 and invalidate CloudFront

set -euo pipefail

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "$PROJECT_ROOT"

# Disable AWS CLI pager
export AWS_PAGER=""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}ℹ${NC} $1"; }

echo "🚀 DEPLOYING WEBSITE CONTENT"
echo ""

# Verify prerequisites
echo "Step 1: Verifying prerequisites..."
if ./scripts/verify-prerequisites.sh; then
  echo "✓ All prerequisites satisfied"
else
  # Check if running in GitHub Actions
  if [ "${GITHUB_ACTIONS:-}" = "true" ]; then
    echo ""
    echo "❌ Prerequisites failed in GitHub Actions environment"
    echo "   Cannot run bootstrap script in GitHub Actions"
    echo "   Bootstrap must be run locally by someone with repository admin permissions"
    exit 1
  fi
  
  echo ""
  echo "Checking if bootstrap is needed..."
  
  # Check if the failure is due to missing GitHub variable or dependencies
  if command -v gh &>/dev/null && gh auth status &>/dev/null 2>&1; then
    if ! gh variable list | grep -q "AWS_ACCOUNT_ID"; then
      echo "Running bootstrap to configure GitHub variables..."
      ./scripts/bootstrap.sh || exit 1
      
      echo ""
      echo "Re-verifying prerequisites after bootstrap..."
      ./scripts/verify-prerequisites.sh || exit 1
    else
      # Check if node_modules exists, if not run bootstrap for dependencies
      if [ ! -d "node_modules" ]; then
        echo "Running bootstrap to install dependencies..."
        ./scripts/bootstrap.sh || exit 1
        
        echo ""
        echo "Re-verifying prerequisites after bootstrap..."
        ./scripts/verify-prerequisites.sh || exit 1
      else
        echo "Prerequisites failed for reasons other than GitHub variables or dependencies"
        exit 1
      fi
    fi
  else
    echo "Prerequisites failed and GitHub CLI not available for bootstrap"
    exit 1
  fi
fi

echo ""

# Load configuration
source "${PROJECT_ROOT}/config.env"

# Extract project name (keep dynamic for accurate deployment role resolution)
PROJECT_NAME=$(git remote get-url origin 2>/dev/null | sed -E 's|.*github\.com[:/][^/]+/([^/.]+)(\.git)?$|\1|' || echo "")

# Check for deployment role and assume if available
ROLE_ARN=$(aws ssm get-parameter --region "$AWS_REGION" --name "/deployment-roles/${PROJECT_NAME}/role-arn" --query Parameter.Value --output text 2>/dev/null || echo "")

if [ -n "$ROLE_ARN" ]; then
    print_status "Attempting to assume deployment role: $ROLE_ARN"
    
    if TEMP_CREDS=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name "${PROJECT_NAME}-deploy-$(date +%s)" --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' --output text 2>/dev/null); then
        export AWS_ACCESS_KEY_ID=$(echo "$TEMP_CREDS" | cut -f1)
        export AWS_SECRET_ACCESS_KEY=$(echo "$TEMP_CREDS" | cut -f2)
        export AWS_SESSION_TOKEN=$(echo "$TEMP_CREDS" | cut -f3)
        echo -e "${GREEN}✓${NC} Successfully assumed deployment role"
    else
        echo -e "${YELLOW}⚠${NC} Failed to assume deployment role, using current credentials"
    fi
else
    echo -e "${YELLOW}⚠${NC} No deployment role found, using current credentials"
fi

echo ""

# Get infrastructure parameters
BUCKET_NAME=$(aws ssm get-parameter --region "$AWS_REGION" --name "/static-website/infrastructure/${DOMAIN_NAME}/bucket-name" --query Parameter.Value --output text)
DISTRIBUTION_ID=$(aws ssm get-parameter --region "$AWS_REGION" --name "/static-website/infrastructure/${DOMAIN_NAME}/cloudfront-distribution-id" --query Parameter.Value --output text)

echo -e "${GREEN}✓${NC} S3 bucket: $BUCKET_NAME"
echo -e "${GREEN}✓${NC} CloudFront distribution: $DISTRIBUTION_ID"

echo ""

# Build the website
print_status "Building website..."

if [ ! -f "package.json" ]; then
    echo -e "${RED}✗${NC} package.json not found"
    exit 1
fi

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    print_status "Installing dependencies..."
    npm install
fi

# Build the site
print_status "Building Astro site..."
npm run build

if [ ! -d "dist" ]; then
    echo -e "${RED}✗${NC} Build failed - dist directory not found"
    exit 1
fi

echo -e "${GREEN}✓${NC} Website built successfully"

echo ""

# Deploy to S3
print_status "Deploying to S3..."

# Backup existing index.html if it exists
if aws s3 ls "s3://$BUCKET_NAME/index.html" &>/dev/null; then
    print_status "Backing up existing index.html..."
    aws s3 cp "s3://$BUCKET_NAME/index.html" "s3://$BUCKET_NAME/index.html.backup"
    echo -e "${GREEN}✓${NC} Existing index.html backed up"
fi

# Sync files to S3 with appropriate cache headers
aws s3 sync dist/ "s3://$BUCKET_NAME" \
    --delete \
    --cache-control "public, max-age=31536000" \
    --exclude "*.html" \
    --exclude "*.xml" \
    --exclude "*.txt" \
    --exclude "index.html.backup"

# Upload HTML files with shorter cache
aws s3 sync dist/ "s3://$BUCKET_NAME" \
    --delete \
    --cache-control "public, max-age=0, must-revalidate" \
    --exclude "*" \
    --include "*.html" \
    --include "*.xml" \
    --include "*.txt" \
    --exclude "index.html.backup"

echo -e "${GREEN}✓${NC} Files uploaded to S3"

echo ""

# Invalidate CloudFront cache
print_status "Invalidating CloudFront cache..."

INVALIDATION_ID=$(aws cloudfront create-invalidation \
    --distribution-id "$DISTRIBUTION_ID" \
    --paths "/*" \
    --query 'Invalidation.Id' \
    --output text)

echo -e "${GREEN}✓${NC} CloudFront invalidation created: $INVALIDATION_ID"

echo ""

# Verify deployment
print_status "Verifying deployment..."

# Wait a moment for S3 consistency
sleep 2

# Check if index.html exists in bucket
if aws s3 ls "s3://$BUCKET_NAME/index.html" &>/dev/null; then
    echo -e "${GREEN}✓${NC} index.html found in S3 bucket"
    
    # Clean up backup file after successful deployment
    if aws s3 ls "s3://$BUCKET_NAME/index.html.backup" &>/dev/null; then
        print_status "Cleaning up backup file..."
        aws s3 rm "s3://$BUCKET_NAME/index.html.backup"
        echo -e "${GREEN}✓${NC} Backup file removed"
    fi
else
    echo -e "${RED}✗${NC} index.html not found in S3 bucket"
    
    # Restore backup if deployment failed
    if aws s3 ls "s3://$BUCKET_NAME/index.html.backup" &>/dev/null; then
        echo -e "${YELLOW}⚠${NC} Restoring backup due to deployment failure..."
        aws s3 cp "s3://$BUCKET_NAME/index.html.backup" "s3://$BUCKET_NAME/index.html"
        aws s3 rm "s3://$BUCKET_NAME/index.html.backup"
        echo -e "${GREEN}✓${NC} Backup restored"
    fi
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 DEPLOYMENT COMPLETED SUCCESSFULLY!${NC}"
print_status "Website URL: https://$DOMAIN_NAME"
print_status "CloudFront may take a few minutes to serve updated content"

# Verify Google Search Console DNS record
echo ""
print_status "Verifying Google Search Console DNS record..."
if ./scripts/manage-dns.sh verify; then
    echo -e "${GREEN}✓${NC} Google Search Console TXT record is configured"
else
    echo -e "${YELLOW}⚠${NC} Google Search Console TXT record not found or incorrect"
    echo "  Run './scripts/manage-dns.sh add' to configure it"
fi
