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

## Design Quality Standard: Impeccable

To prevent generic "AI template" design, apply the **Impeccable** design standard before declaring UI/UX complete. This means reviewing the design across 7 domains and explicitly catching common anti-patterns.

### The 7 Review Domains

For every user-facing feature, verify quality in these areas:

| Domain | What to Check |
|--------|---------------|
| **Typography** | Type system is intentional, hierarchy is clear, font pairing supports the brand |
| **Color & Contrast** | Colors are accessible (WCAG 2.1 AA), neutrals are tinted (not pure gray), dark mode is considered |
| **Spatial Design** | Spacing follows a system, visual hierarchy guides the eye, grids are consistent |
| **Motion Design** | Animations use purposeful easing, support `prefers-reduced-motion`, avoid bounce/elastic |
| **Interaction Design** | Forms have clear focus states, loading patterns are defined, feedback is immediate |
| **Responsive Design** | Mobile-first, fluid layouts, container queries considered where appropriate |
| **UX Writing** | Button labels are action-oriented, error messages are helpful, empty states guide the user |

### Agent Design Review Commands

Before handing UI/UX off to testing, the agent must run at least one self-critique using these prompts:

| Command | Purpose |
|---------|---------|
| **Audit** | Run technical quality checks (a11y, contrast, responsive behavior, performance) |
| **Critique** | Review hierarchy, clarity, and emotional resonance — does this feel intentional? |
| **Polish** | Final pass: align with design tokens, fix inconsistencies, prepare for shipping |
| **Distill** | Strip to essence — remove unnecessary complexity, cards, gradients, or decoration |
| **Harden** | Check error handling, onboarding, empty states, and edge cases |

**Minimum requirement:** Run **Audit** + **Critique** before UI/UX approval.

### Curated Anti-Patterns (Do Not)

The following patterns are explicit signals of unreviewed, template-driven design. Avoid them unless there is a specific, documented reason:

- ❌ Overused default fonts (Arial, Inter as a lazy default, system defaults without intention)
- ❌ Gray text on colored backgrounds
- ❌ Pure black (`#000000`) or pure gray neutrals — always tint neutrals toward the brand color
- ❌ Cards nested inside cards
- ❌ Purple gradients or dark glows without brand justification
- ❌ Bounce or elastic easing — feels dated and unprofessional
- ❌ Side-tab borders or other "AI slop" visual clichés
- ❌ "We'll figure out the copy later" — Tests cannot be written, code cannot be verified.
- ❌ "It's obvious what the UI should be" — Obvious to you, not to the test. Document it.
- ❌ Skipping empty/loading/error states — These are where most bugs hide.
- ❌ Designing after coding — You will write code that is untestable by design.

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
5. **Impeccable audit passed** — at minimum, the 7 domains are checked and anti-patterns are addressed

### Handoff to Testing

When UI/UX is approved, create `docs/templates/test-spec.md` from the UI/UX specs. Every designed state must have a corresponding test.

---

## Quick Reference

```
PRD approved
    ↓
UI/UX design (flows, wireframes, copy)
    ↓
Impeccable audit + critique (7 domains, anti-patterns)
    ↓
Design review gate (human approval)
    ↓
Test definition (from UI/UX specs)
    ↓
Interface contracts (if needed)
    ↓
Code implementation
```
