#!/bin/bash
# ============================================================================
# pre-ship-audit.sh
# Final validation before deploying to production.
# ============================================================================

# Exit immediately if a command exits with a non-zero status.
# Also exit if any command in a pipeline fails.
set -euo pipefail

echo "========================================"
echo "  Pre-Ship Audit"
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

# Run base health check
echo "Running health check..."
if ./scripts/health-check.sh > /dev/null 2>&1; then
  echo "✅ Health check passed"
  PASS=$((PASS + 1))
else
  echo "❌ Health check failed"
  FAIL=$((FAIL + 1))
fi
echo ""

# Documentation checks
check "PRD.md is not empty" "[ -s PRD.md ]"
check "README.md is not empty" "[ -s README.md ]"
check "SECURITY checklist reviewed" "[ -s docs/checklists/SECURITY.md ]"
check "FUNCTIONALITY checklist reviewed" "[ -s docs/checklists/FUNCTIONALITY.md ]"
check "PRE_SHIP checklist reviewed" "[ -s docs/checklists/PRE_SHIP.md ]"
check "ACCESSIBILITY checklist reviewed" "[ -s docs/checklists/ACCESSIBILITY.md ]"
check "PERFORMANCE checklist reviewed" "[ -s docs/checklists/PERFORMANCE.md ]"
check "OBSERVABILITY checklist reviewed" "[ -s docs/checklists/OBSERVABILITY.md ]"
check "RELIABILITY checklist reviewed" "[ -s docs/checklists/RELIABILITY.md ]"
check "OPERATIONS checklist reviewed" "[ -s docs/checklists/OPERATIONS.md ]"
check "COMPLIANCE checklist reviewed" "[ -s docs/checklists/COMPLIANCE.md ]"
check "COST_MANAGEMENT checklist reviewed" "[ -s docs/checklists/COST_MANAGEMENT.md ]"

# Security checks (only if in a git repo)
if [ -d .git ]; then
  check ".env is gitignored" "git check-ignore -q .env 2>/dev/null || [ ! -f .env ]"
  check ".env.local is gitignored" "git check-ignore -q .env.local 2>/dev/null || [ ! -f .env.local ]"
  check "No secrets/ directory committed" "git check-ignore -q secrets/ 2>/dev/null || [ ! -d secrets ]"
else
  echo "⚠️  Not a git repository — skipping git security checks"
fi

# Code quality checks (adapt to your stack)
if [ -f "package.json" ]; then
  if grep -q '"lint"' package.json; then
    echo "Running linter..."
    if npm run lint > /dev/null 2>&1; then
      echo "✅ Linter passed"
      PASS=$((PASS + 1))
    else
      echo "❌ Linter failed"
      FAIL=$((FAIL + 1))
    fi
  fi

  if grep -q '"typecheck"' package.json; then
    echo "Running type check..."
    if npm run typecheck > /dev/null 2>&1; then
      echo "✅ Type check passed"
      PASS=$((PASS + 1))
    else
      echo "❌ Type check failed"
      FAIL=$((FAIL + 1))
    fi
  fi

  if grep -q '"build"' package.json; then
    echo "Running build..."
    if npm run build > /dev/null 2>&1; then
      echo "✅ Build passed"
      PASS=$((PASS + 1))
    else
      echo "❌ Build failed"
      FAIL=$((FAIL + 1))
    fi
  fi
fi

# Console log check (basic grep for actual calls, not comments)
if grep -rn "console\.log(" src/ > /dev/null 2>&1; then
  echo "⚠️  console.log statements found in src/ — review before shipping"
else
  echo "✅ No console.log statements in src/"
  PASS=$((PASS + 1))
fi

echo ""
echo "========================================"
echo "  Results: $PASS passed, $FAIL failed"
echo "========================================"

if [ $FAIL -gt 0 ]; then
  echo ""
  echo "🚫 SHIPPING BLOCKED — fix failures before deploying."
  exit 1
fi

echo ""
echo "🚀 All checks passed. Ready for production."
exit 0
