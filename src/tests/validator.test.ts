/**
 * Exhaustive atomic tests for validateEmail
 *
 * Every test asserts exactly one quantifiable claim.
 * See docs/TESTING.md for the testing philosophy.
 */

import { validateEmail } from "../utils/validator";

describe("validateEmail", () => {
  // Happy path: simple valid email
  it("should return valid=true for a standard email address", () => {
    const result = validateEmail("alice@example.com");
    expect(result.valid).toBe(true);
    expect(result.error).toBeUndefined();
  });

  // Happy path: email with plus sign (common for filtering)
  it("should return valid=true for an email containing a plus sign in the local part", () => {
    const result = validateEmail("alice+tag@example.com");
    expect(result.valid).toBe(true);
    expect(result.error).toBeUndefined();
  });

  // Happy path: subdomain
  it("should return valid=true for an email with a subdomain", () => {
    const result = validateEmail("alice@mail.example.com");
    expect(result.valid).toBe(true);
    expect(result.error).toBeUndefined();
  });

  // Edge case: empty string
  it("should return valid=false with error EMAIL_EMPTY when input is an empty string", () => {
    const result = validateEmail("");
    expect(result.valid).toBe(false);
    expect(result.error).toBe("EMAIL_EMPTY");
  });

  // Edge case: whitespace-only string
  it("should return valid=false with error EMAIL_EMPTY when input is whitespace only", () => {
    const result = validateEmail("   ");
    expect(result.valid).toBe(false);
    expect(result.error).toBe("EMAIL_EMPTY");
  });

  // Edge case: missing @ symbol
  it("should return valid=false with error EMAIL_INVALID when input lacks an @ symbol", () => {
    const result = validateEmail("aliceexample.com");
    expect(result.valid).toBe(false);
    expect(result.error).toBe("EMAIL_INVALID");
  });

  // Edge case: missing TLD (no dot in domain)
  it("should return valid=false with error EMAIL_INVALID when domain has no TLD", () => {
    const result = validateEmail("alice@example");
    expect(result.valid).toBe(false);
    expect(result.error).toBe("EMAIL_INVALID");
  });

  // Edge case: multiple @ symbols
  it("should return valid=false with error EMAIL_INVALID when input contains multiple @ symbols", () => {
    const result = validateEmail("alice@foo@example.com");
    expect(result.valid).toBe(false);
    expect(result.error).toBe("EMAIL_INVALID");
  });

  // Edge case: local part exceeds 64 characters
  it("should return valid=false with error EMAIL_TOO_LONG_LOCAL when local part exceeds 64 characters", () => {
    const longLocal = "a".repeat(65) + "@example.com";
    const result = validateEmail(longLocal);
    expect(result.valid).toBe(false);
    expect(result.error).toBe("EMAIL_TOO_LONG_LOCAL");
  });

  // Edge case: total length exceeds 254 characters
  it("should return valid=false with error EMAIL_TOO_LONG when total length exceeds 254 characters", () => {
    const longEmail = "a".repeat(250) + "@b.co";
    expect(longEmail.length).toBeGreaterThan(254);
    const result = validateEmail(longEmail);
    expect(result.valid).toBe(false);
    expect(result.error).toBe("EMAIL_TOO_LONG");
  });
});
