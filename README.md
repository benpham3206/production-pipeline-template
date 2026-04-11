# Production Pipeline Template

> A stack-agnostic, production-ready project scaffold designed for human + AI agent collaboration.

---

## What This Is

This template provides:

1. **A production-grade folder structure** for any software product
2. **An embedded governance model** — the process of how to build things correctly
3. **Security & functionality checklists** derived from real-world production requirements
4. **Agentic collaboration workflows** — how humans and AI agents work together safely
5. **Anti-test-gaming safeguards** — ensuring code is accurate, not just test-passing

---

## Quick Start

```bash
# 1. Initialize the project (creates .kimi/ tail pointer, validates structure)
./scripts/init-project.sh

# 2. Fill out PRD.md before writing any code
# 3. Fill out docs/TECHNOLOGY_SELECTION.md and get it approved
# 4. Review docs/PROCESS.md to understand the full workflow
# 5. Run health checks continuously
./scripts/health-check.sh

# 6. Run pre-ship audit before deploying
./scripts/pre-ship-audit.sh
```

You can also use npm aliases:
```bash
npm run health-check
npm run pre-ship-audit
npm run checkpoint
npm run recover
```

---

## Git Workflow: No Direct Push to `main`

Because this repo does not use GitHub's branch protection rules (common on free private accounts), we enforce safety through **process and local git hooks** instead.

### The Rule
**Never push directly to `main`.** Always create a branch, open a Pull Request, wait for the green checkmark (CI tests passing), and only then merge.

### Step-by-Step
```bash
# 1. Make sure you're on main and it's up to date
git checkout main
git pull origin main

# 2. Create a new branch for your change
git checkout -b your-branch-name

# 3. Make changes, commit them
git add .
git commit -m "Describe your change"

# 4. Push the branch (not main!)
git push origin your-branch-name

# 5. Go to GitHub and open a Pull Request
# 6. Wait for "CI / Test & Build" to pass ✅
# 7. Merge only after tests pass and code review is complete
```

### Local Safety Net
`init-project.sh` installs a git pre-push hook that **blocks direct pushes to `main`**. If you accidentally try, you'll see:
```
❌ Direct push to main is not allowed.
   Create a branch and open a Pull Request instead.
```

---

## Core Principles

| Principle | Meaning |
|-----------|---------|
| **State Banner First** | Every agent response begins with `**State: [reasoning\|coding\|discussing\|recovering]**` |
| **PRD First** | No code until requirements are documented and approved |
| **Technology Selection Before Design** | Stack and architecture must be approved before design doc |
| **Design Doc Before Code** | Constraints and criteria prevent test-gaming |
| **UI/UX Drives Tests** | You cannot write exhaustive tests without knowing the exact design |
| **Log is Truth** | `CONTEXT_LOG.md` is the source of truth; PRD is derived from it |
| **Audit First** | Run `health-check.sh` before any planning or implementation |
| **Checklist-Driven** | Security and functionality gates must pass before shipping |
| **Agent-Native** | Documents and processes are readable by both humans and AI agents |

---

## Folder Structure

```
.
├── AGENTS.md                     # AI agent onboarding & ground rules
├── PRD.md                        # Product Requirements Document
├── NEXT_ACTION.md                # The one thing to do next
├── CONTEXT_LOG.md                # Append-only execution journal
├── STATE.md                      # Current task state & success criteria
├── LOGS.md                       # Chronological completion log
├── MEMORY.md                     # Project memory: decisions, mistakes, wins
├── ERRORS.md                     # Error log and patterns to remember
├── SECURITY.md                   # Security policy
├── INDEX.md                      # Catalog of all documents
├── README.md                     # This file — human onboarding
├── docs/
│   ├── PROCESS.md                # The agentic/human collaboration workflow
│   ├── AGENT_REASONING.md        # 5-gate reasoning protocol
│   ├── AGENT_STATES.md           # Agent state machine (4 states)
│   ├── MENTAL_MODELS.md          # Mental models quick reference
│   ├── UI_UX.md                  # UI/UX design phase
│   ├── DESIGN_DOC.md             # Design document philosophy
│   ├── ANTI_TEST_GAMING.md       # Safeguards against test-gaming
│   ├── TESTING.md                # Testing philosophy
│   ├── INTERFACES.md             # Interface contracts
│   ├── TECHNOLOGY_SELECTION.md   # Stack and architecture approval
│   ├── adr/                      # Architecture Decision Records
│   │   └── 000-template.md
│   ├── checklists/
│   │   ├── SECURITY.md           # Security checklist
│   │   ├── FUNCTIONALITY.md      # Functionality checklist
│   │   ├── PRE_SHIP.md           # Final go-live checklist
│   │   ├── ACCESSIBILITY.md      # WCAG 2.1 AA
│   │   ├── PERFORMANCE.md        # Performance checklist
│   │   ├── OBSERVABILITY.md      # Observability checklist
│   │   ├── RELIABILITY.md        # Reliability checklist
│   │   ├── OPERATIONS.md         # Operations checklist
│   │   ├── COMPLIANCE.md         # Compliance checklist
│   │   └── COST_MANAGEMENT.md    # Cost management checklist
│   └── templates/
│       ├── work-package.md
│       ├── intervention.md
│       ├── post-mortem.md
│       ├── ui-spec.md
│       ├── test-spec.md
│       ├── design-doc.md
│       ├── code-review.md
│       └── bug-report.md
├── scripts/
│   ├── init-project.sh           # Project initialization
│   ├── health-check.sh           # Pre-work audit script
│   ├── checkpoint.sh             # Create recoverable checkpoints
│   ├── recovery.sh               # Post-crash state restoration
│   └── pre-ship-audit.sh         # Final shipping validation
├── src/                          # Your actual code lives here
│   ├── index.ts
│   ├── utils/
│   ├── tests/
│   └── ...
├── memory/                       # Dated decision records
│   └── YYYY-MM-DD.md
└── .kimi/                        # Agent context & checkpoint metadata
    ├── context_log.tail
    └── checkpoints/
```

---

## The Workflow (Human + Agent)

See [`docs/PROCESS.md`](docs/PROCESS.md) for the full workflow. At a high level:

```
0. Think         → Agent drafts PRD, sets to "Ready for Review"
1. Approve       → Human approves PRD → "Approved"
2. Select Stack  → Document technology selection, get human approval
3. Design Doc    → Constraints, criteria, adversarial review
4. Approve       → Human approves design doc
5. UI/UX or Arch → Design flows, screens, copy, or system architecture
6. Approve       → Human approves UI/UX or architecture
7. Define Tests  → Tests derived from design specs
8. Plan          → Define interfaces, create work packages
9. Log           → Record INTENT before every execution step
10. Execute      → Write code to make tests pass
11. Code Review  → Review by human or independent agent before verification
12. Derive       → Update PRD status from the log
13. Verify       → Run tests, constraint audit, anti-gaming review, health checks
14. Ship         → Pre-ship audit passes → Deploy
15. Closeout     → Update MEMORY.md, ERRORS.md, CONTEXT_LOG.md, LOGS.md
```

**Key gates:**
- No technology selection until PRD is approved
- No design doc until technology selection is approved
- No UI/UX or architecture until design doc is approved
- No test definition until UI/UX/architecture is approved
- No code until tests are defined and design doc is approved
- No verification until code review is approved

---

## Agent States

Every agent response must begin with a state banner:

```markdown
**State: reasoning**
```

| State | When Used |
|-------|-----------|
| `reasoning` | Planning, reading, drafting docs, running read-only commands |
| `coding` | Writing files, running tests, builds, deployments |
| `discussing` | Casual Q&A, no files touched |
| `recovering` | Restoring state after a crash |

The agent may only enter `coding` state after passing the **Coding Lock**:
- ✅ PRD approved
- ✅ Technology selection approved (or N/A)
- ✅ Design doc approved
- ✅ Tests defined
- ✅ Plan exists

See `docs/AGENT_STATES.md` and `docs/PROCESS.md` for full details.

---

## Checklists

Before any code ships, verify the relevant checklists:

### Always Required
- [`docs/checklists/SECURITY.md`](docs/checklists/SECURITY.md) — Authentication, secrets, rate limits, RLS, backups, etc.
- [`docs/checklists/FUNCTIONALITY.md`](docs/checklists/FUNCTIONALITY.md) — Health endpoints, monitoring, CI/CD, migrations, etc.
- [`docs/checklists/PRE_SHIP.md`](docs/checklists/PRE_SHIP.md) — Final go-live gates

### Domain-Specific
- [`docs/checklists/ACCESSIBILITY.md`](docs/checklists/ACCESSIBILITY.md) — WCAG 2.1 AA (web/mobile)
- [`docs/checklists/PERFORMANCE.md`](docs/checklists/PERFORMANCE.md) — Load testing and optimization
- [`docs/checklists/OBSERVABILITY.md`](docs/checklists/OBSERVABILITY.md) — Logging, metrics, alerting, tracing
- [`docs/checklists/RELIABILITY.md`](docs/checklists/RELIABILITY.md) — Graceful degradation, retries, backups
- [`docs/checklists/OPERATIONS.md`](docs/checklists/OPERATIONS.md) — Deployment, incident response, maintenance
- [`docs/checklists/COMPLIANCE.md`](docs/checklists/COMPLIANCE.md) — GDPR, CCPA, SOC 2, HIPAA, PCI-DSS
- [`docs/checklists/COST_MANAGEMENT.md`](docs/checklists/COST_MANAGEMENT.md) — Budgets, caps, right-sizing

---

## For Humans

- Start with `PRD.md`. Fill it out completely.
- Review `docs/TECHNOLOGY_SELECTION.md` and approve the stack before design.
- Review `docs/PROCESS.md` to understand how agents will interact with this project.
- Use `scripts/health-check.sh` before and after every work session.
- Update `MEMORY.md` when you learn something important.

## For AI Agents

- Read `AGENTS.md` first. It contains your operating rules.
- Begin **every** response with the state banner.
- Run the 5 gates in `docs/AGENT_REASONING.md` before every response.
- Never write code before the Coding Lock gates are satisfied.
- Log INTENT → Execute → Log OUTCOME in `CONTEXT_LOG.md` for every turn.
- After coding, run the constraint audit in `docs/ANTI_TEST_GAMING.md`.

---

## Project Status

- [x] Project initialized (`./scripts/init-project.sh` passes)
- [x] PRD.md template complete
- [x] Technology Selection phase integrated
- [x] Full agentic workflow documented (`docs/PROCESS.md`)
- [x] 4-state agent model with Coding Lock enforced
- [x] UI/UX, Test Definition, and Design Doc phases integrated
- [x] Anti-test-gaming safeguards in place
- [x] All automation scripts tested on macOS and Linux
- [x] Reference implementation with passing test suite
- [x] All checklists passing

**Current health:** `28/28` checks passing  
**Current tests:** `13/13` passing (2 suites)

---

## Credits

This template synthesizes:
- **PRD-first development** — requirements before code
- **Technology selection gates** — architecture before design
- **Rigorous context preservation** — two-phase commit logging
- **Multi-agent orchestration** — checkpoints, interfaces, and intervention
- **Production security best practices** — 30 security rules and pre-ship gates
- **Behavior-driven design** — UI/UX drives tests, tests drive code
- **Anti-test-gaming engineering** — constraints, criteria, and adversarial review
