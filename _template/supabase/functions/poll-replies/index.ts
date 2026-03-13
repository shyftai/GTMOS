// GTM:OS Reply Polling Edge Function
// Polls Instantly for new replies, classifies them, inserts into reply_queue.
// Deploy: supabase functions deploy poll-replies
// Schedule: every 5 minutes via pg_cron or external cron

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const INSTANTLY_API_URL = "https://api.instantly.ai/api/v2";

interface Reply {
  id: string;
  from_address: string;
  from_name: string;
  subject: string;
  body: string;
  timestamp: string;
  campaign_id: string;
  campaign_name: string;
}

interface ClassificationResult {
  intent:
    | "positive"
    | "negative"
    | "ooo"
    | "unsubscribe"
    | "redirect"
    | "wrong_person"
    | "objection"
    | "competitor";
  confidence: number;
  ooo_return_date: string | null;
  summary: string;
}

// Simple rule-based classifier — no LLM needed for obvious cases
function classifyReply(body: string): ClassificationResult {
  const lower = body.toLowerCase();

  // OOO detection
  const oooPatterns = [
    /out of (the )?office/i,
    /on (annual |paid )?leave/i,
    /away from/i,
    /auto.?reply/i,
    /automatic reply/i,
    /i('m| am) (currently )?(away|out|off|on vacation|on holiday|travelling)/i,
    /will (be )?(back|return)/i,
    /absent/i,
    /congé/i, // French
    /abwesend/i, // German
    /fuera de la oficina/i, // Spanish
    /não estarei/i, // Portuguese
  ];
  if (oooPatterns.some((p) => p.test(body))) {
    const returnDate = parseReturnDate(body);
    return {
      intent: "ooo",
      confidence: 0.95,
      ooo_return_date: returnDate,
      summary: returnDate
        ? `OOO — returns ${returnDate}`
        : "OOO — no return date found",
    };
  }

  // Unsubscribe
  const unsubPatterns = [
    /unsubscribe/i,
    /remove me/i,
    /stop (emailing|contacting|sending)/i,
    /take me off/i,
    /do not (contact|email|send)/i,
    /opt.?out/i,
  ];
  if (unsubPatterns.some((p) => p.test(body))) {
    return {
      intent: "unsubscribe",
      confidence: 0.95,
      ooo_return_date: null,
      summary: "Explicit unsubscribe request",
    };
  }

  // Wrong person / redirect
  const redirectPatterns = [
    /not the right person/i,
    /wrong person/i,
    /you should (talk|speak|reach out) to/i,
    /try (contacting|reaching)/i,
    /forward.*(to|this)/i,
    /no longer (at|with|work)/i,
    /left (the )?company/i,
  ];
  if (redirectPatterns.some((p) => p.test(body))) {
    return {
      intent: "redirect",
      confidence: 0.85,
      ooo_return_date: null,
      summary: "Redirected to another person",
    };
  }

  // Positive signals
  const positivePatterns = [
    /interested/i,
    /let'?s (chat|talk|connect|set up|schedule|book)/i,
    /sounds good/i,
    /tell me more/i,
    /send me (more )?info/i,
    /what('s| is) your availability/i,
    /book a (call|meeting|demo|time)/i,
    /i('d| would) (love|like) to/i,
  ];
  if (positivePatterns.some((p) => p.test(body))) {
    return {
      intent: "positive",
      confidence: 0.8,
      ooo_return_date: null,
      summary: "Positive — interested in next steps",
    };
  }

  // Negative — short dismissals
  const negativePatterns = [
    /not interested/i,
    /no thanks/i,
    /no thank you/i,
    /we('re| are) (all )?set/i,
    /pass on this/i,
    /not (a |the )?(right|good) (fit|time)/i,
    /not looking/i,
  ];
  if (negativePatterns.some((p) => p.test(body))) {
    return {
      intent: "negative",
      confidence: 0.85,
      ooo_return_date: null,
      summary: "Negative — not interested",
    };
  }

  // Default: needs manual classification
  return {
    intent: "positive",
    confidence: 0.3,
    ooo_return_date: null,
    summary: "Needs manual review — low confidence classification",
  };
}

// Parse return dates from OOO messages (multilingual)
function parseReturnDate(body: string): string | null {
  // Match common date patterns
  const patterns = [
    // "back on March 15" / "return March 15th"
    /(?:back|return|available|in office).*?(\w+ \d{1,2}(?:st|nd|rd|th)?(?:,? \d{4})?)/i,
    // "back on 15/03" / "back on 03-15"
    /(?:back|return|available).*?(\d{1,2}[\/\-]\d{1,2}(?:[\/\-]\d{2,4})?)/i,
    // "back on 2026-03-15"
    /(?:back|return|available).*?(\d{4}-\d{2}-\d{2})/i,
    // "back next Monday" / "return on Friday"
    /(?:back|return|available).*?(next (?:monday|tuesday|wednesday|thursday|friday))/i,
    // "retour le 15 mars" (French)
    /retour.*?(\d{1,2} (?:janvier|février|mars|avril|mai|juin|juillet|août|septembre|octobre|novembre|décembre))/i,
    // "zurück am 15. März" (German)
    /zurück.*?(\d{1,2}\. (?:Januar|Februar|März|April|Mai|Juni|Juli|August|September|Oktober|November|Dezember))/i,
  ];

  for (const pattern of patterns) {
    const match = body.match(pattern);
    if (match) {
      return match[1].trim();
    }
  }
  return null;
}

Deno.serve(async (req) => {
  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const instantlyKey = Deno.env.get("INSTANTLY_API_KEY")!;
    const slackWebhook = Deno.env.get("SLACK_WEBHOOK_URL");

    const supabase = createClient(supabaseUrl, supabaseKey);

    // Get all active campaigns from Instantly
    const campaignsRes = await fetch(`${INSTANTLY_API_URL}/campaigns`, {
      headers: { Authorization: `Bearer ${instantlyKey}` },
    });
    const campaigns = await campaignsRes.json();

    let totalNew = 0;
    let positiveReplies: { name: string; company: string; campaign: string }[] =
      [];

    for (const campaign of campaigns) {
      // Get replies for this campaign
      const repliesRes = await fetch(
        `${INSTANTLY_API_URL}/campaigns/${campaign.id}/replies?limit=100`,
        { headers: { Authorization: `Bearer ${instantlyKey}` } }
      );

      if (!repliesRes.ok) continue;
      const replies: Reply[] = await repliesRes.json();

      for (const reply of replies) {
        // Dedup by instantly email ID
        const { data: existing } = await supabase
          .from("reply_queue")
          .select("id")
          .eq("workspace_id", campaign.workspace_id)
          .eq("contact_email", reply.from_address)
          .eq("campaign_id", campaign.id)
          .gte("received_at", reply.timestamp)
          .limit(1);

        if (existing && existing.length > 0) continue;

        // Classify
        const classification = classifyReply(reply.body);

        // Insert into reply_queue
        const { error } = await supabase.from("reply_queue").insert({
          workspace_id: campaign.workspace_id,
          campaign_id: campaign.id,
          contact_email: reply.from_address,
          contact_name: reply.from_name,
          reply_text: reply.body,
          received_at: reply.timestamp,
          classification: classification.intent,
          status: "unhandled",
          notes: JSON.stringify({
            ai_intent: classification.intent,
            ai_confidence: classification.confidence,
            ai_analysis: {
              summary: classification.summary,
              ooo_return_date: classification.ooo_return_date,
            },
            instantly_campaign_name: campaign.name,
          }),
        });

        if (!error) {
          totalNew++;
          if (classification.intent === "positive") {
            positiveReplies.push({
              name: reply.from_name,
              company: reply.from_address.split("@")[1],
              campaign: campaign.name,
            });
          }
        }
      }
    }

    // Slack notification for positive replies
    if (slackWebhook && positiveReplies.length > 0) {
      const lines = positiveReplies
        .map((r) => `• *${r.name}* (${r.company}) — ${r.campaign}`)
        .join("\n");
      await fetch(slackWebhook, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          text: `🟢 ${positiveReplies.length} positive ${positiveReplies.length === 1 ? "reply" : "replies"}:\n${lines}\n\nRun \`/gtm:replies\` to handle.`,
        }),
      });
    }

    return new Response(
      JSON.stringify({
        ok: true,
        new_replies: totalNew,
        positive: positiveReplies.length,
      }),
      { headers: { "Content-Type": "application/json" } }
    );
  } catch (err) {
    return new Response(JSON.stringify({ ok: false, error: String(err) }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
