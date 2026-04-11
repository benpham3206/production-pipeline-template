# UI/UX Design Phase

> Design the experience before writing tests or code. UI/UX drives testability.

---

## Core Rule

**PRD → UI/UX → Test Definition → Code**

You cannot write exhaustive tests without knowing:
- What buttons exist and what they are labeled
- What error states look like and what copy they contain
- What the user flow is from screen to screen
- What loading, empty, and success states look like

---

## When UI/UX is Required

| Feature Type | UI/UX Depth Needed |
|--------------|-------------------|
| New user-facing screen | Full wireframes + copy + interaction specs |
| API/backend only | Minimal UI/UX (error message formats only) |
| Modified existing screen | Delta wireframes + updated copy |
| New component | Component spec with states and props |
| Workflow change | Full user flow diagram |

---

## UI/UX Phase Checklist

Before approving UI/UX and moving to test definition:

- [ ] User flow mapped (entry → action → exit)
- [ ] All screens/components identified
- [ ] Copy/text is exact (no lorem ipsum, no placeholders)
- [ ] Error states designed with exact error messages
- [ ] Loading states designed
- [ ] Empty states designed
- [ ] Accessibility requirements noted (contrast, aria labels, keyboard nav)
- [ ] Mobile/responsive behavior specified (if applicable)
- [ ] Feedback mechanism defined (how does the user know something worked?)

---

## Feedback Loops

Every user action must have a visible system response. Define these explicitly:

| Action | Immediate Feedback | Delayed Feedback | Error Feedback |
|--------|-------------------|------------------|----------------|
| Submit form | Button loading state | Success toast/page | Inline error with exact message |
| Delete item | Confirmation dialog | Item removed from list | Error modal with recovery action |
| Search | Input debounce indicator | Results render | "No results" empty state |
| Upload file | Progress bar | File appears in list | Size/type error message |

---

## Design Review Gate

**No test definition until UI/UX is approved.**

### Approval Criteria
1. Human reviewer has seen and approved the design
2. All copy is final
3. All states (happy, loading, error, empty) are defined
4. Accessibility requirements are included

### Handoff to Testing

When UI/UX is approved, create `docs/templates/test-spec.md` from the UI/UX specs. Every designed state must have a corresponding test.

---

## Anti-Patterns

❌ **"We'll figure out the copy later"** → Tests cannot be written, code cannot be verified.  
❌ **"It's obvious what the UI should be"** → Obvious to you, not to the test. Document it.  
❌ **Skipping empty/loading/error states** → These are where most bugs hide.  
❌ **Designing after coding** → You will write code that is untestable by design.

---

## Quick Reference

```
PRD approved
    ↓
UI/UX design (flows, wireframes, copy)
    ↓
Design review gate (human approval)
    ↓
Test definition (from UI/UX specs)
    ↓
Interface contracts (if needed)
    ↓
Code implementation
```
