# Topical Memory Template

> Use this template when a decision or lesson is worth remembering but doesn't need a full formal ADR.

---

## File Naming

```
memory/YYYY-MM-DD-[short-topic].md
```

Examples:
- `memory/2026-04-10-script-hardening.md`
- `memory/2026-04-11-auth-refactor.md`
- `memory/2026-04-12-cors-issue.md`

---

## Template

```markdown
# Decisions — YYYY-MM-DD: [Topic]

## [Decision Title]
**Context:** [Why this came up]
**Decision:** [What we chose]
**Rationale:** [Why]
**Trade-offs:** [What we gave up]
**Consequences:** [What happens next]

## [Second Decision Title — if applicable]
**Context:**
**Decision:**
**Rationale:**
**Trade-offs:**
**Consequences:**
```

---

## When to Use Topical Memory vs. ADR vs. MEMORY.md

| Use | File |
|-----|------|
| Quick lesson, bug fix, user preference | `MEMORY.md` |
| Day-by-day chronological dump | `memory/YYYY-MM-DD.md` (index) |
| Focused decision on one topic | `memory/YYYY-MM-DD-topic.md` (this template) |
| Big architectural or interface decision | `docs/adr/NNN-title.md` |

---

## Rule of Thumb

> If an agent would have to grep through 100+ lines to find this later, make it a topical memory file instead of dumping it in the daily monolith.
