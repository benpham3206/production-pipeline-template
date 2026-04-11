/**
 * Email validation utility
 *
 * Validates email format with precise, quantifiable rules.
 *
 * Design notes:
 * - This is a pragmatic (80/20) implementation, not a full RFC 5322 parser.
 * - The regex covers the vast majority of real-world valid emails while
 *   remaining readable and maintainable.
 * - Length limits follow SMTP standards:
 *   - Local part (before @): max 64 characters
 *   - Total email length: max 254 characters
 * - Error codes are machine-readable strings to support i18n and
 *   deterministic test assertions.
 */

export interface ValidationResult {
  valid: boolean;
  error?: string;
}

// Pragmatic email regex: local-part@domain.tld
// Covers alphanumeric, dots, underscores, percent, plus, and minus in local part.
// Does NOT support quoted strings or IP-literal domains (rare in practice).
const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

// SMTP local-part limit per RFC 5321
const MAX_LOCAL_LENGTH = 64;

// Total email length limit per RFC 5321 (255 including null terminator, so 254 usable)
const MAX_TOTAL_LENGTH = 254;

/**
 * Validate an email address string.
 *
 * @param email - The email address to validate
 * @returns ValidationResult with `valid: true` or `valid: false` plus an error code
 */
export function validateEmail(email: string): ValidationResult {
  // Guard against null, undefined, empty string, or whitespace-only input.
  if (!email || email.trim().length === 0) {
    return { valid: false, error: "EMAIL_EMPTY" };
  }

  // Reject emails that exceed the total SMTP length limit.
  if (email.length > MAX_TOTAL_LENGTH) {
    return { valid: false, error: "EMAIL_TOO_LONG" };
  }

  // Require exactly one @ separator.
  const atIndex = email.indexOf("@");
  if (atIndex === -1) {
    return { valid: false, error: "EMAIL_INVALID" };
  }

  // Reject local parts that exceed the SMTP local-part limit.
  const localPart = email.slice(0, atIndex);
  if (localPart.length > MAX_LOCAL_LENGTH) {
    return { valid: false, error: "EMAIL_TOO_LONG_LOCAL" };
  }

  // Final format validation against the pragmatic regex.
  if (!EMAIL_REGEX.test(email)) {
    return { valid: false, error: "EMAIL_INVALID" };
  }

  return { valid: true };
}
