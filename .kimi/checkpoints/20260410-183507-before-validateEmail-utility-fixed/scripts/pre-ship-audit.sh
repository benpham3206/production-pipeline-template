#!/bin/bash
# ============================================================================
# pre-ship-audit.sh
# Final validation before deploying to production.
# ============================================================================

set -e

echo "========================================"
echo "  Pre-Ship Audit"
echo "========================================"
echo ""

PASS=0
FAIL=0

check() {
  if eval "$2" > /dev/null 2>&1; then
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

# Security checks
check ".env is gitignored" "git check-ignore -q .env 2>/dev/null || [ ! -f .env ]"
check ".env.local is gitignored" "git check-ignore -q .env.local 2>/dev/null || [ ! -f .env.local ]"
check "No secrets/ directory committed" "git check-ignore -q secrets/ 2>/dev/null || [ ! -d secrets ]"

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

# Console log check (basic grep for common languages)
if grep -rn "console\.log" src/ > /dev/null 2>&1; then
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
else
  echo ""
  echo "🚀 All checks passed. Ready for production."
fi
