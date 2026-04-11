# Error Log

> Append-only chronicle of bugs, mistakes, and near-misses. Read this before starting related work.

---

### 2026-04-10 — checkpoint.sh fails on macOS due to GNU cp --parents
- **Component:** `scripts/checkpoint.sh`
- **Error:** `cp: illegal option -- -` repeated for every file during fallback copy
- **Context:** Running `./scripts/checkpoint.sh create "before-validateEmail-utility"` on macOS
- **Root Cause:** macOS `cp` does not support `--parents` (GNU-only flag). The fallback path in the script used `find ... -exec cp --parents {}`, causing silent failures for every file.
- **Resolution:** Replaced `cp --parents` with a `while read` loop using `mkdir -p` + `cp`, which is POSIX-compatible.
- **Lesson:** Never assume GNU coreutils on macOS. Test scripts on target OS or use POSIX-compatible constructs.
- **Time Lost:** ~2 minutes
- **Severity:** minor

---

## Sections

### Error Entries (Chronological — Newest First)

*(See above for the most recent entry.)*

---

### Patterns to Remember

| Pattern | When to Use | Example |
|---------|-------------|---------|
| POSIX-compatible file copy | Cross-platform shell scripts | `mkdir -p` + `cp` loop instead of `cp --parents` |

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
