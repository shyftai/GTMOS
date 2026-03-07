# Command: Intake Interview

## Trigger
"Onboard a new workspace" or "Run the intake interview for [workspace]"

## Steps
1. Create the workspace folder structure from _template/
2. Ask intake questions in blocks — not all at once:
   Block 1: Offer and product
   Block 2: ICP — company profile and persona
   Block 3: Pain points and buying triggers
   Block 4: Campaign angle, hook, proof points
   Block 5: Tone, CTA, constraints
   Block 6: Tone of voice deep-dive — sentence structure, style, words, channel rules, examples
   Block 7: Tool stack and credit rules
   Block 8: Cost tracking — pricing, budgets, alerts
   Block 9: Sending infrastructure — outbound domains, DNS status, mailboxes, warmup
   Block 10: Compliance — physical address, CAN-SPAM/GDPR readiness, existing suppression list
   Block 11: CRM pipeline — CRM tool, pipeline stages, attribution model, sync preferences
   Block 12: Multi-channel — channels in use, priority, cross-channel timing preferences
   Block 13: Booking links — calendar URLs, landing pages, UTM parameters
   Block 14: Competitors — primary competitors, positioning, win/loss patterns
3. After each block, confirm what was captured before moving on
4. On completion, write answers directly into:
   - ICP.md (workspace level)
   - PERSONA.md (workspace level)
   - TOV.md (workspace level)
   - workspace.config.md (workspace level)
   - TOOLS.md (workspace level)
   - COSTS.md (workspace level)
   - INFRASTRUCTURE.md (workspace level)
   - SUPPRESSION.md (workspace level)
   - PIPELINE.md (workspace level)
   - MULTICHANNEL.md (workspace level)
   - BOOKING.md (workspace level)
   - COMPETITORS.md (workspace level)
   - BRIEFING.md (campaign level — written when first campaign is created)
   - PERSONALIZATION.md (campaign level — written when campaign is created)
5. Check .env for any keys needed by active tools — flag any that are missing
6. Flag any fields still empty that will need to be filled before copy can start
7. Suggest running the research phase next

## Block 7 — Tool stack questions
- Which tools are active for this workspace?

  **Prospecting & enrichment:** Apollo / Icypeas / Prospeo / Apify
  **Sending:** Lemlist / Instantly / Smartlead
  **LinkedIn:** Crispy
  **CRM:** Attio / HubSpot / Salesforce / Pipedrive
  **Signals:** Signalbase / Commonroom / Jungler.ai / Trigify / Sentrion.ai / Fantastic.jobs
  **Lookalike discovery:** Ocean.io / DiscoLike
  **Research & scraping:** Exa / Firecrawl
  **Email verification:** ZeroBounce / MillionVerifier / Scrubby
  **Email finding:** Dropcontact / FindyMail
  **Meeting transcripts:** Fireflies.ai
  **Ad platforms (ABM audience sync):** LinkedIn Ads / Meta (Facebook) / Google Ads

- For each active tool: what is the credit behaviour? (confirm-every-time / confirm-above-threshold / auto-approved)
- For confirm-above-threshold tools: what is the batch size limit?
- Are there any tools this workspace specifically should not use?

**After tool selection, check .env for API keys:**
- APOLLO_API_KEY, ICYPEAS_API_KEY, PROSPEO_API_KEY, APIFY_API_KEY
- LEMLIST_API_KEY, INSTANTLY_API_KEY, SMARTLEAD_API_KEY
- CRISPY_API_KEY
- ATTIO_API_KEY, HUBSPOT_API_KEY
- SIGNALBASE_API_KEY, COMMONROOM_API_KEY, JUNGLER_API_KEY, TRIGIFY_API_KEY
- OCEAN_API_KEY, DISCOLIKE_API_KEY
- EXA_API_KEY, FIRECRAWL_API_KEY
- DROPCONTACT_API_KEY, FINDYMAIL_API_KEY
- FIREFLIES_API_KEY
- LINKEDIN_ADS_TOKEN, LINKEDIN_AD_ACCOUNT_ID
- META_ACCESS_TOKEN, META_AD_ACCOUNT_ID
- GOOGLE_ADS_TOKEN, GOOGLE_ADS_DEVELOPER_TOKEN, GOOGLE_ADS_CUSTOMER_ID

Flag any active tools with missing API keys using the MISSING TOOLS box from tool-links.md.

## Block 8 — Cost tracking questions
- For each active tool: what is the cost per unit? (e.g. $0.05 per Apollo enrichment, $0.01 per Lemlist email)
- What is the monthly budget for this workspace?
- What is the per-campaign budget?
- At what percentage should Claude flag a budget warning? (default: 80%)

## Block 9 — Sending infrastructure questions
- What outbound domains do you have? (never use primary business domain for cold sending)
- For each domain: is SPF, DKIM, and DMARC set up?
- What email provider? (Google Workspace / Microsoft 365 / other)
- How many mailboxes per domain?
- What warmup tool are you using? (Instantly warmup / Mailreach / Warmup Inbox / other)
- What warmup stage are the inboxes at? (not started / warming / live)
- Do you have custom tracking domains set up?

## Block 10 — Compliance questions
- What is the physical mailing address for email footers?
- Are you targeting EU contacts? (GDPR applies)
- Are you targeting California residents? (CCPA applies)
- Do you have an existing suppression/do-not-contact list to import?
- What is your unsubscribe handling process today?

## Block 11 — CRM pipeline questions
- What CRM are you using? (Attio / HubSpot / Salesforce / other)
- What are your pipeline stages from first contact to closed-won?
- How do you attribute deals to campaigns today?
- Who updates deal stages in the CRM? (sales team / ops / automated)
- What data should be synced back from CRM for health checks?

## Block 12 — Multi-channel questions
- Which channels are active? (email / LinkedIn / both)
- Which is the primary channel?
- If multi-channel: what timing do you use between email and LinkedIn touches?
- Are there any channel-specific constraints? (e.g. LinkedIn daily limits, email volume caps)

## Block 13 — Booking links
- What is the primary calendar/booking link? (e.g. Calendly, Cal.com, HubSpot meetings)
- Is there a fallback booking link (different team member)?
- What landing pages should be linked in outreach? (case studies, product pages, demo videos)
- What UTM parameters do you use for attribution?

## Block 14 — Competitor intelligence
- Who are the top 2-3 competitors prospects mention?
- For each: what is their positioning? What do prospects like about them?
- What are the win angles — how do you differentiate?
- Are there things we should never say about competitors?
