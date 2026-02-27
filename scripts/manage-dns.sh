#!/bin/bash
# scripts/manage-dns.sh - Manage DNS records for the website

set -euo pipefail

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "$PROJECT_ROOT"

# Load configuration
source "${PROJECT_ROOT}/config.env"

# Disable AWS CLI pager
export AWS_PAGER=""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}ℹ${NC} $1"; }
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Get hosted zone ID for the domain
get_hosted_zone_id() {
    aws route53 list-hosted-zones --region "$AWS_REGION" \
        --query "HostedZones[?Name=='${DOMAIN_NAME}.'].Id" \
        --output text | sed 's|/hostedzone/||'
}

# Add Google Search Console TXT record
add_google_txt_record() {
    print_status "Adding Google Search Console TXT record..."
    
    HOSTED_ZONE_ID=$(get_hosted_zone_id)
    if [ -z "$HOSTED_ZONE_ID" ]; then
        print_error "Could not find hosted zone for domain: $DOMAIN_NAME"
        return 1
    fi
    
    # Create change batch JSON
    CHANGE_BATCH=$(cat <<EOF
{
    "Changes": [{
        "Action": "UPSERT",
        "ResourceRecordSet": {
            "Name": "${DOMAIN_NAME}",
            "Type": "TXT",
            "TTL": 300,
            "ResourceRecords": [{"Value": "\"${GOOGLE_SEARCH_CONSOLE_TXT}\""}]
        }
    }]
}
EOF
)
    
    # Submit the change
    CHANGE_ID=$(aws route53 change-resource-record-sets \
        --hosted-zone-id "$HOSTED_ZONE_ID" \
        --change-batch "$CHANGE_BATCH" \
        --query 'ChangeInfo.Id' \
        --output text)
    
    print_success "Google TXT record added (Change ID: $CHANGE_ID)"
    print_status "Waiting for DNS propagation..."
    
    aws route53 wait resource-record-sets-changed --id "$CHANGE_ID"
    print_success "DNS change propagated successfully"
}

# Remove Google Search Console TXT record
remove_google_txt_record() {
    print_status "Removing Google Search Console TXT record..."
    
    HOSTED_ZONE_ID=$(get_hosted_zone_id)
    if [ -z "$HOSTED_ZONE_ID" ]; then
        print_error "Could not find hosted zone for domain: $DOMAIN_NAME"
        return 1
    fi
    
    # Check if Google verification record exists
    EXISTING_RECORD=$(aws route53 list-resource-record-sets \
        --hosted-zone-id "$HOSTED_ZONE_ID" \
        --query "ResourceRecordSets[?Name=='${DOMAIN_NAME}.' && Type=='TXT'].ResourceRecords[0].Value" \
        --output text 2>/dev/null || echo "")
    
    EXPECTED_RECORD="\"${GOOGLE_SEARCH_CONSOLE_TXT}\""
    
    if [ "$EXISTING_RECORD" != "$EXPECTED_RECORD" ]; then
        print_warning "No Google TXT record found to remove"
        return 0
    fi
    
    # Delete the Google TXT record
    CHANGE_BATCH=$(cat <<EOF
{
    "Changes": [{
        "Action": "DELETE",
        "ResourceRecordSet": {
            "Name": "${DOMAIN_NAME}",
            "Type": "TXT",
            "TTL": 300,
            "ResourceRecords": [{"Value": "\"${GOOGLE_SEARCH_CONSOLE_TXT}\""}]
        }
    }]
}
EOF
)
    
    # Submit the change
    CHANGE_ID=$(aws route53 change-resource-record-sets \
        --hosted-zone-id "$HOSTED_ZONE_ID" \
        --change-batch "$CHANGE_BATCH" \
        --query 'ChangeInfo.Id' \
        --output text)
    
    print_success "Google TXT record removed (Change ID: $CHANGE_ID)"
}

# Verify Google Search Console TXT record
verify_google_txt_record() {
    print_status "Verifying Google Search Console TXT record..."
    
    HOSTED_ZONE_ID=$(get_hosted_zone_id)
    if [ -z "$HOSTED_ZONE_ID" ]; then
        print_error "Could not find hosted zone for domain: $DOMAIN_NAME"
        return 1
    fi
    
    EXISTING_RECORD=$(aws route53 list-resource-record-sets \
        --hosted-zone-id "$HOSTED_ZONE_ID" \
        --query "ResourceRecordSets[?Name=='${DOMAIN_NAME}.' && Type=='TXT'].ResourceRecords[0].Value" \
        --output text 2>/dev/null || echo "")
    
    EXPECTED_RECORD="\"${GOOGLE_SEARCH_CONSOLE_TXT}\""
    
    if [ "$EXISTING_RECORD" = "$EXPECTED_RECORD" ]; then
        print_success "Google TXT record verified: $EXISTING_RECORD"
        return 0
    elif [ -z "$EXISTING_RECORD" ] || [ "$EXISTING_RECORD" = "None" ]; then
        print_warning "No Google TXT record found"
        return 1
    else
        print_warning "Google TXT record mismatch:"
        print_warning "  Expected: $EXPECTED_RECORD"
        print_warning "  Found:    $EXISTING_RECORD"
        return 1
    fi
}

# Show DNS record status
show_dns_status() {
    print_status "DNS Record Status for $DOMAIN_NAME:"
    
    HOSTED_ZONE_ID=$(get_hosted_zone_id)
    if [ -z "$HOSTED_ZONE_ID" ]; then
        print_error "Could not find hosted zone for domain: $DOMAIN_NAME"
        return 1
    fi
    
    echo "  Hosted Zone ID: $HOSTED_ZONE_ID"
    
    # Get all TXT records for the domain
    TXT_RECORDS=$(aws route53 list-resource-record-sets \
        --hosted-zone-id "$HOSTED_ZONE_ID" \
        --query "ResourceRecordSets[?Name=='${DOMAIN_NAME}.' && Type=='TXT']" \
        --output json)
    
    if [ "$TXT_RECORDS" = "[]" ]; then
        echo "  TXT Records: None"
    else
        echo "  TXT Records:"
        echo "$TXT_RECORDS" | jq -r '.[].ResourceRecords[].Value' | sed 's/^/    /'
    fi
}

# Usage information
show_usage() {
    echo "Usage: $0 {add|remove|verify|status}"
    echo ""
    echo "Commands:"
    echo "  add     - Add Google Search Console TXT record"
    echo "  remove  - Remove Google Search Console TXT record"
    echo "  verify  - Verify Google Search Console TXT record exists and is correct"
    echo "  status  - Show current DNS record status"
    echo ""
    echo "Configuration:"
    echo "  Domain: $DOMAIN_NAME"
    echo "  Google TXT: $GOOGLE_SEARCH_CONSOLE_TXT"
}

# Main script logic
case "${1:-}" in
    add)
        add_google_txt_record
        ;;
    remove)
        remove_google_txt_record
        ;;
    verify)
        verify_google_txt_record
        ;;
    status)
        show_dns_status
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
