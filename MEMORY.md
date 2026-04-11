# Project Memory

> Append-only log of decisions, mistakes, and lessons learned. Read this before starting any work.

---

## How to Use This File

- **Agents:** Read this file at the start of every session.
- **Humans:** Add entries when you learn something worth remembering.
- **Format:** Chronological, newest at the top.

---

## Template Entry

```markdown
## [YYYY-MM-DD] [Feature/Decision/Topic]

### What Worked Well
-

### What Didn't Work
-

### Technical Decisions
| Decision | Rationale | Trade-offs |
|----------|-----------|------------|
| | | |

### Lessons Learned
-

### For Future Reference
-
```

---

## Entries

### [2026-04-10] Branch-Based Workflow beats GitHub Branch Protection

On free private GitHub accounts, the "Require status checks to pass before merging" branch protection option may not be available. **The workaround is process, not platform settings:**
- Always create a branch before making changes: `git checkout -b your-branch-name`
- Never push directly to `main`
- Open a Pull Request and wait for the green checkmark (CI / Test & Build)
- Merge only after tests pass
- The `.githooks/pre-push` hook installed by `init-project.sh` blocks accidental direct pushes to `main`

**Lesson:** A local git hook + disciplined habit is just as safe as a GitHub UI toggle, and it works everywhere.

