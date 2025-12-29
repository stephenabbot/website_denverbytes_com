#!/bin/bash
# scripts/list-deployed-resources.sh - List deployed resources and verify website status

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

echo "📋 LISTING DEPLOYED RESOURCES"
echo ""

# Extract project name and domain
PROJECT_NAME=$(git remote get-url origin 2>/dev/null | sed -E 's|.*github\.com[:/][^/]+/([^/.]+)(\.git)?$|\1|' || echo "")

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}✗${NC} Could not determine project name from git remote"
    exit 1
fi

DOMAIN_STUB=$(echo "$PROJECT_NAME" | sed 's/^website_//' | sed 's/_com$//')
DOMAIN_NAME="${DOMAIN_STUB}.com"

print_status "Project: $PROJECT_NAME"
print_status "Target domain: $DOMAIN_NAME"
echo ""

# Check deployment role
print_status "Deployment Role:"
ROLE_ARN=$(aws ssm get-parameter --region us-east-1 --name "/deployment-roles/${PROJECT_NAME}/role-arn" --query Parameter.Value --output text 2>/dev/null || echo "")

if [ -n "$ROLE_ARN" ]; then
    echo -e "${GREEN}✓${NC} Role ARN: $ROLE_ARN"
else
    echo -e "${YELLOW}⚠${NC} No deployment role configured"
fi

echo ""

# Get and display infrastructure parameters
print_status "Infrastructure Parameters:"

# Get all parameters for the domain
PARAMS=$(aws ssm get-parameters-by-path --region us-east-1 --path "/static-website/infrastructure/${DOMAIN_NAME}/" --query 'Parameters[*].[Name,Value]' --output text 2>/dev/null || echo "")

if [ -z "$PARAMS" ]; then
    echo -e "${RED}✗${NC} No infrastructure found for domain: $DOMAIN_NAME"
    echo -e "${RED}✗${NC} Deploy the static-website-infrastructure project first"
    exit 1
fi

# Parse and display parameters
BUCKET_NAME=""
DISTRIBUTION_ID=""
CERTIFICATE_ARN=""
HOSTED_ZONE_ID=""

while IFS=$'\t' read -r name value; do
    case "$name" in
        *bucket-name)
            BUCKET_NAME="$value"
            echo -e "${GREEN}✓${NC} S3 Bucket: $value"
            ;;
        *bucket-arn)
            echo -e "${GREEN}✓${NC} S3 Bucket ARN: $value"
            ;;
        *cloudfront-distribution-id)
            DISTRIBUTION_ID="$value"
            echo -e "${GREEN}✓${NC} CloudFront Distribution: $value"
            ;;
        *cloudfront-domain-name)
            echo -e "${GREEN}✓${NC} CloudFront Domain: $value"
            ;;
        *certificate-arn)
            CERTIFICATE_ARN="$value"
            echo -e "${GREEN}✓${NC} SSL Certificate: $value"
            ;;
        *hosted-zone-id)
            HOSTED_ZONE_ID="$value"
            echo -e "${GREEN}✓${NC} Route53 Hosted Zone: $value"
            ;;
    esac
done <<< "$PARAMS"

echo ""

# Check S3 bucket contents
if [ -n "$BUCKET_NAME" ]; then
    print_status "S3 Bucket Contents:"
    
    OBJECT_COUNT=$(aws s3 ls "s3://$BUCKET_NAME" --recursive | wc -l | tr -d ' ')
    
    if [ "$OBJECT_COUNT" -eq 0 ]; then
        echo -e "${YELLOW}⚠${NC} S3 bucket is empty"
    else
        echo -e "${GREEN}✓${NC} $OBJECT_COUNT objects in bucket"
        
        # Show recent objects
        print_status "Recent objects:"
        aws s3 ls "s3://$BUCKET_NAME" --recursive --human-readable | tail -10 | while read -r line; do
            echo "  $line"
        done
    fi
    
    echo ""
fi

# Check CloudFront distribution status
if [ -n "$DISTRIBUTION_ID" ]; then
    print_status "CloudFront Distribution Status:"
    
    DIST_STATUS=$(aws cloudfront get-distribution --id "$DISTRIBUTION_ID" --query 'Distribution.Status' --output text 2>/dev/null || echo "Unknown")
    
    case "$DIST_STATUS" in
        "Deployed")
            echo -e "${GREEN}✓${NC} Status: $DIST_STATUS"
            ;;
        "InProgress")
            echo -e "${YELLOW}⚠${NC} Status: $DIST_STATUS (deployment in progress)"
            ;;
        *)
            echo -e "${YELLOW}⚠${NC} Status: $DIST_STATUS"
            ;;
    esac
    
    echo ""
fi

# Test website accessibility
print_status "Website Accessibility Test:"

if command -v curl &> /dev/null; then
    # Test HTTPS access
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "https://$DOMAIN_NAME" --max-time 10 || echo "000")
    
    case "$HTTP_STATUS" in
        "200")
            echo -e "${GREEN}✓${NC} HTTPS access: OK (HTTP $HTTP_STATUS)"
            ;;
        "000")
            echo -e "${RED}✗${NC} HTTPS access: Failed (connection timeout or error)"
            ;;
        *)
            echo -e "${YELLOW}⚠${NC} HTTPS access: HTTP $HTTP_STATUS"
            ;;
    esac
    
    # Test HTTP redirect
    HTTP_REDIRECT=$(curl -s -o /dev/null -w "%{http_code}" "http://$DOMAIN_NAME" --max-time 10 || echo "000")
    
    case "$HTTP_REDIRECT" in
        "301"|"302")
            echo -e "${GREEN}✓${NC} HTTP redirect: OK (HTTP $HTTP_REDIRECT)"
            ;;
        "000")
            echo -e "${RED}✗${NC} HTTP redirect: Failed (connection timeout or error)"
            ;;
        *)
            echo -e "${YELLOW}⚠${NC} HTTP redirect: HTTP $HTTP_REDIRECT"
            ;;
    esac
else
    echo -e "${YELLOW}⚠${NC} curl not available - skipping accessibility test"
fi

echo ""

# Summary
print_status "Summary:"
print_status "Website URL: https://$DOMAIN_NAME"

if [ "$OBJECT_COUNT" -gt 1 ]; then
    echo -e "${GREEN}✓${NC} Website appears to be deployed with content"
elif [ "$OBJECT_COUNT" -eq 1 ]; then
    echo -e "${YELLOW}⚠${NC} Website shows coming soon page (single index.html)"
else
    echo -e "${RED}✗${NC} Website has no content"
fi

if [ "$DIST_STATUS" = "Deployed" ]; then
    echo -e "${GREEN}✓${NC} CloudFront distribution is ready"
else
    echo -e "${YELLOW}⚠${NC} CloudFront distribution may still be deploying"
fi
