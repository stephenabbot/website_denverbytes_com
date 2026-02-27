#!/bin/bash
# scripts/destroy.sh - Remove website content and restore coming soon page

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

echo "🗑️  DESTROYING WEBSITE DEPLOYMENT"
echo ""

# Verify prerequisites
./scripts/verify-prerequisites.sh || exit 1

echo ""

# Load configuration
source "${SCRIPT_DIR}/../config.env"

# Extract project name (keep dynamic for accurate deployment role resolution)
PROJECT_NAME=$(git remote get-url origin 2>/dev/null | sed -E 's|.*github\.com[:/][^/]+/([^/.]+)(\.git)?$|\1|' || echo "")

# Check for deployment role and assume if available
ROLE_ARN=$(aws ssm get-parameter --region "$AWS_REGION" --name "/deployment-roles/${PROJECT_NAME}/role-arn" --query Parameter.Value --output text 2>/dev/null || echo "")

if [ -n "$ROLE_ARN" ]; then
    print_status "Assuming deployment role: $ROLE_ARN"
    
    if TEMP_CREDS=$(aws sts assume-role --role-arn "$ROLE_ARN" --role-session-name "${PROJECT_NAME}-destroy-$(date +%s)" --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' --output text 2>/dev/null); then
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

# Confirm destruction
echo -e "${YELLOW}⚠${NC} This will remove all website content from $DOMAIN_NAME"
echo -e "${YELLOW}⚠${NC} The domain will show a 'coming soon' page after destruction"
echo ""
read -p "Are you sure you want to proceed? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_status "Destruction cancelled"
    exit 0
fi

echo ""

# Clear S3 bucket content
print_status "Clearing S3 bucket content..."

# List current objects (for logging)
OBJECT_COUNT=$(aws s3 ls "s3://$BUCKET_NAME" --recursive | wc -l | tr -d ' ')
print_status "Found $OBJECT_COUNT objects in bucket"

if [ "$OBJECT_COUNT" -gt 0 ]; then
    # Delete all objects
    aws s3 rm "s3://$BUCKET_NAME" --recursive
    echo -e "${GREEN}✓${NC} All objects removed from S3 bucket"
else
    print_status "S3 bucket is already empty"
fi

echo ""

# Create coming soon page
print_status "Creating coming soon page..."

# Create temporary coming soon page
COMING_SOON_CONTENT='<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coming Soon - DOMAIN_NAME</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, '"'"'Segoe UI'"'"', Roboto, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            text-align: center;
            padding: 2rem;
            max-width: 600px;
        }
        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            font-weight: 300;
        }
        p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        .domain {
            font-weight: 600;
            color: #ffd700;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Coming Soon</h1>
        <p>The website for <span class="domain">DOMAIN_NAME</span> is under construction.</p>
        <p>Please check back soon!</p>
    </div>
</body>
</html>'

# Replace domain placeholder
COMING_SOON_CONTENT=$(echo "$COMING_SOON_CONTENT" | sed "s/DOMAIN_NAME/$DOMAIN_NAME/g")

# Create temporary file and upload
TEMP_FILE=$(mktemp)
echo "$COMING_SOON_CONTENT" > "$TEMP_FILE"

aws s3 cp "$TEMP_FILE" "s3://$BUCKET_NAME/index.html" \
    --content-type "text/html" \
    --cache-control "public, max-age=0, must-revalidate"

rm "$TEMP_FILE"

echo -e "${GREEN}✓${NC} Coming soon page uploaded"

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

# Verify destruction
print_status "Verifying destruction..."

# Wait a moment for S3 consistency
sleep 2

# Check if only index.html exists in bucket
REMAINING_OBJECTS=$(aws s3 ls "s3://$BUCKET_NAME" --recursive | wc -l | tr -d ' ')

if [ "$REMAINING_OBJECTS" -eq 1 ]; then
    echo -e "${GREEN}✓${NC} Only coming soon page remains in S3 bucket"
else
    echo -e "${YELLOW}⚠${NC} $REMAINING_OBJECTS objects remain in S3 bucket"
fi

echo ""
echo -e "${GREEN}🎉 DESTRUCTION COMPLETED SUCCESSFULLY!${NC}"
print_status "Website URL: https://$DOMAIN_NAME"
print_status "The domain now shows the original coming soon page"
print_status "CloudFront may take a few minutes to serve the updated content"

# Optionally remove Google Search Console DNS record
echo ""
print_status "Checking Google Search Console DNS record..."
if ./scripts/manage-dns.sh verify &>/dev/null; then
    echo -e "${YELLOW}⚠${NC} Google Search Console TXT record still exists"
    echo "  Run './scripts/manage-dns.sh remove' to remove it if no longer needed"
else
    echo -e "${GREEN}✓${NC} No Google Search Console TXT record found"
fi
