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
# 3. Review docs/PROCESS.md to understand the full workflow
# 4. Run health checks continuously
./scripts/health-check.sh

# 5. Run pre-ship audit before deploying
./scripts/pre-ship-audit.sh
```

---

## Core Principles

| Principle | Meaning |
|-----------|---------|
| **PRD First** | No code until requirements are documented and approved |
| **UI/UX Drives Tests** | You cannot write exhaustive tests without knowing the exact design |
| **Design Doc Before Code** | Constraints and criteria prevent test-gaming |
| **Log is Truth** | `CONTEXT_LOG.md` is the source of truth; PRD is derived from it |
| **Audit First** | Run `health-check.sh` before any planning or implementation |
| **Checklist-Driven** | Security and functionality gates must pass before shipping |
| **Agent-Native** | Documents and processes are readable by both humans and AI agents |

---

## Folder Structure

```
.
├── AGENTS.md                # AI agent onboarding & ground rules
├── PRD.md                   # Product Requirements Document (template)
├── CONTEXT_LOG.md           # Append-only execution journal (source of truth)
├── STATE.md                 # Current task state & success criteria
├── LOGS.md                  # Chronological completion log
├── MEMORY.md                # Project memory: decisions, mistakes, wins
├── ERRORS.md                # Error log and patterns to remember
├── INDEX.md                 # Catalog of all markdown documents
├── README.md                # This file — human onboarding
├── docs/
│   ├── PROCESS.md           # The agentic/human collaboration workflow
│   ├── AGENT_REASONING.md   # 5-gate reasoning protocol for AI agents
│   ├── AGENT_STATES.md      # Agent state machine and transitions
│   ├── MENTAL_MODELS.md     # Mental models quick reference
│   ├── UI_UX.md             # UI/UX design phase and feedback loops
│   ├── DESIGN_DOC.md        # Design document philosophy and constraints
│   ├── ANTI_TEST_GAMING.md  # Safeguards against test-gaming code
│   ├── TESTING.md           # Atomic and exhaustive testing philosophy
│   ├── INTERFACES.md        # Interface contracts between components
│   ├── adr/                 # Architecture Decision Records
│   │   └── 000-template.md
│   ├── checklists/
│   │   ├── SECURITY.md      # 30 security rules + AI security review
│   │   ├── FUNCTIONALITY.md # Production readiness checklist
│   │   └── PRE_SHIP.md      # Final go-live checklist
│   └── templates/
│       ├── work-package.md
│       ├── intervention.md
│       ├── post-mortem.md
│       ├── ui-spec.md       # UI specification template
│       ├── test-spec.md     # Test definition template
│       ├── design-doc.md    # Design document template
│       └── bug-report.md    # Bug report with edge case tracking
├── scripts/
│   ├── init-project.sh      # One-time project initialization
│   ├── health-check.sh      # Pre-work audit script
│   ├── checkpoint.sh        # Create recoverable checkpoints
│   ├── recovery.sh          # Post-crash state restoration
│   └── pre-ship-audit.sh    # Final shipping validation
├── src/                     # Your actual code lives here
│   ├── index.ts             # Entry point (adapt to your stack)
│   ├── utils/
│   ├── tests/
│   └── ...
├── memory/                  # Dated decision records
│   └── YYYY-MM-DD.md
└── .kimi/                   # Agent context & checkpoint metadata
    ├── context_log.tail
    └── checkpoints/
```

---

## The Workflow (Human + Agent)

See [`docs/PROCESS.md`](docs/PROCESS.md) for the full workflow. At a high level:

```
1. Think      → Write/approve the PRD
2. Design     → UI/UX specs with exact copy and all states
3. Define     → Tests derived from UI/UX specs
4. Document   → Design Doc with constraints, criteria, and adversarial review
5. Plan       → Define interfaces, create work packages
6. Log         → Record INTENT before every execution step
7. Execute     → Write code to make tests pass
8. Code Review → Review by human or independent agent before verification
9. Verify      → Run tests, constraint audit, anti-gaming review, health checks
10. Ship       → Pre-ship audit passes → Deploy
11. Document   → Update MEMORY.md, ERRORS.md, CONTEXT_LOG.md, LOGS.md
```

**Key gates:**
- No UI/UX until PRD is approved
- No test definition until UI/UX is approved
- No design document until tests are defined
- No code until design document is approved
- No verification until code review is approved

---

## Checklists

Before any code ships, these must be complete:

- [`docs/checklists/SECURITY.md`](docs/checklists/SECURITY.md) — Authentication, secrets, rate limits, RLS, backups, etc.
- [`docs/checklists/FUNCTIONALITY.md`](docs/checklists/FUNCTIONALITY.md) — Health endpoints, monitoring, CI/CD, migrations, etc.
- [`docs/checklists/PRE_SHIP.md`](docs/checklists/PRE_SHIP.md) — Final go-live gates

---

## For Humans

- Start with `PRD.md`. Fill it out completely.
- Review `docs/UI_UX.md` before designing any user-facing feature.
- Review `docs/PROCESS.md` to understand how agents will interact with this project.
- Use `scripts/health-check.sh` before and after every work session.
- Update `MEMORY.md` when you learn something important.

## For AI Agents

- Read `AGENTS.md` first. It contains your operating rules.
- Read `MEMORY.md` and `ERRORS.md` before starting any work.
- Run the 5 gates in `docs/AGENT_REASONING.md` before every response.
- Never write code before the Design Document is approved.
- Log INTENT → Execute → Log OUTCOME in `CONTEXT_LOG.md` for every turn.
- After coding, run the constraint audit in `docs/ANTI_TEST_GAMING.md`.

---

## Project Status

- [x] Project initialized (`./scripts/init-project.sh` passes)
- [x] PRD.md template complete
- [x] Full agentic workflow documented (`docs/PROCESS.md`)
- [x] UI/UX, Test Definition, and Design Doc phases integrated
- [x] Anti-test-gaming safeguards in place
- [x] All automation scripts tested on macOS and Linux
- [x] Reference implementation with passing test suite
- [x] All checklists passing

**Current health:** `25/25` checks passing  
**Current tests:** `13/13` passing (2 suites)

---

## Credits

This template synthesizes:
- **PRD-first development** — requirements before code
- **Rigorous context preservation** — two-phase commit logging
- **Multi-agent orchestration** — checkpoints, interfaces, and intervention
- **Production security best practices** — 30 security rules and pre-ship gates
- **Behavior-driven design** — UI/UX drives tests, tests drive code
- **Anti-test-gaming engineering** — constraints, criteria, and adversarial review
