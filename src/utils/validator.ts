/**
 * Email validation utility.
 * Validates format with SMTP length limits (local ≤ 64, total ≤ 254).
 */

export interface ValidationResult {
  valid: boolean;
  error?: string;
}

const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
const MAX_LOCAL_LENGTH = 64;
const MAX_TOTAL_LENGTH = 254;

/**
 * Validate an email address string.
 */
export function validateEmail(email: string): ValidationResult {
  if (!email || email.trim().length === 0) {
    return { valid: false, error: "EMAIL_EMPTY" };
  }

  if (email.length > MAX_TOTAL_LENGTH) {
    return { valid: false, error: "EMAIL_TOO_LONG" };
  }

  const atIndex = email.indexOf("@");
  if (atIndex === -1) {
    return { valid: false, error: "EMAIL_INVALID" };
  }

  const localPart = email.slice(0, atIndex);
  if (localPart.length > MAX_LOCAL_LENGTH) {
    return { valid: false, error: "EMAIL_TOO_LONG_LOCAL" };
  }

  if (!EMAIL_REGEX.test(email)) {
    return { valid: false, error: "EMAIL_INVALID" };
  }

  return { valid: true };
}
