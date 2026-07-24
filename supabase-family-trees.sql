create table if not exists public.family_trees (
  id text primary key,
  name text not null,
  data jsonb not null default '{"people":[],"relations":[]}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.family_trees enable row level security;

drop policy if exists "Public read family trees" on public.family_trees;
drop policy if exists "Public write family trees" on public.family_trees;
drop policy if exists "Public update family trees" on public.family_trees;
drop policy if exists "Authenticated read family trees" on public.family_trees;
create policy "Authenticated read family trees"
on public.family_trees
for select
to authenticated
using (auth.role() = 'authenticated');

drop policy if exists "Authenticated write family trees" on public.family_trees;
create policy "Authenticated write family trees"
on public.family_trees
for insert
to authenticated
with check (auth.role() = 'authenticated');

drop policy if exists "Authenticated update family trees" on public.family_trees;
create policy "Authenticated update family trees"
on public.family_trees
for update
to authenticated
using (auth.role() = 'authenticated')
with check (auth.role() = 'authenticated');
