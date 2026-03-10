-- GTMOS Scrape Cache Schema
-- Syncs scrape journal metadata to Supabase for team visibility.
-- Raw cache data stays in local files — only metadata syncs.

-- ============================================================
-- SCRAPE CACHE (journal metadata)
-- ============================================================
create table public.scrape_cache (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  campaign_id uuid references public.campaigns(id),
  journal_id text not null,
  tool text not null,
  endpoint text,
  angle text not null,
  goal text not null,
  filters_applied jsonb,
  records_requested integer,
  records_cached integer default 0,
  pages_fetched integer default 0,
  total_pages integer,
  status text not null default 'in-progress' check (status in (
    'in-progress', 'complete', 'partial', 'failed', 'stale'
  )),
  cache_file_path text,
  credits_used numeric(10,2) default 0,
  started_by uuid references public.users(id),
  started_at timestamptz not null default now(),
  completed_at timestamptz,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index idx_scrape_workspace on public.scrape_cache(workspace_id);
create index idx_scrape_status on public.scrape_cache(workspace_id, status);
create index idx_scrape_tool_angle on public.scrape_cache(workspace_id, tool, angle);

-- View: recent scrapes per workspace
create view public.recent_scrapes as
select
  workspace_id,
  journal_id,
  tool,
  angle,
  goal,
  records_cached,
  status,
  cache_file_path,
  started_at,
  completed_at
from public.scrape_cache
where started_at > now() - interval '30 days'
order by started_at desc;

-- View: scrape stats per tool
create view public.scrape_stats as
select
  workspace_id,
  tool,
  count(*) as total_scrapes,
  count(*) filter (where status = 'complete') as successful,
  count(*) filter (where status = 'failed') as failed,
  count(*) filter (where status = 'partial') as partial,
  sum(records_cached) as total_records_cached,
  sum(credits_used) as total_credits_used,
  max(started_at) as last_scrape
from public.scrape_cache
group by workspace_id, tool;

-- RLS
alter table public.scrape_cache enable row level security;

create policy "Scoped scrape cache access"
  on public.scrape_cache for all
  using (workspace_id in (
    select workspace_id from public.workspace_members where user_id = auth.uid()
  ));

-- Updated_at trigger
create trigger scrape_cache_updated_at
  before update on public.scrape_cache
  for each row execute function public.update_updated_at();
