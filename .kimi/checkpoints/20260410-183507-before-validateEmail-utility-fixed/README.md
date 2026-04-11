# Production Pipeline Template

> A stack-agnostic, production-ready project scaffold designed for human + AI agent collaboration.

---

## What This Is

This template provides:

1. **A production-grade folder structure** for any software product
2. **An embedded governance model** — the process of how to build things correctly
3. **Security & functionality checklists** derived from real-world production requirements
4. **Agentic collaboration workflows** — how humans and AI agents work together safely

---

## Quick Start

```bash
# 1. Initialize the project (creates .kimi/ tail pointer, validates structure)
./scripts/init-project.sh

# 2. Fill out PRD.md before writing any code
# 3. Fill out docs/PROCESS.md with your team/agent workflow
# 4. Run health checks continuously
./scripts/health-check.sh
```

---

## Core Principles

| Principle | Meaning |
|-----------|---------|
| **PRD First** | No code until requirements are documented and approved |
| **Log is Truth** | `CONTEXT_LOG.md` is the source of truth; PRD is derived from it |
| **Audit First** | Run `health-check.sh` before any planning or implementation |
| **Checklist-Driven** | Security and functionality gates must pass before shipping |
| **Agent-Native** | Documents and processes are readable by both humans and AI agents |

---

## Folder Structure

```
.
├── AGENTS.md              # AI agent onboarding & ground rules
├── PRD.md                 # Product Requirements Document (template)
├── CONTEXT_LOG.md         # Append-only execution journal
├── STATE.md               # Current task state & success criteria
├── LOGS.md                # Chronological completion log
├── MEMORY.md              # Project memory: decisions, mistakes, wins
├── ERRORS.md              # Error log and patterns to remember
├── README.md              # This file — human onboarding
├── docs/
│   ├── PROCESS.md         # The agentic/human collaboration workflow
│   ├── AGENT_REASONING.md # 5-gate reasoning protocol for AI agents
│   ├── AGENT_STATES.md    # Agent state machine and transitions
│   ├── MENTAL_MODELS.md   # Mental models quick reference
│   ├── TESTING.md         # Atomic and exhaustive testing philosophy
│   ├── INTERFACES.md      # Interface contracts between components
│   ├── adr/               # Architecture Decision Records
│   ├── checklists/
│   │   ├── SECURITY.md    # 30 security rules + AI security review
│   │   ├── FUNCTIONALITY.md # Production readiness checklist
│   │   └── PRE_SHIP.md    # Final go-live checklist
│   └── templates/
│       ├── work-package.md
│       ├── intervention.md
│       └── post-mortem.md
├── scripts/
│   ├── init-project.sh    # One-time project initialization
│   ├── health-check.sh    # Pre-work audit script
│   ├── checkpoint.sh      # Create recoverable checkpoints
│   ├── recovery.sh        # Post-crash state restoration
│   └── pre-ship-audit.sh  # Final shipping validation
├── src/                   # Your actual code lives here
│   ├── index.ts           # Entry point (adapt to your stack)
│   ├── utils/
│   ├── tests/
│   └── ...
└── memory/                # Dated decision records
    └── YYYY-MM-DD.md
```

---

## The Workflow (Human + Agent)

See [`docs/PROCESS.md`](docs/PROCESS.md) for the full workflow. At a high level:

1. **Think** — Write/approve the PRD
2. **Plan** — Define interfaces, create work packages
3. **Log** — Record INTENT before every execution step
4. **Execute** — Write code, run tests
5. **Verify** — Run health checks, checklists, tests
6. **Document** — Update MEMORY.md, ERRORS.md, CONTEXT_LOG.md

---

## Checklists

Before any code ships, these must be complete:

- [`docs/checklists/SECURITY.md`](docs/checklists/SECURITY.md) — Authentication, secrets, rate limits, RLS, backups, etc.
- [`docs/checklists/FUNCTIONALITY.md`](docs/checklists/FUNCTIONALITY.md) — Health endpoints, monitoring, CI/CD, migrations, etc.
- [`docs/checklists/PRE_SHIP.md`](docs/checklists/PRE_SHIP.md) — Final go-live gates

---

## For Humans

- Start with `PRD.md`. Fill it out completely.
- Review `docs/PROCESS.md` to understand how agents will interact with this project.
- Use `scripts/health-check.sh` before and after every work session.
- Update `MEMORY.md` when you learn something important.

## For AI Agents

- Read `AGENTS.md` first. It contains your operating rules.
- Read `MEMORY.md` and `ERRORS.md` before starting any work.
- Never write code before the PRD is approved.
- Log INTENT → Execute → Log OUTCOME in `CONTEXT_LOG.md` for every turn.

---

## Status

- [ ] Project initialized (`./scripts/init-project.sh` run)
- [ ] PRD.md completed
- [ ] Team/agent workflow agreed upon
- [ ] First feature implemented using PROCESS.md
- [ ] All checklists passing

---

*This template synthesizes PRD-first development, rigorous context preservation, multi-agent orchestration, and production security best practices.*
