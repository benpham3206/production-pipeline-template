# Decisions — 2026-04-10: Testing Philosophy

## Exhaustive Atomic Testing Philosophy
**Context:** User specified tests should be "atomically and precisely quantifiable to the point of exhaustion."
**Decision:** Created `docs/TESTING.md` with atomic test contracts, quantification checklists, coverage map template, and updated `src/tests/index.test.ts` as an example of atomic, quantified tests.
**Rationale:** Vague tests create false confidence. Atomic, quantifiable tests make every claim about the system explicit and verifiable.
**Trade-offs:** More test files and lines of test code, but each failure is immediately diagnostic.
**Consequences:** Testing is now treated as a first-class engineering discipline in this template.

## Simulation: validateEmail Utility Built End-to-End
**Context:** User requested a live simulation of the pipeline in action.
**Decision:** Built `src/utils/validator.ts` and `src/tests/validator.test.ts` following every pipeline rule: 5-gate reasoning, checkpoint before coding, INTENT/OUTCOME logging, atomic tests, coverage map update, and full closeout.
**Rationale:** A real feature is the only way to prove the pipeline isn't just documentation.
**Trade-offs:** Added Jest + TypeScript tooling to the template (package.json, jest.config.js, tsconfig.json), making it slightly less stack-agnostic but more immediately usable.
**Consequences:** The template now boots with a working test runner and a passing reference implementation.

## Bug Fix: checkpoint.sh macOS Compatibility
**Context:** During simulation, `checkpoint.sh` failed on macOS because `cp --parents` is GNU-only.
**Decision:** Replaced `cp --parents` with a POSIX-compatible `while read` loop using `mkdir -p` + `cp`.
**Rationale:** Scripts must work on macOS and Linux out of the box.
**Consequences:** Checkpoints are now reliable across platforms.
