# Notifications — GTMOS

GTMOS can send Slack notifications for critical events using the Slack MCP integration. This is optional — if Slack MCP is not connected, notifications are displayed inline only.

---

## Setup

1. Ensure Slack MCP is connected in Claude Code
2. Set the notification channel in `global/COLLABORATION.md`:
   ```
   ## Notifications
   slack_channel: #gtmos-alerts
   slack_enabled: true
   ```
3. Optionally set per-workspace channels in `workspace.config.md`:
   ```
   slack_channel: #client-name-alerts
   ```

---

## Notification triggers

### Critical (always notify if Slack is connected)

| Event | Message format |
|-------|---------------|
| Positive reply received | `[{workspace}] Positive reply from {name} at {company} — "{preview...}"` |
| Meeting booked | `[{workspace}] Meeting booked: {name} at {company} — {date}` |
| Budget threshold crossed | `[{workspace}] Budget alert: {pct}% of {campaign} budget used (${spent} of ${budget})` |
| Domain health red flag | `[{workspace}] Domain alert: {domain} — bounce rate {pct}% (above 5% threshold)` |
| Spam complaint | `[{workspace}] Spam complaint from {email} on {campaign} — sequence paused` |

### Important (notify during active campaigns)

| Event | Message format |
|-------|---------------|
| Campaign shipped | `[{workspace}] Shipped: {campaign} — {n} contacts, {n} touches via {tool}` |
| A/B test winner declared | `[{workspace}] A/B test: Variant {A/B} won — {metric} was {x}% higher` |
| Signal detected | `[{workspace}] Signal: {signal_type} for {company} — {detail}` |
| Re-engagement eligible | `[{workspace}] {n} contacts eligible for re-engagement from {campaign}` |

### Informational (optional — enable per workspace)

| Event | Message format |
|-------|---------------|
| Health check complete | `[{workspace}] Health check: {status} — reply rate {pct}%, bounce {pct}%` |
| Weekly pulse ready | `[{workspace}] Weekly pulse report ready for {campaign}` |
| List validated | `[{workspace}] List validated: {n} contacts, {n} shipped, {n} rejected` |

---

## How to send

When a notification trigger fires:

1. Check if `slack_enabled: true` in COLLABORATION.md
2. Determine the correct channel (workspace-specific or global)
3. Send via Slack MCP: `mcp__claude_ai_Slack__slack_send_message`
4. Format: plain text, no markdown formatting, keep under 200 characters
5. If Slack MCP is not available, display the notification inline with `!!` prefix

---

## User control

Users can configure notifications during onboarding or at any time:
- `slack_enabled: true/false` — master toggle
- `notify_critical: true` — positive replies, budget alerts, domain issues
- `notify_important: true` — ships, A/B tests, signals
- `notify_info: false` — health checks, reports, validations

Default: critical only.
