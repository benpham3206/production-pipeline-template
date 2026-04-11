# Functionality & Production Readiness Checklist

> Ensures the product works reliably and can be operated in production.

---

## Infrastructure & Operations

- [ ] **Health Endpoint Exists**
  - `/health` checks DB and external dependencies
  - Returns meaningful status codes

- [ ] **README is Complete and Accurate**
  - Setup steps documented
  - Environment variables listed
  - Architecture overview included

- [ ] **Staging Environment Exists**
  - Explicit staging env separate from dev and prod

- [ ] **Monitoring & Alerts Configured**
  - Uptime monitoring active
  - Alerts route to PagerDuty/Opsgenie/email

- [ ] **Centralized Logging**
  - Logs go to Datadog/CloudWatch/Splunk/etc.
  - Not just local terminal history

- [ ] **Database Backups Tested**
  - Automated backups
  - Restore tested to staging at least monthly

- [ ] **CI/CD Pipeline Exists**
  - GitHub Actions, GitLab CI, or equivalent
  - No local-machine deploys

- [ ] **Automated Test Suite on Every PR**
  - Unit, integration, and/or E2E tests run automatically

- [ ] **Bus Factor > 1**
  - Documentation sufficient for another engineer to run and deploy

---

## Code Quality & Architecture

- [ ] **Database Migrations in Place**
  - Schema changes managed via Prisma/Flyway/Liquibase/etc.
  - Not just "in your head"

- [ ] **Queries Are Explicit and Optimized**
  - No `SELECT *` in production queries
  - Queries reviewed for performance

- [ ] **Structured Error Handling**
  - Error boundaries (frontend)
  - Global error handlers (backend)
  - Alerts for unexpected errors

- [ ] **Time Standardization**
  - UTC everywhere
  - Convert to local time only at display layer

- [ ] **Component Decomposition**
  - No "god components"
  - Single responsibility principle followed

- [ ] **Analytics Instrumented**
  - Product analytics (Amplitude, Mixpanel, PostHog, etc.)
  - Key user flows tracked

- [ ] **Technical Debt Tracked**
  - Debt documented in tickets
  - Scheduled refactoring sprints

- [ ] **Backend-for-Frontend or API Gateway**
  - Frontend doesn't talk directly to 5+ third-party APIs

- [ ] **Feature Flag System**
  - LaunchDarkly, Unleash, Flagsmith, or equivalent
  - No "commenting code in and out"

- [ ] **Input Validation on All Boundaries**
  - Zod, Joi, or class-validator on all inputs

- [ ] **Structured Logging with Correlation IDs**
  - Log levels used correctly
  - Correlation IDs trace requests across services

---

## Reliability

- [ ] **Graceful Degradation**
  - Service failures don't cascade
  - Timeouts and circuit breakers where appropriate

- [ ] **Retry Logic with Backoff**
  - External API calls retry with exponential backoff
  - Max retry limits enforced

- [ ] **Idempotency**
  - Critical operations are idempotent
  - Duplicate requests handled safely

- [ ] **Resource Limits**
  - Memory, CPU, and connection limits configured
  - File upload size limits enforced

---

## Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Tech Lead | | | |
| DevOps / SRE | | | |
| Product Owner | | | |
