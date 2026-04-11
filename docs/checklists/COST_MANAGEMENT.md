# Cost Management Checklist

## Estimation
- [ ] Monthly cost estimate documented before deployment
- [ ] Cost per user/request calculated
- [ ] Break-even analysis completed (if revenue-generating)

## Controls
- [ ] Budget alerts at 50%, 80%, 100% of monthly cap
- [ ] Per-service cost anomaly detection enabled
- [ ] Resources tagged for cost allocation
- [ ] Unused resources identified and terminated

## API Costs (LLM, Maps, etc.)
- [ ] Per-request cost known for each paid API
- [ ] Rate limits set to cap spend
- [ ] Cheapest sufficient model/tier selected
- [ ] Caching to reduce redundant API calls
- [ ] Kill switch to disable paid API calls if budget exceeded

## Infrastructure
- [ ] Right-sized instances (not over-provisioned)
- [ ] Reserved/savings plans evaluated for steady-state workloads
- [ ] Spot instances used for fault-tolerant workloads
- [ ] Storage lifecycle policies (move to cheaper tiers over time)
- [ ] Data transfer costs reviewed (cross-AZ, cross-region, egress)

## Review Cadence
- [ ] Monthly cost review
- [ ] Quarterly optimization sprint
- [ ] Annual reserved instance/commitment renewal
