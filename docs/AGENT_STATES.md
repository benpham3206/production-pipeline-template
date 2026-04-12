# Agent States

> Distinct operational modes with specific behaviors, transitions, and safety rules.

---

## State Definitions

| State | Purpose | Behavior |
|-------|---------|----------|
| **reasoning** | Analysis before action | Think, plan, define success criteria — no file changes |
| **coding** | Build, test, run | Write code, scripts, tests, run commands, verify |
| **discussing** | Informal conversation | Clarification, meta-work, no file changes |
| **recovering** | Post-crash | Restore state, resume interrupted work |

---

## State Behaviors

### reasoning
- Run the 5 gates (`docs/AGENT_REASONING.md`)
- Define or confirm success criteria in `STATE.md`
- Select mental models from `docs/MENTAL_MODELS.md`
- Do NOT write code or modify files while in this state
- Output structured analysis and plan only

### coding
- Create checkpoint before significant changes
- Validate syntax before saving
- Run tests continuously; fix failures before proceeding
- Log INTENT before acting, OUTCOME after
- Update `STATE.md` progress after each logical unit

**Scripting sub-rules:**
- Dry-run destructive commands first (`--dry-run`, `echo` preview)
- Validate with `shellcheck` or `bash -n` before saving
- Never run interactive commands in automation

**Testing sub-rules:**
- Report exact pass/fail counts with numbers
- On failure: capture expected vs actual, stack trace, and environment state
- Do NOT skip flaky tests — fix or document

**Execution sub-rules:**
- Capture stdout, stderr, and exit codes
- Abort on unexpected errors; do not proceed blindly

### discussing
- Use for casual clarification, brainstorming, or meta-conversation
- Does NOT require a `CONTEXT_LOG.md` entry for every message
- If a durable insight emerges (process improvement, decision, lesson learned), capture it in `MEMORY.md`
- When project work resumes, transition back to `reasoning` or `coding` and log fresh INTENT

### recovering
- Check `.recovery_needed` flag on startup
- Load latest session backup from `.kimi/session_backup/`
- Read `STATE.md` to identify interrupted tasks
- Run `./scripts/recovery.sh` to validate state
- Do NOT start new work until recovery is complete

---

## State Transitions

| From | To | Requirement |
|------|-----|-------------|
| *any* | **reasoning** | Before any material work |
| *any* | **coding** | Create checkpoint first (for significant changes) |
| **discussing** | **coding/reasoning** | User asks for formal project work |
| *any* | **recovering** | `.recovery_needed` flag detected |

### Auto-Checkpoint Triggers
- Entering **coding** for significant changes → checkpoint
- Long tasks (>60s of continuous execution) → auto-checkpoint
- Before gateway restart → save session state

---

## Quick Reference

```
Reason before coding
Checkpoint before significant changes
Auto-checkpoint every 60s on long tasks
Save session state before gateway restart
Check .recovery_needed on startup
Discuss freely; log formally once work resumes
```
