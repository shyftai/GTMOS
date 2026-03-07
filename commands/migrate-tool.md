# Command: Tool Migration Playbook

## Trigger
"Migrate from [tool A] to [tool B]" or "Switch sending tool"

## Supported migrations

### Email sequencing: Instantly ↔ Lemlist ↔ Smartlead

**From Instantly to Lemlist (or reverse):**
1. Export all contacts from active campaigns in the source tool
   - Instantly: GET `/api/v1/lead/list?api_key={key}&campaign_id={id}`
   - Lemlist: GET `/api/campaigns/{id}/export`
2. Map columns to GTM:OS standard format (csv-format.md)
3. Note which contacts are mid-sequence — record their current touch position
4. In the new tool:
   - Create the campaign with the same sequence
   - Import contacts
   - Set each contact to start from their current touch position (if the tool supports it)
   - If not: start from the next touch only for contacts who haven't received all touches
5. Update campaign.config.md with new tool and campaign ID
6. Update TOOLS.md with new tool status
7. Pause the old campaign (don't delete — keep for reference)
8. Verify: send a test to a seed address from the new tool

**Data to preserve:**
- Contact list with current status (sent, opened, replied, bounced)
- Reply history (copy to campaign replies/ folder)
- Performance metrics (copy to performance/results.md before switching)
- Active A/B test data

**Risks:**
- Contacts may receive a duplicate touch if touch position isn't mapped correctly
- Warmup reputation doesn't transfer — if using new inboxes, warmup first
- Tracking links change — old links in sent emails will still work but track in the old tool

### CRM: Attio ↔ HubSpot ↔ Salesforce ↔ Pipedrive

**General CRM migration:**
1. Export all contacts and deals from the source CRM
2. Map fields to GTM:OS standard columns + CRM-specific fields
3. Import to new CRM
4. Map pipeline stages — ensure stage names match PIPELINE.md
5. Update PIPELINE.md CRM sync rules section
6. Update TOOLS.md
7. Update .env with new API key
8. Run `/gtm:pipeline` to verify data looks correct

**Data to preserve:**
- All contacts with campaign attribution
- Deal stages and history
- Notes and activity history
- Custom fields (campaign_source, lead_score, etc.)

### Enrichment: Apollo ↔ Icypeas ↔ Prospeo

**Switching enrichment tool:**
1. No data migration needed — enrichment is per-lookup
2. Update TOOLS.md: set old tool to inactive, new tool to active
3. Update .env with new API key
4. Update COSTS.md pricing table with new per-unit cost
5. Verify: run a test enrichment on 5 contacts

**Note:** You can use multiple enrichment tools simultaneously — waterfall enrichment (try tool A, if no result try tool B) often gives better coverage.

### LinkedIn: switching to Crispy

**From PhantomBuster or manual LinkedIn:**
1. Install Crispy MCP server in Claude Code
2. Connect LinkedIn account in Crispy dashboard
3. Set daily limits in dashboard
4. Update TOOLS.md: set Crispy to active
5. Update .env: add CRISPY_API_KEY
6. No data migration needed — Crispy works directly with LinkedIn

---

## Pre-migration checklist
- [ ] Export all data from source tool
- [ ] Save performance metrics to campaign performance/ folder
- [ ] Note which contacts are mid-sequence
- [ ] Set up and test new tool independently first
- [ ] Update TOOLS.md, COSTS.md, .env, campaign.config.md
- [ ] Verify with a small test batch before full migration
- [ ] Keep source tool access for 30 days (in case you need to reference old data)

## Post-migration checklist
- [ ] All contacts imported correctly
- [ ] Sequences configured and tested
- [ ] Tracking links working
- [ ] Warmup active on all inboxes (if new inboxes)
- [ ] First batch sent successfully
- [ ] Old tool paused (not deleted)
