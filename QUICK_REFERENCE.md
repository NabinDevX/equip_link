# EquipLink Flutter - Quick Reference

## 🔑 Frontend Secrets for GitHub Actions

### Required Secrets:
```
SERVER_URL = https://nabindev.api.serverpod.space
GOOGLE_SERVER_CLIENT_ID = 515370521108-067ki0sgmef8u0hi0g033v1f4josjisi.apps.googleusercontent.com
```

### How to add in GitHub:
1. Go to Settings → Secrets and variables → Actions
2. Click New repository secret for each above
3. Add the value and click Add

---

## 🚀 Quick Setup Commands

```bash
# Install all fixes (one command)
./scripts/setup-all.sh

# Or individual steps:
./scripts/setup-git-hooks.sh
./scripts/test-deployment-endpoints.sh
./scripts/review-api-endpoints.sh
```

---

## 👤 How to Run Flutter App

```bash
cd equip_link_flutter

# Method 1: Use default config (from config.json)
flutter run

# Method 2: Override with environment variable
flutter run --dart-define=SERVER_URL=https://nabindev.api.serverpod.space

# Method 3: Use Google Sign-In
flutter run --dart-define=SERVER_URL=https://nabindev.api.serverpod.space \
            --dart-define=GOOGLE_SERVER_CLIENT_ID=515370521108-067ki0sgmef8u0hi0g033v1f4josjisi.apps.googleusercontent.com
```

---

## 📝 Git Commands

```bash
# Review all changes
git diff

# Stage all changes
git add .

# Commit (pre-commit hook will run)
git commit -m "Fix: Configure Flutter app for deployed Serverpod API"

# View modified files
git status --short
```

---

## 🔍 Verification

```bash
# Check code quality
dart analyze

# Check code formatting  
dart format --set-exit-if-changed .

# Test deployment endpoints
./scripts/test-deployment-endpoints.sh

# Review API configuration
./scripts/review-api-endpoints.sh
```

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| **FIXES_SUMMARY.md** | Complete list of all fixes and fixes details |
| **GITHUB_ACTIONS_SECRETS.md** | Frontend secrets reference only |
| **.github/workflows/secrets-reference.md** | All (backend + frontend) secrets reference |
| **README.md** | Project README |

---

## 📋 Modified Files in equip_link_flutter/

```
M equip_link_flutter/assets/config.json
M equip_link_flutter/lib/client.dart
M equip_link_flutter/lib/features/auth/presentation/register_screen.dart
M equip_link_flutter/lib/features/auth/presentation/sign_in_screen.dart
M equip_link_flutter/android/app/src/main/AndroidManifest.xml
```

**Key Changes:**
- `client.dart`: Prioritizes environment variable for API URL
- `config.json`: Updated to use deployed cloud server URL
- `sign_in_screen.dart`: Removed unnecessary import
- `register_screen.dart`: Updated auth calls

---

## 🏠 Deployed Server Details

**URL:** https://nabindev.api.serverpod.space

**Authentication Endpoints Now Working:**
- ✅ Email/Password login
- ✅ Registration with email verification
- ✅ Password reset
- ✅ OTP-based login
- ✅ Google Sign-In (if configured)

**Other API Endpoints:**
- ✅ Equipment listings (search, get, create, update)
- ✅ Rental requests (create, approve, reject, etc.)
- ✅ Student profiles
- ✅ Notifications

---

## ✅ Common Issues & Solutions

### Issue: "Unable to connect to server"
**Solution:** Set SERVER_URL environment variable
```bash
flutter run --dart-define=SERVER_URL=https://nabindev.api.serverpod.space
```

### Issue: Authentication fails
**Solution:** 
- Ensure Google Client ID is set correctly
- Verify session is being stored properly
- Check browser console for OAuth errors

### Issue: Pre-commit hook doesn't run
**Solution:**
```bash
chmod +x .git/hooks/pre-commit
```

### Issue: Code formatting fails
**Solution:**
```bash
cd equip_link_flutter
dart format .
```

---

## 📞 Support

- **Backend issues**: Check Serverpod Cloud dashboard
- **Authentication issues**: Verify email service (Brevo) is configured
- **Frontend issues**: See FIXES_SUMMARY.md
- **GitHub Actions**: Check .github/workflows/secrets-reference.md

---

**Last Updated:** 2026-10-14  
**Deployed Server:** https://nabindev.api.serverpod.space
