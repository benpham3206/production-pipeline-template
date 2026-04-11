# Decisions — 2026-04-10: Maintainability

## Document Index Created
**Context:** User requested an index of all markdown files in the folder.
**Decision:** Created `INDEX.md` at the root, cataloging all markdown documents by directory.
**Rationale:** As the template grows, discoverability becomes critical. An index prevents documents from being lost.
**Consequences:** New markdown files should be added to `INDEX.md` when created.

## Self-Test and Long-Term Maintainability Pass
**Context:** User requested that the project folder be tested against itself, and that all code be clear enough to follow in 10 months to 10 years.
**Decision:**
- Ran `./scripts/init-project.sh`, `./scripts/health-check.sh`, and `./scripts/pre-ship-audit.sh` against the template itself
- Confirmed all pass with zero warnings (health: 25/25, pre-ship: 10/10)
- Rewrote `README.md` from scratch to accurately reflect the current 20+ file structure and complete workflow
- Refactored `src/index.ts` to return a string instead of using `console.log`, making it pure and testable
- Added extensive inline documentation to `src/utils/logger.ts` explaining why it exists and why it uses `process.stdout/stderr`
- Added extensive inline documentation to `src/utils/validator.ts` explaining RFC basis, regex trade-offs, and length limits
- Simplified `src/tests/index.test.ts` to test return values instead of mocking console I/O
- Verified `INDEX.md` remains accurate
**Rationale:** Code that cannot be understood in 10 years is technical debt from day one. Every file must explain its own purpose, constraints, and design decisions to future maintainers (human or AI).
**Trade-offs:** More comments increase file size, but they pay for themselves in reduced confusion and bugs.
**Consequences:** The template is now self-validating, warning-free, and every source file contains sufficient context for long-term maintenance.
