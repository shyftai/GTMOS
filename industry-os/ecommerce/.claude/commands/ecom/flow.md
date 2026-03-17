---
name: ecom:flow
description: Build or update an email/SMS automation flow — welcome, abandoned cart, post-purchase, win-back, and more
argument-hint: "<workspace-name> [flow-type]"
---

<objective>
Generate a complete email/SMS automation flow with trigger, email sequence, subject lines, full copy, timing, and exit conditions. Ensure suppression and flow conflict gates pass. Recommend the highest-impact A/B test.
</objective>

<execution_context>
@./ECOMMERCEOS.md
@./references/email-flows.md
</execution_context>

<process>

1. Display header:
```
<< ECOMMERCE:OS // FLOW >>
{workspace name} — {date}
```

2. Load FLOWS.md, AUDIENCES.md, SUPPRESSION.md, BRAND.md.

3. Ask: What do you want to do?
   - A. Create a new flow
   - B. Review and optimize an existing flow
   - C. Diagnose an underperforming flow

---

**For new flow:**

4. Ask: Which flow type?
   - Welcome Series
   - Abandoned Cart
   - Browse Abandonment
   - Post-Purchase
   - Win-Back
   - VIP / Loyalty
   - Custom (describe the trigger and goal)

5. Ask:
   - Platform: Klaviyo / Omnisend / other?
   - Audience segment (reference AUDIENCES.md)?
   - Primary goal metric (first purchase / repeat purchase / review / reactivation)?

6. **Flow conflict check (hard gate):**
   - Review FLOWS.md — is the target audience already in a conflicting flow?
   - Apply flow conflict matrix from email-flows.md
   - If conflict found: surface it. Require explicit approval or recommend segment adjustment before continuing.

7. Load the flow spec from email-flows.md for the selected type. Generate the full sequence:

For each email in the sequence, provide:
- Trigger or delay from previous email
- Subject line: 3 variants
- Preview text: matched to best subject line
- Full email copy: header, body (2–3 short paragraphs), CTA copy
- CTA button text and destination
- Exit condition (e.g. "exit if purchase made")
- UTM parameters on all links (required)

For any SMS in the sequence:
- Message copy (160 characters max)
- Personalization tokens
- Opt-out instruction ("Reply STOP to unsubscribe")
- UTM link

8. Run quality gate for each email:
   - [ ] Suppression mechanism confirmed (in FLOWS.md exit logic)
   - [ ] Unsubscribe link present
   - [ ] UTM parameters on all links
   - [ ] Brand voice matches BRAND.md
   - [ ] No flow conflicts in FLOWS.md (gate confirmed above)
   - [ ] CAN-SPAM/GDPR compliant (physical address in footer, unsubscribe link)

9. Recommend A/B test for highest-impact element:
   - Welcome Series: subject line of Email 1 (offer framing) vs. alternative
   - Abandoned Cart: Email 1 timing (20 min vs. 1 hour)
   - Post-Purchase: Email 3 timing (Day 7 vs. Day 14 post-delivery)
   - Win-Back: Email 2 offer (% off vs. free shipping)

10. Update FLOWS.md — add the new/updated flow to the active flows table.

11. Log to `logs/workspace-log.md`.

---

**For existing flow review:**

4. Ask which flow to review (pull current performance data from FLOWS.md).

5. Compare performance against benchmarks from email-flows.md and ecom-benchmarks.md.

6. Identify the weakest element:
   - Open rate below benchmark → subject line issue
   - CTR below benchmark → body copy or CTA issue
   - Revenue per recipient below benchmark → offer, timing, or audience mismatch

7. Generate specific improvements:
   - New subject line variants for underperforming emails
   - CTA copy alternatives
   - Timing adjustment recommendation
   - Offer test recommendation

8. Update FLOWS.md with notes on current performance and planned test.

---

**For underperforming flow diagnosis:**

4. Ask: What metric is underperforming — open rate, CTR, CVR, or revenue per recipient?

5. Run through diagnostic framework:
   - Open rate low (<25%): subject line, sender name, send time, list segment health
   - CTR low (<1%): CTA placement, CTA copy, email length, image-to-text ratio, mobile rendering
   - CVR low (<1%): landing page, offer relevance, product availability, price point
   - Revenue per recipient low: offer size, audience segment match, product relevance

6. Produce a prioritized fix list with specific recommendations.

7. Log diagnosis to `logs/workspace-log.md`.

</process>
