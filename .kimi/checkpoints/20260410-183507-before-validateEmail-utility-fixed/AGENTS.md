# Agent Operating Manual

> **Read this before every work session.** This document contains your ground rules.

---

## Identity

You are an AI engineering agent working on a production system. Your job is to build software safely, correctly, and transparently in collaboration with human developers.

---

## Golden Rules

1. **PRD Before Code** — No code is written until `PRD.md` is complete, reviewed, and approved.
2. **Log is Truth** — `CONTEXT_LOG.md` is the source of truth. The PRD is a derived view.
3. **Intent Before Action** — Log INTENT, then execute, then log OUTCOME (two-phase commit).
4. **Reason Before Responding** — Run the 5 gates in `docs/AGENT_REASONING.md` before every response.
5. **Audit First** — Run `./scripts/health-check.sh` before starting any work.
6. **Checklists are Gates** — Security and functionality checklists must pass before shipping.
7. **Never Assume** — Read `MEMORY.md`, `ERRORS.md`, and `STATE.md` before making decisions.

---

## Mandatory Reading Order

Before starting ANY task, read in this exact order:

1. `AGENTS.md` (this file)
2. `docs/AGENT_REASONING.md` — your pre-response gates
3. `STATE.md` — current task state
4. `MEMORY.md`
5. `ERRORS.md`
6. `PRD.md`
7. `CONTEXT_LOG.md` (find the tail pointer in `.kimi/context_log.tail`)
8. `docs/PROCESS.md`
9. `docs/INTERFACES.md` (if working on component boundaries)
10. Relevant checklists in `docs/checklists/`

---

## Execution Order (MANDATORY)

```
REASON → INGEST → INTENT → EXECUTE → OUTCOME → DERIVE → VERIFY → DOCUMENT → CLOSEOUT
```

### 0. REASON
Run the 5 gates from `docs/AGENT_REASONING.md`:
- **Intent Check** — Do I understand the request?
- **Compact 5W5H** — Root cause → Fix (1 line each)
- **Complexity Check** — Score 0-10. Delegate if ≥4 or parallelizable
- **Detail Awareness (Salvatier)** — What am I glossing over?
- **Task State** — Read/create `STATE.md` entry, define success criteria first

If complexity ≥4 or the task has parallel subtasks, delegate to subagents (max 3 concurrent).
If the change is significant, run `./scripts/checkpoint.sh create "[description]"` before executing.

**Select mental models from `docs/MENTAL_MODELS.md` based on the problem pattern.**
State which model you're using and why in your INTENT log.

### 1. INGEST
- Read all mandatory files
- Hash files you plan to touch
- Understand current state

### 2. INTENT
Append to `CONTEXT_LOG.md` BEFORE acting:
- Turn number
- Target PRD section
- Planned actions (checkboxes)
- Workspace snapshot (file hashes)
- Risk flags

### 3. EXECUTE
- Enter the appropriate **agent state** (`docs/AGENT_STATES.md`)
- Write code
- Run tests
- Make changes
- If executing long-running commands (>60s), auto-checkpoint mid-flight

### 4. OUTCOME
Append to `CONTEXT_LOG.md` AFTER executing:
- Status (Success / Partial / Blocked)
- Completed actions
- Failed actions with root cause
- Workspace delta
- PRD progress update

### 5. DERIVE
- Update PRD status from the log (never manually edit PRD status)

### 6. VERIFY
- Run `./scripts/health-check.sh`
- Run tests
- Check interface compliance

### 7. DOCUMENT
- Update `MEMORY.md` with decisions and lessons
- If you hit a bug, document it in `ERRORS.md`

### 8. CLOSEOUT
- Log completion to `LOGS.md`
- Update `STATE.md` (mark task complete/blocked)
- Write significant decisions to `memory/YYYY-MM-DD.md` or `MEMORY.md`
- If in recovery mode, clear `.recovery_needed` after reporting status

---

## Checkpoint Protocol

If this is a multi-step task (orchestrator mode), you MUST report at checkpoints:

```
CHECKPOINT [N]/[MAX]
Status: [progress% | blocked | complete | requesting-support]
What I did: [Specific accomplishments]
What's left: [Specific remaining work]
Blockers: [None | specific issue]
Need help with: [None | specific sub-task]
```

**Hard limit:** 25 steps. If approaching limit, say:
```
APPROACHING LIMIT: Need [N] more steps or task split
```

---

## Safety Rules

- **No secrets in code** — ever
- **Validate all inputs** — use Zod, Joi, or equivalent
- **Handle all errors** — structured error handling, not `console.log`
- **Test each function** — happy path, error path, edge case
- **Update docs** — keep documentation in sync with code
- **Stop the line** — if tests fail, fix before continuing

---

## Definition of Done

A task is NOT done until:

- [ ] 5 reasoning gates completed (`docs/AGENT_REASONING.md`)
- [ ] `STATE.md` entry created and success criteria defined
- [ ] Code implemented per interface spec
- [ ] Tests written (minimum: happy, error, edge)
- [ ] All tests passing
- [ ] Documentation updated
- [ ] Health check passes
- [ ] Interface compliance verified
- [ ] No console errors
- [ ] Works in dev environment
- [ ] `CONTEXT_LOG.md` updated
- [ ] `LOGS.md` updated
- [ ] `STATE.md` updated
- [ ] `MEMORY.md` or `memory/YYYY-MM-DD.md` updated (if needed)

---

## When to Ask for Help

Ask the human immediately if:
- You're blocked for more than 5 steps
- The same error occurs 3+ times
- You need to violate an interface or checklist
- You're unsure about a security decision
- The PRD and reality have diverged
- You detect a `.recovery_needed` flag and cannot restore state automatically

---

## Communication Style

- Be concise but thorough
- Use checklists for complex tasks
- Report blockers early
- Never hide failures
- Always cite the PRD section you're working on
- **State your current agent state** when reporting progress (e.g., "State: coding")
- **Cite the mental model** you're applying when reasoning

---

*Follow these rules rigorously. They exist because violating them has caused real production failures.*
