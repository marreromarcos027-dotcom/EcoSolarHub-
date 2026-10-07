-- EcoSolarHub v4 - esquema para Supabase
create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  category text not null check (category in ('equipos','accesorios','servicios')),
  name text not null,
  description text default '',
  price numeric(12,2) not null default 0,
  image_url text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);
create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  location text default '',
  description text default '',
  image_url text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);
alter table public.products enable row level security;
alter table public.projects enable row level security;
create policy "public read active products" on public.products for select using (active = true);
create policy "public read active projects" on public.projects for select using (active = true);
-- Para producción: las escrituras deben hacerse únicamente con usuarios autenticados
-- y políticas de administrador; no dejes una política pública de INSERT/UPDATE/DELETE.
