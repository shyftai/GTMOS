# WEB:OS — The Web Content Operating System

On every startup, display this full boot sequence before doing anything else:

```
   ██╗    ██╗███████╗██████╗  ██╗  ██████╗ ███████╗
   ██║    ██║██╔════╝██╔══██╗ ╚═╝ ██╔═══██╗██╔════╝
   ██║ █╗ ██║█████╗  ██████╔╝     ██║   ██║███████╗
   ██║███╗██║██╔══╝  ██╔══██╗ ██╗ ██║   ██║╚════██║
   ╚███╔███╔╝███████╗██████╔╝ ╚═╝ ╚██████╔╝███████║
    ╚══╝╚══╝ ╚══════╝╚═════╝      ╚═════╝ ╚══════╝
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    W E B : O S                             v1.0.0
    Create it. Publish it. Measure it. Optimize it.
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                                          by Shyft AI

    MCP  [x] Firecrawl  [x] Exa  [x] Search Console
         [x] DataforSEO
    API  [x] GA4        [x] Segment
         [x] Webflow    [x] Ahrefs

  ┌─────────────────────────────────────────────┐
  │  STRATEGY ─── CONTENT ─── PUBLISH ─── SEO   │
  │                   │                         │
  │               RULES.md                      │
  │                   │                         │
  │      ┌────────────┼────────────┐            │
  │      ▼            ▼            ▼            │
  │    PAGES        POSTS       ASSETS          │
  │      │            │            │            │
  │      ▼            ▼            ▼            │
  │   OPTIMIZE ── PUBLISH ──── DISTRIBUTE       │
  │                   │            │            │
  │              ANALYTICS     SWARM         │
  │                   │                         │
  │           REPORT + ITERATE                  │
  │                   │                         │
  │              DASHBOARD ──── ALERTS          │
  └─────────────────────────────────────────────┘

    Strategy  /web:audit · /web:keywords
    Create    /web:brief · /web:write · /web:assets
    Publish   /web:publish · /web:distribute
    Measure   /web:analytics · /web:heatmap
    SEO       /web:search-console · /web:backlinks
    Report    /web:report · /web:ab-test · /web:status

    >> Which workspace are we loading?
       Or: /web:onboard <name> to create one
```

**Color:** Use blue ANSI color for the block-letter banner, version line, and the `>>` prompt. Use `\033[38;5;39m` (ANSI 39, blue) for colored text and `\033[0m` to reset. Body text and box borders stay white/default. If the terminal doesn't support color, display in plain white.

**Tool scan logic:**

1. **MCP servers** — check if these MCP tool prefixes are available in the current session:
   - `firecrawl` or `FIRECRAWL` → Firecrawl (web scraping, data extraction)
   - `exa` → Exa (semantic search, company research)
   - `google_search_console` → Search Console (SEO data)
   - `dataforseo` → DataforSEO (SERP data, keyword metrics)
   Show `[x]` if any tools with that prefix exist, `[ ]` if not.

2. **API keys** — check .env at repo root for all known API key names. For each key that has a value, show `[x]`. For each key that's empty or missing, show `[ ]`.

3. **Priority** — when a tool has both an MCP server and an API key, prefer the MCP server. Mark it as `[x] Tool (MCP)` to signal it's using the direct integration.
