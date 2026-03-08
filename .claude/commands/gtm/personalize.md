---
name: gtm:personalize
description: Generate per-contact personalization lines at scale
argument-hint: "<workspace-name> <campaign-name> [--batch-size N]"
---
<objective>
Research each contact on a validated list and generate custom personalization lines. Not merge fields — real, researched insights unique to each person. "Saw you're hiring 3 SDRs" or "Your post about X resonated."

Workspace and campaign: $ARGUMENTS
</objective>

<execution_context>
@./.claude/gtmos/references/ui-brand.md
@./.claude/gtmos/references/api-reference.md
@./.claude/gtmos/references/cold-email-skill.md
</execution_context>

<process>
1. Display mode header: `<< GTM:OS // PERSONALIZE >>`
2. Load validated list from lists/validated/
3. Load approved sequence from copy/approved/
4. Load PERSONA.md, ICP.md, LEARNINGS.md, TOV.md
5. Identify personalization slots in the sequence — look for {{personalized_line}}, {{observation}}, {{trigger}}, or the first line after the greeting

## Personalization strategy
6. Ask: "What type of personalization?"
   - **LinkedIn activity** — recent posts, comments, shared content (requires Crispy)
   - **Company news** — funding, launches, hires, press (Exa)
   - **Job posts** — what they're hiring for (Sentrion/Exa)
   - **Website** — something specific from their company site (Firecrawl)
   - **Role-based** — observation about their specific title/responsibility
   - **Auto** — try all available sources, pick the best signal per contact

7. Check which tools are available:
   - Crispy → LinkedIn activity
   - Exa → company news, web search
   - Firecrawl → website scraping
   - Sentrion/Fantastic.jobs → job posts
   - Apollo → company data

## Research phase
8. Display the plan:
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃  PERSONALIZATION PLAN                                        ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                                                              ┃
┃  Contacts: {n}                                               ┃
┃  Strategy: {auto / linkedin / news / etc.}                   ┃
┃  Sources: {available tools}                                  ┃
┃  Batch size: {n} (default 10, max 50)                        ┃
┃                                                              ┃
┃  Estimated cost:                                             ┃
┃    Crispy lookups: {n} × {cost} = {total}                    ┃
┃    Exa searches: {n} × $0.007 = {total}                     ┃
┃    Total: ~${total}                                          ┃
┃                                                              ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  >> Proceed? (y/n)
```

9. For each contact (in batches):

**Research:**
   a. Search for recent activity/news about this person and company
   b. Prioritize signals by strength:
      - Personal activity (they posted/commented something) → strongest
      - Company news (funding, launch, hire) → strong
      - Job post (hiring for relevant role) → good
      - Website observation (specific page/feature) → decent
      - Role-based observation (generic but relevant) → fallback

**Generate personalization line:**
   c. Write a 1-sentence observation-led opener based on the best signal found
   d. Rules:
      - Must be specific and verifiable — never fabricate
      - Must connect to a pain point or relevance, not just flattery
      - No "I saw that you..." — use observation format: "{{company}} just raised Series B — scaling the sales team usually means..."
      - No compliments about LinkedIn posts — reference the substance of what they said
      - If nothing strong found, use role-based observation (still better than generic)
      - Match TOV.md tone

10. Display results in batches for review:
```
  Contact: {name} — {title} at {company}
  Source: LinkedIn post (Crispy)
  Signal: Posted about struggling with SDR hiring
  Line: "Hiring 3 SDRs while keeping ramp time under 60 days —
         that's the puzzle most sales leaders hit around Series B."
  Quality: ★★★★★ (specific, relevant, connects to pain)

  Contact: {name} — {title} at {company}
  Source: Company news (Exa)
  Signal: Raised $12M Series A last month
  Line: "Post-Series A is when most teams realize their outbound
         process doesn't scale past the founder doing it manually."
  Quality: ★★★★☆ (good signal, slightly generic connection)

  Contact: {name} — {title} at {company}
  Source: Fallback (role-based)
  Signal: No specific signal found
  Line: "Running demand gen at a 50-person fintech usually means
         you're the entire marketing team."
  Quality: ★★★☆☆ (role-based, not personalized to individual)

  >> Approve batch? (approve all / edit / reject / skip)
```

11. Track personalization quality:
```
  Personalization summary:
    ★★★★★  12 contacts — specific personal signal
    ★★★★☆   8 contacts — strong company signal
    ★★★☆☆   5 contacts — role-based fallback
    ★★☆☆☆   0 contacts — weak (would flag for manual review)
    Skipped: 2 contacts — no usable signal, needs manual research
```

## Output
12. Save personalized lines to campaign personalization file:
    - Add a `{{personalized_line}}` column to the validated list CSV
    - Or save as a separate personalization mapping file

13. Update PERSONALIZATION.md with the new variable

14. Log costs in COSTS.md

15. Display:
```
  Personalized {n} of {total} contacts.
  {n} high quality (★★★★+), {n} role-based fallback, {n} need manual review.

  >> Review flagged contacts: {list of contacts needing manual lines}
  >> Ship: /gtm:ship {ws} {campaign}
```

## Scale mode
16. If contact count >25, ask how they want to run it:
```
  {n} contacts to personalize. How do you want to run this?

  >> Claude Code — runs here, review results in real time
     Best for: interactive review, first-time runs

  >> API — runs via Anthropic API in the background, faster at scale
     Best for: 50-500+ contacts, batch processing
     Requires: ANTHROPIC_API_KEY in .env

  >> Sequential — one at a time, slowest but most control
```
    - Claude Code: uses agent swarm within session, results presented for review
    - API: spawns batch jobs, saves results to files, user reviews when complete
    - Sequential: processes one by one (default for <25 contacts)
</process>
</content>
