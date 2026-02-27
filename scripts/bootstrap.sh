#!/bin/bash
# scripts/bootstrap.sh - Bootstrap project for local development

set -euo pipefail

# Change to project root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "$PROJECT_ROOT"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${BLUE}ℹ${NC} $1"; }

echo "🚀 BOOTSTRAPPING PROJECT"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}✗${NC} Node.js is required but not installed"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi
echo -e "${GREEN}✓${NC} Node.js found: $(node --version)"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}✗${NC} npm is required but not installed"
    exit 1
fi
echo -e "${GREEN}✓${NC} npm found: $(npm --version)"

echo ""

# Install dependencies
print_status "Installing dependencies..."
npm install
echo -e "${GREEN}✓${NC} Dependencies installed"

echo ""

# Verify project can build
print_status "Testing build process..."
npm run build
echo -e "${GREEN}✓${NC} Build test successful"

echo ""
echo -e "${GREEN}✓${NC} Project bootstrapped successfully!"
echo ""
echo "Next steps:"
echo "  1. Run 'npm run dev' to start development server"
echo "  2. Run './scripts/verify-prerequisites.sh' to check deployment readiness"
echo "  3. Run './scripts/deploy.sh' to deploy to AWS"
