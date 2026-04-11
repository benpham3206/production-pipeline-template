# Decisions — 2026-04-10: Script Hardening

## Script Robustness Improvements
**Context:** User asked to fix all bugs and edge cases to ensure clean execution.
**Decision:**
- Fixed `health-check.sh` to check `npm test` exit code directly instead of piping to `grep` (brittle, could false-positive)
- Fixed `pre-ship-audit.sh` to skip git checks gracefully when not in a git repository
- Fixed `pre-ship-audit.sh` npm checks to use exit codes directly
- Fixed `pre-ship-audit.sh` `console.log` grep to only match actual calls (`console.log(`) instead of catching comments
- Fixed `recovery.sh` to default to "y" in non-interactive terminals without hanging
**Rationale:** Edge cases in automation scripts are where pipelines silently fail. Explicit exit-code checking and environment guards prevent false positives.
**Consequences:** All scripts now run cleanly on macOS, Linux, inside and outside git repos, and in CI/non-interactive environments. Pre-ship audit now reports 10/10 with zero warnings.

## Clean Exit Audit for All Functions and Scripts
**Context:** User requested that all return, callback, and timeout functions be clean and exit cleanly/report back.
**Decision:**
- Audited all 5 shell scripts and all TypeScript source files for clean exits
- Added `set -euo pipefail` to all shell scripts:
  - `checkpoint.sh`
  - `health-check.sh`
  - `init-project.sh`
  - `pre-ship-audit.sh`
  - `recovery.sh`
- Added explicit `exit 0` at the end of every successful script path
- Fixed `checkpoint.sh` to fall back from `tac` to `tail -r` for macOS compatibility
- Fixed `checkpoint.sh` restore to use `"$TARGET/"*` (trailing slash) to ensure reliable content copying even with empty directories
- Verified all TypeScript functions have guaranteed return values on every code path
- Confirmed no async callbacks, Promises, setTimeout, or other potentially hanging operations exist in the source code
**Rationale:** Scripts that fail silently in pipelines or hang on missing input are a common source of CI/debugging pain. `pipefail` ensures pipeline failures are caught. Explicit exit codes make script behavior predictable for callers.
**Consequences:** Every script in the pipeline now exits cleanly with a well-defined status code, and no function can hang or leak pipeline failures.
