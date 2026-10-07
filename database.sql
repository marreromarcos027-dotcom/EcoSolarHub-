-- SOLARNOVA / SUPABASE
-- Ejecutar en Supabase > SQL Editor
create extension if not exists "pgcrypto";

create table if not exists products (
  id bigint primary key,
  name text not null,
  category text not null default 'Accesorios',
  price numeric(12,2) not null default 0,
  icon text default '☀️',
  description text default '',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  order_number text unique not null,
  customer_name text not null,
  customer_id text not null,
  phone text not null,
  email text,
  address text not null,
  delivery_method text not null,
  notes text,
  total numeric(12,2) not null default 0,
  status text not null default 'pending',
  created_at timestamptz not null default now()
);

create table if not exists order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references orders(id) on delete cascade,
  name text not null,
  qty integer not null,
  price numeric(12,2) not null,
  subtotal numeric(12,2) not null
);

-- Seguridad: visitantes pueden leer productos activos.
alter table products enable row level security;
alter table orders enable row level security;
alter table order_items enable row level security;

drop policy if exists "public read active products" on products;
create policy "public read active products"
on products for select
using (active = true);

-- Solo usuarios autenticados pueden administrar productos.
drop policy if exists "authenticated manage products" on products;
create policy "authenticated manage products"
on products for all
to authenticated
using (true)
with check (true);

-- Los pedidos no se exponen públicamente.
-- La inserción desde el frontend requiere una política específica.
-- Para producción recomendamos mover la creación de pedidos a una Edge Function.
drop policy if exists "public create orders" on orders;
create policy "public create orders"
on orders for insert
to anon, authenticated
with check (true);

drop policy if exists "public create order items" on order_items;
create policy "public create order items"
on order_items for insert
to anon, authenticated
with check (true);

-- Carga inicial de ejemplo
insert into products(id,name,category,price,icon,description,active) values
(1,'Panel Solar 550W','Paneles',249,'☀️','Módulo fotovoltaico de alta eficiencia.',true),
(2,'Inversor Híbrido 5kW','Inversores',1299,'⚡','Solución híbrida para hogar y comercio.',true),
(3,'Batería LiFePO4 5.12kWh','Baterías',1799,'🔋','Almacenamiento de larga duración.',true),
(4,'Kit de Conectores MC4','Accesorios',29,'🔌','Conectores para instalaciones fotovoltaicas.',true)
on conflict (id) do nothing;
