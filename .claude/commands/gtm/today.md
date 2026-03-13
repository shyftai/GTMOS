---
name: gtm:today
description: Daily action briefing — what you need to do right now
argument-hint: "<workspace-name>"
---
<objective>
Morning briefing. Scan the workspace, surface what needs action today, and prioritize it. Built for SDRs and operators who want to know "what do I do right now?"

Workspace: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/sending-calendar.md
@./.claude/gtmos/references/BENCHMARKS.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // TODAY >>`
2. Load full workspace context — all files, all campaigns
3. Check current date against sending calendar for holidays

## Scan everything
4. Scan and categorize actions by urgency:

**Urgent (do now):**
- Unhandled positive replies — these are warm leads going cold
- Bounce rate spikes (>3% in last 24h) — pause and investigate
- Budget threshold hit — campaigns may need pausing
- Infrastructure alerts — inbox/domain issues

**Today (do before end of day):**
- Unhandled neutral/objection replies — respond same day
- OOO contacts whose return date has passed — `/gtm:re-engage {ws} --ooo`
- Nurture contacts due for follow-up today — `/gtm:nurture --due`
- Open to-dos marked Urgent or High in ROADMAP.md
- Signals detected that match active campaigns — time-sensitive outreach
- A/B tests that hit statistical significance — pick winner
- Campaigns ready to ship (copy approved, list validated)
- Meetings booked today — prep needed? — `/gtm:prep-meeting`

**This week (plan for it):**
- Planned campaigns approaching target start date
- Nurture contacts due this week
- Data hygiene tasks (emails needing re-verification)
- To-dos marked Medium in ROADMAP.md
- Health check due (last one >7 days ago)
- Debrief due (campaign completed, not yet debriefed)

5. Display the daily briefing:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  TODAY — {Workspace} — {date}                                ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  Do now
    !! 2 positive replies waiting — /gtm:replies {ws}
    !! Signal: {company} just raised Series B — /gtm:signals {ws}

  Today
    >> Respond to 3 objection replies — /gtm:replies {ws}
    >> 2 nurture contacts due — /gtm:nurture {ws} --due
    >> Prep meeting with {name} at 2pm — /gtm:prep-meeting {ws} {email}
    >> Ship "Q2 Expansion" (copy approved, list ready) — /gtm:ship {ws} q2-expansion
    >> To-do: Rewrite Touch 1 opener (High) — ROADMAP.md

  This week
    .. Health check due (last: 8 days ago) — /gtm:health {ws} {campaign}
    .. "Event Follow-up" starts in 5 days — prep list
    .. 140 emails need re-verification — /gtm:data-hygiene {ws}

  Campaigns pulse
    {campaign-1}   Day 8    Reply: 4.2%   ▲ above benchmark
    {campaign-2}   Day 3    Reply: 1.1%   ▼ early, monitoring

  All clear?
    {If nothing urgent: "Nothing urgent. Focus on to-dos or plan the next campaign."}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

6. Recommend the single most important action:
```
  >> Start here: /gtm:replies {ws}
```

7. If role is set in workspace.config.md, adjust emphasis:
   - **SDR**: emphasize replies, signals, shipping
   - **GTM Engineer**: emphasize infrastructure, data hygiene, tool issues
   - **Head of Sales**: emphasize pipeline movement, meetings booked, attribution
   - **Founder**: keep it simple — top 3 actions only
   - **Agency**: show cross-workspace summary if multiple workspaces exist
</process>
</content>
</invoke>