# Command: Run Research

## Trigger
"Run research for [workspace]" or "Research the market for [campaign]"

## Available research tools

Check which tools are available before starting:

| Tool | How to use | Best for |
|------|-----------|----------|
| **Exa MCP** | `web_search_exa`, `company_research_exa`, `deep_researcher_start` | Semantic company/market research, finding similar companies, industry reports |
| **Firecrawl MCP** | `FIRECRAWL_SCRAPE_EXTRACT_DATA_LLM`, `FIRECRAWL_EXTRACT` | Scraping competitor websites, extracting structured data from company pages |
| **Crispy MCP** | `search_companies`, `search_people` | Finding ICP-matching companies and decision-makers on LinkedIn/Sales Navigator |
| **Apollo API** | `POST /mixed_people/api_search` | Free people search (275M+ contacts) for validating persona assumptions |
| **Crunchbase API** | `POST /searches/organizations` | Free company search — funding, headcount, industry filters |
| **Diffbot API** | `GET /dql?query=X` | Free entity search (10B+ entities) — tech stack, revenue, employees |

**Priority:** Use Exa for semantic discovery and market intelligence. Use Firecrawl to scrape specific company/competitor pages for structured data. Use Crispy/Apollo/Crunchbase for building actual prospect lists.

## Steps

### ICP company research
1. Load ICP.md to understand the target segment
2. Use **Exa `company_research_exa`** to research what perfect-fit companies look like:
   - Find 10-20 companies matching ICP criteria
   - Identify patterns: tech stack, team structure, growth stage
3. Use **Exa `web_search_exa`** to find:
   - Typical signals: hiring, funding, events, expansions
   - Tools and vendors they commonly use
   - Pain language buyers in this space actually use
   - What triggers a buying decision
4. Use **Firecrawl** to scrape key company websites for:
   - Product positioning and messaging (how they describe their own pain)
   - Team pages (decision-maker titles and structure)
   - Job posts (hiring signals, tech stack clues)
5. Use **Crunchbase/Diffbot** (free) to validate firmographic assumptions:
   - Are target companies actually in the revenue/headcount range assumed?
   - What funding stages are most common?
6. Save to: context/research/icp-research-[YYYY-MM-DD].md

### Market and industry landscape
1. Use **Exa `deep_researcher_start`** for a comprehensive market report:
   - Market size and current dynamics
   - Trends making the campaign angle relevant right now
   - Key players, categories, and competitive landscape
2. Use **Exa `web_search_exa`** for specific queries:
   - Terminology and framing buyers actually use
   - Category context for copy and positioning
   - Recent news, reports, and thought leadership
3. Use **Firecrawl `FIRECRAWL_EXTRACT`** to extract structured data from:
   - Industry reports and market analyses
   - Competitor comparison pages
   - G2/Capterra category pages (if relevant)
4. Save to: context/research/market-landscape-[YYYY-MM-DD].md

### Competitor intelligence
1. Load COMPETITORS.md for known competitors
2. Use **Firecrawl** to scrape competitor websites:
   - Pricing pages (positioning, packaging)
   - Feature pages (what they emphasize)
   - Case studies (who they target, results they claim)
   - Blog/content (topics they own, pain points they address)
3. Use **Exa `web_search_exa`** to find:
   - Competitor reviews and complaints (G2, Reddit, Twitter)
   - Competitor customer case studies
   - "Alternatives to [competitor]" content
4. Save to: context/research/competitor-intel-[YYYY-MM-DD].md

### Signal-to-angle extraction
For every meaningful signal found in research:
1. Name the signal
2. State why it is relevant for this ICP
3. Write the copy angle it enables
4. Write one sample opening line using that angle
5. Flag if the signal is time-sensitive or expiring

Save all signals and angles to: context/research/signal-angles.md
Format as a scannable table — one row per signal.

### List building seeds (new)
From research, extract concrete list-building inputs:
1. **Company lists** — specific companies discovered that match ICP. Save LinkedIn URLs, domains, names
2. **Search filters** — Sales Navigator / Apollo filters that would find more companies like these
3. **Lookalike signals** — what makes these companies similar (tech stack, funding stage, hiring patterns)
4. Save to: context/research/list-seeds-[YYYY-MM-DD].md
5. These seeds feed directly into `/gtm:list-brief`

### After all files are saved
- Update context/INDEX.md to reference all research files as priority reads
- Flag any findings that should update ICP.md, PERSONA.md, or COMPETITORS.md
- Summarise the top 3 recommended angles for the next sequence
- Suggest next action: build lists from seeds or refine briefing
