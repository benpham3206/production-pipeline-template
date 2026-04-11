# Project Memory

> Shared sticky notes for humans and agents. Read this before starting any work. Append anything that would save future-you from re-learning a lesson.

---

## How to Use This File

- **Agents:** Read this at the start of every session. **Write to it when you hit a surprise, fix a bug, or learn something non-obvious.**
- **Humans:** Drop in quick lessons, preferences, or gotchas anytime.
- **Format:** Chronological, newest at the top. Keep entries short — this is a fridge, not a filing cabinet.

---

## Agent Auto-Detect: When to Remember Something

Before ending a task, scan the session for any of these triggers. If one happened, write a 1-3 sentence note here.

### Remember-This Triggers

| Trigger | Example Note |
|---------|--------------|
| **A bug had a non-obvious cause** | "`checkpoint.sh` failed on macOS because `cp --parents` is GNU-only. Use `mkdir -p` + `cp` instead." |
| **A tool or command behaved unexpectedly** | "`npm test \| grep` silently passes even when tests fail. Always check exit codes directly." |
| **The user stated a preference or constraint** | "User prefers first-principles explanations with engineering analogies." |
| **You tried something that didn't work** | "`git rm -r --cached` on an untracked folder returns exit 128 — use `git add` + ignore instead." |
| **A process step was unclear or needed tweaking** | "The PRD template asks for exact copy, but for CLI tools that's command help text." |
| **You discovered a limitation or edge case** | "GitHub branch protection 'status checks' dropdown only appears after the check has run on `main` at least once." |

### What NOT to Put Here
- Step-by-step logs (those go in `CONTEXT_LOG.md` or `LOGS.md`)
- Big architectural decisions (those go in `memory/YYYY-MM-DD.md` or `docs/adr/`)
- Active task state (that goes in `STATE.md`)
- Actual errors with stack traces (those go in `ERRORS.md`)

**Rule of thumb:** If you think *"I hope I don't forget this next time,"* put it in `MEMORY.md`.

---

## Quick Note Template

```markdown
### [YYYY-MM-DD] — [One-line topic]
[1-3 sentences max. What happened, why it matters, and what to do next time.]
```

---

## Entries

### [2026-04-10] — Branch-Based Workflow beats GitHub Branch Protection
On free private GitHub accounts, the "Require status checks to pass before merging" branch protection option may not be available. **The workaround is process, not platform settings:**
- Always create a branch before making changes: `git checkout -b your-branch-name`
- Never push directly to `main`
- Open a Pull Request and wait for the green checkmark (CI / Test & Build)
- Merge only after tests pass
- The `.githooks/pre-push` hook installed by `init-project.sh` blocks accidental direct pushes to `main`

**Lesson:** A local git hook + disciplined habit is just as safe as a GitHub UI toggle, and it works everywhere.
