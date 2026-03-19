---
name: agency:analytics
description: Analyze campaign and pipeline performance — score results vs. benchmarks, update LEARNINGS.md, recommend next moves
argument-hint: "<workspace-name> [campaign-name | --all]"
---

<objective>
Review outbound campaign and pipeline performance against benchmarks. Surface what worked, what did not, and why. Update LEARNINGS.md with findings. Recommend specific next actions based on the data.
</objective>

<execution_context>
@./AGENCYOS.md
@./references/agency-benchmarks.md
@./references/agency-campaigns.md
@./references/agency-personas.md
</execution_context>

<process>

1. Display header:
```
<< AGENCY:OS // ANALYTICS >>
{workspace name}
```

2. Load PIPELINE.md, LEARNINGS.md, SERVICE-LINES.md, CLIENTS.md.
   Load `references/agency-benchmarks.md` for benchmark targets.

3. Determine scope:
   - If `--all` or no argument: analyze all campaigns active in the last 90 days from PIPELINE.md
   - If campaign name specified: analyze that campaign only

4. For each campaign in scope, collect metrics:

   Ask (or pull from PIPELINE.md if already recorded):
   - Campaign name, target persona, service line pitched
   - Contacts targeted (total)
   - Emails/LinkedIn messages sent
   - Open rate / connection acceptance rate
   - Reply rate (positive + neutral + negative)
   - Meetings booked
   - Proposals sent
   - Deals closed
   - Revenue from closed deals

5. Score each campaign against benchmarks from agency-benchmarks.md:

```
┌─ CAMPAIGN SCORECARD ─── {campaign name} ──────────────────────┐
│                                                               │
│  Persona:    {persona}     Service:   {service line}          │
│  Contacts:   {count}       Period:    {date range}            │
│                                                               │
│  Metric              Actual    Benchmark    Status            │
│  ──────────────────────────────────────────────────────────── │
│  Open rate           {X%}      {bench%}     🟢/🟡/🔴          │
│  Reply rate          {X%}      {bench%}     🟢/🟡/🔴          │
│  Positive reply %    {X%}      {bench%}     🟢/🟡/🔴          │
│  Meeting booked %    {X%}      {bench%}     🟢/🟡/🔴          │
│  Proposal → Close %  {X%}      {bench%}     🟢/🟡/🔴          │
│                                                               │
│  Overall:  {Outperforming / On track / Underperforming}       │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

   Scoring:
   - 🟢 ≥ 90% of benchmark
   - 🟡 70–89% of benchmark
   - 🔴 < 70% of benchmark

6. Diagnose underperforming metrics — pick the most likely root cause:

   | Metric | If 🔴 | Most likely cause |
   |--------|-------|-------------------|
   | Open rate | Subject line or sender reputation | Test new subject lines or warm up domain |
   | Reply rate | Offer/angle not matching persona | Re-read persona profile; test different angle |
   | Positive reply % | Wrong ICP | Review ICP.md — are targets actually qualified? |
   | Meeting booked % | CTA too weak or trust deficit | Add social proof; simplify ask |
   | Close % | Proposal not strong enough | Load pitch-frameworks.md; check case studies used |

7. Check LEARNINGS.md — flag if a 🔴 metric maps to a documented learning that was not applied.

8. Draft LEARNINGS.md entries for this campaign:

   For each significant finding (good or bad):
   ```
   ## [{today's date}] [Category: New Biz]
   **Context:** {campaign name} targeting {persona} for {service line} — {1 sentence summary of what happened}
   **Learning:** {what this tells us}
   **Apply when / Apply to:** {specific trigger or campaign type}
   **Outcome:** Win / Loss / Improved / Inconclusive
   ```

   Show entries and ask: "Add these to LEARNINGS.md?" If yes, append to LEARNINGS.md.

9. Recommend next actions:

   Based on campaign scores and LEARNINGS.md findings, recommend:
   - If open rate 🔴: "Run `/agency:signals {workspace}` — find higher-signal prospects before next campaign"
   - If reply rate 🔴: "Run `/agency:new-business {workspace}` — rebuild campaign with updated angle from learnings"
   - If pipeline stalling at proposal stage: "Run `/agency:pitch {workspace}` — review pitch frameworks"
   - If strong results: "Run `/agency:new-business {workspace} --clone {campaign}` — scale what worked"
   - If client conversion poor despite meetings: "Check CASE-STUDIES.md — are proof points current and relevant?"

10. Log analysis to `logs/workspace-log.md`:
```
## {date} Campaign analytics
Campaigns analyzed: {count}
🟢 Outperforming: {count}
🟡 On track: {count}
🔴 Underperforming: {count}
Learnings added: {count}
```

</process>
