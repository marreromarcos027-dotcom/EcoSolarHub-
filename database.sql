-- EcoSolarHub v3 - Supabase
-- Ejecuta este script en Supabase > SQL Editor.
-- Luego crea un usuario administrador en Authentication > Users.

create extension if not exists pgcrypto;

drop table if exists public.projects cascade;
drop table if exists public.catalog_items cascade;

create table public.catalog_items (
  id text primary key,
  type text not null check (type in ('equipo','servicio','accesorio')),
  name text not null,
  price numeric(12,2) not null default 0,
  description text default '',
  image_url text default '',
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.projects (
  id text primary key,
  name text not null,
  location text default '',
  description text default '',
  image_url text default '',
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.catalog_items enable row level security;
alter table public.projects enable row level security;

-- Lectura pública: los clientes pueden ver el catálogo y los proyectos publicados.
create policy "public read catalog" on public.catalog_items
for select using (active = true);

create policy "public read projects" on public.projects
for select using (active = true);

-- Escritura únicamente para usuarios autenticados (administrador).
create policy "authenticated insert catalog" on public.catalog_items
for insert to authenticated with check (true);
create policy "authenticated update catalog" on public.catalog_items
for update to authenticated using (true) with check (true);
create policy "authenticated delete catalog" on public.catalog_items
for delete to authenticated using (true);

create policy "authenticated insert projects" on public.projects
for insert to authenticated with check (true);
create policy "authenticated update projects" on public.projects
for update to authenticated using (true) with check (true);
create policy "authenticated delete projects" on public.projects
for delete to authenticated using (true);

-- Storage: fotos públicas para que los clientes puedan verlas.
insert into storage.buckets (id,name,public) values ('catalogo','catalogo',true) on conflict (id) do update set public=true;
insert into storage.buckets (id,name,public) values ('proyectos','proyectos',true) on conflict (id) do update set public=true;
insert into storage.buckets (id,name,public) values ('prefacturas','prefacturas',false) on conflict (id) do update set public=false;

-- Las imágenes pueden ser vistas por todos.
create policy "public view catalog images" on storage.objects
for select using (bucket_id = 'catalogo');
create policy "public view project images" on storage.objects
for select using (bucket_id = 'proyectos');

-- Solo administradores autenticados pueden subir/cambiar/eliminar imágenes.
create policy "authenticated upload catalog images" on storage.objects
for insert to authenticated with check (bucket_id = 'catalogo');
create policy "authenticated update catalog images" on storage.objects
for update to authenticated using (bucket_id = 'catalogo') with check (bucket_id = 'catalogo');
create policy "authenticated delete catalog images" on storage.objects
for delete to authenticated using (bucket_id = 'catalogo');

create policy "authenticated upload project images" on storage.objects
for insert to authenticated with check (bucket_id = 'proyectos');
create policy "authenticated update project images" on storage.objects
for update to authenticated using (bucket_id = 'proyectos') with check (bucket_id = 'proyectos');
create policy "authenticated delete project images" on storage.objects
for delete to authenticated using (bucket_id = 'proyectos');

-- El frontend sube prefacturas solo si está autenticado.
create policy "authenticated upload prefacturas" on storage.objects
for insert to authenticated with check (bucket_id = 'prefacturas');
create policy "authenticated read prefacturas" on storage.objects
for select to authenticated using (bucket_id = 'prefacturas');

insert into public.catalog_items(id,type,name,price,description,active) values
('e1','equipo','Panel Solar 550 W',249,'Módulo fotovoltaico de alta eficiencia.',true),
('e2','equipo','Inversor Híbrido 5 kW',1299,'Inversor híbrido para paneles, baterías y cargas.',true),
('e3','equipo','Batería LiFePO4 5.12 kWh',1799,'Almacenamiento de energía para respaldo y autonomía.',true),
('a1','accesorio','Kit de conectores MC4',29,'Conectores para instalaciones fotovoltaicas.',true),
('a2','accesorio','Protección DC Solar',85,'Protección y seguridad para strings solares.',true),
('a3','accesorio','Cable Solar',3.50,'Precio orientativo por metro.',true),
('s1','servicio','Instalación de sistema fotovoltaico',350,'Montaje, conexión y puesta en marcha.',true),
('s2','servicio','Visita y diagnóstico técnico',75,'Evaluación del sitio y recomendaciones.',true),
('s3','servicio','Mantenimiento preventivo',120,'Revisión, limpieza y comprobación del sistema.',true)
on conflict (id) do nothing;

insert into public.projects(id,name,location,description,active) values
('p1','Sistema residencial','Cuba','Instalación fotovoltaica para respaldo y reducción del consumo de red.',true),
('p2','Sistema para comercio','Cuba','Solución solar con almacenamiento para continuidad operativa.',true),
('p3','Proyecto a medida','Cuba','Diseño y montaje adaptado a las necesidades energéticas del cliente.',true)
on conflict (id) do nothing;
