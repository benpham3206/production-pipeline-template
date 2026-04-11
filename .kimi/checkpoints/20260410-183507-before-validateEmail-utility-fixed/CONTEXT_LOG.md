---
session_id: "sess-CHANGE_ME"
started: "YYYY-MM-DDTHH:MM:SSZ"
project: "[Project Name]"
workflow:
  - prd-first
  - rigorous-context
  - orchestrator
  - vibe-coding-security
prd_version: "1.0.0"
---

# Context Log: [Project Name]

## Session Overview
[Brief description of what this session aims to accomplish]

---

## Turn 0: Session Initialization
**Phase:** SETUP
**Context:** [Initial context from user request or project kickoff]

### Workspace State
```json
{
  "existing_files": {},
  "missing_files": {},
  "tech_stack": {}
}
```

---

## Turn 1: Intent (HH:MM:SS)
**Target:** PRD Section [X.Y] "[Section Title]"  
**Context:** [Brief summary of what user asked for this turn]

### Planned Actions
- [ ] [Action 1]
- [ ] [Action 2]
- [ ] [Action 3]

### Workspace Snapshot
```json
{
  "files": {},
  "risk_flags": [],
  "estimated_tokens": 0
}
```

---

## Turn 1: Outcome (HH:MM:SS)
**Status:** ✅ Success / ⚠️ Partial Success / ❌ Blocked  
**Execution Time:** [N seconds]

### Completed
- ✅ [Action 1]: [Result]

### Blocked / Failed
- ❌ [Action 2]: [Error message + root cause]
  - **Impact:** [How this affects PRD progress]
  - **Resolution:** [Next step or workaround]

### Workspace Delta
| File | Before | After | Lines +/- |
|------|--------|-------|-----------|
| | | | |

### PRD Progress Update
| Section | Previous | Current |
|---------|----------|---------|
| | | |

### Next Recommended Action
[What should happen next based on this outcome]

---

*(Continue appending Turn N: Intent / Turn N: Outcome pairs below.)*
