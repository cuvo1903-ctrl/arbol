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

create table if not exists public.people (
  id uuid primary key,
  first_names text not null,
  paternal_last_name text not null,
  maternal_last_name text,
  birth date,
  death date,
  notes text,
  x numeric not null default 420,
  y numeric not null default 250,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.relations (
  id uuid primary key,
  from_person_id uuid not null references public.people(id) on delete cascade,
  to_person_id uuid not null references public.people(id) on delete cascade,
  type text not null check (type in ('parent', 'partner')),
  created_at timestamptz not null default now()
);

alter table public.people enable row level security;
alter table public.relations enable row level security;

grant usage on schema public to authenticated;
grant select, insert, update, delete on public.family_trees to authenticated;
grant select, insert, update, delete on public.people to authenticated;
grant select, insert, update, delete on public.relations to authenticated;

drop policy if exists "Authenticated read people" on public.people;
create policy "Authenticated read people"
on public.people
for select
to authenticated
using (true);

drop policy if exists "Authenticated write people" on public.people;
create policy "Authenticated write people"
on public.people
for insert
to authenticated
with check (true);

drop policy if exists "Authenticated update people" on public.people;
create policy "Authenticated update people"
on public.people
for update
to authenticated
using (true)
with check (true);

drop policy if exists "Authenticated delete people" on public.people;
create policy "Authenticated delete people"
on public.people
for delete
to authenticated
using (true);

drop policy if exists "Authenticated read relations" on public.relations;
create policy "Authenticated read relations"
on public.relations
for select
to authenticated
using (true);

drop policy if exists "Authenticated write relations" on public.relations;
create policy "Authenticated write relations"
on public.relations
for insert
to authenticated
with check (true);

drop policy if exists "Authenticated update relations" on public.relations;
create policy "Authenticated update relations"
on public.relations
for update
to authenticated
using (true)
with check (true);

drop policy if exists "Authenticated delete relations" on public.relations;
create policy "Authenticated delete relations"
on public.relations
for delete
to authenticated
using (true);

insert into public.people (
  id,
  first_names,
  paternal_last_name,
  maternal_last_name,
  birth,
  death,
  notes,
  x,
  y
)
select
  (person->>'id')::uuid,
  coalesce(nullif(person->>'firstNames', ''), nullif(person->>'name', ''), 'Sin nombre'),
  coalesce(person->>'paternalLastName', ''),
  nullif(person->>'maternalLastName', ''),
  nullif(person->>'birth', '')::date,
  nullif(person->>'death', '')::date,
  coalesce(person->>'notes', ''),
  coalesce((person->>'x')::numeric, 420),
  coalesce((person->>'y')::numeric, 250)
from public.family_trees tree
cross join lateral jsonb_array_elements(tree.data->'people') person
where not exists (
  select 1
  from public.people existing
  where existing.id = (person->>'id')::uuid
);

insert into public.relations (
  id,
  from_person_id,
  to_person_id,
  type
)
select
  (relation->>'id')::uuid,
  (relation->>'from')::uuid,
  (relation->>'to')::uuid,
  relation->>'type'
from public.family_trees tree
cross join lateral jsonb_array_elements(tree.data->'relations') relation
where exists (
  select 1 from public.people person where person.id = (relation->>'from')::uuid
)
and exists (
  select 1 from public.people person where person.id = (relation->>'to')::uuid
)
and not exists (
  select 1
  from public.relations existing
  where existing.id = (relation->>'id')::uuid
);

drop policy if exists "Authenticated update family trees" on public.family_trees;
create policy "Authenticated update family trees"
on public.family_trees
for update
to authenticated
using (auth.role() = 'authenticated')
with check (auth.role() = 'authenticated');
