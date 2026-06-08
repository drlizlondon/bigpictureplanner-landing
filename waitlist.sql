-- Run this in Supabase SQL Editor

create table if not exists public.waitlist (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  name text,
  signed_up_at timestamptz not null default now(),
  position integer,
  source text default 'landing'
);

comment on table public.waitlist is
  'Landing page waitlist. First 50 get 4 weeks free.';

-- Auto-assign a queue position on insert
create or replace function set_waitlist_position()
returns trigger as $$
begin
  new.position := (select coalesce(max(position), 0) + 1 from public.waitlist);
  return new;
end;
$$ language plpgsql security definer;

create trigger waitlist_position_trigger
  before insert on public.waitlist
  for each row execute function set_waitlist_position();

-- RLS
alter table public.waitlist enable row level security;

-- Anyone can sign up (insert only, no email required to be unique across attempts)
create policy "Anyone can join waitlist"
  on public.waitlist
  for insert
  with check (true);

-- Only you (authenticated) can read the list
create policy "Authenticated users can read waitlist"
  on public.waitlist
  for select
  using (auth.role() = 'authenticated');
