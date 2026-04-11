#!/bin/bash
# ============================================================================
# init-project.sh
# One-time initialization for the production pipeline template.
# ============================================================================

# Exit immediately if a command exits with a non-zero status.
# Also exit if any command in a pipeline fails.
set -euo pipefail

echo "========================================"
echo "  Production Pipeline Initialization"
echo "========================================"
echo ""

# Validate structure
REQUIRED_FILES=(
  "AGENTS.md"
  "PRD.md"
  "NEXT_ACTION.md"
  "CONTEXT_LOG.md"
  "STATE.md"
  "LOGS.md"
  "MEMORY.md"
  "ERRORS.md"
  "README.md"
  "docs/PROCESS.md"
  "docs/AGENT_REASONING.md"
  "docs/AGENT_STATES.md"
  "docs/MENTAL_MODELS.md"
  "docs/UI_UX.md"
  "docs/DESIGN_DOC.md"
  "docs/ANTI_TEST_GAMING.md"
  "docs/TESTING.md"
  "docs/INTERFACES.md"
  "docs/checklists/SECURITY.md"
  "docs/checklists/FUNCTIONALITY.md"
  "docs/checklists/PRE_SHIP.md"
  "scripts/health-check.sh"
  "scripts/checkpoint.sh"
  "scripts/recovery.sh"
  "scripts/pre-ship-audit.sh"
  "INDEX.md"
)

MISSING=0
for file in "${REQUIRED_FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "❌ Missing required file: $file"
    MISSING=1
  fi
done

if [ $MISSING -eq 1 ]; then
  echo ""
  echo "Please ensure all template files are present before proceeding."
  exit 1
fi

# Initialize directories
mkdir -p .kimi
mkdir -p .kimi/session_backup
mkdir -p memory

# Initialize recovery flag (clear on fresh init)
rm -f .recovery_needed

# Initialize tail pointer if missing
if [ ! -f ".kimi/context_log.tail" ]; then
  echo "0" > .kimi/context_log.tail
  echo "✅ Created .kimi/context_log.tail"
else
  echo "✅ .kimi/context_log.tail already exists"
fi

# Ensure scripts are executable
chmod +x scripts/*.sh

# Install git hooks (local safety net for no-direct-push-to-main)
if [ -d ".git" ]; then
  git config core.hooksPath .githooks
  chmod +x .githooks/pre-push 2>/dev/null || true
  echo "✅ Installed git hooks (.githooks/pre-push)"
else
  echo "⚠️  No .git directory found — skipping git hook installation"
fi

echo ""
echo "✅ Project structure validated."
echo ""
echo "Next steps:"
echo "  1. Fill out PRD.md"
echo "  2. Review docs/PROCESS.md"
echo "  3. Run: ./scripts/health-check.sh"
echo ""

exit 0
