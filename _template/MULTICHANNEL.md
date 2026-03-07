# Multi-Channel Orchestration — [Workspace Name]

## Channel priority
Define the primary and secondary channels for this workspace.

| Channel | Role | Tool | Status |
|---------|------|------|--------|
| Email | primary / secondary / inactive | Lemlist / Instantly / Smartlead | |
| LinkedIn | primary / secondary / inactive | Crispy | |

---

## Cross-channel sequencing

### Timing rules
- **Email then LinkedIn:** Wait 2-3 days after email touch before LinkedIn connect request
- **LinkedIn then email:** Wait 1-2 days after connection accepted before first email
- **Never:** Send email and LinkedIn message on the same day to the same contact
- **Signal override:** If a time-sensitive signal fires, use the primary channel regardless of sequence position

### Sequence pattern (multi-channel example)
| Day | Channel | Touch | Notes |
|-----|---------|-------|-------|
| 1 | Email | Touch 1 — cold open | |
| 4 | Email | Touch 2 — follow-up | |
| 6 | LinkedIn | Connection request + note | Short, reference email angle |
| 9 | Email | Touch 3 — value add | |
| 12 | LinkedIn | Follow-up message (if connected) | Only if connection accepted |
| 15 | Email | Touch 4 — breakup | |

### Stop rules
These override the sequence — stop all channels immediately when:
- Contact replies on ANY channel (positive, negative, or objection)
- Contact unsubscribes or requests removal on any channel
- Contact marks as spam
- Contact bounces (email) or profile not found (LinkedIn)
- Deal stage changes in CRM (meeting booked, closed-won, closed-lost)

### Channel-specific behaviour
**If LinkedIn reply received:**
1. Pause email sequence immediately
2. Continue conversation on LinkedIn
3. Move to email only if contact suggests it
4. Log in campaign decisions.md

**If email reply received:**
1. Pause LinkedIn sequence
2. Continue on email
3. Log in campaign decisions.md

---

## LinkedIn-specific rules
If you're using Crispy for LinkedIn, it connects directly to Claude Code as an MCP server — meaning LinkedIn actions (connections, messages, Sales Navigator searches) can be orchestrated without leaving the terminal.

**Crispy capabilities:**
- Automated connection requests with personalized notes
- Automated messaging sequences
- Profile viewing automation
- **LinkedIn Sales Navigator integration** — search, filter, save leads, extract lists directly
- MCP server architecture — Claude Code controls all actions via tool calls

**Default LinkedIn limits:**
- Max 25 connection requests per day
- Max 50 profile views per day
- Max 100 messages per day (to existing connections)
- Advanced users can adjust these limits in the Crispy dashboard

**Best practices:**
- Personalize connection notes — no generic "I'd like to connect"
- Connection note max: 300 characters
- Do not pitch in the connection request — earn the connection first
- Wait for acceptance before messaging

---

## Channel performance tracking
Track per-channel to understand which channel performs best for this ICP.

| Channel | Contacts reached | Response rate | Positive response rate | Meetings from channel |
|---------|-----------------|---------------|----------------------|----------------------|
| Email | | | | |
| LinkedIn | | | | |
| Combined | | | | |
