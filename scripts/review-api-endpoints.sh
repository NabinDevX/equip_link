#!/bin/sh
# Verify all API endpoints are correctly configured

repo_root="$(git rev-parse --show-toplevel)"

echo "🔍 Reviewing API endpoint configuration..."
echo ""

# Check backend configuration files
echo "1️⃣ Checking Serverpod backend configuration..."
if grep -q "publicHost.*api.serverpod.space" "$repo_root/equip_link_server/config/production.yaml"; then
  echo "   ✅ Production config has correct API host"
else
  echo "   ⚠️  Warning: Production config may not have correct API host"
fi

echo "2️⃣ Checking Flutter client configuration..."
if grep -q "nabindev.api.serverpod.space" "$repo_root/equip_link_flutter/assets/config.json"; then
  echo "   ✅ Flutter app configured for deployed server"
else
  echo "   ⚠️  Flutter app may not be configured for deployed server"
fi

echo "3️⃣ Checking client initialization..."
if grep -q "SERVER_URL environment variable" "$repo_root/equip_link_flutter/lib/client.dart"; then
  echo "   ✅ Client prioritizes environment variable for API URL"
else
  echo "   ⚠️  Client may not properly prioritize environment variable"
fi

echo ""
echo "4️⃣ Reviewing authentication code..."
cd "$repo_root"

# Check if auth initialization is correct
if grep -q "client.auth.initialize()" "$repo_root/equip_link_flutter/lib/client.dart"; then
  echo "   ✅ Client initialization includes auth setup"
else
  echo "   ❌ Auth initialization may be missing"
fi

# Check for proper session storage
if grep -q "FlutterAuthSessionManager" "$repo_root/equip_link_flutter/lib/client.dart"; then
  echo "   ✅ Session management is configured"
else
  echo "   ⚠️  Session management may not be configured"
fi

echo ""
echo "✅ API endpoint review complete. Check warnings above."
