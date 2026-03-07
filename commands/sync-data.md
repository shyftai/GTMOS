# Command: Sync Data

## Trigger
"Sync data for [campaign]" or "Pull latest data from all tools"

## Steps
1. Load TOOLS.md — identify which tools are active and in bidirectional or read mode
2. For each active tool, pull the latest data via direct API call:

   Apollo:
   - Contact status updates for shipped list records
   - Bounce and invalid email flags
   - Save to sync/apollo/[YYYY-MM-DD-HH].json

   Clay:
   - Enrichment results for any pending jobs
   - Field-level updates for records in validated/
   - Save to sync/clay/[YYYY-MM-DD-HH].json

   Lemlist:
   - Per-sequence: open rate, reply rate, bounce rate, unsubscribe rate
   - Per-touch: open rate, click rate, reply rate
   - Reply text samples (last 50 replies, anonymised on save)
   - Save to sync/lemlist/[YYYY-MM-DD-HH].json

   Instantly:
   - Per-campaign: open rate, reply rate, bounce rate, deliverability flags
   - Sending domain health signals
   - Save to sync/instantly/[YYYY-MM-DD-HH].json

   Smartlead:
   - Per-campaign: open rate, reply rate, bounce rate, deliverability flags
   - Save to sync/smartlead/[YYYY-MM-DD-HH].json

   Crispy:
   - Connection acceptance rate
   - Reply rate and reply content samples
   - Save to sync/crispy/[YYYY-MM-DD-HH].json

   Attio:
   - Deal stage distribution for contacts in this campaign
   - New replies or status changes since last sync
   - Contacts marked won, lost, or disqualified
   - Save to sync/attio/[YYYY-MM-DD-HH].json

3. Confirm sync complete — show timestamp and record count per tool
4. Flag if any tool returned an error or empty response
5. Do not analyse yet — sync is a data pull only. Run campaign-health-check to analyse.
