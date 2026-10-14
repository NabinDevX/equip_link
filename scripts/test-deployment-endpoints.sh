#!/bin/sh
# Test script to verify API endpoints are accessible on deployed server

echo "🔍 Testing deployed Serverpod API endpoints..."
echo "Server URL: https://nabindev.api.serverpod.space"
echo ""

# Test 1: Health check
echo "1️⃣ Health Check Endpoint..."
curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" https://nabindev.api.serverpod.space/health || echo "Failed"

# Test 2: Try to get a greeting (should return profile info if authenticated, or error if not)
echo "2️⃣ Greeting Endpoint (Requires Authentication)..."
curl -s https://nabindev.api.serverpod.space/greet | head -20 || echo "Failed"

# Test 3: Check if server config endpoint is accessible
echo "3️⃣ Server Config Endpoint..."
curl -s https://nabindev.api.serverpod.space/config | head -20 || echo "Failed"

echo ""
echo "✅ Endpoints tested. If all return HTTP 200/401, the server is accessible."
echo "⚠️  Authentication requires proper token/session management."
