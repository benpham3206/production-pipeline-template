# Error Log

> Append-only chronicle of bugs, mistakes, and near-misses. Read this before starting related work.

---

## How to Use This File

- **Update when:** You encounter a new bug, discover an architectural issue, or learn a significant lesson.
- **Do NOT update for:** Minor typos, formatting fixes, or routine progress updates.
- **Read when:** Starting a new session, taking over from another developer, or working on a related component.

---

## Entry Template

```markdown
### [DATE] — [SHORT TITLE]
- **Component:** Which part broke
- **Error:** What happened
- **Context:** What was happening
- **Root Cause:** Why it happened
- **Resolution:** How it was fixed
- **Lesson:** What to do differently
- **Time Lost:** Approximate debugging time
- **Severity:** critical / major / minor
```

---

## Sections

### Error Entries (Chronological — Newest First)

*(None yet — this is a new project.)*

---

### Patterns to Remember

| Pattern | When to Use | Example |
|---------|-------------|---------|

---

### Technology-Specific Guidelines

*(Add stack-specific gotchas here as you encounter them.)*

---

### Pre-Flight Checklists

#### Before Starting Work
- [ ] Read latest `MEMORY.md` entries
- [ ] Read latest `ERRORS.md` entries
- [ ] Run `./scripts/health-check.sh`
- [ ] Check `CONTEXT_LOG.md` tail pointer

#### Before Shipping
- [ ] All tests pass
- [ ] `docs/checklists/SECURITY.md` complete
- [ ] `docs/checklists/FUNCTIONALITY.md` complete
- [ ] `docs/checklists/PRE_SHIP.md` complete
