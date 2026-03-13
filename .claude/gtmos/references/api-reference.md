# API Reference — GTMOS Supported Tools

Quick reference for making API calls from Claude Code. Auth, base URLs, key endpoints, and request formats.

---

## Dangerous Endpoints — Comprehensive Reference

**HARD GATE — even in AUTO mode, always stop and confirm before calling any endpoint below.**

These endpoints have blast radius that exceeds expectation. Misuse can destroy live campaign data, burn credits, damage domain reputation, or trigger account bans irreversibly.

Last updated: 2026-03-13

**Rules (apply to ALL platforms):**
1. Never call a DELETE endpoint on a live campaign's leads without explicit user confirmation showing the exact blast radius
2. Always prefer status changes (pause, suppress, archive) over deletes
3. If an endpoint's behavior is undocumented or ambiguous, test with a single record in a non-production campaign first
4. Log all destructive API calls in `logs/decisions.md` with full context
5. Check remaining credits/balance BEFORE any bulk operation
6. Never exceed 80% of any documented rate limit — build in buffer
7. When in doubt, the safe alternative is always "do nothing and ask"

---

### 1. Instantly (api.instantly.ai/api/v2)

**Rate limit:** 6,000 requests/minute globally. Email endpoint: 20 requests/minute. Exceeding returns 429.

#### DELETE Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| `DELETE /api/v2/leads` with `delete_list: true` | **CATASTROPHIC.** Wipes ALL leads in the campaign, not just the specified lead. We lost 444 leads in a live campaign. The name says "delete lead" but with the flag it becomes "delete all leads." | YES | Change lead status to `completed` or use campaign settings to suppress. There is no safe single-lead delete endpoint. |
| `DELETE /api/v2/leads` (single lead) | Deletes one lead from campaign. Returns count of deleted leads — verify count=1 before trusting. | YES | Move lead to a suppression list instead. |
| `DELETE /api/v2/campaigns/{id}` | Permanently deletes campaign AND all associated data (leads, analytics, sequences, email history). | YES | Pause the campaign: `POST /campaigns/{id}/pause`. |
| `DELETE /api/v2/lead-lists/{id}` | Deletes the entire lead list. Requires scope `lead_lists:delete`. | YES | Remove leads from list individually or archive. |
| `DELETE /api/v2/accounts/{email}` | Removes a sending email account from the workspace. If account is mid-warmup or mid-campaign, all scheduled sends stop. | YES | Pause account instead. |

#### Unexpected Behaviors
- **Lead deletion is POST, not DELETE.** The delete leads endpoint uses POST method due to complex arguments, despite being a destructive operation. This breaks REST conventions and makes it easy to accidentally call from integration code.
- **`skip_if_in_workspace: true`** on lead creation silently skips duplicates — no error, no warning. You may think leads were added when they weren't.
- **Moving leads between campaigns** (`POST /leads/move`) removes them from the source campaign permanently.

#### Warmup & Domain Reputation Risks
- Instantly does NOT guarantee warmup will improve deliverability or prevent blacklisting.
- Hitting API rate limits during warmup does not directly damage reputation, but **pausing/resuming warmup erratically** via API can create inconsistent sending patterns that ESPs flag as suspicious.
- Never exceed 30 emails per single inbox per day — scale by adding inboxes, not increasing per-inbox volume.
- Disabling warmup via `POST /accounts/disable-warmup` on an account still sending campaigns exposes the domain to cold-sender reputation damage.
- If you hit the 20 req/min email endpoint limit, queued messages may fail silently — monitor delivery confirmations.

#### Account Ban Triggers
- Instantly reserves the right to suspend/terminate accounts for: abuse or misuse, adult/inappropriate content, violations of sending policy.
- Sending policy violations (excessive bounce rates, spam complaints) can trigger rate limitations on sending or temporary/permanent suspension.
- Using the API to circumvent sending limits or warmup schedules is grounds for termination.

---

### 2. Lemlist (api.lemlist.com)

**Rate limit:** 20 requests per 2 seconds (600/minute). Exceeding returns 429.

#### DELETE Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| `DELETE /api/campaigns/{id}/leads/{email}` | Removes lead from campaign AND triggers unsubscribe. Stats for the lead are permanently deleted. The lead remains in your Lemlist account but is unsubscribed. | PARTIAL — lead exists but stats are gone | `POST /leads/{leadId}/pause` to stop sequence without removing. |
| `DELETE /api/campaigns/{id}` | Permanently deletes: entire campaign structure (sequence steps, email content, LinkedIn actions), ALL campaign analytics (open rates, reply rates, clicks), campaign settings (sending schedule, delays, conditions). | YES — cannot be undone | Pause or Archive the campaign. Both preserve analytics and allow reactivation. |
| `DELETE /api/schedules/{scheduleId}` | Deletes a sending schedule. Active campaigns using this schedule will have no sending window. | YES | Disable/pause the schedule instead. |
| `DELETE /api/unsubscribes/{email}` | Removes an email from the unsubscribe list — meaning the lead can now receive emails again. This is dangerous in reverse: you may accidentally re-enable sending to someone who opted out. | YES — compliance risk | Never call this without explicit legal/compliance review. |

#### Unexpected Behaviors
- **Removing a lead from a campaign =/= unsubscribing globally.** The lead remains in your account and can be added to other campaigns. But the DELETE endpoint DOES trigger an unsubscribe event for that specific campaign.
- **Campaign deletion does NOT remove leads from your account.** Leads persist — only the campaign structure and analytics are destroyed.
- **Editing an active campaign** can reset lead positions in the sequence depending on which steps you modify. Changing step content is safe; adding/removing steps can re-trigger sends.

#### Credit/Billing Gotchas
- Lemlist is seat-based, not credit-based. No per-email charges. But sending limits are per-provider (Google: 500/day, Microsoft: 10,000/day).
- Exceeding provider limits gets your emails bounced and can damage your sender reputation — Lemlist does not enforce provider limits, you must track them yourself.

---

### 3. Smartlead (server.smartlead.ai/api/v1)

**Rate limit:** 60 requests per 60 seconds per API key. Campaign creation/lead upload: ~30 requests/minute. Exceeding returns 429 with Retry-After header.

#### DELETE Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| `DELETE /campaigns/{id}?api_key={key}` | Deletes the entire campaign and all associated data. | YES | Pause the campaign instead. |
| `DELETE /campaigns/{id}/leads?api_key={key}` (with lead_id) | Removes lead from campaign. **ALL consequences:** lead no longer tracked for replies in master inbox, all communications deleted per GDPR compliance, positive response data deleted from analytics, lead data removed from lead list tab. | YES — analytics and communications permanently lost | Pause the lead's sequence instead. Use `POST /campaigns/{id}/leads/{lead_id}/status` to change status. |
| `POST /leads/{email}/unsubscribe-all?api_key={key}` | Unsubscribes lead from ALL campaigns and prevents adding to ANY future campaigns. This is workspace-wide, not campaign-specific. | YES — global block | Only use for genuine opt-outs. For single-campaign removal, use the campaign-specific endpoint. |
| Remove email account from campaign | Removes sending account from active campaign. Scheduled sends from that account stop. | YES | Pause the account within the campaign instead. |

#### Unexpected Behaviors
- **Lead deletion wipes master inbox history.** Unlike other platforms where inbox history persists, Smartlead removes all communications with the lead from the master inbox. If you need a record, export first.
- **Analytics are retroactively altered.** Deleting a lead that replied positively reduces your campaign's reply count and positive response metrics. Your historical reports become inaccurate.
- **Webhook reliability.** Smartlead webhooks can miss events during downtime. Supplement with periodic polling every 15-30 minutes and run reconciliation jobs comparing Smartlead lead statuses against local records.

---

### 4. Apollo (api.apollo.io/api/v1)

**Rate limits:** Free plan: 50 requests/minute, 600/day. Paid plans: 200 requests/minute, 2,000/day (Basic/Pro). Bulk endpoints throttled to 50% of per-minute rate of their single-record counterparts.

#### DELETE/Destructive Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| Contact deletion (UI/API) | Removes contact from saved contacts, all lists, all tasks, and all active sequences. Takes up to 3 days to reappear as net-new. | PARTIAL — can manually re-add or re-import, but sequence history is lost | Mark as "Do Not Contact" instead. |
| `POST /people/match` (enrichment) | Burns 1 email credit + 1 export credit per call, even if the person was already enriched. No dedup. | N/A — credit loss | Cache results locally. Check cache before calling. |
| `POST /people/match` with `reveal_phone_number: true` | Burns 5 MOBILE credits per call on top of email credits. Mobile credits are expensive and limited. | N/A — credit loss | Only request phone when explicitly needed. Never batch with phone by default. |
| `POST /people/match` with `reveal_personal_emails: true` | Additional credits for personal email reveal. | N/A — credit loss | Only use when business email not found. |
| `POST /people/bulk_match` (max 10) | Same per-person credit cost but throttled to 50% of per-minute rate. If one person in batch fails, others may still be charged. | N/A — credit loss | Process in small batches. Verify all inputs before calling. |
| Sequence removal | Removing a contact from a sequence stops all scheduled emails. If you re-add a bounced contact to the same sequence, they restart from step 1 (not where they left off). | PARTIAL | Pause instead of remove. |

#### Credit-Burning Gotchas
- **Search is FREE** (`POST /mixed_people/api_search`) — no credits consumed. But results lack email/phone. Credits only burn on enrichment.
- **No dedup on enrichment.** Enriching the same person twice costs credits both times. Always check your local cache and Apollo's own contact database first.
- **Bulk enrichment has SAME per-person cost** as single enrichment. The only benefit is fewer API calls (rate limit efficiency), not cost savings.
- **Organization enrichment** (`POST /organizations/enrich`) costs 1 export credit per call. Bulk org enrichment max 10 per request.
- **Credits are pooled by type.** Email credits, mobile credits, and export credits are separate pools. Running out of one type blocks operations requiring that type even if others have balance.

#### Account Flag Triggers
- Exceeding rate limits returns 429 but does not immediately ban. However, persistent rate limit abuse may trigger API access review.
- Apollo monitors for scraping patterns. Rapidly paginating through search results to extract all contacts without enriching looks like scraping and can trigger account review.
- Using free tier to systematically search and export (via screen scraping or indirect extraction) violates ToS.

---

### 5. Instantly Warmup & Domain Reputation

This section covers API actions that can damage email deliverability and domain reputation.

#### Direct Damage Vectors

| Action | Risk | Mitigation |
|--------|------|------------|
| Disabling warmup on active sending accounts | Domain reverts to cold-sender status. ESPs start spam-filtering. | Never disable warmup unless you are permanently retiring the account. |
| Toggling warmup on/off via API | Creates erratic sending patterns ESPs flag as bot behavior. | Set warmup once and leave it. |
| Exceeding 30 emails/day per inbox | ESP rate limits hit, emails bounce, sender score drops. | Scale horizontally: add more inboxes across more domains. |
| Adding leads with bad emails to campaigns | Bounces spike, domain reputation tanks within days. | Always verify emails (ZeroBounce/MillionVerifier) before adding to campaigns. |
| Rapidly adding/removing email accounts | Infrastructure instability. Warmup progress reset. | Add accounts gradually (1-2 per week). |
| Sending from accounts that haven't completed warmup | Cold sending from fresh accounts triggers spam filters immediately. | Wait minimum 14-21 days warmup before campaign sends. |

#### Recovery Timeline
- Minor reputation damage (single bad batch): 2-4 weeks with clean sending
- Moderate damage (sustained bounces): 1-3 months
- Severe damage (blacklisted): 3-6+ months, may require new domain
- Instantly does NOT guarantee recovery — their warmup is best-effort

---

### 6. Attio (api.attio.com/v2)

**Rate limits:** 100 requests/second (read), 25 requests/second (write). Score-based limits on List records/entries with 10-second sliding window.

#### DELETE Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| `DELETE /objects/people/records/{id}` | Deletes person record for ALL workspace members. Linked notes and files are also deleted. References in tasks, notes, templates, and comments are removed. Data removed from reports. | YES — permanently removed from servers, no recovery | Add a "do-not-contact" attribute or move to an archived list. |
| `DELETE /objects/companies/records/{id}` | Same cascading deletion as people. All linked records, notes, files removed. | YES | Archive instead. |
| `DELETE /objects/deals/records/{id}` | Deletes deal and all associated data. | YES | Move to "Lost" or "Archived" deal stage. |
| `DELETE /objects/users/records/{id}` | Deletes user record. | YES | Deactivate instead. |
| `DELETE /objects/{custom}/records/{id}` | Deletes any custom object record with same cascading behavior. | YES | Add archival status attribute. |
| `DELETE /lists/{id}/entries/{entry_id}` | Removes entry from list. The underlying record still exists but loses list membership. | YES — list entry gone | Use a status field on the entry instead. |
| `DELETE /notes/{id}` | Permanently deletes a note. | YES | There is no soft-delete for notes. Export content first. |
| `DELETE /tasks/{id}` | Permanently deletes a task. | YES | Mark task as completed instead. |

#### Unexpected Behaviors
- **Archiving vs. deleting is a separate concept in Attio.** Archived records are hidden but recoverable. Deleted records are gone permanently. The API DELETE endpoint performs true deletion, not archival.
- **Cascading deletions are aggressive.** Deleting a person removes: all their notes, all their files, all references in tasks/comments, all list entries, all report data. This is more aggressive than most CRMs.
- **No bulk delete endpoint.** You must delete records one by one via API. This is actually a safety feature — but means cleanup scripts need careful rate limiting at 25 writes/second max.
- **Scopes required:** `object_configuration:read` AND `record_permission:read-write`. If your API key has write permission, it can delete. There is no separate "delete" scope.

---

### 7. HubSpot (api.hubapi.com)

**Rate limits:** Private apps: 100 requests/10 seconds. OAuth apps: 100 requests/10 seconds per account. Daily limit varies by plan. Search: 4 requests/second. Error responses must stay under 5% of daily total.

#### DELETE/Archive Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| `POST /crm/v3/objects/contacts/batch/archive` | Archives up to 100 contacts per call. Contacts go to recycle bin for 90 days, then permanently deleted. Associations with other objects are severed. | 90-day recovery window, then YES | Set lifecycle stage to "Other" or add to suppression list. |
| `POST /crm/v3/objects/deals/batch/archive` | Archives deals. Same 90-day recycle bin. | 90-day window | Move deal to "Lost" stage. |
| `POST /crm/v3/objects/companies/batch/archive` | Archives companies. Same 90-day recycle bin. | 90-day window | Add "archived" property. |
| `POST /crm/v3/objects/{objectType}/batch/archive` | Generic batch archive for ANY object type including custom objects. | 90-day window | Use status property changes. |
| `POST /crm/v3/objects/contacts/gdpr-delete` | **PERMANENT GDPR deletion.** Cannot be recovered. Removes contact and severs all associations. Associated objects (companies, deals) remain but lose the contact link. Notes/engagements lose contact association. | YES — immediate and permanent | Only use for genuine GDPR requests. Cannot be done in bulk — individual records only. |
| `DELETE /crm/v3/objects/{objectType}/{id}` | Single record archive. Same as batch but one at a time. | 90-day window | Property change. |
| `DELETE /crm/v3/associations/{fromType}/{toType}/batch/archive` | Removes associations between objects in bulk. The objects themselves remain but lose their links. | YES — associations permanently severed | There is no soft-remove for associations. Export association data before removing. |

#### Workflow Trigger Side Effects (CRITICAL)

**API writes trigger workflows just like UI changes.** There is NO built-in way to distinguish API-initiated changes from human changes.

| Action via API | Potential Side Effect |
|---------------|---------------------|
| Updating `lifecyclestage` property | Can trigger enrollment workflows, lead scoring recalculations, and notification emails to sales reps. |
| Updating `dealstage` property | Can trigger pipeline automation, Slack notifications, task creation, and handoff workflows. |
| Creating a new contact | Can trigger welcome sequences, lead routing, assignment workflows. |
| Changing `hs_lead_status` | Can trigger re-engagement sequences or removal workflows. |
| Setting `hs_target_account: true` | Can trigger ABM workflows, ad audience syncs, and Slack alerts. |
| Any property change | Can re-enroll contacts in property-change-triggered workflows. |

**Mitigation:** Create a flag property like `last_updated_via_api` and set it to `true` on every API write. Add a workflow condition that checks `last_updated_via_api = false` before executing. This is a workaround — HubSpot has no native API-write filter.

#### Billing Gotchas
- Free CRM: no per-record charges for basic operations.
- Marketing Hub: contacts become "marketing contacts" when enrolled in marketing tools. Marketing contacts cost $0.01-0.02/month each above your tier limit. API-created contacts that trigger marketing workflows become marketing contacts automatically.
- Exceeding API rate limits does not cause billing charges but can trigger temporary API suspension in severe cases.

---

### 8. Enrichment & Verification Tools

#### Icypeas (app.icypeas.com/api)

**Rate limit:** 30 requests/minute.

| Concern | Detail |
|---------|--------|
| **Credit charging** | Credits charged on SUCCESS only ("DEBITED" status). No charge if email not found. This is safer than most — you pay for results, not attempts. |
| **Bulk limit** | Max 5,000 items per bulk search. Exceeding silently truncates or errors. |
| **Credit expiry** | Credits never expire, even on downgrade/cancellation. Roll over monthly. |
| **Data retention** | Not publicly documented. Export and cache results locally. |
| **No DELETE endpoints** | Icypeas is read-only enrichment. No destructive API operations. Risk is purely credit-based. |

#### Prospeo (api.prospeo.io)

**Rate limit:** Not publicly documented per endpoint. Bulk operations capped at 50 per request.

| Concern | Detail |
|---------|--------|
| **Credit charging** | Generally charged on SUCCESS. 0 credits if no results. 0 credits for re-enriching same record (lifetime dedup). However: domain search charges 1 credit per 50 emails found regardless of quality. |
| **Mobile finder** | 10 credits per valid mobile number. No charge if none found. This is expensive — never enable mobile by default. |
| **Verification** | Email verification is BUILT INTO enrichment (email_status field). Separately calling verification on an already-enriched email is redundant credit waste. |
| **Bulk limits** | Max 50 per bulk request (enrich-person and enrich-company). |
| **Dedup** | Lifetime dedup on enrichment — re-enriching same LinkedIn URL or email costs 0 credits. This is a significant cost saver but means you can't force a re-enrichment of stale data. |
| **No DELETE endpoints** | Read-only enrichment API. No destructive operations. |

#### ZeroBounce (api.zerobounce.net/v2)

**Rate limit:** Batch validation: 5 requests/minute, max 200 emails per batch. Single validation: timeout 10-120 seconds.

| Concern | Detail |
|---------|--------|
| **Credit charging** | 1 credit per email validated. Credits consumed on attempt, NOT on result. "Unknown" results do NOT consume credits. But invalid, valid, catch-all, abuse, do_not_mail — all consume 1 credit. |
| **Batch gotcha** | Max 200 emails per batch, 5 batches per minute = max 1,000 emails/minute. Results take up to 70 seconds per email. |
| **Duplicate submissions** | Validating the same email twice costs credits both times. ZeroBounce has no dedup. Always check local cache first. |
| **No DELETE endpoints** | Read-only verification API. No destructive operations. |
| **Data retention** | Validation results available for download for a limited period. Cache results locally immediately. |

---

### 9. LinkedIn Ads API (api.linkedin.com/rest)

**Rate limits:** Varies by endpoint, resets midnight UTC daily. 300 req/min for `/dmpSegments/{id}/companies`, 600 req/min for `/dmpSegments/{id}/users`. 75% usage triggers email alert to developer admins.

#### DELETE Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| `DELETE /dmpSegments/{id}` | Permanently deletes the DMP segment (matched audience). Cannot delete if segment is used by a predictive audience — will error. | YES | Remove segment from campaign targeting. Keep the segment for future use. |
| Predictive audience deletion | Deletes predictive audience derived from parent DMP segment. | YES | Remove from campaign targeting instead. |

#### Unexpected Behaviors
- **Audience processing takes 24-48 hours.** Deleting a segment that's still in BUILDING state may leave orphaned data.
- **Minimum audience size: 300 matched members.** If your segment falls below this after removing members, it becomes unusable for targeting but still exists.
- **Partial batch validation.** When streaming companies/users, invalid elements in a batch are skipped but valid ones are processed. You may not realize some entries were rejected.
- **DMP Segment List Uploads API sunset:** The CSV upload endpoint (`POST /media/upload`) sunsets September 16, 2025. Use `POST /dmpSegments?action=generateUploadUrl` instead.

#### Account Ban Triggers
- Repeated advertising policy violations: ads disapproved, then account suspension, then permanent termination.
- Automated inauthentic activity detected via API (e.g., mass connection requests routed through marketing API).
- Using the Ads API for non-advertising purposes violates Terms of Use.
- Egregious content violations (CSAM, terrorism, extreme violence) result in immediate permanent ban from a single offense.
- EU TTPA regulation (effective October 2025): campaigns targeting EU must self-declare political ad status or face account restrictions.

---

### 10. Meta Ads API (graph.facebook.com)

**Rate limits:** Development accounts: 60-point max, 300-second block on exceed. Standard accounts: 9,000-point max, 60-second block. Custom audience quota: 5,000 points/hour (dev) to 700,000 points/hour (standard) + 40 points per active audience. Real-time mutation limit: 100 POST requests/second.

#### DELETE Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| `DELETE /{audience_id}` | Permanently deletes custom audience. All associated lookalike audiences become orphaned but may persist. | YES — cannot be recovered | Remove all users from audience or exclude from ad sets. Keep the shell. |
| `DELETE /{audience_id}/users` | Removes users from audience. Cannot remove from audiences with fewer than 1,000 contacts. | YES — users removed | Remove from targeting at ad set level instead. |
| `DELETE /{ad_set_id}` | Deletes ad set and stops all delivery. | YES | Pause ad set: `POST /{ad_set_id}?status=PAUSED`. |
| `DELETE /{campaign_id}` | Deletes entire campaign. | YES | Pause or archive the campaign. |
| `DELETE /{ad_id}` | Deletes individual ad. | YES | Pause the ad. |

#### Unexpected Behaviors
- **Custom audiences flagged for sensitive info are blocked silently.** Starting September 2025, audiences suggesting health conditions or financial status get error 471. Your ad set shows "with issues" but may not clearly explain why.
- **Legacy ASC/AAC API deprecation.** Meta is deprecating Advantage Shopping and Advantage App campaign APIs. Marketing API v25.0 (Q1 2026) removes ability to create new ASC/AAC campaigns entirely.
- **Polling counts against your quota.** Checking async job status for audience uploads consumes API points. Don't poll aggressively.
- **Max 500 custom audiences per ad account.** Creating audiences without cleanup eventually hits this hard limit. Deletion is permanent, so plan audience lifecycle carefully.
- **Reach reporting capped.** Age/gender breakdown limited to past 13 months. Queries beyond that window fail.
- **Housing/employment/credit restrictions.** Starting March 2025, customer list custom audiences for these campaign types must follow additional requirements or ads will be paused.

#### Account Restriction Triggers
- Unusual traffic patterns trigger temporary quota reduction below standard levels.
- Repeated policy violations (disapproved ads) escalate to account-level review.
- Development accounts are very easy to block: only 60 points before 300-second lockout.
- Budget changes via API that dramatically spike spend can trigger Meta's fraud detection and temporarily pause campaigns.

---

### 11. Google Ads API (googleads.googleapis.com)

**Rate limits:** Operations limits vary by endpoint. UserDataService: 10 operations and 100 user_identifiers per request. OfflineUserDataJob: 100,000 identifiers per addOperations request.

#### DELETE/Destructive Endpoints

| Endpoint | Blast Radius | Irreversible? | Safe Alternative |
|----------|-------------|---------------|-----------------|
| User list `REMOVE` operation | Removes individual users from a Customer Match list. Single identifier can remove a user even if multiple identifiers were used to add them. | YES | Remove from campaign targeting instead of list membership. |
| `remove_all: true` in OfflineUserDataJobOperation | **Removes ALL users from the list.** Must be the first operation in a job. Executes hourly, can run up to 24 hours. | YES | Remove targeted users individually. |
| User list `REMOVE` via mutate | Sets user list to CLOSED status (cannot accept new members) or OPEN. Cannot truly "delete" a user list — only close it. | PARTIAL — list persists but cannot be used | Close the list and create a new one if needed. |
| Campaign mutate (budget changes) | Changing campaign budget via API takes effect immediately. No confirmation step. A typo (e.g., $10000 instead of $100) results in immediate overspend. | NO — can adjust back, but money spent is gone | Always validate budget values programmatically before submission. |

#### Critical API Migration (April 1, 2026)
- **New developer tokens** can no longer adopt Customer Match via Google Ads API. Must use Data Manager API.
- **Existing tokens** that haven't uploaded Customer Match data since before October 4, 2025, will lose upload capability. Requests will fail with errors.
- **540-day membership cap** (since April 2025): users not refreshed within 540 days age out automatically. Lists shrink silently if not maintained.

#### Unexpected Behaviors
- **remove_all operations are batched hourly, not instant.** You may see stale data for up to 24 hours after a remove_all.
- **A user list can only be modified by the account that created it.** Cross-account list management is impossible.
- **Conversion tracking changes** (since February 2026): new developers cannot adopt session attributes or IP address in conversion imports without allowlisting.
- **Budget and bid changes are live immediately** with no confirmation or undo. This is the biggest financial risk in the Google Ads API.

---

### Quick Reference — Danger Summary Table

| Platform | Highest-Risk Endpoint | Worst Case | Recovery |
|----------|----------------------|-----------|----------|
| **Instantly** | `DELETE /leads` with `delete_list: true` | All campaign leads wiped | None — re-import required |
| **Lemlist** | `DELETE /campaigns/{id}` | Campaign + all analytics destroyed | None |
| **Smartlead** | `DELETE /campaigns/{id}/leads` | Lead + all inbox history + analytics deleted | None |
| **Apollo** | Bulk enrichment without cache check | Hundreds of credits burned | None — credits consumed |
| **Attio** | `DELETE /objects/people/records/{id}` | Person + all notes/files/references deleted | None |
| **HubSpot** | `POST /contacts/gdpr-delete` | Contact permanently erased, associations severed | None |
| **HubSpot** | Any property update via API | Unintended workflow triggers (emails, Slack alerts, stage changes) | Undo manually or add API-write flag |
| **Meta Ads** | `DELETE /{audience_id}` | Custom audience permanently lost | None — must rebuild |
| **Meta Ads** | Budget change via API | Immediate overspend | Money gone, adjust budget back |
| **LinkedIn Ads** | `DELETE /dmpSegments/{id}` | Matched audience permanently deleted | None — must rebuild |
| **Google Ads** | `remove_all: true` | All users removed from Customer Match list | None — must re-upload |
| **Google Ads** | Campaign budget mutate | Immediate overspend, no confirmation | Money gone |
| **ZeroBounce** | Batch validate without dedup | Credits burned on duplicate validations | None — credits consumed |

---

## Apollo

**Auth:** API key in header `X-Api-Key`
**Base URL:** `https://api.apollo.io/api/v1`

Apollo uses **three separate credit pools**: email credits, mobile credits, export credits.

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search people | POST | `/mixed_people/api_search` | FREE (no email/phone in results) |
| Enrich person | POST | `/people/match` | 1 email + 1 export credit |
| Bulk enrich people | POST | `/people/bulk_match` (max 10) | Same per person |
| Search orgs | POST | `/mixed_companies/search` | Costs credits |
| Enrich org | POST | `/organizations/enrich` | 1 export credit |
| Bulk enrich orgs | POST | `/organizations/bulk_enrich` (max 10) | Same per org |

**Enrich options:** Add `reveal_phone_number: true` for phone (5 mobile credits). Add `reveal_personal_emails: true` for personal emails.

**Search contacts example (FREE):**
```bash
curl -X POST "https://api.apollo.io/api/v1/mixed_people/api_search" \
  -H "X-Api-Key: $APOLLO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "person_titles": ["VP Sales", "Head of Sales"],
    "organization_num_employees_ranges": ["50,200"],
    "person_locations": ["United States"],
    "page": 1,
    "per_page": 25
  }'
```

**Enrich person example (1 email + 1 export credit):**
```bash
curl -X POST "https://api.apollo.io/api/v1/people/match" \
  -H "X-Api-Key: $APOLLO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "first_name": "John",
    "last_name": "Doe",
    "organization_name": "Acme Inc",
    "reveal_phone_number": false
  }'
```

**Enrich org example (1 export credit):**
```bash
curl -X POST "https://api.apollo.io/api/v1/organizations/enrich" \
  -H "X-Api-Key: $APOLLO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domain": "acme.com"
  }'
```

---

## Instantly

**Auth (V2):** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.instantly.ai/api/v2`

**Note:** V1 API is deprecated. Use V2 endpoints below.

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaigns` |
| Get campaign | GET | `/campaigns/{id}` |
| Add leads | POST | `/leads` |
| Get lead status | GET | `/leads?campaign_id={id}&email={email}` |
| **Analytics overview** | GET | `/campaigns/analytics/overview` |
| **Daily analytics** | GET | `/campaigns/{id}/analytics/daily` |
| List accounts | GET | `/email-accounts` |
| Pause campaign | POST | `/campaigns/{id}/pause` |

**Analytics overview (sync endpoint):**
```bash
curl "https://api.instantly.ai/api/v2/campaigns/analytics/overview?id={campaign_id}&start_date=2026-01-01&end_date=2026-03-07" \
  -H "Authorization: Bearer $INSTANTLY_API_KEY"
```

**Analytics response fields:**
- `emails_sent_count`, `contacted_count`, `completed_count`
- `open_count`, `open_count_unique`, `open_count_unique_by_step`
- `reply_count`, `reply_count_unique`, `reply_count_unique_by_step`
- `reply_count_automatic`, `reply_count_automatic_unique`
- `link_click_count`, `link_click_count_unique`
- `bounced_count`, `unsubscribed_count`
- `total_opportunities`, `total_interested`, `total_meeting_booked`, `total_meeting_completed`, `total_closed`

**Add leads example:**
```bash
curl -X POST "https://api.instantly.ai/api/v2/leads" \
  -H "Authorization: Bearer $INSTANTLY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "campaign_id": "campaign-uuid",
    "skip_if_in_workspace": true,
    "leads": [
      {
        "email": "john@acme.com",
        "first_name": "John",
        "last_name": "Doe",
        "company_name": "Acme Inc",
        "personalization": "Noticed your team just expanded the SDR team"
      }
    ]
  }'
```

---

## Lemlist

**Auth:** API key via Basic Auth (key as password, no username) or header `Authorization: Bearer {key}`
**Base URL:** `https://api.lemlist.com/api`

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaigns` |
| Get campaign | GET | `/campaigns/{id}` |
| **Get campaign stats** | GET | `/campaigns/{id}/stats` |
| **Get campaign reports** | GET | `/campaigns/reports` |
| **Export campaign** | POST | `/campaigns/{id}/export` |
| **Get export status** | GET | `/campaigns/{id}/export-status` |
| Add lead to campaign | POST | `/campaigns/{id}/leads/{email}` |
| Export leads | GET | `/campaigns/{id}/leads/export` |
| Mark interested | POST | `/leads/{leadId}/interested` |
| Mark not interested | POST | `/leads/{leadId}/not-interested` |
| Pause lead | POST | `/leads/{leadId}/pause` |
| Unsubscribe lead | DELETE | `/campaigns/{id}/leads/{email}` |
| **List activities** | GET | `/activities?type={type}&campaignId={id}` |

**Activity types:** `emailsSent`, `emailsOpened`, `emailsClicked`, `emailsReplied`, `emailsBounced`, `emailsUnsubscribed`, `emailsFailed`

**Get campaign stats (sync endpoint):**
```bash
curl "https://api.lemlist.com/api/campaigns/{campaign_id}/stats" \
  --user ":$LEMLIST_API_KEY"
```

**Stats response fields:**
- `sent`, `opened`, `clicked`, `replied`, `booked`, `interested`
- `bounced`, `unsubscribed`, `notInterested`
- `invitationAccepted` (LinkedIn)
- Open rate, click rate, reply rate, bounce rate (calculated)

**Add lead example:**
```bash
curl -X POST "https://api.lemlist.com/api/campaigns/{campaign_id}/leads/john@acme.com" \
  --user ":$LEMLIST_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "firstName": "John",
    "lastName": "Doe",
    "companyName": "Acme Inc",
    "linkedinUrl": "https://linkedin.com/in/johndoe",
    "customField1": "Noticed your team expanded"
  }'
```

---

## Smartlead

**Auth:** API key as query param `api_key`
**Base URL:** `https://server.smartlead.ai/api/v1`

| Action | Method | Endpoint |
|--------|--------|----------|
| List campaigns | GET | `/campaigns?api_key={key}` |
| Create campaign | POST | `/campaigns/create?api_key={key}` |
| Add leads | POST | `/campaigns/{id}/leads?api_key={key}` |
| **Top-level analytics** | GET | `/campaigns/{id}/analytics?api_key={key}` |
| **Lead-level stats** | GET | `/campaigns/{id}/statistics?api_key={key}&email_status={status}` |
| Get leads by status | GET | `/campaigns/{id}/leads?api_key={key}&status={status}` |

**email_status filter values:** `opened`, `clicked`, `replied`, `unsubscribed`, `bounced`

**Get campaign analytics (sync endpoint):**
```bash
curl "https://server.smartlead.ai/api/v1/campaigns/{campaign_id}/analytics?api_key=$SMARTLEAD_API_KEY"
```

**Analytics response fields:**
- `sent_count`, `unique_sent_count`
- `open_count`, `unique_open_count`
- `click_count`, `unique_click_count`
- `reply_count`, `bounce_count`, `unsubscribed_count`
- `total_count`, `drafted_count`
- `campaign_lead_stats` — interested, total, notStarted, inprogress, completed, blocked, paused

**Rate calculations:**
- Open rate: `unique_open_count / unique_sent_count × 100`
- Reply rate (plain text): `reply_count / unique_sent_count × 100`
- Reply rate (tracked): `reply_count / unique_open_count × 100`
- Positive reply rate: `campaign_lead_stats.interested / reply_count × 100`

**Lead-level stats example (get all who replied):**
```bash
curl "https://server.smartlead.ai/api/v1/campaigns/{id}/statistics?api_key=$SMARTLEAD_API_KEY&email_status=replied"
```

**Lead stats response fields:** `lead_name`, `lead_email`, `sequence_number`, `email_subject`, `sent_time`, `open_time`, `click_time`, `reply_time`, `open_count`, `click_count`, `is_unsubscribed`, `is_bounced`

**Add leads example:**
```bash
curl -X POST "https://server.smartlead.ai/api/v1/campaigns/{id}/leads?api_key=$SMARTLEAD_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "lead_list": [
      {
        "email": "john@acme.com",
        "first_name": "John",
        "last_name": "Doe",
        "company": "Acme Inc",
        "custom_fields": {
          "personalization": "Noticed your team expanded"
        }
      }
    ]
  }'
```

---

## Icypeas

**Auth:** API key + secret in headers `Authorization: {api_key}:{secret}`
**Base URL:** `https://app.icypeas.com/api`
**Rate limit:** 30 requests/minute

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Email finder | POST | `/email-search` | 1 (only on success) |
| Email verifier | POST | `/email-verification` | ~0.01 |
| Domain scan | POST | `/domain-scan` | 0.1 |
| Company scraper | GET | `/scrape/company?url=URL` | 0.5 |
| Profile scraper | POST | `/scrape` (max 50) | 1.5 |
| Find people (DB) | POST | `/leads-db/find-people/` | Low |
| Find companies (DB) | POST | `/leads-db/find-companies/` | 0.02/result |
| Bulk search | POST | `/bulk-search` (max 5,000) | Same as single |

**Email finder example:**
```bash
curl -X POST "https://app.icypeas.com/api/email-search" \
  -H "Authorization: $ICYPEAS_API_KEY:$ICYPEAS_SECRET" \
  -H "Content-Type: application/json" \
  -d '{
    "firstname": "John",
    "lastname": "Doe",
    "domainOrCompany": "acme.com"
  }'
```

**Company scraper example:**
```bash
curl "https://app.icypeas.com/api/scrape/company?url=https://linkedin.com/company/acme" \
  -H "Authorization: $ICYPEAS_API_KEY:$ICYPEAS_SECRET"
```

---

## Prospeo

**Auth:** API key in header `X-KEY`
**Base URL:** `https://api.prospeo.io`

**Note:** Old endpoints (`/email-finder`, `/linkedin-email-finder`, `/email-verifier`, `/domain-search`) were deprecated March 2025. Use the new endpoints below.

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Enrich person | POST | `/enrich-person` | 1 (10 with mobile) |
| Bulk enrich person | POST | `/bulk-enrich-person` (max 50) | Same |
| Enrich company | POST | `/enrich-company` | 1 |
| Bulk enrich company | POST | `/bulk-enrich-company` (max 50) | Same |
| Search person | POST | `/search-person` | 1 per 25 results |
| Search company | POST | `/search-company` | 1 per 25 results |

Credits: 0 if no results found. 0 for re-enriching same record (lifetime dedup). Verification is built into enrichment responses (`email_status` field).

**Enrich person example:**
```bash
curl -X POST "https://api.prospeo.io/enrich-person" \
  -H "X-KEY: $PROSPEO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "linkedin_url": "https://linkedin.com/in/johndoe",
    "only_verified_email": true
  }'
```

**Enrich company example:**
```bash
curl -X POST "https://api.prospeo.io/enrich-company" \
  -H "X-KEY: $PROSPEO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domain": "acme.com"
  }'
```

---

## Dropcontact

**Auth:** Token in header `X-Access-Token`
**Base URL:** `https://api.dropcontact.com`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Batch enrich | POST | `/batch` | 1 per success |
| Get results | GET | `/v1/enrich/all/{request-id}` | 0 |

No database — 100% algorithmic. GDPR compliant. Verification built-in.

**Batch enrich example:**
```bash
curl -X POST "https://api.dropcontact.com/batch" \
  -H "X-Access-Token: $DROPCONTACT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "data": [
      { "first_name": "John", "last_name": "Doe", "company": "Acme Inc" }
    ]
  }'
```

---

## FindyMail

**Auth:** API key
**Base URL:** `https://app.findymail.com`
**Docs:** `https://app.findymail.com/docs/`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Email finder | — | See docs | 1 |
| Phone finder | — | See docs | 10 |
| Email verifier | — | See docs | Included |
| Company info | — | See docs | — |

Guarantees <5% bounce rate. Credits never expire. Pay only on success.

---

## Crunchbase (FREE company search)

**Auth:** Free API key (register at crunchbase.com)
**Base URL:** `https://api.crunchbase.com/api/v4`
**Cost:** FREE (Basic API plan)

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search organizations | POST | `/searches/organizations` | FREE |
| Get organization | GET | `/entities/organizations/{id}` | FREE |
| Autocomplete | GET | `/autocompletes` | FREE |

**Rate limit:** 200 calls/minute

**Filters:** Categories, location, employee count, company type, domain, funding stage, founding date.

**Fields returned:** Company name, description, address, categories, founding date, employee count range, funding info, news, social profiles.

**Search example:**
```bash
curl -X POST "https://api.crunchbase.com/api/v4/searches/organizations" \
  -H "X-cb-user-key: $CRUNCHBASE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "field_ids": ["identifier", "short_description", "num_employees_enum", "categories"],
    "query": [
      { "type": "predicate", "field_id": "num_employees_enum", "operator_id": "includes", "values": ["c_00051_00100", "c_00101_00250"] }
    ],
    "limit": 25
  }'
```

---

## Diffbot Knowledge Graph (FREE tier)

**Auth:** API token
**Base URL:** `https://kg.diffbot.com/kg/v3`
**Cost:** FREE — 10,000 credits/month, no credit card required

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search entities | GET | `/dql?query=X` | 25 per export |
| Enhance (enrich) | GET | `/enhance?url=X` | 25 per entity |

**Search capabilities:** DQL (Diffbot Query Language) — search 10B+ entities by industry, location, revenue, employee count, tech stack.

**Fields returned:** Company profiles, employee data, financials, news, products, technologies used.

**Search example:**
```bash
curl "https://kg.diffbot.com/kg/v3/dql?token=$DIFFBOT_API_KEY&query=type%3AOrganization+industries%3A%22SaaS%22+nbEmployeesMin%3A50+nbEmployeesMax%3A200&size=25"
```

---

## Companies House (UK — FREE)

**Auth:** Free API key (register at developer.company-information.service.gov.uk)
**Base URL:** `https://api.company-information.service.gov.uk`
**Cost:** Completely free. No paid tiers.

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search companies | GET | `/search/companies?q=X` | FREE |
| Get company | GET | `/company/{number}` | FREE |
| Get officers | GET | `/company/{number}/officers` | FREE |
| Get filing history | GET | `/company/{number}/filing-history` | FREE |

**Rate limit:** 600 requests per 5 minutes

**Fields returned:** Company name, number, status, registered address, SIC codes, incorporation date, officers/directors, filing history, Persons with Significant Control.

**Coverage:** UK companies only (~5M+).

---

## HubSpot

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.hubapi.com`

| Action | Method | Endpoint |
|--------|--------|----------|
| Create contact | POST | `/crm/v3/objects/contacts` |
| Update contact | PATCH | `/crm/v3/objects/contacts/{id}` |
| Search contacts | POST | `/crm/v3/objects/contacts/search` |
| Create deal | POST | `/crm/v3/objects/deals` |
| Update deal | PATCH | `/crm/v3/objects/deals/{id}` |
| Get pipeline | GET | `/crm/v3/pipelines/deals` |
| Batch create | POST | `/crm/v3/objects/contacts/batch/create` |

**ABM — Mark company as target account:**
```bash
curl -X PATCH "https://api.hubapi.com/crm/v3/objects/companies/{companyId}" \
  -H "Authorization: Bearer $HUBSPOT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "properties": {
      "hs_target_account": "true",
      "hs_target_account_probability": "0.85"
    }
  }'
```

**ABM — Set buying role on contact:**
Buying role values: `BLOCKER`, `BUDGET_HOLDER`, `CHAMPION`, `DECISION_MAKER`, `END_USER`, `EXECUTIVE_SPONSOR`, `INFLUENCER`, `LEGAL_AND_COMPLIANCE`, `OTHER`
```bash
curl -X PATCH "https://api.hubapi.com/crm/v3/objects/contacts/{contactId}" \
  -H "Authorization: Bearer $HUBSPOT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "properties": {
      "hs_buying_role": "CHAMPION"
    }
  }'
```

**Create contact example:**
```bash
curl -X POST "https://api.hubapi.com/crm/v3/objects/contacts" \
  -H "Authorization: Bearer $HUBSPOT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "properties": {
      "email": "john@acme.com",
      "firstname": "John",
      "lastname": "Doe",
      "company": "Acme Inc",
      "jobtitle": "VP Sales"
    }
  }'
```

---

## Attio

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.attio.com/v2`

| Action | Method | Endpoint |
|--------|--------|----------|
| List records | POST | `/objects/{object}/records/query` |
| Create record | POST | `/objects/{object}/records` |
| Update record | PATCH | `/objects/{object}/records/{id}` |
| List objects | GET | `/objects` |
| Create note | POST | `/notes` |
| List lists | GET | `/lists` |
| Add to list | POST | `/lists/{id}/entries` |

**Create contact example:**
```bash
curl -X POST "https://api.attio.com/v2/objects/people/records" \
  -H "Authorization: Bearer $ATTIO_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "data": {
      "values": {
        "email_addresses": [{"email_address": "john@acme.com"}],
        "name": [{"first_name": "John", "last_name": "Doe"}]
      }
    }
  }'
```

---

## Apify

**Auth:** Bearer token or query param `token`
**Base URL:** `https://api.apify.com/v2`

| Action | Method | Endpoint |
|--------|--------|----------|
| Run actor | POST | `/acts/{actorId}/runs` |
| Get run | GET | `/actor-runs/{runId}` |
| Get dataset | GET | `/datasets/{datasetId}/items` |
| List actors | GET | `/acts` |

**Run LinkedIn scraper example:**
```bash
curl -X POST "https://api.apify.com/v2/acts/anchor~linkedin-profile-scraper/runs?token=$APIFY_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": ["https://linkedin.com/in/johndoe"],
    "proxy": { "useApifyProxy": true }
  }'
```

---

## ZeroBounce (email verification)

**Auth:** API key as query param `api_key`
**Base URL:** `https://api.zerobounce.net/v2`

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Validate email | GET | `/validate?api_key={key}&email={email}` | 1 |
| Batch validate | POST | `/validatebatch` | 1 per email |
| Get credits | GET | `/getcredits?api_key={key}` | 0 |

---

## Fireflies.ai (meeting transcripts)

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.fireflies.ai/graphql`
**API type:** GraphQL

| Action | Query/Mutation | Description |
|--------|---------------|-------------|
| List transcripts | `transcripts` | All transcripts with filters |
| Get transcript | `transcript(id)` | Full transcript with sentences, speakers, timestamps |
| Get user | `user` | Account info and remaining credits |

**List transcripts example:**
```bash
curl -X POST "https://api.fireflies.ai/graphql" \
  -H "Authorization: Bearer $FIREFLIES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ transcripts { id title date duration organizer_email participants sentences { text speaker_name start_time end_time } summary { overview shorthand_bullet } } }"
  }'
```

**Get single transcript with full detail:**
```bash
curl -X POST "https://api.fireflies.ai/graphql" \
  -H "Authorization: Bearer $FIREFLIES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "query Transcript($id: String!) { transcript(id: $id) { id title date duration organizer_email participants sentences { text speaker_name start_time end_time } summary { overview shorthand_bullet action_items } } }",
    "variables": { "id": "transcript-id-here" }
  }'
```

**Key fields per transcript:**
- `title` — meeting title
- `date` — meeting date
- `duration` — length in minutes
- `participants` — list of attendees (names/emails)
- `organizer_email` — who scheduled the meeting
- `sentences` — full transcript broken into speaker-attributed segments
- `summary.overview` — AI-generated summary
- `summary.shorthand_bullet` — bullet point summary
- `summary.action_items` — extracted action items

**Filtering transcripts (by date range):**
```bash
curl -X POST "https://api.fireflies.ai/graphql" \
  -H "Authorization: Bearer $FIREFLIES_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ transcripts(date_from: \"2025-01-01\", date_to: \"2026-03-07\", limit: 50) { id title date participants sentences { text speaker_name } summary { overview } } }"
  }'
```

---

## Ocean.io (lookalike company search)

**Auth:** `x-api-token` header or `apiToken` query param
**Base URL:** `https://api.ocean.io/v2`
**Cost:** 0.2 credits/search result, 1 credit/enrich (with domain), 5 credits/enrich (without domain)

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Lookalike company search | POST | `/search/companies` | 0.2 per result |
| Lookalike people search | POST | `/search/people` | 0.2 per result |
| Enrich company | POST | `/enrich/company` | 1 (with domain) / 5 (without) |
| Enrich person | POST | `/enrich/person` | Credits vary |
| Reveal emails | POST | `/reveal/emails` | Credits vary |
| Reveal phones | POST | `/reveal/phones` | Credits vary |
| Credit balance | GET | `/credits` | 0 |

**Search parameters:** Feed customer domains for lookalike, or filter by industry, company size, location, technologies, keywords, revenue range, headcount growth.

**Fields returned per company:** name, domain, description, locations, employeeCount (Ocean + LinkedIn), departmentSizes, headcountGrowth, revenue, yearFounded, fundingRound, industries, technologies, technologyCategories, webTraffic (visits, pageViews, bounceRate), emails, phones, social media URLs, logo.

**Lookalike search example:**
```bash
curl -X POST "https://api.ocean.io/v2/search/companies" \
  -H "x-api-token: $OCEAN_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domains": ["bestcustomer1.com", "bestcustomer2.com"],
    "filters": {
      "companySize": ["11-50", "51-200"],
      "countries": ["US", "UK"]
    },
    "limit": 25
  }'
```

---

## DiscoLike (AI lookalike discovery)

**Auth:** `x-discolike-key` header
**Base URL:** `https://api.discolike.com/v1`
**Cost:** $0.10/API call + $2/1K records

| Action | Method | Endpoint | Cost |
|--------|--------|----------|------|
| Discover entities | POST | `/discover` | $0.10/call |
| Bulk match | POST | `/bulk-match` | $2/1K records |
| Extract from URL | POST | `/extract` | $0.10/call |
| Domain metrics | GET | `/metrics/{domain}` | $0.10/call |
| Subsidiaries | GET | `/subsidiaries/{domain}` | $0.10/call |
| Count keywords | POST | `/count` | $0.10/call |

**How it works:** Analyzes 60M+ SSL-verified domains across 45 languages. Uses LLM-powered semantic matching against actual website content — finds companies traditional databases miss.

**Discovery example:**
```bash
curl -X POST "https://api.discolike.com/v1/discover" \
  -H "x-discolike-key: $DISCOLIKE_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "domains": ["bestcustomer1.com", "bestcustomer2.com"],
    "query": "B2B SaaS companies selling sales enablement tools"
  }'
```

---

## Exa (AI-powered web search)

**Auth:** API key in header `x-api-key`
**Base URL:** `https://api.exa.ai`
**Cost:** 1,000 free requests/month. Paid: $7/1K searches (1-10 results), $1/1K content pages

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Search | POST | `/search` | 1 search |
| Get contents | POST | `/contents` | 1 per page |
| Find similar | POST | `/findSimilar` | 1 search |
| Answer | POST | `/answer` | 1 answer |

**MCP tools (preferred — use these directly in Claude Code):**
- `web_search_exa` — semantic web search, returns clean content
- `company_research_exa` — deep company research (crawls company website)
- `deep_researcher_start` — starts AI research agent, returns task ID
- `deep_researcher_check` — check status / get research report
- `people_search_exa` — find people and professional profiles (enable via config)
- `web_search_advanced_exa` — advanced search with domain/date filters (enable via config)
- `crawling_exa` — get full content from a known URL (enable via config)

**Search example:**
```bash
curl -X POST "https://api.exa.ai/search" \
  -H "x-api-key: $EXA_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "B2B SaaS companies that raised Series A in 2025",
    "type": "neural",
    "numResults": 10,
    "contents": { "text": true }
  }'
```

**GTMOS use cases:**
- Market research: find companies matching ICP semantically (not just keyword match)
- Competitor intelligence: find reviews, comparisons, "alternatives to X" content
- Signal discovery: find news about funding, launches, expansions in target market
- Content research: find pain language, terminology, and framing buyers use

---

## Firecrawl (web scraping & extraction)

**Auth:** Bearer token in header `Authorization: Bearer {key}`
**Base URL:** `https://api.firecrawl.dev/v1`
**Cost:** 500 free credits (one-time). Hobby $16/mo (3K credits), Standard $83/mo (100K credits)

| Action | Method | Endpoint | Credits |
|--------|--------|----------|---------|
| Scrape page | POST | `/scrape` | 1 per page |
| Crawl site | POST | `/crawl` | 1 per page |
| Map site URLs | POST | `/map` | 1 |
| Extract structured data | POST | `/extract` | Token-based (15 tokens/credit) |
| Search web | POST | `/search` | 2 per 10 results |

**MCP tools (preferred — use these directly in Claude Code):**
- `FIRECRAWL_SCRAPE_EXTRACT_DATA_LLM` — scrape a URL, returns clean markdown
- `FIRECRAWL_EXTRACT` — extract structured data using prompt/schema
- `FIRECRAWL_CRAWL_URLS` — crawl entire site with filters
- `FIRECRAWL_CRAWL_JOB_STATUS` — check crawl progress

**Scrape example:**
```bash
curl -X POST "https://api.firecrawl.dev/v1/scrape" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://competitor.com/pricing",
    "formats": ["markdown"]
  }'
```

**Extract example (structured data without knowing exact URL):**
```bash
curl -X POST "https://api.firecrawl.dev/v1/extract" \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": ["https://competitor.com/*"],
    "prompt": "Extract pricing tiers, features per tier, and target audience",
    "enableWebSearch": true
  }'
```

**GTMOS use cases:**
- Scrape competitor pricing, features, and positioning pages
- Extract team/about pages for decision-maker intel
- Crawl job boards for hiring signals
- Extract structured company data from websites Exa finds
- Build prospect lists from directory pages, award lists, conference speaker lists

---

## LinkedIn Ads (Matched Audiences)

**Auth:** OAuth2 Bearer token
**Base URL:** `https://api.linkedin.com/rest`
**Access:** Requires separate Audiences API approval (not included in Marketing API). Apply via [interest form](https://forms.office.com/r/eiffXL3iUW).
**Permissions:** `rw_dmp_segments` (streaming), `rw_ads` (CSV upload)

| Action | Method | Endpoint | Notes |
|--------|--------|----------|-------|
| Create DMP Segment | POST | `/dmpSegments` | type: COMPANY or USER |
| Stream companies | POST | `/dmpSegments/{id}/companies` | Up to 5,000/batch |
| Stream users | POST | `/dmpSegments/{id}/users` | Up to 5,000/batch |
| Get segment status | GET | `/dmpSegments/{id}` | BUILDING → READY |
| Find segments | GET | `/dmpSegments?q=account&account={urn}` | List all segments |
| Delete segment | DELETE | `/dmpSegments/{id}` | Cannot delete if used by predictive audience |

**Required headers (all requests):**
```
Authorization: Bearer $LINKEDIN_ADS_TOKEN
Content-Type: application/json
Linkedin-Version: 202602
X-Restli-Protocol-Version: 2.0.0
```

**Create company segment + stream example:**
```bash
# Step 1: Create segment
curl -X POST "https://api.linkedin.com/rest/dmpSegments" \
  -H "Authorization: Bearer $LINKEDIN_ADS_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Linkedin-Version: 202602" \
  -H "X-Restli-Protocol-Version: 2.0.0" \
  -d '{
    "name": "GTMOS ABM targets",
    "sourcePlatform": "GTMOS",
    "account": "urn:li:sponsoredAccount:516848833",
    "type": "COMPANY",
    "destinations": [{ "destination": "LINKEDIN" }]
  }'

# Wait 5 seconds

# Step 2: Batch stream companies
curl -X POST "https://api.linkedin.com/rest/dmpSegments/{segmentId}/companies" \
  -H "X-RestLi-Method: BATCH_CREATE" \
  -H "Authorization: Bearer $LINKEDIN_ADS_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Linkedin-Version: 202602" \
  -H "X-Restli-Protocol-Version: 2.0.0" \
  -d '{
    "elements": [
      { "action": "ADD", "companyName": "Acme Inc", "companyWebsiteDomain": "acme.com", "country": "US" },
      { "action": "ADD", "companyName": "Globex Corp", "companyWebsiteDomain": "globex.com", "country": "US" }
    ]
  }'
```

**Company matching fields:** companyName, companyWebsiteDomain, companyEmailDomain, organizationUrn, companyPageUrl, stockSymbol, industries (max 3), city, state, country, postalCode. Must provide at least one of: name, URN, domain, or page URL.

**User matching:** SHA256 or SHA512 hashed emails. Lowercase + trim before hashing.

**Rate limits:** 300 req/min (/companies), 600 req/min (/users). Initial processing: up to 48 hours. Updates: up to 24 hours. Min audience: 300 matched members.

---

## Meta Ads (Custom Audiences)

**Auth:** Access token (OAuth2 or system user token)
**Base URL:** `https://graph.facebook.com/v22.0`
**Permissions:** `ads_management` scope

| Action | Method | Endpoint | Notes |
|--------|--------|----------|-------|
| Create custom audience | POST | `/{ad_account_id}/customaudiences` | Returns audience ID |
| Add users | POST | `/{audience_id}/users` | Batch up to 10,000 rows |
| Remove users | DELETE | `/{audience_id}/users` | Same format as add |
| Get audience | GET | `/{audience_id}` | Status and size |
| Delete audience | DELETE | `/{audience_id}` | Permanent |

**Create audience + upload contacts example:**
```bash
# Step 1: Create blank audience
curl -X POST "https://graph.facebook.com/v22.0/act_123456789/customaudiences" \
  -F 'name=GTMOS ABM targets' \
  -F 'subtype=CUSTOM' \
  -F 'description=ABM target accounts' \
  -F 'customer_file_source=USER_PROVIDED_ONLY' \
  -F "access_token=$META_ACCESS_TOKEN"

# Step 2: Upload hashed contacts
curl -X POST "https://graph.facebook.com/v22.0/{audience_id}/users" \
  -H "Content-Type: application/json" \
  -d '{
    "payload": {
      "schema": ["EMAIL", "FN", "LN", "COUNTRY"],
      "data": [
        ["sha256_hash_of_email", "sha256_hash_of_firstname", "sha256_hash_of_lastname", "sha256_hash_of_us"],
        ["sha256_hash_of_email2", "sha256_hash_of_fn2", "sha256_hash_of_ln2", "sha256_hash_of_uk"]
      ]
    },
    "access_token": "'$META_ACCESS_TOKEN'"
  }'
```

**Schema fields:** EMAIL, PHONE, FN, LN, GEN, DOB, CT (city), ST (state), ZIP, COUNTRY, MADID, EXTERN_ID

**Hashing rules:** SHA256. Lowercase + trim before hashing. Phone: digits only with country code (e.g., 12025551234). Do NOT hash country codes — use ISO 2-letter lowercase.

**Limits:** Max 500 custom audiences per ad account. 10,000 rows per upload request. Min audience: ~100 matched users.

---

## Google Ads (Customer Match)

**Auth:** OAuth2 Bearer token + developer token
**Base URL:** `https://googleads.googleapis.com/v18`
**Permissions:** Customer Match access on developer token

| Action | Method | Endpoint | Notes |
|--------|--------|----------|-------|
| Create user list | POST | `/customers/{id}/userLists:mutate` | crmBasedUserList type |
| Create upload job | POST | `/customers/{id}/offlineUserDataJobs:create` | CUSTOMER_MATCH_USER_LIST |
| Add data to job | POST | `/{jobResourceName}:addOperations` | Up to 100,000 identifiers |
| Run job | POST | `/{jobResourceName}:run` | Processes async |
| Get job status | GET | `/{jobResourceName}` | Check completion |

**Required headers:**
```
Authorization: Bearer $GOOGLE_ADS_TOKEN
developer-token: $GOOGLE_ADS_DEVELOPER_TOKEN
Content-Type: application/json
```

**User identifiers:** hashedEmail, hashedPhoneNumber, addressInfo (hashedFirstName, hashedLastName, countryCode, postalCode). SHA256 hashed, lowercase + trimmed.

**Important:** Starting April 1, 2026, new developer tokens without prior Customer Match usage must use the Data Manager API instead.

**Limits:** 100,000 identifiers per addOperations request. 15 operations per userLists:mutate. Min audience: 1,000 matched users.

---

## Notes

- Always check remaining credits/balance before batch operations
- Rate limits vary by plan — add delays between requests if hitting limits
- Store API responses in campaign `sync/` folder for reference
- Log every write operation in COSTS.md
- For tools not listed here, check the tool's API documentation — most follow REST patterns with key-based auth
