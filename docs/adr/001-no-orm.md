# ADR-001: No ORM in the Base Template

**Status:** accepted  
**Date:** 2026-04-10  
**Deciders:** Benjamin Pham + AI Agent

---

## Context

Most production templates include an ORM (Prisma, Drizzle, TypeORM) by default. We considered this for the production pipeline template.

## Decision

Do not include an ORM in the base template. The template should remain stack-agnostic. Database patterns will be documented as optional examples.

## Consequences

**Positive:**
- Template works for any backend language or framework
- No migration tooling or schema files to maintain
- Projects that don't need a DB aren't burdened by ORM boilerplate

**Negative:**
- Every project that adds a DB must choose and configure its own ORM
- Slightly slower startup for DB-backed projects

## Alternatives Considered

| Alternative | Pros | Cons | Verdict |
|-------------|------|------|---------|
| Prisma | Mature, great DX | Ties template to Node.js; heavy schema files | Rejected |
| Drizzle | Lighter, type-safe | Still framework-specific | Rejected |
| Raw SQL examples only | Universal, no deps | More boilerplate for users | Accepted as documentation only |
