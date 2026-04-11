# Testing Philosophy

> Tests must be atomically and precisely quantifiable to the point of exhaustion.

---

## Core Principle

**One test = one quantifiable claim about the system.**

### Tests Before Code

**Tests are defined after UI/UX and before implementation.**

This is not optional. The order is:
```
PRD → UI/UX Design → Test Definition → Code
```

Writing tests after UI/UX but before code ensures:
- Tests verify the actual designed behavior, not accidental implementation
- Edge cases are considered before architecture locks them out
- Every designed state has a corresponding test
- Developers write code to make tests pass (TDD/BDD)

**Gate:** No code until the test spec is complete and edge case audit is done.

If you cannot reduce a test to a binary pass/fail with a single, precise assertion, it is not atomic enough.

---

## The Atomic Test Contract

Every test must declare:

1. **Input** — exact, reproducible, no ambiguity
2. **Operation** — single action, no side quests
3. **Expected output** — precise, measurable, verifiable
4. **Tolerance** — if approximate, tolerance is explicit

---

## Test Granularity Rules

### DO
- Write one assertion per test when possible
- Name tests with the pattern: `should [expected behavior] when [condition]`
- Quantify everything: counts, thresholds, timings, boundaries
- Test the boundary, the boundary ± 1, and a representative interior point
- Exhaust edge cases: empty, null, zero, max, overflow, underflow
- Mock external dependencies to isolate the unit under test
- Record exact environment state if a test is non-deterministic
- **Map every test to an objective in the Design Document**
- **Write tests that are implementation-independent (black-box)**

### DO NOT
- Combine multiple behaviors in one test
- Use vague expectations like "should work" or "should not throw"
- Leave magic numbers unexplained
- Skip flaky tests — fix or document with root cause
- Test implementation details instead of observable behavior

---

## Quantification Checklist

Before declaring a test complete, verify it is exhaustively quantifiable:

- [ ] Input is exact and reproducible
- [ ] Output is precisely defined
- [ ] Edge cases are covered (minimum 3: lower bound, upper bound, nominal)
- [ ] Error case is covered with exact error message or code
- [ ] Timing/precision tolerance is stated if applicable
- [ ] Side effects are verified if the function has them
- [ ] Test name describes the exact claim being made

---

## Example: Atomic Tests

### Bad (Vague)
```typescript
it("should handle users", () => {
  const result = processUser({ name: "Alice" });
  expect(result).toBeDefined();
});
```

### Good (Atomic + Quantified)
```typescript
describe("processUser", () => {
  it("should return id as UUID v4 when given valid input", () => {
    const result = processUser({ name: "Alice", email: "alice@example.com" });
    expect(result.id).toMatch(/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i);
  });

  it("should throw ValidationError with code 'EMAIL_INVALID' when email is malformed", () => {
    expect(() => processUser({ name: "Alice", email: "not-an-email" }))
      .toThrow("EMAIL_INVALID");
  });

  it("should throw ValidationError with code 'NAME_EMPTY' when name is empty string", () => {
    expect(() => processUser({ name: "", email: "alice@example.com" }))
      .toThrow("NAME_EMPTY");
  });

  it("should throw ValidationError with code 'NAME_EMPTY' when name is whitespace-only", () => {
    expect(() => processUser({ name: "   ", email: "alice@example.com" }))
      .toThrow("NAME_EMPTY");
  });
});
```

---

## Coverage Map

Track what is tested and what is not. Update this section as the project grows.

| Module | Unit Tests | Integration Tests | E2E Tests | Coverage % |
|--------|------------|-------------------|-----------|------------|
| `src/index.ts` | 🟡 partial | ❌ none | ❌ none | TBD |
| `src/utils/logger.ts` | 🟡 partial | ❌ none | ❌ none | TBD |
| `src/utils/validator.ts` | 🟢 exhaustive | ❌ none | ❌ none | 100% |

**Legend:**
- 🟢 exhaustive — all paths, edges, and errors covered
- 🟡 partial — happy path + some edges
- 🔴 minimal — only happy path or untested
- ❌ none — no tests

---

## Test Execution Rules

1. **Every code change is tested before commit.**
2. **Red build = stop the line.** No exceptions.
3. **Flaky tests are treated as bugs.** They must be fixed, not skipped.
4. **Tests run in CI on every PR.**
5. **Coverage thresholds are enforced.** Minimum target: 80% line coverage, 70% branch coverage.
6. **Adversarial review is mandatory before coding.** Review `docs/ANTI_TEST_GAMING.md` for every test suite.
7. **Constraint audit runs after coding.** Tests passing is necessary, not sufficient.

---

## Sign-Off

Before shipping, this coverage map must show 🟢 or 🟡 for all production modules. No 🔴 or ❌ allowed.
