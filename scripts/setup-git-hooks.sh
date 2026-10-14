#!/bin/sh
# Set up pre-commit hooks for this repository
OPTIONS_SPEC="[options]"

. $(git --exec-path)/git-parse-options

HOOK_DIR=$(git rev-parse --git-dir)/hooks

# Create hooks directory if it doesn't exist
if [ ! -d "$HOOK_DIR" ]; then
  mkdir -p "$HOOK_DIR"
fi

# Install pre-commit hook
if [ -f ".githooks/pre-commit" ]; then
  cp .githooks/pre-commit "$HOOK_DIR/pre-commit"
  chmod +x "$HOOK_DIR/pre-commit"
  echo "✅ Pre-commit hook installed at $HOOK_DIR/pre-commit"
else
  echo "❌ Error: .githooks/pre-commit not found"
  exit 1
fi

echo ""
echo "🎉 Git hooks successfully configured!"
echo "📝 Next steps:"
echo "  - Review the pre-commit hook at: .githooks/pre-commit"
echo "  - Test it by making a commit in this repository"
echo "  - To uninstall, run: rm $HOOK_DIR/pre-commit"
