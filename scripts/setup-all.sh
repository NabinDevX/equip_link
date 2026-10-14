#!/bin/sh
# Comprehensive setup script for EquipLink deployment fixes

set -e

echo "🚀 Setting up EquipLink deployment fixes..."
echo ""

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Check required tools
echo "📝 Checking required tools..."
REQUIRED_TOOLS=("git" "dart" "flutter")

for tool in "${REQUIRED_TOOLS[@]}"; do
    if command_exists "$tool"; then
        echo "   ✅ $tool: $(echo $tool | dd count=1 2>/dev/null | xargs || echo 'installed')"
    else
        echo "   ⚠️  Warning: $tool not found in PATH"
    fi
done
echo ""

# 2. Install git hooks
echo "🔧 Setting up git hooks..."
if [ -f ".githooks/pre-commit" ]; then
    chmod +x .githooks/pre-commit

    # Install hook in .git/hooks/
    if [ -f ".git/hooks/pre-commit" ]; then
        echo "   ⚠️  Hook already exists in .git/hooks/pre-commit"
        echo "   💡 Run: rm .git/hooks/pre-commit && .githooks/pre-commit"
    else
        cp .githooks/pre-commit .git/hooks/pre-commit
        chmod +x .git/hooks/pre-commit
        echo "   ✅ Pre-commit hook installed"
    fi
else
    echo "   ❌ Error: .githooks/pre-commit not found"
    echo "   💡 Make sure the file exists in the repository root"
    exit 1
fi
echo ""

# 3. Fix import issue in sign_in_screen.dart
echo "🔧 Fixing code issues..."
if grep -q "package:flutter/foundation.dart" "equip_link_flutter/lib/features/auth/presentation/sign_in_screen.dart"; then
    # Remove the import line
    sed -i '/import '\''package:flutter\/foundation.dart'\''/d' "equip_link_flutter/lib/features/auth/presentation/sign_in_screen.dart"
    echo "   ✅ Fixed unnecessary import in sign_in_screen.dart"
else
    echo "   ✅ No unnecessary imports to fix"
fi
echo ""

# 4. Verify API URL configuration
echo "🔍 Verifying API URL configuration..."
if grep -q "nabindev.api.serverpod.space" "equip_link_flutter/assets/config.json"; then
    echo "   ✅ Flutter config.json points to deployed server"
else
    echo "   ⚠️  Warning: config.json may not have correct API URL"
fi

if grep -q "SERVER_URL environment variable" "equip_link_flutter/lib/client.dart"; then
    echo "   ✅ Client prioritizes environment variable for API URL"
else
    echo "   ⚠️  Warning: client.dart may not properly prioritize environment variable"
fi
echo ""

# 5. Check for uncommitted changes
echo "📊 Checking git status..."
if [ -n "$(git status --porcelain)" ]; then
    echo "   📝 There are uncommitted changes. Review them with: git status"
    git status --short | head -20
else
    echo "   ✅ No uncommitted changes"
fi
echo ""

# 6. Provide next steps
echo "============================================"
echo "🎉 Setup Complete!"
echo "============================================"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Review and commit the changes:"
echo "   git add ."
echo "   git commit -m 'Fix: Configure Flutter app for deployed Serverpod API'"
echo ""
echo "2. Test deployment endpoints:"
echo "   ./scripts/test-deployment-endpoints.sh"
echo ""
echo "3. Review API configuration:"
echo "   ./scripts/review-api-endpoints.sh"
echo ""
echo "4. (Optional) Install git hooks in current repo:"
echo "   ./scripts/setup-git-hooks.sh"
echo ""
echo "5. Run Flutter app with deployed backend:"
echo "   cd equip_link_flutter"
echo "   flutter run --dart-define=SERVER_URL=https://nabindev.api.serverpod.space"
echo ""
echo "📚 Documentation:"
echo "   - FIXES_SUMMARY.md - Complete list of fixes"
echo "   - GITHUB_ACTIONS_SECRETS.md - Frontend secrets reference"
echo "   - .github/workflows/secrets-reference.md - All secrets reference"
echo ""
echo "🔑 Required GitHub Secrets:"
echo "   - SERVER_URL: https://nabindev.api.serverpod.space"
echo "   - GOOGLE_SERVER_CLIENT_ID: Your Google OAuth Client ID"
echo ""
echo "============================================"