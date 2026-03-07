---
name: gtm:audience-sync
description: Push account/contact lists to ad platforms as custom audiences
argument-hint: "<workspace-name> <campaign-name> [platform]"
---
<objective>
Optionally sync target account or contact lists to LinkedIn Ads, Meta (Facebook/Instagram), and/or Google Ads as matched/custom audiences. If HubSpot ABM is active, suggest using HubSpot's built-in Target Accounts and LinkedIn Ads sync instead.

Workspace, campaign, and optional platform filter: $ARGUMENTS
</objective>

<execution_context>
@./commands/audience-sync.md
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
</execution_context>

<process>
1. Display mode header: `<< GTMOS // AUDIENCE SYNC >>`
2. Load TOOLS.md — check which ad platforms are active
3. Check .env for ad platform API keys (LINKEDIN_ADS_TOKEN, META_ACCESS_TOKEN, GOOGLE_ADS_DEVELOPER_TOKEN)
4. Load the campaign's contact/company list from lists/
5. Display sync plan: source list, contact/company count, active platforms, audience name
6. Prepare data per platform (hash emails with SHA256, format company data)
7. For LinkedIn Ads: create DMP segment → stream companies or users (batch up to 5,000)
8. For Meta: create custom audience → upload users with hashed identifiers
9. For Google Ads: create user list → create OfflineUserDataJob → add operations → run job
10. Display sync summary with audience IDs and estimated processing time
11. Save audience IDs to campaign workspace for future updates
12. Suggest ad campaign timeline: start awareness ads 7-14 days before outreach
</process>
