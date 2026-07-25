create table if not exists public.saved_layouts (
  id uuid primary key default gen_random_uuid(),
  tree_id text not null default 'arbol-genealogico-principal',
  name text not null,
  positions jsonb not null default '[]'::jsonb,
  created_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint saved_layouts_name_not_blank check (length(btrim(name)) > 0),
  constraint saved_layouts_positions_array check (jsonb_typeof(positions) = 'array')
);

create index if not exists saved_layouts_tree_updated_idx
on public.saved_layouts (tree_id, updated_at desc);

alter table public.saved_layouts enable row level security;

grant select, insert, update, delete on public.saved_layouts to authenticated;

drop policy if exists "Authenticated read saved layouts" on public.saved_layouts;
create policy "Authenticated read saved layouts"
on public.saved_layouts
for select
to authenticated
using (true);

drop policy if exists "Family editor insert saved layouts" on public.saved_layouts;
create policy "Family editor insert saved layouts"
on public.saved_layouts
for insert
to authenticated
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

drop policy if exists "Family editor update saved layouts" on public.saved_layouts;
create policy "Family editor update saved layouts"
on public.saved_layouts
for update
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local')
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

drop policy if exists "Family editor delete saved layouts" on public.saved_layouts;
create policy "Family editor delete saved layouts"
on public.saved_layouts
for delete
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local');
