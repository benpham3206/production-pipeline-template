# ADR-003: Use Branch-Based Workflow Instead of GitHub Branch Protection

**Status:** accepted  
**Date:** 2026-04-10

---

## Context

GitHub's "Require status checks to pass before merging" branch protection feature is not reliably available on free private repositories.

## Decision

Enforce safety through local git hooks and process discipline rather than relying on GitHub UI settings.

## Consequences

**Positive:**
- Works on free accounts and any git host
- `.githooks/pre-push` blocks accidental pushes to `main` locally
- No platform lock-in

**Negative:**
- Depends on individual discipline rather than server-enforced rules
- Must run `init-project.sh` on every clone to install hooks

## Alternatives Considered

| Alternative | Pros | Cons | Verdict |
|-------------|------|------|---------|
| GitHub Pro ($4/mo) | Server-enforced rules | Unnecessary cost for a template | Rejected |
| Require all repos to be public | Branch protection works for free | User may need private repos | Rejected |
