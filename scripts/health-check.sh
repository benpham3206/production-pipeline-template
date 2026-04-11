#!/bin/bash
# ============================================================================
# health-check.sh
# Run this before any planning or implementation work.
# ============================================================================

# Exit immediately if a command exits with a non-zero status.
# Also exit if any command in a pipeline fails.
set -euo pipefail

echo "========================================"
echo "  Health Check"
echo "========================================"
echo ""

PASS=0
FAIL=0

# check: evaluates a condition and reports pass/fail.
# Arguments:
#   $1 - human-readable description
#   $2 - bash command to evaluate
# MED-3: Uses direct execution instead of eval to prevent command injection.
check() {
  if bash -c "$2" > /dev/null 2>&1; then
    echo "✅ $1"
    PASS=$((PASS + 1))
  else
    echo "❌ $1"
    FAIL=$((FAIL + 1))
  fi
}

# Structure checks
check "AGENTS.md exists" "[ -f AGENTS.md ]"
check "PRD.md exists" "[ -f PRD.md ]"
check "NEXT_ACTION.md exists" "[ -f NEXT_ACTION.md ]"
check "CONTEXT_LOG.md exists" "[ -f CONTEXT_LOG.md ]"
check "STATE.md exists" "[ -f STATE.md ]"
check "LOGS.md exists" "[ -f LOGS.md ]"
check "MEMORY.md exists" "[ -f MEMORY.md ]"
check "ERRORS.md exists" "[ -f ERRORS.md ]"
check "docs/PROCESS.md exists" "[ -f docs/PROCESS.md ]"
check "docs/AGENT_REASONING.md exists" "[ -f docs/AGENT_REASONING.md ]"
check "docs/INTERFACES.md exists" "[ -f docs/INTERFACES.md ]"
check "docs/checklists/SECURITY.md exists" "[ -f docs/checklists/SECURITY.md ]"
check "docs/checklists/FUNCTIONALITY.md exists" "[ -f docs/checklists/FUNCTIONALITY.md ]"
check "docs/checklists/PRE_SHIP.md exists" "[ -f docs/checklists/PRE_SHIP.md ]"
check "docs/AGENT_STATES.md exists" "[ -f docs/AGENT_STATES.md ]"
check "docs/MENTAL_MODELS.md exists" "[ -f docs/MENTAL_MODELS.md ]"
check "docs/DESIGN_DOC.md exists" "[ -f docs/DESIGN_DOC.md ]"
check "docs/ANTI_TEST_GAMING.md exists" "[ -f docs/ANTI_TEST_GAMING.md ]"
check "docs/TESTING.md exists" "[ -f docs/TESTING.md ]"
check "INDEX.md exists" "[ -f INDEX.md ]"

# .kimi checks
check ".kimi/ directory exists" "[ -d .kimi ]"
check ".kimi/context_log.tail exists" "[ -f .kimi/context_log.tail ]"

# memory directory
check "memory/ directory exists" "[ -d memory ]"

# scripts
check "checkpoint.sh exists and executable" "[ -x scripts/checkpoint.sh ]"
check "recovery.sh exists and executable" "[ -x scripts/recovery.sh ]"

# Git checks (only if in a git repo)
if [ -d .git ]; then
  check ".gitignore exists" "[ -f .gitignore ]"
  check ".env files are gitignored" "git check-ignore -q .env 2>/dev/null || git check-ignore -q .env.local 2>/dev/null"
else
  echo "⚠️  Not a git repository — skipping git checks"
fi

# Optional: test suite check (adapt to your stack)
if [ -f "package.json" ]; then
  if grep -q '"test"' package.json; then
    echo ""
    echo "Running test suite..."
    # Run tests and capture exit code directly — do NOT pipe to grep,
    # because piping masks the real exit code and can false-positive.
    if npm test; then
      echo "✅ Tests passing"
      PASS=$((PASS + 1))
    else
      echo "❌ Tests failing"
      FAIL=$((FAIL + 1))
    fi
  fi
fi

echo ""
echo "========================================"
echo "  Results: $PASS passed, $FAIL failed"
echo "========================================"

if [ $FAIL -gt 0 ]; then
  exit 1
fi

exit 0
