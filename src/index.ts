/**
 * Application entry point.
 * Returns a string for testability; writes to stdout only when run directly.
 */

export function main(): string {
  const message = "Production Pipeline Template — replace this with your app logic.";
  return message;
}

if (require.main === module) {
  process.stdout.write(main() + "\n");
}
