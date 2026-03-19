# Briefing: GTM:OS Automated Demo Pipeline

You are building an automated demo video pipeline for GTM:OS — a CLI-based GTM Operating System that runs inside Claude Code. The goal is to produce polished demo videos for every major feature, with AI voiceover, fully automated and runnable on a remote server.

---

## What GTM:OS is

A markdown-based GTM (go-to-market) operating system that runs as a Claude Code project. It lives at https://github.com/shyftai/GTMOS. Everything happens in the terminal — there is no web UI. Users interact via slash commands like `/gtm:onboard`, `/gtm:write`, `/gtm:research`, etc.

On startup it displays an ASCII banner, scans for connected tools (MCP servers + API keys), loads workspace context, and then the user works through commands. All state is stored in markdown files in a workspace directory.

---

## What you're building

An end-to-end pipeline that:

1. **Scripts** terminal demo sessions (one per feature)
2. **Records** them as MP4 video (headless, on server)
3. **Generates** voiceover narration via ElevenLabs API
4. **Merges** video + audio with proper timing
5. **Outputs** final demo videos ready to publish

Everything must run headlessly on a Linux server via SSH. No GUI, no display.

---

## Tech stack

| Component | Tool | Why |
|-----------|------|-----|
| Terminal recording | **VHS** (github.com/charmbracelet/vhs) | Purpose-built for scripted CLI demos. Write `.tape` files, renders to MP4/GIF. Headless. |
| Voiceover | **ElevenLabs API** (`/v1/text-to-speech/{voice_id}`) | High-quality AI voice. Takes text, returns MP3. |
| Video processing | **ffmpeg** | Merge video + audio, adjust timing, add intro/outro frames |
| Orchestration | **Bash script** or **Node.js** | Ties everything together. Runs the full pipeline per demo. |
| Server | User's server accessible via `ssh shyft` | Linux, headless |

### Install requirements

```bash
# VHS — requires Go 1.21+ and ttyd and ffmpeg
go install github.com/charmbracelet/vhs@latest

# ffmpeg
sudo apt install -y ffmpeg

# ttyd (VHS dependency for terminal rendering)
sudo apt install -y ttyd

# Chrome/Chromium (VHS uses it for rendering)
sudo apt install -y chromium-browser
# or: npx playwright install chromium

# Node.js (for orchestration script if using Node)
# Already installed or: curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash && sudo apt install -y nodejs

# ElevenLabs — no SDK needed, just curl. Or: npm install elevenlabs
```

---

## Directory structure to create

```
demos/
├── pipeline.sh                  # Main orchestrator — runs everything
├── config.env                   # ElevenLabs API key, voice ID, output settings
├── scripts/                     # One .tape file per demo
│   ├── 01-boot.tape
│   ├── 02-onboard.tape
│   ├── 03-research.tape
│   ├── 04-list-brief.tape
│   ├── 05-enrich.tape
│   ├── 06-write.tape
│   ├── 07-validate-copy.tape
│   ├── 08-ship.tape
│   ├── 09-replies.tape
│   ├── 10-signals.tape
│   ├── 11-health.tape
│   ├── 12-report.tape
│   ├── 13-scrape-cache.tape
│   ├── 14-team-mode.tape
│   ├── 15-dashboard.tape
│   └── 16-full-workflow.tape
├── narration/                   # Voiceover scripts (text) + generated audio
│   ├── 01-boot.txt
│   ├── 01-boot.mp3
│   ├── ...
├── raw/                         # Raw VHS output (MP4, no audio)
│   ├── 01-boot.mp4
│   ├── ...
├── final/                       # Finished videos (video + voiceover)
│   ├── 01-boot-demo.mp4
│   ├── ...
└── README.md                    # How to run the pipeline
```

---

## Demo scenarios to script

Each demo is a `.tape` file (VHS format) paired with a narration `.txt` file. Below is every demo with what it should show and what the voiceover should say.

### 01 — Boot sequence
**Shows:** Starting Claude Code in the GTMOS directory. The full ASCII banner renders, system scan shows connected tools, workspace list appears, flow diagram displays.
**Narration:** "GTM OS boots automatically when you open Claude Code in the project directory. It scans your connected tools — MCP servers, API keys — and shows you exactly what's online. Here's the full boot sequence."
**Duration:** ~15 seconds

### 02 — Onboard a workspace
**Shows:** Running `/gtm:onboard acme-corp`. The structured intake interview — answering ICP questions, persona, tone of voice. Files being created in the workspace directory.
**Narration:** "Onboarding walks you through a structured intake. Who's the buyer, what's the offer, what tone fits. GTM OS builds your ICP, persona, tone of voice, and rules files from your answers. Everything is stored as markdown — no database, no vendor lock-in."
**Duration:** ~30 seconds

### 03 — Research
**Shows:** Running `/gtm:research`. Exa semantic search pulling market landscape, Firecrawl scraping competitor pages, results being saved to `context/research/`.
**Narration:** "Before building lists or writing copy, run a research pass. GTM OS uses Exa for semantic search, Firecrawl for web scraping, and saves structured research to your workspace context. This informs everything downstream."
**Duration:** ~20 seconds

### 04 — List brief
**Shows:** Running `/gtm:list-brief`. Defining target criteria, generating a structured brief document.
**Narration:** "List briefs define exactly who you're targeting — job titles, company size, geography, signals. The brief becomes the filter every record is scored against."
**Duration:** ~15 seconds

### 05 — Enrich
**Shows:** Running `/gtm:enrich`. The waterfall enrichment plan displaying (Apollo → Icypeas → Prospeo), cost estimate, progress bars showing hit rates per source, final results summary.
**Narration:** "Enrichment runs a waterfall — cheapest source first, cascade on misses, stop when data is found. You see the plan, the cost estimate, and real-time hit rates. No credits wasted on duplicate pulls."
**Duration:** ~25 seconds

### 06 — Write sequences
**Shows:** Running `/gtm:write`. Loading the cold email skill, generating a 4-touch sequence with subject lines, showing the quality checks (ICP fit, persona fit, briefing fit, voice fit).
**Narration:** "Copy generation loads your briefing, tone of voice, and persona — then writes a full sequence. Every draft runs through five quality checks before you see it. Subject lines, word counts, CTA style — all enforced automatically."
**Duration:** ~25 seconds

### 07 — Validate copy
**Shows:** Running `/gtm:validate-copy`. The QA checklist running, flagging a banned word, showing the revision.
**Narration:** "Validate copy runs a QA pass against your briefing. Banned words, word count violations, claims not in the brief — all flagged before anything ships."
**Duration:** ~15 seconds

### 08 — Ship
**Shows:** Running `/gtm:ship`. The launch check sequence — suppression check, compliance check, domain health check, the hard approval gate, then pushing to the sending tool.
**Narration:** "Shipping is the one hard gate that never auto-approves. GTM OS checks the suppression list, verifies compliance, confirms domain health, and only pushes to your sending tool after explicit approval."
**Duration:** ~20 seconds

### 09 — Reply handling
**Shows:** Running `/gtm:replies`. Classifying a reply as an objection, loading the objection map, drafting a response, presenting for approval.
**Narration:** "Replies are classified into seven types — positive, negative, objection, referral, out of office, unsubscribe, competitor mention. Each type triggers a specific workflow. Objections are matched against your persona's objection map."
**Duration:** ~20 seconds

### 10 — Signals
**Shows:** Running `/gtm:signals`. Detecting a funding signal, matching it to a contact, drafting signal-triggered outreach.
**Narration:** "When a time-sensitive signal hits — funding, key hire, product launch — GTM OS drafts targeted outreach that references the signal directly. Most signals expire in five to seven days, so speed matters."
**Duration:** ~15 seconds

### 11 — Health check
**Shows:** Running `/gtm:health`. Pulling analytics from the sending tool, calculating rates, flagging issues, comparing against benchmarks.
**Narration:** "Health checks pull live analytics, calculate open and reply rates, compare against industry benchmarks, and flag anything that needs attention — bounce rates, spam complaints, domain reputation."
**Duration:** ~20 seconds

### 12 — Report
**Shows:** Running `/gtm:report`. Generating a client-facing campaign report with metrics, insights, and recommendations.
**Narration:** "Reports are client-ready — metrics, insights, and recommendations. Generated from live data, formatted for sharing."
**Duration:** ~15 seconds

### 13 — Scrape cache + session recovery
**Shows:** Starting a scrape, showing the journal entry being created, cache file being written page by page. Then simulating a session drop (exit). Re-opening Claude Code, GTM OS detecting the in-progress scrape, offering to resume.
**Narration:** "Every API call is cached locally and journaled before it starts. If your session drops mid-scrape, nothing is lost. On restart, GTM OS detects the incomplete scrape and offers to pick up where you left off."
**Duration:** ~25 seconds

### 14 — Team mode
**Shows:** Running `/gtm:collab setup`. Supabase connection, real-time suppression sync, claim-based reply handling.
**Narration:** "Team mode syncs shared state through Supabase — suppression lists, reply queues, cost tracking, pipeline. Multiple operators, one source of truth. If the connection drops, it falls back to file-based mode automatically."
**Duration:** ~20 seconds

### 15 — Dashboard
**Shows:** Running `/gtm:dashboard`. The daily action briefing showing what needs attention across campaigns.
**Narration:** "The dashboard shows what needs attention right now — pending replies, budget alerts, domain health flags, upcoming sends. One command, full situational awareness."
**Duration:** ~15 seconds

### 16 — Full workflow (hero video)
**Shows:** Condensed end-to-end: boot → onboard → research → list brief → enrich → write → ship → health check → report. Fast cuts between each stage.
**Narration:** "This is GTM OS end to end. Brief it, build it, ship it, measure it. From workspace setup to campaign report — all orchestrated from the terminal, all state in markdown, all tools connected through one system."
**Duration:** ~45 seconds

---

## VHS tape file format

Reference: https://github.com/charmbracelet/vhs

```tape
# Configuration
Output raw/01-boot.mp4
Set FontSize 16
Set Width 1400
Set Height 900
Set Theme "Catppuccin Mocha"
Set TypingSpeed 50ms
Set Padding 20

# Record
Type "cd /path/to/GTMOS && claude"
Enter
Sleep 4s

# Show banner loading
Sleep 3s

# Type a command
Type "/gtm:status"
Enter
Sleep 3s

# Scroll to show output
Down 5
Sleep 2s
```

**Important VHS notes:**
- VHS simulates a real terminal — it types characters and captures the rendered output
- For GTM:OS demos, you need Claude Code actually installed and running. VHS will launch a real shell.
- Since Claude Code is an AI assistant, the responses won't be deterministic. Two approaches:
  - **Option A (recommended): Mock the output.** Create a shell script that prints the expected GTM:OS output (banners, tables, etc.) with realistic timing. VHS records this scripted output. No actual Claude Code needed.
  - **Option B: Record real sessions.** Use asciinema to record real Claude Code sessions first, then replay them through VHS or convert directly.

**Go with Option A** — it's deterministic, reproducible, and doesn't require Claude Code running on the server. Create mock scripts in `demos/mocks/` that print the exact terminal output for each demo.

---

## Mock script approach

For each demo, create a bash script that simulates the terminal output:

```bash
#!/bin/bash
# demos/mocks/01-boot.sh — Simulates GTM:OS boot sequence

# Orange color
O='\033[38;5;208m'
R='\033[0m'

echo -e "${O}"
cat << 'BANNER'
 ██████╗ ████████╗███╗   ███╗ ██╗  ██████╗ ███████╗
██╔════╝ ╚══██╔══╝████╗ ████║ ╚═╝ ██╔═══██╗██╔════╝
██║  ███╗   ██║   ██╔████╔██║     ██║   ██║███████╗
██║   ██║   ██║   ██║╚██╔╝██║ ██╗ ██║   ██║╚════██║
╚██████╔╝   ██║   ██║ ╚═╝ ██║ ╚═╝ ╚██████╔╝███████║
 ╚═════╝    ╚═╝   ╚═╝     ╚═╝     ╚═════╝ ╚══════╝
BANNER
echo -e "${R}"

sleep 0.5
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  G T M : O S                             ${O}v1.4.0${R}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 0.3
echo ""
echo "  Brief it. Build it. Ship it. Measure it."
echo "                                          by Shyft AI"
sleep 1

# System status
echo ""
echo "  ┌─ SYSTEM ──────────────────────────────────────┐"
echo "  │                                                │"
echo "  │  Workspaces:  acme-corp, globex                │"
sleep 0.2
# ... continue with full boot output
```

The VHS tape file then just runs this mock:

```tape
Output raw/01-boot.mp4
Set FontSize 16
Set Width 1400
Set Height 900
Set Theme "Catppuccin Mocha"

Type "claude"
Enter
Sleep 1s
# VHS captures whatever the shell outputs
# But since we can't run real Claude Code deterministically,
# we use: Type "./demos/mocks/01-boot.sh"
Hide
Type "bash demos/mocks/01-boot.sh"
Show
Enter
Sleep 10s
```

---

## ElevenLabs voiceover generation

```bash
#!/bin/bash
# demos/generate-voiceover.sh
# Generates MP3 voiceover from text files

source demos/config.env

for txt in demos/narration/*.txt; do
  name=$(basename "$txt" .txt)
  mp3="demos/narration/${name}.mp3"

  if [ -f "$mp3" ]; then
    echo "Skipping $name — already generated"
    continue
  fi

  echo "Generating voiceover for $name..."

  curl -s -X POST \
    "https://api.elevenlabs.io/v1/text-to-speech/${ELEVENLABS_VOICE_ID}" \
    -H "xi-api-key: ${ELEVENLABS_API_KEY}" \
    -H "Content-Type: application/json" \
    -d "{
      \"text\": $(cat "$txt" | jq -Rs .),
      \"model_id\": \"eleven_multilingual_v2\",
      \"voice_settings\": {
        \"stability\": 0.5,
        \"similarity_boost\": 0.75,
        \"style\": 0.3
      }
    }" \
    --output "$mp3"

  echo "  → Saved $mp3"
  sleep 1  # Rate limit courtesy
done
```

---

## Merge pipeline

```bash
#!/bin/bash
# demos/merge.sh
# Merges raw video + voiceover audio into final output

for mp4 in demos/raw/*.mp4; do
  name=$(basename "$mp4" .mp4)
  mp3="demos/narration/${name}.mp3"
  out="demos/final/${name}-demo.mp4"

  if [ ! -f "$mp3" ]; then
    echo "No voiceover for $name — copying raw video"
    cp "$mp4" "$out"
    continue
  fi

  # Get durations
  vid_dur=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$mp4")
  aud_dur=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$mp3")

  # Use the longer duration — pad shorter one
  echo "Merging $name (video: ${vid_dur}s, audio: ${aud_dur}s)..."

  ffmpeg -y \
    -i "$mp4" \
    -i "$mp3" \
    -c:v libx264 -preset medium -crf 23 \
    -c:a aac -b:a 192k \
    -shortest \
    -movflags +faststart \
    "$out" 2>/dev/null

  echo "  → Saved $out"
done
```

---

## Main pipeline orchestrator

```bash
#!/bin/bash
# demos/pipeline.sh
# Run the full demo pipeline: record → voiceover → merge

set -e
source demos/config.env

echo "=== GTM:OS Demo Pipeline ==="
echo ""

# Step 1: Record all demos
echo "Step 1: Recording terminal demos..."
for tape in demos/scripts/*.tape; do
  name=$(basename "$tape" .tape)
  echo "  Recording $name..."
  vhs "$tape"
done

# Step 2: Generate voiceovers
echo ""
echo "Step 2: Generating voiceovers..."
bash demos/generate-voiceover.sh

# Step 3: Merge
echo ""
echo "Step 3: Merging video + audio..."
bash demos/merge.sh

# Step 4: Summary
echo ""
echo "=== Done ==="
echo "Final videos:"
ls -lh demos/final/
```

---

## config.env template

```env
# ElevenLabs
ELEVENLABS_API_KEY=your-key-here
ELEVENLABS_VOICE_ID=your-voice-id-here
# Recommended voices: "Adam" (narrative), "Antoni" (professional), or clone your own

# Video settings
VIDEO_WIDTH=1400
VIDEO_HEIGHT=900
VIDEO_FONT_SIZE=16
VIDEO_THEME="Catppuccin Mocha"

# Output
OUTPUT_FORMAT=mp4
OUTPUT_QUALITY=medium  # VHS: low/medium/high
```

---

## Order of work

1. **Set up the `demos/` directory** with the structure above
2. **Write `config.env`** template
3. **Create all 16 mock scripts** in `demos/mocks/` — each one prints realistic GTM:OS terminal output with proper colors, boxes, and timing
4. **Create all 16 `.tape` files** in `demos/scripts/` — each runs its mock script and captures the output
5. **Create all 16 narration text files** in `demos/narration/`
6. **Write `generate-voiceover.sh`** — loops through narration text, calls ElevenLabs API
7. **Write `merge.sh`** — ffmpeg merge for each video + audio pair
8. **Write `pipeline.sh`** — orchestrates everything
9. **Write `README.md`** — how to install deps and run the pipeline
10. **Test with demo 01 (boot sequence)** first — get one working end-to-end before building all 16

---

## Important notes

- **The mock scripts are the most important part.** They need to look exactly like real GTM:OS output — correct ASCII art, ANSI colors (orange `\033[38;5;208m`), box drawing characters, tables. Study the GTMOS.md file in the repo for exact formats.
- **VHS needs a working terminal.** On a headless server, VHS uses ttyd + headless Chrome to render. Make sure Chrome/Chromium is installed.
- **ElevenLabs has rate limits.** Batch the voiceover generation, add 1s delays between calls. The `eleven_multilingual_v2` model gives the best quality.
- **Keep videos SHORT.** 15-30 seconds each. Attention spans are short. The hero video (16) can be 45-60 seconds.
- **Use consistent styling.** Same font size, theme, and terminal width across all demos. The Catppuccin Mocha theme gives a modern dark look that matches GTM:OS aesthetics.

---

## The repo

Clone from: `https://github.com/shyftai/GTMOS.git`

The key files to study for accurate mock output:
- `GTMOS.md` — the banner, system status box, flow diagram, commands box formats
- `.claude/gtmos/references/defaults.md` — default settings (for enrichment/sending demos)
- `.claude/gtmos/references/enrichment-waterfall.md` — waterfall display format
- `_template/` — workspace file structure
- `_template/SCRAPE-JOURNAL.md` — scrape journal format (for demo 13)
- `_template/COSTS.md` — cost tracking format

All the box-drawing, table formats, and ANSI color patterns are defined in GTMOS.md. Match them exactly.
