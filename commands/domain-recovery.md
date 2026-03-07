# Command: Domain Recovery Playbook

## Trigger
"Domain recovery" or triggered when /gtm:health detects deliverability red flags

## When to activate
- Bounce rate exceeds 5% on any inbox
- Spam complaint rate exceeds 0.3%
- Google Postmaster shows domain reputation drop to "Low" or "Bad"
- Inbox placement drops below 80% on seed tests
- Multiple inboxes landing in spam

## Recovery steps

### Phase 1 — Stop the bleeding (Day 0)
1. **Pause all cold sending immediately** — every inbox on the affected domain
2. Do NOT pause warmup — keep warmup running on all inboxes
3. Document the current state:
   - Which domain(s) affected
   - Current bounce rate per inbox
   - Current spam complaint rate
   - Google Postmaster domain reputation
   - Number of emails sent in last 7 days
4. Identify the cause:
   - Bad list quality? (check bounce logs)
   - Spam complaints from specific segment?
   - DNS misconfiguration? (re-verify SPF/DKIM/DMARC)
   - Shared tracking domain contamination?
   - Sending volume too high too fast?
5. Log findings in INFRASTRUCTURE.md under a recovery section

### Phase 2 — Clean up (Day 1-3)
6. Remove all bounced addresses from active lists → add to SUPPRESSION.md
7. Remove all spam complainers → add to SUPPRESSION.md with "spam complaint" flag
8. If DNS issue: fix and verify with MXToolbox
9. If shared tracking domain: switch to custom tracking domain immediately
10. Check all active lists for quality — re-validate with email verification tool
11. If the domain is blacklisted: submit delisting requests (Spamhaus, Barracuda, etc.)

### Phase 3 — Warm back (Day 4-14)
12. Keep warmup running at normal volume
13. After 7 days of warmup-only, run a seed test
14. If seed test shows >90% inbox placement: proceed to Phase 4
15. If seed test still shows spam placement: continue warmup for another 7 days
16. If no improvement after 21 days: consider retiring the domain and rotating to a new one

### Phase 4 — Ramp back (Day 14-28)
17. Resume cold sending at 25% of previous volume
18. Use only the cleanest list segment (score 3 contacts only)
19. Monitor daily: bounce rate, spam complaints, inbox placement
20. If metrics stay healthy for 3 days: increase to 50%
21. If metrics stay healthy for 7 days: increase to 75%
22. Full volume only after 14 days of clean metrics

### Nuclear option — domain retirement
If a domain cannot recover after 28 days:
1. Stop all sending on that domain
2. Keep the domain registered (don't let it expire — squatters)
3. Spin up a new outbound domain
4. Full warmup cycle (14-21 days minimum)
5. Update INFRASTRUCTURE.md with the domain swap
6. Update campaign.config.md with new inbox assignments

## Prevention rules
- Never exceed 40 cold emails per inbox per day
- Always verify lists before sending
- Monitor bounce rate daily during active campaigns
- Rotate inboxes — don't overload a single sender
- Keep warmup active on ALL inboxes, always
