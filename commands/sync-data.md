# Command: Sync Data

## Trigger
"Sync data for [campaign]" or "Pull latest data from all tools"

## Steps

### 1. Check connected tools
- Load TOOLS.md — identify which tools are active and in bidirectional or read mode
- Check .env for API keys — skip tools with missing keys
- Display sync plan:

```
  ┌─ SYNC PLAN ─────────────────────────────────┐
  │                                               │
  │  Campaign: {name}                             │
  │  Last sync: {date} or "never"                 │
  │                                               │
  │  Active tools:                                │
  │    [x] Instantly      (analytics + leads)     │
  │    [x] Attio          (pipeline + deals)      │
  │    [x] Crispy         (LinkedIn metrics)      │
  │    [ ] Lemlist         (no API key)            │
  │    [ ] Smartlead       (inactive)              │
  │    [ ] HubSpot         (inactive)              │
  │                                               │
  └───────────────────────────────────────────────┘
  >> Sync now? (y/n)
```

### 2. Pull data from each active tool

Only call tools that are active AND have API keys. Skip everything else silently.

---

#### Instantly (sending tool)

**Analytics overview:**
```
GET https://api.instantly.ai/api/v2/campaigns/analytics/overview
  ?id={campaign_id}&start_date={campaign_start}&end_date={today}
Header: Authorization: Bearer $INSTANTLY_API_KEY
```

**Fields to capture:**
- `emails_sent_count`, `contacted_count`, `completed_count`
- `open_count`, `open_count_unique`
- `reply_count`, `reply_count_unique`
- `bounced_count`, `unsubscribed_count`
- `link_click_count`, `link_click_count_unique`
- `total_opportunities`, `total_interested`, `total_meeting_booked`, `total_meeting_completed`, `total_closed`
- Per-step breakdown via `open_count_unique_by_step`, `reply_count_unique_by_step`

**Calculate rates:**
- Open rate: `open_count_unique / emails_sent_count × 100`
- Reply rate: `reply_count_unique / emails_sent_count × 100`
- Bounce rate: `bounced_count / emails_sent_count × 100`
- Unsubscribe rate: `unsubscribed_count / emails_sent_count × 100`

Save to: `sync/instantly/{YYYY-MM-DD-HH}.json`

---

#### Lemlist (sending tool)

**Campaign stats:**
```
GET https://api.lemlist.com/api/campaigns/{campaign_id}/stats
Auth: Basic (empty username, API key as password)
```

**Fields to capture:**
- `sent`, `opened`, `clicked`, `replied`, `booked`, `interested`
- `bounced`, `unsubscribed`, `notInterested`
- `invitationAccepted` (LinkedIn touches)

**Reply content (last 50):**
```
GET https://api.lemlist.com/api/activities?type=emailsReplied&campaignId={campaign_id}
```

**Calculate rates:**
- Open rate: `opened / sent × 100`
- Reply rate: `replied / sent × 100`
- Bounce rate: `bounced / sent × 100`
- Click rate: `clicked / sent × 100`

Save to: `sync/lemlist/{YYYY-MM-DD-HH}.json`

---

#### Smartlead (sending tool)

**Top-level analytics:**
```
GET https://server.smartlead.ai/api/v1/campaigns/{campaign_id}/analytics
  ?api_key=$SMARTLEAD_API_KEY
```

**Fields to capture:**
- `sent_count`, `unique_sent_count`
- `open_count`, `unique_open_count`
- `click_count`, `unique_click_count`
- `reply_count`, `bounce_count`, `unsubscribed_count`
- `campaign_lead_stats` — interested, total, notStarted, inprogress, completed, blocked, paused

**Lead-level detail (replied leads):**
```
GET https://server.smartlead.ai/api/v1/campaigns/{campaign_id}/statistics
  ?api_key=$SMARTLEAD_API_KEY&email_status=replied
```

Returns per lead: `lead_name`, `lead_email`, `sequence_number`, `reply_time`, `open_count`

**Calculate rates:**
- Open rate: `unique_open_count / unique_sent_count × 100`
- Reply rate: `reply_count / unique_sent_count × 100` (plain text) or `reply_count / unique_open_count × 100` (tracked)
- Bounce rate: `bounce_count / unique_sent_count × 100`
- Positive reply rate: `campaign_lead_stats.interested / reply_count × 100`

Save to: `sync/smartlead/{YYYY-MM-DD-HH}.json`

---

#### Crispy / LinkedIn (via MCP)

**Metrics to capture (via Crispy MCP tools):**
- Connection requests sent vs accepted → acceptance rate
- InMails sent vs replied → InMail reply rate
- Messages sent vs replied → message reply rate
- Profile views sent

**No direct analytics endpoint** — calculate from activity history:
- Pull recent connection request statuses
- Pull recent message statuses (sent, read, replied)
- Calculate rates from counts

Save to: `sync/crispy/{YYYY-MM-DD-HH}.json`

---

#### Attio (CRM)

**Pipeline data:**
```
POST https://api.attio.com/v2/objects/deals/records/query
Header: Authorization: Bearer $ATTIO_API_KEY
Body: { "filter": { "list_id": "{campaign_list_id}" } }
```

**Contact status updates:**
```
POST https://api.attio.com/v2/objects/people/records/query
Header: Authorization: Bearer $ATTIO_API_KEY
Body: { "filter": { "list_id": "{campaign_list_id}" } }
```

**Fields to capture:**
- Deal stage distribution (contacted, interested, meeting booked, proposal, won, lost)
- Contacts by status (contacted, replied, interested, not interested, meeting booked)
- New status changes since last sync
- Won/lost/disqualified counts
- Revenue attribution per deal

Save to: `sync/attio/{YYYY-MM-DD-HH}.json`

---

#### HubSpot (CRM)

**Deal pipeline:**
```
POST https://api.hubapi.com/crm/v3/objects/deals/search
Header: Authorization: Bearer $HUBSPOT_API_KEY
Body: { "filterGroups": [{ "filters": [{ "propertyName": "campaign_tag", "operator": "EQ", "value": "{campaign_name}" }] }] }
```

**Contact updates:**
```
POST https://api.hubapi.com/crm/v3/objects/contacts/search
Header: Authorization: Bearer $HUBSPOT_API_KEY
Body: { "filterGroups": [{ "filters": [{ "propertyName": "campaign_tag", "operator": "EQ", "value": "{campaign_name}" }] }] }
```

**Fields to capture:**
- Deal stage distribution, deal amounts
- Contact lifecycle stage changes
- Marketing engagement data (if Marketing Hub active)
- New replies or status changes since last sync

Save to: `sync/hubspot/{YYYY-MM-DD-HH}.json`

---

#### Apollo (enrichment status)

**Only sync if contacts were enriched via Apollo:**
```
POST https://api.apollo.io/api/v1/people/bulk_match
Header: X-Api-Key: $APOLLO_API_KEY
Body: { "details": [{ "email": "..." }] }  (max 10 per call)
```

**Fields to capture:**
- Email status updates (verified → invalid, bounced)
- Job changes (new title, new company)
- Company changes

Save to: `sync/apollo/{YYYY-MM-DD-HH}.json`

---

### 3. Display sync summary

```
  ── SYNC COMPLETE ──────────────────────────────
  Instantly:    ✓  287 sent, 68% open, 4.2% reply, 1.0% bounce
  Attio:        ✓  12 interested, 4 meetings, 1 won
  Crispy:       ✓  45 connections, 78% accepted, 12% replied
  Apollo:       ✓  3 job changes detected
  Lemlist:      ○  skipped (no API key)
  Smartlead:    ○  skipped (inactive)
  HubSpot:      ○  skipped (inactive)
  ─────────────────────────────────────────────────
  Synced at: {timestamp}
  Data saved to: sync/{tool}/{timestamp}.json
```

### 4. Post-sync actions
- Flag any tool that returned an error or empty response
- Flag any rate that crosses a threshold:
  - Bounce rate > 5% → red flag
  - Open rate < 30% → amber flag
  - Reply rate < 1% → amber flag
  - Unsubscribe rate > 2% → red flag
- Do NOT analyse yet — sync is a data pull only
- Suggest: `/gtm:health {workspace} {campaign}` to analyse

### 5. Save sync metadata
Update a sync log at the campaign level so we know when the last sync happened:
- Campaign: {name}
- Last sync: {timestamp}
- Tools synced: {list}
- Next suggested sync: {timestamp + interval based on campaign stage}
