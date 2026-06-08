-- Run this in Supabase SQL Editor to create the feedback table.

create table if not exists public.feedback (
  id           uuid primary key default gen_random_uuid(),
  rating       int check (rating between 1 and 5),
  use_cases    text[],
  missing      text,
  working      text,
  email        text,
  name         text,
  source       text default 'direct',
  submitted_at timestamptz default now()
);

-- Allow anonymous inserts (for the landing page form)
alter table public.feedback enable row level security;

create policy "Anyone can submit feedback"
  on public.feedback
  for insert
  to anon
  with check (true);

-- Only authenticated users (i.e. you) can read feedback
create policy "Authenticated users can read feedback"
  on public.feedback
  for select
  to authenticated
  using (true);
