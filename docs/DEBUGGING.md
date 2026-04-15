# Debugging Workflow

> A disciplined, step-by-step methodology for investigating and fixing bugs. This applies to runtime errors, test failures, unexpected behavior, and production incidents.

---

## Philosophy

Debugging is not guess-and-check. It is **controlled experimentation** applied to a malfunctioning system. The agent's natural tendency is to form a hypothesis, edit code to test it, and repeat. This workflow exists to make that process explicit, rigorous, and reversible.

**Golden rule:** If you are trying to understand why something is broken, you are in **debugging mode**. Debugging mode defaults to `reasoning` state. Every experiment must be logged.

**Relationship to `docs/AGENT_REASONING.md`:** Debugging is a special case of reasoning. Before and during the debugging loop, you must run the **5 gates** from `docs/AGENT_REASONING.md`, particularly **Gate 2 (5W5H)** for root-cause analysis and **Gate 4 (Detail Awareness)** to surface hidden contributing factors.

---

## When This Applies

Use this workflow whenever:
- A test fails unexpectedly
- A runtime error occurs
- Production behavior deviates from the spec
- A user reports a bug
- CI/CD fails on a step that "used to work"

---

## The Debugging Loop

```
┌─────────────────────────────────────────────────────────────────┐
│                    DEBUGGING WORKFLOW                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   1. FREEZE                                                     │
│      → Stop all non-essential changes                           │
│      → Create a checkpoint if one doesn't exist                 │
│      → Transition to reasoning state                            │
│      → Run the 5 gates (docs/AGENT_REASONING.md)                │
│                                                                 │
│   2. REPRODUCE                                                  │
│      → Find or write a test/command that fails reliably         │
│      → No reproduction = no fix                                 │
│                                                                 │
│   3. OBSERVE                                                    │
│      → Read the full error message (top to bottom)              │
│      → Identify the exact file, line, and call stack            │
│      → Inspect actual runtime values                            │
│      → Resist the urge to guess                                 │
│                                                                 │
│   4. HYPOTHESIZE                                                │
│      → State ONE possible cause in one sentence                 │
│      → Use Gate 2 (5W5H) from docs/AGENT_REASONING.md           │
│      → Pick the simplest hypothesis first                       │
│                                                                 │
│   5. EXPERIMENT                                                 │
│      → Design a test that would falsify your hypothesis         │
│      → Change ONLY ONE variable at a time                       │
│      → Log the experiment in CONTEXT_LOG.md                     │
│      → If editing code, treat it as coding state                │
│                                                                 │
│   6. EVALUATE                                                   │
│      → Did the experiment confirm or refute the hypothesis?     │
│      → If refuted, return to step 4 with the next hypothesis    │
│      → If confirmed, proceed to step 7                          │
│      → If stuck after 3 hypotheses, escalate to human           │
│                                                                 │
│   7. FIX ROOT CAUSE                                             │
│      → Apply the minimal fix at the source                      │
│      → Do NOT paper over symptoms with workarounds              │
│      → Run the reproduction test to verify                      │
│                                                                 │
│   8. REGRESSION TEST                                            │
│      → Add the reproduction case to the test suite              │
│      → Run the full test suite, not just the one test           │
│      → Check for unintended side effects                        │
│                                                                 │
│   9. DOCUMENT                                                   │
│      → Log the bug and root cause in ERRORS.md                  │
│      → If the fix involved a surprise, add to MEMORY.md         │
│      → Update CONTEXT_LOG.md with the debugging session outcome │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## State Rules for Debugging

### Default State: `reasoning`

When you encounter an unexpected failure, your first action is:

```markdown
**State: reasoning**

I encountered an unexpected failure. Transitioning from coding → reasoning to run the debugging workflow.
```

In `reasoning` state you may:
- Read files and stack traces
- Run read-only diagnostic commands
- Write temporary test cases to reproduce the bug
- Form hypotheses and plan experiments

You may NOT:
- Edit production code to "see if it works"
- Make multiple changes at once
- Skip the reproduction step

### Temporary Transition to `coding` for Experiments

If an experiment requires editing code (e.g., adding a targeted log line or changing one variable), you must:

1. State the hypothesis explicitly
2. Log INTENT for the experiment
3. Transition to `coding`
4. Make the MINIMAL change
5. Run the reproduction case
6. Log OUTCOME immediately
7. Transition back to `reasoning` to evaluate

**Example:**

```markdown
Hypothesis: The failure occurs because `userId` is undefined when passed to `getUser()`.

Transitioning reasoning → coding for a controlled experiment.

INTENT: Add a single `console.log` in `getUser()` to inspect the actual value of `userId` at runtime.

[execute minimal change and run reproduction test]

OUTCOME: `userId` was indeed `undefined`. The call originated from `auth.ts:42`. Hypothesis confirmed. Transitioning back to reasoning.

**State: reasoning**
```

---

## Common Anti-Patterns (And Their Cures)

### Anti-Pattern 1: Hypothesis-First Without Data
**Symptom:** You read the first line of a stack trace and immediately start editing files based on a guess.

**Cure:** Follow the **OBSERVE** step completely. Read the entire stack trace. Find the exact line. Inspect actual values before hypothesizing.

### Anti-Pattern 2: Multiple Variables at Once
**Symptom:** You change the function signature, add a null check, and refactor a helper all in one edit. The test passes, but you don't know which change fixed it.

**Cure:** Each experiment changes **exactly one thing**. If you need to try three things, do three separate edits with verification between each.

### Anti-Pattern 3: Console.log Archaeology
**Symptom:** You sprinkle temporary prints throughout the codebase and run the program repeatedly, parsing output by eye.

**Cure:** Write a **targeted test case** that isolates the failing path. Use structured inspection (debugger, assertions, or exactly one log at the critical point) rather than scattering prints.

### Anti-Pattern 4: Fixing Without Reproducing
**Symptom:** A bug report describes a symptom. You immediately patch the most obvious location without confirming the failure.

**Cure:** **No reproduction = no fix.** If you cannot reproduce it, document why and ask the human for more information.

### Anti-Pattern 5: Symptom Patching
**Symptom:** After 2-3 failed hypotheses, you wrap the failing call in `try/catch` and return a default value. The immediate error disappears, but the underlying bug remains.

**Cure:** Use **Gate 2 (5W5H — Sequential Mode)** from `docs/AGENT_REASONING.md`. If you cannot find the root cause after 3 disciplined hypotheses, escalate rather than workaround.

### Anti-Pattern 6: Debugging While Coding
**Symptom:** You're in `coding` state implementing a feature, a test fails, and you start troubleshooting without transitioning to `reasoning`. Fifteen minutes later you've made a dozen unrelated edits and the CONTEXT_LOG shows a single bloated INTENT.

**Cure:** **Stop the line.** Any unexpected failure in `coding` state triggers an immediate transition to `reasoning` to run the debugging workflow.

---

## Escalation Criteria

Escalate to the human immediately if:
- You cannot reproduce the bug after 3 attempts
- You are stuck after 3 falsified hypotheses
- The same error has occurred 3+ times in this session
- The bug touches security, authentication, authorization, or data integrity
- The fix would require violating a documented interface or constraint
- The stack trace points to code you did not write and do not understand

---

## Mapping to the 5 Gates

| Debugging Step | Corresponding Gate | Why |
|----------------|-------------------|-----|
| **Freeze** | Gate 1 (Intent Check) | Do I understand what is broken? Restate the failure in one sentence. |
| **Reproduce + Observe** | Gate 2 (5W5H) | Classify: sequential (deep/systemic) or paired (independent issues)? |
| **Hypothesize** | Gate 3 (Complexity) | Score the fix, not just the symptom. Delegate if the root cause spans multiple modules. |
| **Experiment** | Gate 4 (Detail Awareness) | What hidden factors am I glossing over? What edge case could falsify this hypothesis? |
| **Fix + Document** | Gate 5 (Task State) | Update `STATE.md` and `ERRORS.md` before considering the bug closed. |

---

## Debugging Log Template

Append to `CONTEXT_LOG.md` for every debugging session:

```markdown
## Debugging Session: [Short Description]
**Started:** [YYYY-MM-DD HH:MM:SS]
**State:** reasoning

### Failure
- **Symptom:** [What went wrong]
- **Error Message:** [Full message or key excerpt]
- **Location:** [File:Line]

### Reproduction
- **Test/Command:** [How to reproduce]

### Hypotheses
1. [Hypothesis 1] → [Status: confirmed/refuted/pending]
2. [Hypothesis 2] → [Status: confirmed/refuted/pending]
3. [Hypothesis 3] → [Status: confirmed/refuted/pending]

### Root Cause
[One sentence explaining the actual cause]

### Fix
[What was changed and why]

### Verification
- [ ] Reproduction test passes
- [ ] Full test suite passes
- [ ] No unintended side effects observed
```

---

## Quick Reference Card

```
FAIL  → Freeze → reasoning state → checkpoint
READ  → Full error, full stack trace, actual values
THINK → One hypothesis, simplest first
TEST  → One variable changed, log INTENT/OUTCOME
FIX   → Root cause, not symptom
VERIFY→ Reproduction test + full suite + side effects
LOG   → ERRORS.md + MEMORY.md + CONTEXT_LOG.md
```
