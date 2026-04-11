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

## Workflow Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    PRODUCTION PIPELINE WORKFLOW                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   ┌─────────────┐                                                       │
│   │  0. REASON  │  → Run 5 gates (docs/AGENT_REASONING.md)              │
│   │             │  → Create STATE.md entry                               │
│   └──────┬──────┘                                                       │
│          ▼                                                              │
│   ┌─────────────┐                                                       │
│   │  1. AUDIT   │  → Run health-check.sh                                 │
│   │             │  → Read STATE.md, MEMORY.md, ERRORS.md                 │
│   └──────┬──────┘                                                       │
│          ▼                                                              │
│   ┌─────────────┐                                                       │
│   │  2. PRD     │  → Human + Agent draft PRD.md                          │
│   │             │  → Human approves before any code                      │
│   └──────┬──────┘                                                       │
│          ▼                                                              │
│   ┌─────────────┐                                                       │
│   │  3. PLAN    │  → Define interfaces (docs/INTERFACES.md)              │
│   │             │  → Create work packages                                │
│   └──────┬──────┘                                                       │
│          ▼                                                              │
│   ┌─────────────┐     ┌─────────────┐     ┌─────────────┐               │
│   │  4. INTENT  │────▶│  5. EXECUTE │────▶│  6. OUTCOME │               │
│   │   (Log)     │     │   (Work)    │     │   (Log)     │               │
│   └─────────────┘     └─────────────┘     └──────┬──────┘               │
│          ▲────────────────────────────────────────┘                     │
│          │ (Repeat 4-6 for every turn)                                   │
│          ▼                                                              │
│   ┌─────────────┐                                                       │
│   │  7. VERIFY  │  → Run tests, checklists, health checks                │
│   └──────┬──────┘                                                       │
│          ▼                                                              │
│   ┌─────────────┐                                                       │
│   │  8. SHIP    │  → Pre-ship audit passes → Deploy                      │
│   └──────┬──────┘                                                       │
│          ▼                                                              │
│   ┌─────────────┐                                                       │
│   │  9. CLOSEOUT│  → Update LOGS.md, STATE.md, MEMORY.md                │
│   └─────────────┘                                                       │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Audit

Before any work, the agent must:

1. Run the 5 reasoning gates from `docs/AGENT_REASONING.md`
2. Create/update `STATE.md` with success criteria
3. Run `./scripts/health-check.sh`
4. Read `STATE.md`
5. Read `MEMORY.md`
6. Read `ERRORS.md`
7. Read `CONTEXT_LOG.md` (find current turn via `.kimi/context_log.tail`)
8. Check `docs/INTERFACES.md` for relevant contracts

**Why:** Context windows are limited. These documents are our external memory.

---

## Phase 2: PRD

### Human Responsibility
- Define the problem and success criteria
- Approve the PRD before code begins

### Agent Responsibility
- Ask clarifying questions until requirements are crystal clear
- Draft `PRD.md` using the template
- Ensure every success criterion is measurable
- Ensure out-of-scope is explicitly defined

### Gate
**No code until human says: "PRD approved, proceed with implementation."**

---

## Phase 3: Plan

### Interface Definition
For any new component or API, define the interface in `docs/INTERFACES.md` first.

```typescript
interface [ComponentName]Props {
  [prop]: [type];  // [description]
}

// Behavior:
// - [requirement 1]
// - [requirement 2]

// Validation:
// - [rule 1]
// - [rule 2]
```

### Work Packages
For large features, break work into packages using `docs/templates/work-package.md`.

---

## Phase 4-6: Intent → Execute → Outcome

This is the **two-phase commit** that makes agent work recoverable and auditable.

### Before Acting: INTENT

Append to `CONTEXT_LOG.md`:

```markdown
## Turn N: Intent (HH:MM:SS)
**Target:** PRD Section [X.Y] "[Title]"
**Context:** [Brief summary]

### Planned Actions
- [ ] [Action 1]
- [ ] [Action 2]

### Workspace Snapshot
```json
{
  "files": {
    "src/file.js": "sha256:abc..."
  },
  "risk_flags": []
}
```
```

### Execution
Perform the work. Save files after each logical unit.

### After Acting: OUTCOME

Append to `CONTEXT_LOG.md`:

```markdown
## Turn N: Outcome (HH:MM:SS)
**Status:** ✅ Success / ⚠️ Partial Success / ❌ Blocked
**Execution Time:** [N seconds]

### Completed
- ✅ [Action 1]: [Result]

### Blocked / Failed
- ❌ [Action 2]: [Error + root cause]

### Workspace Delta
| File | Before | After | Lines +/- |
|------|--------|-------|-----------|
| src/file.js | sha256:abc... | sha256:def... | +45/-12 |

### PRD Progress Update
| Section | Previous | Current |
|---------|----------|---------|
| 4.1 | planned | in_progress |
```

---

## Phase 7: Verify

Before declaring anything "done":

- [ ] All tests pass
- [ ] `docs/checklists/SECURITY.md` items verified
- [ ] `docs/checklists/FUNCTIONALITY.md` items verified
- [ ] `./scripts/health-check.sh` passes
- [ ] No console errors
- [ ] PRD success criteria are met

**Rule:** Red build = stop the line. Fix before continuing.

---

## Phase 8: Ship

Run the pre-ship audit:

```bash
./scripts/pre-ship-audit.sh
```

Only deploy if all gates pass.

---

## Phase 9: Closeout

Before declaring the task done:

1. **Log completion to `LOGS.md`**
2. **Update `STATE.md`** — mark task complete or blocked
3. **Update `MEMORY.md`** with decisions and lessons
4. **Write significant decisions to `memory/YYYY-MM-DD.md`**
5. **If bugs were found, add an entry to `ERRORS.md`**

---

## Multi-Agent Orchestration

For complex tasks, the human or lead agent may spawn orchestrators.

### Orchestrator Rules
1. Define work package before spawning
2. Set step limit (default: 25)
3. Require checkpoints every 10 steps
4. Intervene if silent >3 minutes or blocked >5 steps

### Communication Protocol

**Assigner → Orchestrator:**
```
ASSIGN: [Task description]
INTERFACE: [Link to docs/INTERFACES.md]
STEP_LIMIT: [N]
CHECKPOINT_EVERY: [N]
```

**Orchestrator → Assigner:**
```
CHECKPOINT [N]/[MAX]
Status: [progress% | blocked | complete | requesting-support]
What I did: [Specific accomplishments]
What's left: [Specific remaining work]
Blockers: [None | specific issue]
Need help with: [None | specific sub-task]
```

See `docs/templates/work-package.md` and `docs/templates/intervention.md` for templates.

---

## Human / Agent Responsibility Matrix

| Activity | Human | Agent |
|----------|-------|-------|
| Define business requirements | ✅ Lead | ✅ Clarify |
| Draft PRD | ✅ Review | ✅ Draft |
| Approve PRD | ✅ Required | ❌ |
| Define interfaces | ✅ Lead | ✅ Draft |
| Write code | ⚠️ Review | ✅ Lead |
| Write tests | ⚠️ Review | ✅ Lead |
| Run checklists | ✅ Verify | ✅ Draft |
| Approve shipping | ✅ Required | ❌ |
| Update MEMORY.md | ✅ Add context | ✅ Required |
| Update ERRORS.md | ✅ Add context | ✅ Required |

---

## Emergency Overrides

An agent may skip the full workflow ONLY if:

1. It's a one-line bug fix with an obvious solution
2. The human explicitly says: "skip the process, just fix it"
3. It's documentation-only changes
4. There's a critical production incident

Even then, document the change in `CONTEXT_LOG.md` and `MEMORY.md`.
