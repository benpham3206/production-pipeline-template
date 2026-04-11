# Decisions — 2026-04-10: Agent Reasoning

## Agent Reasoning Protocol Externalized
**Context:** User provided a personal 5-gate reasoning framework (Intent, 5W5H, Complexity, Salvatier, Task State) plus execution and closeout rules.
**Decision:** Created `docs/AGENT_REASONING.md`, `STATE.md`, `LOGS.md`, `scripts/checkpoint.sh`, and `memory/` directory to externalize the framework.
**Rationale:** Agent reasoning should be visible, checkpointed, and recoverable — not hidden in context windows.
**Trade-offs:** Adds slight overhead per turn (~100-200 tokens of reasoning), but prevents expensive mistakes.
**Consequences:** Every agent turn now has a structured pre-response checklist and post-task closeout protocol.

## Agent States, Session Persistence, and Mental Models Added
**Context:** User provided an agent state machine (resting, coding, scripting, testing, reasoning, executing, recovering), session persistence/recovery workflow, and a set of mental models for decision-making.
**Decision:** 
- Created `docs/AGENT_STATES.md` with state definitions, behaviors, transitions, and logging rules
- Created `docs/MENTAL_MODELS.md` with 12 models and a selection guide
- Created `scripts/recovery.sh` for post-crash restoration
- Created `.kimi/session_backup/` directory for session backups
- Integrated states and mental models into `AGENTS.md` and `docs/PROCESS.md`
**Rationale:** AI agents need explicit state awareness to behave correctly and recover gracefully from crashes. Mental models provide reusable decision-making frameworks.
**Trade-offs:** More documents to maintain, but they are append-only and self-documenting.
**Consequences:** Agents now operate with explicit state tracking, automatic checkpointing on state transitions, and a recovery workflow on restart.
