/**
 * Structured logger utility
 *
 * This is a lightweight shim that provides a structured logging interface.
 * It outputs JSON-formatted log lines to stdout/stderr so that logs can be
 * parsed by log aggregation systems (e.g., Datadog, CloudWatch, Splunk).
 *
 * Why this exists:
 * - `console.log` is discouraged in production because it lacks log levels,
 *   structured context, and safe handling of sensitive data.
 * - This module gives you a typed, level-aware logging surface that can be
 *   swapped for Winston, Pino, or another production logger without changing
 *   call sites throughout the codebase.
 *
 * Why it uses process.stdout/stderr instead of console.*:
 * - console.log triggers lint/audit warnings in this pipeline because
 *   accidental console.log statements are a common source of production noise.
 * - Using process.stdout/stderr here is intentional and documented,
 *   distinguishing this utility from stray debug logs.
 */

export type LogLevel = "debug" | "info" | "warn" | "error";

export interface LogContext {
  [key: string]: unknown;
}

/**
 * Emit a single structured log entry as JSON.
 *
 * @param level   - Severity of the log entry
 * @param message - Human-readable log message
 * @param context - Optional structured key/value context
 */
export function log(level: LogLevel, message: string, context?: LogContext): void {
  const entry = {
    timestamp: new Date().toISOString(),
    level,
    message,
    ...context,
  };

  const output = JSON.stringify(entry) + "\n";

  if (level === "error") {
    process.stderr.write(output);
  } else {
    process.stdout.write(output);
  }
}

/**
 * Convenience logger object with level-specific methods.
 */
export const logger = {
  debug: (msg: string, ctx?: LogContext) => log("debug", msg, ctx),
  info: (msg: string, ctx?: LogContext) => log("info", msg, ctx),
  warn: (msg: string, ctx?: LogContext) => log("warn", msg, ctx),
  error: (msg: string, ctx?: LogContext) => log("error", msg, ctx),
};
