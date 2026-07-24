drop policy if exists "Authenticated write family trees" on public.family_trees;
drop policy if exists "Authenticated update family trees" on public.family_trees;
drop policy if exists "Authenticated delete family trees" on public.family_trees;

create policy "Family editor insert family trees"
on public.family_trees
for insert
to authenticated
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

create policy "Family editor update family trees"
on public.family_trees
for update
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local')
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

create policy "Family editor delete family trees"
on public.family_trees
for delete
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local');

drop policy if exists "Authenticated write people" on public.people;
drop policy if exists "Authenticated update people" on public.people;
drop policy if exists "Authenticated delete people" on public.people;

create policy "Family editor insert people"
on public.people
for insert
to authenticated
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

create policy "Family editor update people"
on public.people
for update
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local')
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

create policy "Family editor delete people"
on public.people
for delete
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local');

drop policy if exists "Authenticated write relations" on public.relations;
drop policy if exists "Authenticated update relations" on public.relations;
drop policy if exists "Authenticated delete relations" on public.relations;

create policy "Family editor insert relations"
on public.relations
for insert
to authenticated
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

create policy "Family editor update relations"
on public.relations
for update
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local')
with check ((auth.jwt() ->> 'email') = 'usuario@familia.local');

create policy "Family editor delete relations"
on public.relations
for delete
to authenticated
using ((auth.jwt() ->> 'email') = 'usuario@familia.local');
