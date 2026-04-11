# Observability Checklist

## Logging
- [ ] Structured JSON logging (not plain text)
- [ ] Log levels used consistently (DEBUG, INFO, WARN, ERROR)
- [ ] Request ID / correlation ID in every log line
- [ ] No PII in logs (or redacted)
- [ ] Log retention policy defined (≥ 90 days)
- [ ] Centralized log aggregation (ELK, Datadog, CloudWatch)

## Metrics
- [ ] Application metrics exposed (requests, latency, errors)
- [ ] Infrastructure metrics collected (CPU, memory, disk, network)
- [ ] Business metrics tracked (signups, conversions, revenue)
- [ ] Metrics dashboard created
- [ ] SLI/SLO defined for critical paths

## Alerting
- [ ] Alerts require sustained degradation (not single spikes)
- [ ] Every alert has a runbook
- [ ] Alert severity levels defined (P1-P4)
- [ ] On-call rotation configured
- [ ] Alert fatigue reviewed quarterly (tune noisy alerts)

## Tracing
- [ ] Distributed tracing enabled (OpenTelemetry, Jaeger, X-Ray)
- [ ] Trace context propagated across service boundaries
- [ ] Slow requests identifiable via traces
- [ ] Error traces include stack trace and context

## Dashboards
- [ ] Service health overview dashboard
- [ ] Per-service detailed dashboard
- [ ] Business metrics dashboard
- [ ] Incident investigation dashboard
