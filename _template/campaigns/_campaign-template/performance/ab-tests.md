# A/B Tests — [Campaign Name]

| Test ID | Date | Variable | Variant A | Variant B | Metric | A Result | B Result | Winner | Applied |
|---------|------|----------|-----------|-----------|--------|----------|----------|--------|---------|

---

## Significance Rules

A winner can only be declared when one of the following thresholds is met:

- **Path 1:** Both variants have 50+ sends AND there is a >20% relative difference between them.
- **Path 2:** Both variants have 100+ sends AND there is a >10% relative difference between them.

**Relative difference** is calculated as:

```
|A_rate - B_rate| / min(A_rate, B_rate) * 100
```

If neither threshold is met after both variants exceed 100 sends, the test should be logged as **Inconclusive**.

## Guidelines

- Only one active test per campaign at a time.
- Test one variable at a time (subject line, CTA, opening line, etc.).
- Minimum 50 contacts per variant. 100 per variant recommended.
- Always state a hypothesis before running a test.
- Forward-feed every result: winners become the new default, insights go to trends.md, reusable patterns go to snippet-library.md.
