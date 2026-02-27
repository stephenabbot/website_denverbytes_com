#!/bin/bash
# scripts/verify-prerequisites.sh - Verify prerequisites for deployment

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

echo "🔍 VERIFYING PREREQUISITES"
echo ""

# Load configuration
source "${SCRIPT_DIR}/../config.env"

# Extract project name (keep dynamic for accurate deployment role resolution)
PROJECT_NAME=$(git remote get-url origin 2>/dev/null | sed -E 's|.*github\.com[:/][^/]+/([^/.]+)(\.git)?$|\1|' || echo "")
if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}✗${NC} Could not determine project name from git remote"
    exit 1
fi

print_status "Project: $PROJECT_NAME"
print_status "Target domain: $DOMAIN_NAME"
echo ""

# Check required tools
print_status "Checking required tools..."

if ! command -v aws &> /dev/null; then
    echo -e "${RED}✗${NC} AWS CLI is required but not installed"
    exit 1
fi
echo -e "${GREEN}✓${NC} AWS CLI found"

if ! command -v jq &> /dev/null; then
    echo -e "${RED}✗${NC} jq is required but not installed"
    exit 1
fi
echo -e "${GREEN}✓${NC} jq found"

if ! command -v node &> /dev/null; then
    echo -e "${RED}✗${NC} Node.js is required but not installed"
    exit 1
fi
echo -e "${GREEN}✓${NC} Node.js found"

if ! command -v npm &> /dev/null; then
    echo -e "${RED}✗${NC} npm is required but not installed"
    exit 1
fi
echo -e "${GREEN}✓${NC} npm found"

echo ""

# Check git repository state
print_status "Checking git repository state..."

if [ ! -d ".git" ]; then
    echo -e "${RED}✗${NC} Not in a git repository"
    exit 1
fi
echo -e "${GREEN}✓${NC} Git repository found"

# Check for uncommitted changes
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
    echo -e "${YELLOW}⚠${NC} Uncommitted changes detected"
    echo -e "${YELLOW}⚠${NC} Consider committing changes before deployment"
else
    echo -e "${GREEN}✓${NC} Working directory clean"
fi

echo ""

# Check GitHub variable configuration
print_status "Checking GitHub variable configuration..."

# Check if running in GitHub Actions
if [ "${GITHUB_ACTIONS:-}" = "true" ]; then
    if [ -n "${AWS_ACCOUNT_ID:-}" ]; then
        echo -e "${GREEN}✓${NC} AWS_ACCOUNT_ID available in GitHub Actions"
    else
        echo -e "${RED}✗${NC} AWS_ACCOUNT_ID variable not configured in GitHub repository"
        echo ""
        echo "🚨 BOOTSTRAP REQUIRED 🚨"
        echo ""
        echo "This GitHub Actions workflow cannot proceed because the AWS_ACCOUNT_ID"
        echo "repository variable has not been configured."
        echo ""
        echo "REQUIRED ACTION:"
        echo "  Someone with repository admin permissions must run the bootstrap"
        echo "  script locally to configure the required GitHub repository variables:"
        echo ""
        echo "    git clone <this-repository>"
        echo "    cd <repository-directory>"
        echo "    ./scripts/bootstrap.sh"
        echo ""
        echo "This one-time setup configures the AWS_ACCOUNT_ID variable that"
        echo "GitHub Actions workflows need to construct deployment role ARNs."
        exit 1
    fi
elif command -v gh &>/dev/null && gh auth status &>/dev/null 2>&1; then
    if gh variable list | grep -q "AWS_ACCOUNT_ID"; then
        echo -e "${GREEN}✓${NC} AWS_ACCOUNT_ID GitHub variable configured"
    else
        echo -e "${RED}✗${NC} AWS_ACCOUNT_ID GitHub variable not set"
        echo "  Run './scripts/bootstrap.sh' to configure"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠${NC} GitHub CLI not available or not authenticated"
    echo "  Cannot verify GitHub variable configuration"
fi

echo ""

# Check deployment role
print_status "Checking deployment role..."

ROLE_ARN=$(aws ssm get-parameter --region "$AWS_REGION" --name "/deployment-roles/${PROJECT_NAME}/role-arn" --query Parameter.Value --output text 2>/dev/null || echo "")

if [ -n "$ROLE_ARN" ]; then
    echo -e "${GREEN}✓${NC} Deployment role found: $ROLE_ARN"
    
    # Test role assumption
    if aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name "${PROJECT_NAME}-test-$(date +%s)" --query 'Credentials.AccessKeyId' --output text &>/dev/null; then
        echo -e "${GREEN}✓${NC} Role assumption test successful"
    else
        echo -e "${YELLOW}⚠${NC} Cannot assume deployment role, will use current credentials"
    fi
else
    echo -e "${YELLOW}⚠${NC} No deployment role found, using current credentials"
fi

echo ""

# Check infrastructure parameters
print_status "Checking infrastructure parameters..."

BUCKET_NAME=$(aws ssm get-parameter --region "$AWS_REGION" --name "/static-website/infrastructure/${DOMAIN_NAME}/bucket-name" --query Parameter.Value --output text 2>/dev/null || echo "")

if [ -z "$BUCKET_NAME" ]; then
    echo -e "${RED}✗${NC} Infrastructure not found for domain: $DOMAIN_NAME"
    echo -e "${RED}✗${NC} Deploy the static-website-infrastructure project first"
    exit 1
fi
echo -e "${GREEN}✓${NC} Infrastructure found for $DOMAIN_NAME"
echo -e "${GREEN}✓${NC} S3 bucket: $BUCKET_NAME"

# Test S3 bucket access
if aws s3 ls "s3://$BUCKET_NAME" &>/dev/null; then
    echo -e "${GREEN}✓${NC} S3 bucket access confirmed"
else
    echo -e "${RED}✗${NC} Cannot access S3 bucket: $BUCKET_NAME"
    exit 1
fi

# Check CloudFront distribution
DISTRIBUTION_ID=$(aws ssm get-parameter --region "$AWS_REGION" --name "/static-website/infrastructure/${DOMAIN_NAME}/cloudfront-distribution-id" --query Parameter.Value --output text 2>/dev/null || echo "")

if [ -n "$DISTRIBUTION_ID" ]; then
    echo -e "${GREEN}✓${NC} CloudFront distribution: $DISTRIBUTION_ID"
else
    echo -e "${RED}✗${NC} CloudFront distribution not found"
    exit 1
fi

echo ""
echo -e "${GREEN}✓${NC} All prerequisites verified successfully!"
