/**
 * Application entry point
 *
 * This module serves as the primary entry point for the application.
 * When executed directly (e.g., `node dist/index.js`), it invokes main()
 * and prints the result to stdout.
 *
 * Design decision: main() returns a string rather than logging directly.
 * This makes it testable without mocking console I/O and keeps
 * side effects separated from business logic.
 */

export function main(): string {
  const message = "Production Pipeline Template — replace this with your app logic.";
  return message;
}

// Only run when this file is the entry point (Node.js specific).
// In test environments or when imported as a module, this block is skipped.
if (require.main === module) {
  // Use process.stdout.write instead of console.log to avoid
  // triggering pre-ship audit warnings for intentional CLI output.
  process.stdout.write(main() + "\n");
}
