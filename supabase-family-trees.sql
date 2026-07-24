create table if not exists public.family_trees (
  id text primary key,
  name text not null,
  data jsonb not null default '{"people":[],"relations":[]}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.family_trees enable row level security;

drop policy if exists "Public read family trees" on public.family_trees;
create policy "Public read family trees"
on public.family_trees
for select
to anon
using (true);

drop policy if exists "Public write family trees" on public.family_trees;
create policy "Public write family trees"
on public.family_trees
for insert
to anon
with check (true);

drop policy if exists "Public update family trees" on public.family_trees;
create policy "Public update family trees"
on public.family_trees
for update
to anon
using (true)
with check (true);
