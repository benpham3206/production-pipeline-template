/**
 * Example atomic test suite
 *
 * Every test must be precisely quantifiable.
 * See docs/TESTING.md for the full testing philosophy.
 */

import { main } from "../index";

describe("main", () => {
  // Positive case
  it("should run without throwing when invoked directly", () => {
    expect(() => main()).not.toThrow();
  });

  // Side effect / output case
  it("should write exactly one line to stdout when invoked", () => {
    const logs: string[] = [];
    const originalLog = console.log;
    console.log = (msg: string) => logs.push(msg);

    main();

    console.log = originalLog;
    expect(logs.length).toBe(1);
    expect(logs[0]).toMatch(/Production Pipeline Template/);
  });

  // Module boundary case
  it("should be callable multiple times without side effect accumulation", () => {
    const logs: string[] = [];
    const originalLog = console.log;
    console.log = (msg: string) => logs.push(msg);

    main();
    main();
    main();

    console.log = originalLog;
    expect(logs.length).toBe(3);
    expect(logs.every((l) => l.includes("Production Pipeline Template"))).toBe(true);
  });
});
