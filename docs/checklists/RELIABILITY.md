# Reliability Checklist

## Graceful Degradation
- [ ] Non-critical features degrade gracefully when dependencies fail
- [ ] Feature flags allow disabling specific features in emergencies
- [ ] Static fallback pages for total outages

## Retry & Circuit Breaker
- [ ] External calls use retries with exponential backoff + jitter
- [ ] Circuit breaker pattern on flaky dependencies
- [ ] Timeouts on all external calls (HTTP, DB, cache)
- [ ] Dead letter queues for failed async operations

## Data Durability
- [ ] Automated backups configured and tested
- [ ] Point-in-time recovery available
- [ ] Backup restoration tested quarterly

## Deployment Safety
- [ ] Blue/green or canary deployments
- [ ] Health check verifies application readiness
- [ ] Automated rollback on failed health check
- [ ] Database migrations are backward compatible

## Chaos Readiness
- [ ] Documented what happens when each dependency fails
- [ ] Tested behavior under: DB failure, cache failure, network partition
- [ ] Game day / chaos engineering exercises scheduled
