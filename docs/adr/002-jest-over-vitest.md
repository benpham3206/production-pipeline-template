# ADR-002: Use Jest Over Vitest for the Reference Test Suite

**Status:** accepted  
**Date:** 2026-04-10

---

## Context

We needed a test runner for the reference implementation (`validateEmail` utility). Both Jest and Vitest are popular in the TypeScript ecosystem.

## Decision

Use Jest + ts-jest for the template's test runner.

## Consequences

**Positive:**
- Mature ecosystem, extensive documentation
- Works reliably with `ts-jest` without extra configuration
- Familiar to most developers

**Negative:**
- Slower than Vitest for very large suites
- More dependencies in `package.json`

## Alternatives Considered

| Alternative | Pros | Cons | Verdict |
|-------------|------|------|---------|
| Vitest | Fast, modern, ESM-native | Less universally familiar; some edge cases with tsconfig paths | Rejected |
| Node.js native test runner | No extra deps | TypeScript support still evolving in early 2024 | Rejected |
