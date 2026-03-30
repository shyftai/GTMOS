#!/usr/bin/env python3
"""
Pipeline Aging Alert — GTM:OS

Queries Salesforce for open opportunities, flags aging deals based on
three criteria, scores them by priority, and sends a formatted Slack DM.

Criteria:
  1. CloseDate is in the past
  2. No activity logged in the last 7 days
  3. NextStep field is null or blank

Priority scoring:
  - +10 per criterion hit
  - +1 per $10k in Amount
  - +2 per day past CloseDate (if past)
  - +1 per day since last activity beyond 7 days

Usage:
  python3 pipeline-aging-alert.py

Requires:
  - external-tool CLI available on PATH
  - api_credentials=["external-tools"] configured

Designed to run as a Monday morning cron job.
"""

import json
import subprocess
import sys
from datetime import datetime, timedelta


# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
SLACK_USER_ID = "U09PNFX6G5T"
SALESFORCE_SOURCE = "salesforce_rest_api__pipedream"
SLACK_SOURCE = "slack_direct"
INACTIVITY_THRESHOLD_DAYS = 7
TODAY = datetime.utcnow().date()


# ---------------------------------------------------------------------------
# External-tool helpers
# ---------------------------------------------------------------------------

def call_external_tool(source_id: str, tool_name: str, params: dict) -> dict:
    """Call an external tool via the external-tool CLI."""
    cmd = [
        "external-tool", "call",
        "--source", source_id,
        "--tool", tool_name,
        "--input", json.dumps(params),
    ]
    try:
        result = subprocess.run(
            cmd, capture_output=True, text=True, timeout=60
        )
    except FileNotFoundError:
        print("ERROR: external-tool CLI not found on PATH.", file=sys.stderr)
        sys.exit(1)
    except subprocess.TimeoutExpired:
        print(f"ERROR: external-tool call timed out: {tool_name}", file=sys.stderr)
        sys.exit(1)

    if result.returncode != 0:
        print(f"ERROR: external-tool failed ({tool_name}):\n{result.stderr}", file=sys.stderr)
        sys.exit(1)

    try:
        return json.loads(result.stdout)
    except json.JSONDecodeError:
        print(f"ERROR: could not parse external-tool output:\n{result.stdout}", file=sys.stderr)
        sys.exit(1)


def soql_query(query: str) -> list:
    """Run a SOQL query against Salesforce and return the records."""
    resp = call_external_tool(
        SALESFORCE_SOURCE,
        "salesforce_rest_api-soql-query",
        {"query": query},
    )
    # Pipedream wraps results — handle both flat and nested shapes
    if isinstance(resp, dict):
        return resp.get("records", resp.get("result", {}).get("records", []))
    if isinstance(resp, list):
        return resp
    return []


def get_current_user_id() -> str:
    """Get the Salesforce user ID for the current API user."""
    resp = call_external_tool(
        SALESFORCE_SOURCE,
        "salesforce_rest_api-get-user-info",
        {},
    )
    if isinstance(resp, dict):
        return resp.get("user_id", resp.get("Id", ""))
    return ""


def send_slack_dm(user_id: str, text: str) -> None:
    """Send a Slack DM to a user via external-tool."""
    call_external_tool(
        SLACK_SOURCE,
        "slack_send_message",
        {"channel_id": user_id, "text": text},
    )


# ---------------------------------------------------------------------------
# Salesforce queries
# ---------------------------------------------------------------------------

def fetch_open_opportunities(owner_id: str) -> list:
    """Fetch all open opportunities owned by the given user."""
    query = (
        "SELECT Id, Name, StageName, Amount, CloseDate, NextStep, "
        "LastActivityDate, AccountId, Account.Name "
        "FROM Opportunity "
        f"WHERE OwnerId = '{owner_id}' "
        "AND IsClosed = false "
        "ORDER BY CloseDate ASC"
    )
    return soql_query(query)


def fetch_open_opportunities_fallback() -> list:
    """Fetch open opportunities for the current user (no OwnerId filter)."""
    query = (
        "SELECT Id, Name, StageName, Amount, CloseDate, NextStep, "
        "LastActivityDate, AccountId, Account.Name "
        "FROM Opportunity "
        "WHERE IsClosed = false "
        "ORDER BY CloseDate ASC "
        "LIMIT 200"
    )
    return soql_query(query)


# ---------------------------------------------------------------------------
# Scoring & analysis
# ---------------------------------------------------------------------------

def parse_date(date_str: str | None) -> datetime | None:
    """Parse a YYYY-MM-DD date string, returning None on failure."""
    if not date_str:
        return None
    try:
        return datetime.strptime(date_str[:10], "%Y-%m-%d")
    except (ValueError, TypeError):
        return None


def analyze_opportunity(opp: dict) -> dict:
    """Analyze a single opportunity and return scoring details."""
    flags = []
    score = 0.0

    close_date = parse_date(opp.get("CloseDate"))
    last_activity = parse_date(opp.get("LastActivityDate"))
    next_step = (opp.get("NextStep") or "").strip()
    amount = float(opp.get("Amount") or 0)
    account_name = ""
    if isinstance(opp.get("Account"), dict):
        account_name = opp["Account"].get("Name", "")

    # --- Criterion 1: Past close date ---
    days_past_close = 0
    if close_date and close_date.date() < TODAY:
        days_past_close = (TODAY - close_date.date()).days
        flags.append(f"CloseDate {days_past_close}d overdue")
        score += 10 + (days_past_close * 2)

    # --- Criterion 2: No activity in 7+ days ---
    days_since_activity = None
    if last_activity:
        days_since_activity = (TODAY - last_activity.date()).days
    else:
        days_since_activity = 999  # treat no-activity-ever as very stale

    if days_since_activity >= INACTIVITY_THRESHOLD_DAYS:
        if last_activity:
            flags.append(f"No activity in {days_since_activity}d")
        else:
            flags.append("No activity ever logged")
        score += 10 + max(0, days_since_activity - INACTIVITY_THRESHOLD_DAYS)

    # --- Criterion 3: Empty NextStep ---
    if not next_step:
        flags.append("NextStep is empty")
        score += 10

    # --- Amount bonus ---
    score += amount / 10_000  # +1 per $10k

    # Skip if no criteria hit
    if not flags:
        return None

    return {
        "name": opp.get("Name", "Unknown"),
        "account": account_name,
        "stage": opp.get("StageName", ""),
        "amount": amount,
        "close_date": opp.get("CloseDate", ""),
        "last_activity": opp.get("LastActivityDate", ""),
        "next_step": next_step or "(empty)",
        "flags": flags,
        "criteria_count": len(flags),
        "score": round(score, 1),
        "days_past_close": days_past_close,
        "days_since_activity": days_since_activity,
    }


def analyze_all(opportunities: list) -> list:
    """Score all opportunities and return flagged ones, sorted by priority."""
    flagged = []
    for opp in opportunities:
        result = analyze_opportunity(opp)
        if result:
            flagged.append(result)
    flagged.sort(key=lambda x: x["score"], reverse=True)
    return flagged


# ---------------------------------------------------------------------------
# Message formatting
# ---------------------------------------------------------------------------

def format_amount(amount: float) -> str:
    """Format a dollar amount."""
    if amount >= 1_000_000:
        return f"${amount / 1_000_000:.1f}M"
    if amount >= 1_000:
        return f"${amount / 1_000:.0f}k"
    if amount > 0:
        return f"${amount:.0f}"
    return "$0"


def format_slack_message(flagged: list, total_open: int) -> str:
    """Build the Slack message with prioritized action list."""
    lines = []
    lines.append(f"Pipeline Aging Alert — {TODAY.strftime('%A, %b %d %Y')}")
    lines.append(f"{len(flagged)} of {total_open} open opportunities need attention")
    lines.append("")

    # Summary counts
    past_close = sum(1 for o in flagged if o["days_past_close"] > 0)
    inactive = sum(1 for o in flagged if o["days_since_activity"] and o["days_since_activity"] >= INACTIVITY_THRESHOLD_DAYS)
    no_next = sum(1 for o in flagged if "(empty)" in o["next_step"])

    lines.append(f"[!] {past_close} past close date  |  {inactive} inactive 7d+  |  {no_next} missing NextStep")
    lines.append("")

    # Priority tiers
    critical = [o for o in flagged if o["criteria_count"] >= 3]
    high = [o for o in flagged if o["criteria_count"] == 2]
    medium = [o for o in flagged if o["criteria_count"] == 1]

    def render_tier(label: str, items: list):
        if not items:
            return
        lines.append(f"--- {label} ({len(items)}) ---")
        for i, opp in enumerate(items, 1):
            amt = format_amount(opp["amount"])
            lines.append(f"{i}. {opp['name']} ({opp['account']}) — {opp['stage']} — {amt}")
            lines.append(f"   Score: {opp['score']}  |  {' + '.join(opp['flags'])}")
            # Recommended action
            action = suggest_action(opp)
            lines.append(f"   >> {action}")
            lines.append("")

    render_tier("CRITICAL — 3/3 criteria hit", critical)
    render_tier("HIGH — 2/3 criteria hit", high)
    render_tier("MEDIUM — 1/3 criteria hit", medium)

    lines.append(f"Run /gtm:pipeline-aging for the full interactive report.")
    return "\n".join(lines)


def suggest_action(opp: dict) -> str:
    """Suggest a concrete next action based on the flags."""
    if opp["criteria_count"] >= 3:
        return "Triage immediately — update close date, log activity, set next step"
    if opp["days_past_close"] > 30:
        return "Evaluate if this deal is still viable — consider moving to Closed Lost"
    if opp["days_past_close"] > 0:
        return "Update CloseDate to a realistic date and set a concrete NextStep"
    if opp["days_since_activity"] and opp["days_since_activity"] > 14:
        return "Re-engage the contact — schedule a call or send a check-in"
    if "(empty)" in opp["next_step"]:
        return "Add a NextStep — what is the next concrete action to advance this deal?"
    return "Review and update this opportunity"


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    print(f"<< GTM:OS // PIPELINE AGING ALERT >>")
    print(f"Date: {TODAY}")
    print()

    # Get current Salesforce user
    print("Fetching Salesforce user info...")
    user_id = get_current_user_id()

    # Fetch opportunities
    if user_id:
        print(f"Fetching open opportunities for user {user_id}...")
        opportunities = fetch_open_opportunities(user_id)
    else:
        print("Could not resolve user ID, fetching all open opportunities...")
        opportunities = fetch_open_opportunities_fallback()

    if not opportunities:
        print("No open opportunities found.")
        send_slack_dm(
            SLACK_USER_ID,
            f"Pipeline Aging Alert — {TODAY.strftime('%b %d')}: No open opportunities found.",
        )
        return

    print(f"Found {len(opportunities)} open opportunities.")

    # Analyze and score
    flagged = analyze_all(opportunities)
    print(f"Flagged {len(flagged)} opportunities with aging criteria.")

    if not flagged:
        msg = (
            f"Pipeline Aging Alert — {TODAY.strftime('%b %d')}: "
            f"All {len(opportunities)} open opportunities are healthy. No action needed."
        )
        print(msg)
        send_slack_dm(SLACK_USER_ID, msg)
        return

    # Format and send
    message = format_slack_message(flagged, len(opportunities))
    print()
    print("--- Slack message preview ---")
    print(message)
    print("--- End preview ---")
    print()

    print(f"Sending alert to Slack user {SLACK_USER_ID}...")
    send_slack_dm(SLACK_USER_ID, message)
    print("Sent.")


if __name__ == "__main__":
    main()
