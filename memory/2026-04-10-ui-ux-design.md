# Decisions — 2026-04-10: UI/UX and Design

## UI/UX and Test Definition Phases Added
**Context:** User identified that UI/UX design and feedback loops were weak, and asked whether tests should be defined before building.
**Decision:** 
- Created `docs/UI_UX.md` with design phase rules, feedback loop requirements, and approval gates
- Created `docs/templates/ui-spec.md` for screen/component specifications
- Created `docs/templates/test-spec.md` for behavior-driven test definitions
- Created `docs/templates/bug-report.md` with regular/edge-case/regression classification
- Updated `docs/PROCESS.md` to enforce **PRD → UI/UX → Test Definition → Code**
- Updated `AGENTS.md`, `PRD.md`, and `docs/TESTING.md` to reflect this ordering
**Rationale:** You cannot write exhaustive tests without knowing exact UI states, copy, and feedback behavior. UI/UX must precede test definition, and test definition must precede code (BDD).
**Trade-offs:** Adds design and test spec approval gates, potentially slowing initial velocity but catching expensive design/integration bugs early.
**Consequences:** The pipeline now prevents "code first, figure out UX later" anti-patterns. Every designed state must have a test.

## Design Document Phase and Anti-Test-Gaming Safeguards Added
**Context:** User asked how to ensure agents write *accurate* code vs. plausible/test-passing code, and requested a formal Design Document phase with objectives, constraints, criteria, and test philosophy.
**Decision:**
- Created `docs/DESIGN_DOC.md` establishing:
  - High-level objectives (functional + non-functional)
  - Detailed objectives (Salvatier decomposition)
  - Metrics (measurable, meaningful)
  - Constraints (the hard line — cross it, design is out)
  - Criteria (better-looks-like-this optimization)
  - Test-to-objective mapping (no orphan tests)
  - Test philosophy (purpose, method, results, confidence discussion)
  - Adversarial test review (agent must find loopholes before coding)
  - Ordered recommendations
- Created `docs/templates/design-doc.md` as the working template
- Created `docs/ANTI_TEST_GAMING.md` with 7 safeguards
- Updated workflow to: **PRD → UI/UX → Test Definition → Design Doc → Code**
**Rationale:** Tests alone cannot prevent AI agents from writing plausible-but-wrong code. Constraints, adversarial reviews, and design intent create a multi-layer defense.
**Consequences:** The pipeline now explicitly prevents "Goodhart's Law" in code generation. Passing tests is necessary but not sufficient. The code must satisfy design intent, constraints, and pass adversarial scrutiny.
