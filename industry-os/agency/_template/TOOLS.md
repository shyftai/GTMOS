# Tools — [Agency Name]

Agency tech stack. Includes tools for new business development and client delivery.

---

## CRM

| Tool | Used for | Status | Credit behaviour |
|------|----------|--------|-----------------|
| HubSpot | New business pipeline + client contacts | [ ] configured | auto-approved |
| Attio | New business pipeline (alternative to HubSpot) | [ ] configured | auto-approved |

**Active CRM:** [HubSpot / Attio / other]
**Notes:** CRM writes are a hard gate — confirm before any create/update/delete

---

## Email sequencing

| Tool | Used for | Status | Credit behaviour |
|------|----------|--------|-----------------|
| Instantly | Cold outbound email sequences | [ ] configured | confirm-above-threshold |
| Lemlist | Cold outbound + LinkedIn sequences | [ ] configured | confirm-above-threshold |
| Smartlead | High-volume cold outbound | [ ] configured | confirm-above-threshold |

**Active tool:** [Instantly / Lemlist / Smartlead]

---

## LinkedIn

| Tool | Used for | Status | Credit behaviour |
|------|----------|--------|-----------------|
| Crispy (MCP) | LinkedIn outreach, profile research, connection requests | [ ] connected | confirm-before-every-use |

**Note:** All LinkedIn actions via Crispy are hard gates — no auto-approval ever

---

## Enrichment & prospecting

| Tool | Used for | Status | Credit behaviour |
|------|----------|--------|-----------------|
| Apollo | Contact search, email enrichment, company data | [ ] configured | confirm-above-threshold |
| Clay | Multi-source enrichment waterfall | [ ] configured | confirm-above-threshold |
| Hunter.io | Email finding and verification | [ ] configured | confirm-above-threshold |

**Enrichment waterfall:** See `../../.claude/gtmos/references/enrichment-waterfall.md`

---

## Research & web

| Tool | Used for | Status | Credit behaviour |
|------|----------|--------|-----------------|
| Exa (MCP) | Semantic company research | [ ] connected | confirm-above-threshold |
| Firecrawl (MCP) | Website scraping, job board scraping | [ ] connected | confirm-above-threshold |
| Apollo (search) | Company and contact discovery | [ ] configured | confirm-above-threshold |

---

## Client delivery tools

| Tool | Used for | Status |
|------|----------|--------|
| Google Analytics 4 | Client traffic and conversion tracking | [ ] access per client |
| Google Ads | Paid search management | [ ] access per client |
| Meta Ads Manager | Paid social management | [ ] access per client |
| LinkedIn Campaign Manager | B2B paid social | [ ] access per client |
| HubSpot (client) | Client CRM and email | [ ] access per client |
| Klaviyo | E-commerce email | [ ] access per client |
| Databox | Client-facing dashboards | [ ] configured |
| Looker Studio | Custom client reports | [ ] configured |

---

## Project management

| Tool | Used for | Status |
|------|----------|--------|
| Notion | Internal docs, client workspaces | [ ] configured |
| Linear | Sprint planning and task tracking | [ ] configured |
| Slack | Internal comms + client channels | [ ] configured |

---

## Proposals & contracts

| Tool | Used for | Status |
|------|----------|--------|
| PandaDoc | Proposal and contract sending | [ ] configured |
| Notion | Lightweight proposals | [ ] configured |
| DocuSign | Contract signing | [ ] configured |

---

## Tool credit thresholds

Set per campaign or per tool. Claude will stop and confirm before crossing these.

| Tool | Alert threshold | Hard stop threshold |
|------|----------------|---------------------|
| Apollo | 500 credits | 1,000 credits |
| Instantly | 2,000 emails/day | 5,000 emails/day |
| Lemlist | 200 emails/day | 500 emails/day |
| Firecrawl | 100 pages | 500 pages |
| Clay | 500 rows | 2,000 rows |

---

## Tool hit rate tracking

Updated after every enrichment run. Used to optimise the waterfall.

| Tool | Runs | Avg hit rate | Last updated |
|------|------|-------------|-------------|
| Apollo | 0 | — | — |
| Hunter.io | 0 | — | — |
| Clay | 0 | — | — |
