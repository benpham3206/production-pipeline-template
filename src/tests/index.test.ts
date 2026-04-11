/**
 * Example atomic test suite
 *
 * Every test must be precisely quantifiable.
 * See docs/TESTING.md for the full testing philosophy.
 */

import { main } from "../index";

describe("main", () => {
  // Positive case: function returns a string without throwing
  it("should return a string when invoked directly", () => {
    const result = main();
    expect(typeof result).toBe("string");
  });

  // Content case: returned string contains expected identifier
  it("should return a string containing the project name", () => {
    const result = main();
    expect(result).toMatch(/Production Pipeline Template/);
  });

  // Purity case: repeated invocations produce consistent results
  it("should return the same result on every invocation", () => {
    const first = main();
    const second = main();
    const third = main();
    expect(first).toBe(second);
    expect(second).toBe(third);
  });
});
