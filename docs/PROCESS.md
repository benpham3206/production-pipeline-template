# Agentic / Human Collaboration Workflow

> How humans and AI agents work together to build production software.

---

## Philosophy

This project treats the AI agent as a **collaborator**, not a tool. That means:

- The agent has autonomy within defined boundaries
- The agent must communicate transparently (INTENT → OUTCOME)
- The human reviews and approves at key gates
- Both parties share responsibility for quality

---

## Workflow Overview (4 Phases)

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    PRODUCTION PIPELINE (4 PHASES)                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  PHASE 1: DISCOVER                                              │    │
│  │  REASON → INGEST → PRD → TECH_SEL → DESIGN_DOC → UI/UX_or_ARCH│    │
│  │  • Understand the problem                                       │    │
│  │  • Get human approval on PRD, tech stack, design doc, UX/arch   │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                              ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  PHASE 2: DEFINE                                                │    │
│  │  TESTS → PLAN → [DESIGN_TESTS]                                  │    │
│  │  • Define tests from design specs                               │    │
│  │  • Plan interfaces and work packages                            │    │
│  │  • Run adversarial test review                                  │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                              ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  PHASE 3: BUILD                                                 │    │
│  │  INTENT → EXECUTE → OUTCOME → CODE_REVIEW → DERIVE → VERIFY     │    │
│  │  • Write code (TDD/BDD)                                         │    │
│  │  • Log intent and outcome every turn                            │    │
│  │  • Code review gate before verification                         │    │
│  │  • Run tests, checklists, constraint audit                      │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                              ▼                                          │
│  ┌─────────────────────────────────────────────────────────────────┐    │
│  │  PHASE 4: SHIP                                                  │    │
│  │  DOCUMENT → CLOSEOUT                                            │    │
│  │  • Pre-ship audit, deploy                                       │    │
│  │  • Update MEMORY.md, STATE.md, LOGS.md                          │    │
│  └─────────────────────────────────────────────────────────────────┘    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### Detailed 16-Step View

For fine-grained tracking, the 4 phases break down into 16 steps:

| Step | Name | Phase | Purpose |
|------|------|-------|---------|
| 0 | REASON | DISCOVER | Run 5 gates, create STATE.md entry |
| 1 | INGEST | DISCOVER | Read docs, hash files, run health-check.sh |
| 2 | PRD | DISCOVER | Draft PRD.md; human approval required |
| 3 | TECHNOLOGY_SELECTION | DISCOVER | Propose stack; human approval required |
| 4 | DESIGN_DOC | DISCOVER | Write design doc; human approval required |
| 5 | UI/UX_or_ARCHITECTURE | DISCOVER | Design flows or system architecture |
| 6 | TESTS | DEFINE | Define tests from design specs |
| 7 | PLAN | DEFINE | Define interfaces, create work packages |
| 8 | DESIGN_TESTS | DEFINE | Adversarial test review (optional but recommended) |
| 9 | INTENT | BUILD | Log planned actions before executing |
| 10 | EXECUTE | BUILD | Write code, run tests |
| 11 | OUTCOME | BUILD | Log results after executing |
| 12 | CODE_REVIEW | BUILD | Mandatory review before verification |
| 13 | DERIVE | BUILD | Update PRD status from the log |
| 14 | VERIFY | BUILD | Run tests, checklists, constraint audit |
| 15 | DOCUMENT | SHIP | Update MEMORY.md, ERRORS.md |
| 16 | CLOSEOUT | SHIP | Log completion, update STATE.md |

---

## Agent State Banner

Every agent response must begin with a state banner:

```markdown
**State: reasoning**
```

Valid states: `reasoning`, `coding`, `discussing`, `recovering`.

- **`reasoning`** — DISCOVER and DEFINE phases: read, analyze, draft documents, run read-only commands
- **`coding`** — BUILD and SHIP phases: write files, run tests, execute builds, deploy
- **`discussing`** — Casual Q&A, no file changes
- **`recovering`** — Post-crash state restoration

See `docs/AGENT_STATES.md` for full definitions.

---

## Transition to Coding (The Coding Lock)

You may only enter `coding` state if **all** gates are satisfied:

| Gate | Evidence |
|------|----------|
| PRD approved | `PRD.md` contains `**Status:** Approved` or human explicitly approved |
| Technology selected | `docs/TECHNOLOGY_SELECTION.md` approved (or N/A if stack is unchanged) |
| Design doc approved | Human approved `docs/DESIGN_DOC.md` |
| Tests defined | `docs/templates/test-spec.md` exists with test cases |
| Plan exists | `docs/INTERFACES.md` or `STATE.md` has execution plan |

When moving to `coding`, explicitly state the gate check with ✅/❌ for each item. If any gate fails, stay in `reasoning`.

---

## Re-Approval Rule

If you modify any approved document after approval, you must immediately reset its status and request re-approval:

- `PRD.md`
- `docs/TECHNOLOGY_SELECTION.md`
- `docs/DESIGN_DOC.md`
- `docs/templates/test-spec.md`
- `docs/INTERFACES.md`

Required actions:
1. Change status to `**Status:** Pending Review`
2. Update `STATE.md` — note pending re-approval
3. Update `NEXT_ACTION.md` — "Human approval needed for updated [Document]"
4. Write one sentence to `memory/YYYY-MM-DD.md`
5. Add/update `docs/adr/` if architecture/scope/constraints changed

You may **not** return to `coding` until the human explicitly re-approves.

---

## Phase Details

### Phase 0: REASON

Run the 5 gates from `docs/AGENT_REASONING.md`:
1. **Intent Check** — Do I understand the request?
2. **Compact 5W5H** — Root cause → Fix
3. **Complexity Check** — Score 0-10
4. **Detail Awareness** — What am I glossing over?
5. **Task State** — Read/create `STATE.md`, define success criteria

If complexity ≥4 or parallelizable, delegate to subagents (max 3).

### Phase 1: INGEST

Before any work:
1. Read all mandatory files in `AGENTS.md` order
2. Hash files you plan to touch
3. Run `./scripts/health-check.sh`
4. Check `docs/INTERFACES.md` for relevant contracts

### Phase 2: PRD

**Agent:** Draft `PRD.md`, ensure success criteria are measurable, set status to `Ready for Review`. **Stop and wait for human approval.**

**Human:** Approve PRD before any design work begins.

**Gate:** No technology selection until PRD is approved.

### Phase 3: TECHNOLOGY SELECTION

- Propose technology stack and architecture pattern
- Document in `docs/TECHNOLOGY_SELECTION.md`
- Get **human approval** before proceeding
- **No design doc until technology selection is approved**

### Phase 4: DESIGN DOCUMENT

- Write `docs/DESIGN_DOC.md` with objectives, metrics, constraints, criteria
- Map every test to an objective
- Run adversarial test review (`docs/ANTI_TEST_GAMING.md`)
- Get **human approval** before UI/UX or architecture

**Gate:** No UI/UX or architecture until design doc is approved.

### Phase 5: UI/UX or ARCHITECTURE

- User-facing: design flows, screens, copy using `docs/templates/ui-spec.md`
- Backend/infra: design system architecture and data flow
- Get **human approval** before test definition

**Gate:** No test definition until this phase is approved.

### Phase 6: TEST DEFINITION

- Write `docs/templates/test-spec.md` from design specs
- Every designed state must have a test
- Run the Edge Case Audit checklist
- Get human approval for critical features

**Gate:** No code until test spec is complete.

### Phase 7: PLAN

- Define interfaces in `docs/INTERFACES.md`
- Create work packages using `docs/templates/work-package.md` if large/parallelizable

### Phases 8-10: INTENT → EXECUTE → OUTCOME

This is the two-phase commit. Append INTENT to `CONTEXT_LOG.md` before acting, then OUTCOME after. Repeat for every turn of work.

### Phase 11: CODE REVIEW

Mandatory. No verification until reviewed by a human or independent peer agent. No self-review.

### Phase 12: DERIVE

Update PRD status from the log. Never manually edit PRD status outside of this phase.

### Phase 13: VERIFY

- All tests pass
- `docs/checklists/SECURITY.md` and `docs/checklists/FUNCTIONALITY.md` verified
- `./scripts/health-check.sh` passes
- Constraint audit and adversarial review clean
- PRD success criteria met

**Rule:** Red build = stop the line. Fix before continuing.

### Phase 14: SHIP

Run `./scripts/pre-ship-audit.sh`. Only deploy if all gates pass.

### Phase 15: CLOSEOUT

1. Log completion to `LOGS.md`
2. Update `STATE.md`
3. Update `MEMORY.md`
4. Write significant decisions to `memory/YYYY-MM-DD.md`
5. If bugs found, add to `ERRORS.md`

---

## Anti-Laziness Rule

You may not skip, abbreviate, or defer any step because a task seems "small," "obvious," "just a quick fix," or "not worth the overhead." The only valid exceptions are listed in Emergency Overrides below. When in doubt, run the full workflow.

---

## Emergency Overrides

You may skip the full workflow **only** in these situations:

1. The human **explicitly** says: "skip the process, just fix it" or "emergency override"
2. There's a critical production incident requiring immediate action
3. It's documentation-only changes (README, comments) that do not affect behavior

**You may NEVER declare your own task eligible for the fast path.** Only the human can grant an emergency override. Absent explicit human permission, the full workflow applies.

Even on an emergency fast path, document the change in `CONTEXT_LOG.md` and `MEMORY.md`.

---

## Human / Agent Responsibility Matrix

| Activity | Human | Agent |
|----------|-------|-------|
| Define business requirements | ✅ Lead | ✅ Clarify |
| Draft PRD | ✅ Review | ✅ Draft |
| Approve PRD | ✅ Required | ❌ |
| Draft Technology Selection | ✅ Review | ✅ Draft |
| Approve Technology Selection | ✅ Required | ❌ |
| Draft Design Doc | ✅ Review | ✅ Draft |
| Approve Design Doc | ✅ Required | ❌ |
| Define interfaces | ✅ Lead | ✅ Draft |
| Write code | ⚠️ Review | ✅ Lead |
| Write tests | ⚠️ Review | ✅ Lead |
| Run checklists | ✅ Verify | ✅ Draft |
| Approve shipping | ✅ Required | ❌ |
| Update MEMORY.md | ✅ Add context | ✅ Required |
| Update ERRORS.md | ✅ Add context | ✅ Required |
