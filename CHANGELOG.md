# Changelog

All notable changes to this template will be documented here.

## [1.1.0] — 2026-04-10

### Added
- `NEXT_ACTION.md` for instant session startup
- `.github/workflows/ci.yml` for automated testing on PRs
- `.githooks/pre-push` to block accidental pushes to `main`
- `docs/adr/README.md` as a decision index
- Fast-path complexity threshold in `docs/PROCESS.md`
- Agent "Red Lines" etiquette in `AGENTS.md`
- `.env.example` for environment variable documentation
- `CHANGELOG.md` for tracking template evolution
- ESLint + typescript-eslint configuration

### Changed
- `AGENTS.md` reading order now includes `NEXT_ACTION.md` and `docs/adr/README.md`
- `docs/AGENT_REASONING.md` Gate 2 expanded with sequential vs. paired 5W5H modes
- `PRD.md` status workflow now explicitly requires human approval
- `MEMORY.md` reformatted as a shared, auto-detected sticky-note system
- `memory/2026-04-10.md` split into topical files for easier discovery

### Fixed
- `health-check.sh` now checks `npm test` exit codes directly instead of brittle grep
- `pre-ship-audit.sh` handles non-git repositories gracefully
- `recovery.sh` no longer hangs in non-interactive terminals

## [1.0.0] — 2026-04-10

### Added
- Initial production pipeline template with agentic workflow
- 5-gate reasoning protocol (`docs/AGENT_REASONING.md`)
- Agent states, mental models, and recovery scripts
- `health-check.sh`, `pre-ship-audit.sh`, `checkpoint.sh`, `recovery.sh`
- Atomic testing philosophy and `validateEmail` reference implementation
- UI/UX phase, test definition phase, and design document phase
- Anti-test-gaming safeguards
