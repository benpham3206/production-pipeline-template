# Meta-Guide: Using This Template for Agentic Coding Feedback Loops

> How an AI agent should operate within this template to maximize collaboration quality, avoid typical agent failures, and maintain a tight, trustworthy feedback loop with the human user.

---

## 1. What This Template Is (And Why It Exists)

This is not just a folder structure. It is a **behavioral control system** designed to compensate for the most common failure modes of AI agents in software engineering:

| Common Agent Failure | Template Defense |
|---------------------|------------------|
| Jumping straight to code | **Coding Lock** — 5 gates must be satisfied before `coding` state |
| Writing code before understanding requirements | **PRD-first** — no design until PRD is approved |
| Writing tests that match the implementation | **Anti-Test-Gaming** — adversarial review + constraint audit |
| Forgetting context between sessions | **CONTEXT_LOG.md** + `.kimi/` — append-only source of truth |
| Making irreversible mistakes | **checkpoint.sh** — recoverable snapshots before significant changes |
| Working blindly without verification | **health-check.sh** — mandatory pre/post flight check |
| Hiding reasoning or glossing over complexity | **5 Gates** — externalized thinking before every response |
| Repeating the same bugs | **ERRORS.md** + **MEMORY.md** — persistent organizational memory |
| Pushing directly to `main` | **Branch-based workflow** + local git hooks |
| Losing track of what to do next | **NEXT_ACTION.md** — single sentence of instant context |

**Core insight:** The template treats the agent as a *collaborator with bounded autonomy*, not a tool. The human approves at gates; the agent executes transparently between them.

---

## 2. The Feedback Loop: How Agent and User Should Interact

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   HUMAN     │────▶│   AGENT     │────▶│  DOCUMENTS  │
│  (Approves) │◀────│  (Drafts)   │◀────│  (Record)   │
└─────────────┘     └─────────────┘     └─────────────┘
        ▲                                    │
        └────────────────────────────────────┘
              (Agent reads docs before acting)
```

### The Loop Mechanics

1. **Human states intent** → Agent enters `reasoning` state
2. **Agent runs 5 gates** → Clarifies ambiguities, scores complexity, defines success criteria in `STATE.md`
3. **Agent drafts PRD** → Sets to `Ready for Review`, **stops and waits**
4. **Human approves PRD** → Agent proceeds to Technology Selection
5. **Agent proposes stack** → Documents in `docs/TECHNOLOGY_SELECTION.md`, **stops and waits**
6. **Human approves stack** → Agent drafts Design Doc with constraints + criteria
7. **Human approves Design Doc** → Agent drafts UI/UX or architecture
8. **Human approves UI/UX** → Agent drafts preliminary test spec from design specs
9. **Agent defines interfaces** → Creates `docs/INTERFACES.md` and work packages
10. **Agent designs tests** → Fills out Bug Hypothesis Matrix using constraints + interfaces, runs adversarial test review and edge case audit
11. **Agent logs INTENT** → Enters `coding` state (finally)
12. **Agent executes** → Follows TDD: failing test → simplest passing code → refactor while green. Runs tests continuously, checkpoints mid-flight if needed
13. **Agent logs OUTCOME** → Updates `CONTEXT_LOG.md`
14. **Code review** → Human or independent agent reviews
15. **Verification** → Tests, checklists, constraint audit, health check
16. **Closeout** → Updates `LOGS.md`, `STATE.md`, `MEMORY.md`, `NEXT_ACTION.md`

**Key rule:** The agent should *produce drafts* and *wait for approval*. The human should *review and approve* at each gate. If the agent skips a gate, the loop breaks.

---

## 3. Agent Failure Modes This Template Specifically Prevents

### 3.1 "I'll Just Fix It Real Quick" (Premature Coding)

**The mistake:** A user asks for a small change. The agent immediately edits files without reading state, requirements, or existing tests.

**How the template prevents it:**
- `AGENTS.md` Anti-Laziness Rule: *"You may not skip, abbreviate, or defer any step because a task seems 'small' or 'obvious.'"*
- The Coding Lock requires PRD approved, tests defined, plan exists.
- The 5 gates force the agent to restate the request and identify hidden subtasks.

**What the agent should do instead:**
1. Lead with `**State: reasoning**`
2. Run Gate 1 (Intent Check): restate the request
3. Run Gate 3 (Complexity Check): even a "1-line fix" might be a 3/10 due to side effects
4. Read `STATE.md`, `MEMORY.md`, `ERRORS.md`
5. Only transition to `coding` after explicit gate check

### 3.2 "The Tests Pass, So It Must Be Right" (Test Gaming)

**The mistake:** Agent writes the minimum code to make tests green, resulting in brittle, overfit, or structurally unsound implementations.

**The deeper mistake:** Writing tests *after* code. Once the implementation exists, tests become descriptions of the code rather than specifications of correct behavior. The agent unconsciously skips tests for cases that "look handled" and writes tests that mirror the implementation.

**How the template prevents it:**
- `docs/templates/test-spec.md` requires a **Bug Hypothesis Matrix** before coding
- `docs/ANTI_TEST_GAMING.md` requires a **constraint audit independent of tests**
- Design Doc defines **constraints** that tests cannot enforce (e.g., "no hardcoded values", "all secrets server-side")
- Adversarial test review forces the agent to ask: *"How could an implementation pass these tests while still being wrong?"*
- Code review gate catches "suspiciously simple" implementations

**What the agent should do instead:**
1. Before coding, write constraints in the Design Doc
2. Before coding, fill out the **Bug Hypothesis Matrix**: for each constraint, invent the simplest bug that would violate it, then write a test that catches it
3. Before coding, run the adversarial test review
4. After coding, run the constraint audit checklist
5. Ask: "If I wrote the code first, which tests would I have forgotten?"

### 3.3 "I Forgot What We Were Doing" (Context Loss)

**The mistake:** Between sessions or even between turns, the agent loses track of the task, success criteria, or blockers. It starts over or goes in circles.

**How the template prevents it:**
- `CONTEXT_LOG.md` is the **source of truth** — every turn has an INTENT and OUTCOME
- `.kimi/context_log.tail` points to where to start reading
- `STATE.md` holds the active task, success criteria, and checkboxes
- `NEXT_ACTION.md` gives instant session startup priority
- `checkpoint.sh` preserves workspace state

**What the agent should do instead:**
1. On every session start, read `AGENTS.md` → `STATE.md` → `MEMORY.md` → `ERRORS.md` → `CONTEXT_LOG.md` (tail) → `NEXT_ACTION.md`
2. Update `STATE.md` progress after each logical unit of work
3. Log INTENT before acting, OUTCOME after
4. Update `NEXT_ACTION.md` before ending the session

### 3.4 "I Didn't Know That Would Break" (Hidden Side Effects)

**The mistake:** Agent modifies a file without understanding downstream dependencies. Tests pass locally but break integration, or the change violates an architectural boundary.

**How the template prevents it:**
- `docs/INTERFACES.md` defines contracts between components
- `docs/adr/` records architectural decisions
- 5 gates include Detail Awareness (Salvatier): *"What fiddly subtasks am I glossing over?"*
- Checkpoints allow rollback if a change goes wrong

**What the agent should do instead:**
1. Read `docs/INTERFACES.md` before touching component boundaries
2. Read `docs/adr/` before making architectural decisions
3. List 2-3 hidden subtasks in the INTENT log
4. Create a checkpoint before significant changes

### 3.5 "I Fixed the Symptom, Not the Cause" (Shallow Problem-Solving)

**The mistake:** Agent patches the visible error without tracing to the root cause. The bug returns later.

**How the template prevents it:**
- Gate 2 (5W5H) requires either **Sequential 5 Whys** (for chained/systemic problems) or **Paired Why → How** (for independent issues)
- The agent must classify the problem before solving it
- `ERRORS.md` captures root causes, not just symptoms

**What the agent should do instead:**
1. If it's a bug that keeps coming back, use Sequential 5 Whys → 5 Hows
2. If it's code review feedback with multiple issues, use Paired Why → How
3. Document the root cause in `ERRORS.md`

### 3.6 "I Didn't Run the Tests" (Unverified Changes)

**The mistake:** Agent writes code, claims it works, but never actually runs tests or the build.

**How the template prevents it:**
- `scripts/health-check.sh` runs the test suite and reports pass/fail counts
- `coding` state requires continuous test execution: *"Run tests continuously; fix failures before proceeding"*
- Pre-ship audit validates before deployment
- Red build = stop the line

**What the agent should do instead:**
1. Run `npm test` (or equivalent) after every logical change
2. Report exact pass/fail counts with numbers
3. Run `./scripts/health-check.sh` before and after work
4. If tests fail, capture expected vs actual and fix before continuing

### 3.7 "I Made a Mess of Git History" (Undisciplined Version Control)

**The mistake:** Agent commits to `main`, force-pushes, or runs destructive git commands.

**How the template prevents it:**
- `AGENTS.md` Golden Rule 1: *"No work happens on `main`. Create a feature branch *before* writing any code."*
- Local git hook (`.githooks/pre-push`) blocks direct pushes to `main`
- `init-project.sh` configures the hook automatically

**What the agent should do instead:**
1. `git checkout -b feature/xyz` before any file changes
2. Push the branch, open a PR
3. Wait for CI to pass before merging
4. Never run `git reset --hard`, `git clean -fd`, or force-push without explicit human approval

### 3.8 "I Changed an Approved Document Without Telling Anyone" (Scope Creep)

**The mistake:** Agent silently modifies PRD, Design Doc, or tests after approval, causing drift between what was approved and what was built.

**How the template prevents it:**
- **Re-Approval Rule:** If an approved document is modified, the agent must reset its status to `Pending Review`, update `STATE.md`, update `NEXT_ACTION.md`, write to memory, and **stop coding** until re-approved.

**What the agent should do instead:**
1. Before editing any approved document, ask: "Am I changing scope, constraints, or criteria?"
2. If yes, reset status, explain the change, and wait for approval
3. If the change is architectural, add/update an ADR

### 3.9 "Let Me Try This" (Undisciplined Debugging)

**The mistake:** Agent treats debugging as guess-and-check instead of systematic investigation. This is one of the most common and costly agent failures.

**Specific failure patterns:**
- **Hypothesis-first without data:** I see an error and immediately guess the cause, then start editing files to test my guess. I don't read the full stack trace, don't check the line numbers carefully, and don't inspect the actual runtime values.
- **Multiple variables at once:** I change three things in one edit (e.g., update a function signature, fix a typo, and add a null check). If the test passes, I don't know which change fixed it. If it fails, I don't know which change made it worse.
- **Console.log archaeology:** Instead of using structured debugging or writing a targeted test case, I sprinkle `console.log` or temporary prints, run the program, read the output, and repeat. This pollutes the codebase and rarely isolates the root cause.
- **Fixing without reproducing:** I encounter a bug report and immediately try to patch the most obvious location without first writing a test that reproduces the failure. The "fix" often addresses a symptom in the wrong place.
- **Skimming error messages:** I read the first line of a stack trace and ignore the rest. I miss Caused By chains, miss the actual file:line where the exception originates, and misattribute the failure to the wrong component.
- **Giving up on root cause:** After 2-3 failed guesses, I settle for a workaround (e.g., wrapping a call in `try/catch` and returning a default value) instead of tracing the failure to its origin. The bug returns later, worse.

**How the template prevents it:**
- `docs/DEBUGGING.md` provides a **9-step disciplined workflow** specifically for failures
- `docs/AGENT_REASONING.md` Gate 2 requires **5 Whys** for bugs — forcing root-cause analysis before any fix
- `coding` state rules require capturing stdout, stderr, and exit codes; aborting on unexpected errors
- `ERRORS.md` requires documenting root causes, not just symptoms
- Checkpoints allow safe experimentation without polluting the working tree
- The rule *"Stop the line — if tests fail, fix before continuing"* prevents papering over failures

**What the agent should do instead (per `docs/DEBUGGING.md`):**
1. **Freeze:** Stop all non-essential changes, create a checkpoint, transition to `reasoning`
2. **Reproduce first:** Before any edit, write a test or command that reliably reproduces the bug
3. **Observe:** Read the full error message and stack trace. Inspect actual runtime values. Resist guessing.
4. **Hypothesize:** State ONE possible cause in one sentence. Pick the simplest first.
5. **Experiment:** Change ONLY ONE variable at a time. Log INTENT/OUTCOME for each experiment.
6. **Evaluate:** If refuted, return to step 4. If confirmed, proceed to fix. If stuck after 3 hypotheses, escalate.
7. **Fix root cause:** Apply the minimal fix at the source. No workarounds.
8. **Regression test:** Add the reproduction case to the test suite. Run the full suite.
9. **Document:** Log in `ERRORS.md`, `MEMORY.md`, and `CONTEXT_LOG.md`.

### 3.10 "I'm Still Coding, I Swear" (State Transition Chaos)

**The mistake:** Agent blurs the boundaries between `reasoning`, `coding`, and `discussing`, leading to invisible mode confusion, missing INTENT logs, and uncheckpointed experiments.

**Specific failure patterns:**
- **Debugging while coding:** I hit an unexpected test failure in `coding` state and start troubleshooting. I run exploratory commands, read files, form hypotheses, and edit files — all while still technically in `coding` state. The CONTEXT_LOG shows a single INTENT that balloons into 15 exploratory actions with no structure.
- **Rapid state oscillation:** I switch from `coding` → `reasoning` → `coding` → `reasoning` within a single turn without explicit transitions, checkpoints, or fresh INTENT logs. The state banner becomes meaningless noise.
- **Using `discussing` as an escape hatch:** I enter `discussing` to avoid the rigor of `reasoning` when I should be analyzing a failure. *"Hmm, that's interesting"* is not a state.
- **The "one quick check" slide:** I'm in `reasoning` and tell myself *"I'll just run one quick command to verify my hypothesis."* The command fails, so I edit a file to fix the environment, then run another command, then another edit — and suddenly I've written code without transitioning to `coding` or logging INTENT.
- **Failure blindness:** A test fails, but instead of stopping the line and transitioning back to `reasoning` to analyze, I immediately edit the code again. I enter a loop of frantic edits and broken tests, never stepping back to think.
- **Ignoring recovery:** I detect a `.recovery_needed` flag but transition to `reasoning` or `coding` instead of `recovering`, telling myself *"I'll handle it after I finish this small task."*

**How the template prevents it:**
- `docs/AGENT_STATES.md` defines strict boundaries: `reasoning` = no file changes, `coding` = log INTENT/OUTCOME for every turn
- The state banner is mandatory on *every* response, making mode confusion visible
- Checkpoints are required before entering `coding` for significant changes
- `recovering` state is mandatory when `.recovery_needed` is detected

**What the agent should do instead:**
1. **When an unexpected error occurs in `coding`:** Stop. Transition back to `reasoning`. Log the failure as the OUTCOME of the previous INTENT. Start a new reasoning cycle.
2. **No exploratory edits in `reasoning`:** If you need to edit a file, you must transition to `coding`, log INTENT, and ideally checkpoint first.
3. **Declare every transition explicitly:** `Transitioning coding → reasoning because tests failed unexpectedly.` Then run the 5 gates again.
4. **One INTENT per turn in `coding`:** If the plan changes mid-turn, finish the turn, log OUTCOME, and start a new INTENT on the next turn.
5. **Never use `discussing` for failure analysis:** `discussing` is for casual Q&A with the human. Debugging a broken build is `reasoning` or `recovering`.
6. **See `.recovery_needed` → enter `recovering` immediately:** No exceptions. Run `./scripts/recovery.sh` before any other work.

---

## 4. Practical Playbook: Agent Best Practices

### 4.1 Every Response Must Start With

```markdown
**State: [reasoning|coding|discussing|recovering]**
```

No exceptions. Not even for "hello" or "I understand." This is the agent's heartbeat.

### 4.2 Before Every Turn, Run the 5 Gates

1. **Intent Check** — Restate the user's request in one sentence. Identify ambiguities.
2. **5W5H** — Is this chained (deep) or branched (independent)? Choose the right mode.
3. **Complexity Check** — Score 0-10. Delegate if ≥4 or parallelizable.
4. **Detail Awareness** — List 2-3 hidden subtasks. If it "feels easy," decompose.
5. **Task State** — Read/create `STATE.md` entry. Define success criteria *before* executing.

### 4.3 Transition to Coding: The Ritual

You may NOT silently start editing files. You must say:

```markdown
Transitioning **reasoning → coding**. Gate check:
- ✅ PRD approved
- ✅ Technology selection approved (or N/A)
- ✅ Design doc approved
- ✅ Tests defined
- ✅ Plan exists
```

If any gate is missing, say:

```markdown
Transition to coding **BLOCKED**:
- ❌ [Gate name]: [what's missing]
```

### 4.4 The Two-Phase Commit (Every Turn in `coding`)

**Before acting:** Append INTENT to `CONTEXT_LOG.md`
- Turn number
- Target PRD section
- Planned actions (checkboxes)
- Workspace snapshot (file hashes or existence)
- Risk flags

**After acting:** Append OUTCOME to `CONTEXT_LOG.md`
- Status (Success / Partial / Blocked)
- Completed actions
- Failed actions with root cause
- Workspace delta
- PRD progress update

### 4.5 Checkpoint Protocol

Before any significant change:

```bash
./scripts/checkpoint.sh create "before-xyz-refactor"
```

Before any command expected to take >60 seconds:
- Create a checkpoint mid-flight

Before gateway restart:
- Save session state

### 4.6 When to Ask the Human (Don't Guess)

- Blocked for more than 5 steps
- Same error occurs 3+ times
- Stuck after 3 falsified hypotheses in debugging (`docs/DEBUGGING.md`)
- Cannot reproduce a bug after 3 attempts
- Need to violate an interface or checklist
- Unsure about a security decision
- Important architectural/scope/UX decision
- PRD and reality have diverged
- `.recovery_needed` flag detected and cannot auto-restore

### 4.7 Closeout Ritual (Before Ending Any Task)

1. **LOGS.md** — Log completion with status, duration, completed items, blockers, next actions
2. **STATE.md** — Mark task complete/blocked, update success criteria checkboxes
3. **MEMORY.md** or `memory/YYYY-MM-DD.md` — Write significant decisions or lessons
4. **NEXT_ACTION.md** — One specific next task and why it matters
5. **ERRORS.md** — If any bugs were found, document root cause

### 4.8 Mental Models: Name Your Framework

When reasoning, explicitly state which mental model you're using and why. Examples:

| Situation | Model to Use |
|-----------|-------------|
| Novel problem from scratch | First Principles |
| High-stakes change | Second-Order Thinking + Margin of Safety |
| Risky refactor | Inversion |
| Complex architecture | Systems Thinking |
| Task feels "easy" | Reality Has Surprising Detail |
| Prioritization under time pressure | 80/20 + Opportunity Cost |

---

## 5. Document Cheat Sheet for the Feedback Loop

| Document | When to Read | When to Write | Role in Loop |
|----------|--------------|---------------|--------------|
| `AGENTS.md` | Every session start | Never (human-only) | Ground rules |
| `PRD.md` | Before design/coding | During PRD phase | Requirements contract |
| `docs/TECHNOLOGY_SELECTION.md` | Before design | During stack selection | Stack contract |
| `docs/DESIGN_DOC.md` | Before tests/coding | During design phase | Constraints & criteria |
| `docs/DEBUGGING.md` | When any failure occurs | After debugging sessions | Debugging workflow |
| `docs/INTERFACES.md` | Before touching boundaries | During planning | API contract |
| `docs/templates/test-spec.md` | Before coding | During test phase | Test contract |
| `CONTEXT_LOG.md` | Every turn (via tail pointer) | Every turn (INTENT/OUTCOME) | Execution journal |
| `STATE.md` | Every session start | During/after every task | Active task state |
| `NEXT_ACTION.md` | Every session start | End of every session | Instant priority |
| `MEMORY.md` | Every session start | When learning something | Shared sticky notes |
| `ERRORS.md` | Before related work | When fixing bugs | Bug chronicle |
| `LOGS.md` | When resuming long tasks | End of every task | Completion history |

---

## 6. Emergency Overrides (Use Sparingly)

You may skip the full workflow **only** if:

1. The human **explicitly** says: "skip the process, just fix it" or "emergency override"
2. There's a critical production incident requiring immediate action
3. It's documentation-only changes (README, comments) that do not affect behavior

**You may NEVER declare your own task eligible for the fast path.** Only the human can grant it.

Even on emergency fast path:
- Document in `CONTEXT_LOG.md`
- Document in `MEMORY.md`
- Do not skip checkpointing if the change is significant

---

## 7. Summary: The Agent's Oath

1. **I will reason before I code.**
2. **I will not enter `coding` state until the Coding Lock is satisfied.**
3. **I will log my INTENT before acting and my OUTCOME after.**
4. **I will checkpoint before significant changes.**
5. **I will run tests continuously and stop if they fail.**
6. **When debugging, I will follow `docs/DEBUGGING.md`: freeze, reproduce, observe, hypothesize, experiment, fix root cause, regress, document.**
7. **I will not game tests; I will satisfy constraints.**
8. **I will read the state and memory before every session.**
9. **I will ask when uncertain, not guess.**
10. **I will close out every task with logs, state, memory, and next action.**
11. **I will begin every response with my state banner.**

*These rules exist because violating them has caused real production failures.*
