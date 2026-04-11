# Performance Checklist

## Load Testing
- [ ] Baseline performance established
- [ ] Load test covers normal, peak, and stress scenarios
- [ ] SLOs defined (p50, p95, p99 latency; throughput; error rate)
- [ ] Performance regression gate in CI

## Frontend (if applicable)
- [ ] Core Web Vitals in acceptable range (LCP < 2.5s, FID < 100ms, CLS < 0.1)
- [ ] Bundle size within budget
- [ ] Images optimized (WebP, lazy loading)
- [ ] Critical rendering path optimized

## Backend
- [ ] Database queries have appropriate indexes
- [ ] N+1 query patterns eliminated
- [ ] Connection pooling configured
- [ ] Response caching implemented (where safe)
- [ ] Async/background processing for heavy operations

## Infrastructure
- [ ] Auto-scaling configured with appropriate thresholds
- [ ] CDN for static assets
- [ ] Compression enabled (gzip/brotli)
- [ ] Keep-alive connections configured
