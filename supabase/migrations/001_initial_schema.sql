-- GTMOS Collaboration Schema
-- Run this migration to set up the shared state layer.
-- File-based mode still works without this — Supabase is optional.

-- ============================================================
-- WORKSPACES
-- ============================================================
create table public.workspaces (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  status text not null default 'active' check (status in ('active', 'paused', 'archived')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- ============================================================
-- USERS & WORKSPACE MEMBERSHIP
-- ============================================================
create table public.users (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text not null,
  email text not null unique,
  role text not null default 'operator' check (role in ('admin', 'operator', 'viewer')),
  created_at timestamptz not null default now()
);

create table public.workspace_members (
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  user_id uuid not null references public.users(id) on delete cascade,
  role text not null default 'operator' check (role in ('owner', 'approver', 'operator', 'viewer')),
  added_at timestamptz not null default now(),
  primary key (workspace_id, user_id)
);

-- ============================================================
-- CAMPAIGNS
-- ============================================================
create table public.campaigns (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  name text not null,
  status text not null default 'draft' check (status in ('draft', 'active', 'paused', 'complete', 'archived')),
  channel text not null default 'email' check (channel in ('email', 'linkedin', 'multi-channel')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  updated_by uuid references public.users(id),
  unique (workspace_id, name)
);

-- ============================================================
-- SUPPRESSION LIST (real-time, cross-campaign)
-- ============================================================
create table public.suppression_list (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  email text not null,
  name text,
  company text,
  reason text not null check (reason in ('unsubscribe', 'bounce', 'complaint', 'manual', 'role-based', 'personal-domain')),
  added_by uuid references public.users(id),
  source_campaign_id uuid references public.campaigns(id),
  created_at timestamptz not null default now(),
  unique (workspace_id, email)
);

create index idx_suppression_workspace_email on public.suppression_list(workspace_id, email);

-- ============================================================
-- COST LEDGER (real-time spend tracking)
-- ============================================================
create table public.cost_transactions (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  campaign_id uuid references public.campaigns(id),
  tool text not null,
  action text not null,
  units integer not null default 1,
  cost_per_unit numeric(10,4) not null,
  total_cost numeric(10,2) generated always as (units * cost_per_unit) stored,
  currency text not null default 'USD',
  approved_by uuid references public.users(id),
  created_at timestamptz not null default now()
);

create index idx_costs_workspace on public.cost_transactions(workspace_id);
create index idx_costs_campaign on public.cost_transactions(campaign_id);

-- Running totals view
create view public.cost_summary as
select
  workspace_id,
  campaign_id,
  tool,
  sum(units) as total_units,
  sum(units * cost_per_unit) as total_cost,
  max(created_at) as last_transaction
from public.cost_transactions
group by workspace_id, campaign_id, tool;

-- Workspace-level totals view
create view public.workspace_cost_summary as
select
  workspace_id,
  tool,
  sum(units) as total_units,
  sum(units * cost_per_unit) as total_cost,
  count(distinct campaign_id) as campaigns,
  max(created_at) as last_transaction
from public.cost_transactions
group by workspace_id, tool;

-- ============================================================
-- PIPELINE (CRM deal tracking)
-- ============================================================
create table public.pipeline_contacts (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  campaign_id uuid references public.campaigns(id),
  email text not null,
  name text,
  company text,
  stage text not null default 'prospect' check (stage in (
    'prospect', 'contacted', 'replied_positive', 'replied_negative',
    'replied_objection', 'meeting_booked', 'qualified',
    'proposal_sent', 'negotiation', 'closed_won', 'closed_lost'
  )),
  first_touch_date date,
  first_touch_channel text,
  reply_date date,
  reply_touch_number integer,
  meeting_date date,
  deal_value numeric(12,2),
  lost_reason text,
  owner_id uuid references public.users(id),
  updated_at timestamptz not null default now(),
  updated_by uuid references public.users(id)
);

create index idx_pipeline_workspace on public.pipeline_contacts(workspace_id);
create index idx_pipeline_stage on public.pipeline_contacts(workspace_id, stage);
create index idx_pipeline_email on public.pipeline_contacts(workspace_id, email);

-- Pipeline funnel view
create view public.pipeline_funnel as
select
  workspace_id,
  campaign_id,
  stage,
  count(*) as contact_count,
  sum(deal_value) as total_deal_value
from public.pipeline_contacts
group by workspace_id, campaign_id, stage;

-- ============================================================
-- REPLY QUEUE (claim-based to prevent double-handling)
-- ============================================================
create table public.reply_queue (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  campaign_id uuid not null references public.campaigns(id) on delete cascade,
  contact_email text not null,
  contact_name text,
  reply_text text not null,
  received_at timestamptz not null default now(),
  classification text check (classification in (
    'positive', 'negative', 'objection', 'referral', 'ooo', 'unsubscribe', 'competitor'
  )),
  status text not null default 'unhandled' check (status in ('unhandled', 'claimed', 'handled', 'escalated')),
  claimed_by uuid references public.users(id),
  claimed_at timestamptz,
  handled_at timestamptz,
  response_draft text,
  notes text
);

create index idx_replies_status on public.reply_queue(workspace_id, status);

-- ============================================================
-- APPROVALS (audit trail)
-- ============================================================
create table public.approvals (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  campaign_id uuid references public.campaigns(id),
  item_type text not null check (item_type in (
    'copy', 'list', 'reply', 'sequence', 'signal_outreach', 'budget_override', 'suppression_removal'
  )),
  item_description text not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected', 'expired')),
  requested_by uuid references public.users(id),
  decided_by uuid references public.users(id),
  requested_at timestamptz not null default now(),
  decided_at timestamptz,
  notes text
);

-- ============================================================
-- ACTIVITY FEED (who did what when)
-- ============================================================
create table public.activity_feed (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  campaign_id uuid references public.campaigns(id),
  user_id uuid references public.users(id),
  action text not null,
  detail text,
  created_at timestamptz not null default now()
);

create index idx_activity_workspace on public.activity_feed(workspace_id, created_at desc);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

-- Enable RLS on all tables
alter table public.workspaces enable row level security;
alter table public.users enable row level security;
alter table public.workspace_members enable row level security;
alter table public.campaigns enable row level security;
alter table public.suppression_list enable row level security;
alter table public.cost_transactions enable row level security;
alter table public.pipeline_contacts enable row level security;
alter table public.reply_queue enable row level security;
alter table public.approvals enable row level security;
alter table public.activity_feed enable row level security;

-- Users can read their own profile
create policy "Users can read own profile"
  on public.users for select
  using (id = auth.uid());

-- Workspace members can read their workspaces
create policy "Members can read workspaces"
  on public.workspaces for select
  using (id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

-- Admins can manage workspaces
create policy "Admins can manage workspaces"
  on public.workspaces for all
  using (id in (
    select workspace_id from public.workspace_members
    where user_id = auth.uid() and role = 'owner'
  ));

-- Members can read workspace members
create policy "Members can read membership"
  on public.workspace_members for select
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

-- Scoped access for all operational tables (same pattern)
-- Each table is scoped to workspaces the user belongs to

create policy "Scoped campaign access"
  on public.campaigns for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

create policy "Scoped suppression access"
  on public.suppression_list for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

create policy "Scoped cost access"
  on public.cost_transactions for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

create policy "Scoped pipeline access"
  on public.pipeline_contacts for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

create policy "Scoped reply access"
  on public.reply_queue for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

create policy "Scoped approval access"
  on public.approvals for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

create policy "Scoped activity access"
  on public.activity_feed for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

-- ============================================================
-- UPDATED_AT TRIGGERS
-- ============================================================
create or replace function public.update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger workspaces_updated_at
  before update on public.workspaces
  for each row execute function public.update_updated_at();

create trigger campaigns_updated_at
  before update on public.campaigns
  for each row execute function public.update_updated_at();

create trigger pipeline_updated_at
  before update on public.pipeline_contacts
  for each row execute function public.update_updated_at();
