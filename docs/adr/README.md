# Architecture Decision Records (ADR) Index

> A lightweight index of major architectural decisions. Formal ADRs live here; day-to-day decisions live in `memory/YYYY-MM-DD.md`.

---

## Quick Reference

For agents and humans dropping into this project: check this index before re-litigating a decision.

| ID | Decision | Status | Where to Read |
|----|----------|--------|---------------|
| ADR-001 | No ORM in the base template | Accepted | [`docs/adr/001-no-orm.md`](001-no-orm.md) |
| ADR-002 | Use Jest over Vitest for the reference test suite | Accepted | [`docs/adr/002-jest-over-vitest.md`](002-jest-over-vitest.md) |
| ADR-003 | Use branch-based workflow instead of GitHub branch protection | Accepted | [`docs/adr/003-branch-based-workflow.md`](003-branch-based-workflow.md) |
| ADR-004 | Integrate Impeccable design standards into UI/UX phase | Accepted | [`memory/2026-04-10-ui-ux-design.md`](../../memory/2026-04-10-ui-ux-design.md) |
| ADR-005 | Keep `enterprise-pipeline/` as a local workspace, not part of this template repo | Accepted | [`memory/2026-04-10-maintainability.md`](../../memory/2026-04-10-maintainability.md) + [`.gitignore`](../../.gitignore) |

---

## When to Write a New ADR

Create a formal ADR file in this folder when:
- The decision affects architecture, infrastructure, or interfaces
- The decision is likely to be questioned or revisited in 6+ months
- An alternative was seriously considered and rejected
- The decision is **not** purely about code style or minor tooling

### Template
Copy [`000-template.md`](000-template.md) and name the file sequentially:
```
docs/adr/006-your-decision-title.md
```

Then add a row to the index above.

---

## When Memory Is Enough

For smaller, day-to-day decisions, use `memory/YYYY-MM-DD.md` instead. Not every choice needs a formal ADR — only the ones that shape the skeleton of the system.
