# EcoSolarHub v3 — Cuba

Versión rediseñada para una tienda/empresa de energía solar en Cuba.

**WhatsApp:** +53 55496198  
**Dirección física:** no se publica; se facilita de forma privada por WhatsApp.

## Qué incluye

- Portada dedicada a sistemas fotovoltaicos.
- Barra horizontal: Inicio, Equipos, Servicios, Accesorios, Proyectos y Contacto.
- Proyectos realizados visibles al deslizar hacia abajo.
- Catálogo separado de equipos, servicios y accesorios.
- Foto, descripción y precio para equipos, accesorios y servicios.
- Servicios con precio editable.
- Galería de proyectos con foto, nombre, ubicación y descripción.
- Carrito de compras.
- Prefactura PDF sin carnet de identidad.
- Dos espacios de firma: cliente y empresa.
- Pie de documento: **“Prefactura generada electrónicamente”**.
- WhatsApp +53 55496198.
- Administrador para agregar, editar, ocultar y eliminar equipos, accesorios, servicios y proyectos.
- Subida de fotografías desde Android mediante el selector de archivos/cámara.
- Modo local para probar el administrador sin configurar Supabase.
- Integración preparada con Supabase para que los cambios se compartan entre dispositivos.
- Función Edge de Supabase preparada para enviar automáticamente el PDF como documento por WhatsApp Cloud API.

## Archivos

```text
EcoSolarHub/
├── index.html
├── database.sql
├── README.md
├── assets/
│   └── logo.png
└── supabase/
    ├── config.toml
    └── functions/
        └── send-whatsapp-prefactura/
            └── index.ts
```

## 1. Publicar en GitHub Pages

1. Abre el repositorio de GitHub.
2. Sube `index.html`, `database.sql` y `README.md`.
3. Crea/sube la carpeta `assets` y coloca `logo.png` dentro.
4. Sube la carpeta `supabase` si quieres configurar la automatización de WhatsApp.
5. Ve a **Settings → Pages**.
6. En **Build and deployment**, selecciona **Deploy from a branch**.
7. Selecciona la rama `main` y la carpeta `/ (root)`.
8. Guarda y espera a que GitHub publique la página.

## 2. Administrador sin Supabase

La página incluye un modo local. Al pulsar **Administrador** puedes agregar, editar y eliminar elementos. Las fotografías se pueden seleccionar desde Android y se guardan localmente en el navegador.

Este modo sirve para probar el diseño, pero **no es suficiente para una tienda pública**, porque los cambios quedan en el dispositivo donde se hicieron.

## 3. Supabase — catálogo compartido

Para que los cambios del administrador sean visibles para todos los clientes:

1. Crea un proyecto en Supabase.
2. Abre **SQL Editor**.
3. Copia todo el contenido de `database.sql` y ejecútalo.
4. En **Authentication → Users**, crea el usuario que utilizarás como administrador.
5. En la página, abre **Administrador → Ajustes**.
6. Introduce:
   - Supabase URL
   - Supabase anon key
7. Pulsa **Guardar ajustes** y después **Conectar ahora**.

La página cargará los elementos publicados desde Supabase. Los cambios realizados desde el panel administrador se pueden sincronizar con las tablas `catalog_items` y `projects`.

### Importante sobre seguridad

La clave `anon` puede utilizarse en el frontend cuando las políticas RLS están correctamente configuradas. **Nunca pongas en `index.html` la `service_role key` de Supabase ni el token de WhatsApp Cloud API.**

## 4. Fotos de equipos, accesorios, servicios y proyectos

Desde el administrador puedes editar un elemento y elegir una foto desde Android.

Cuando Supabase está configurado, las fotos se suben a:

- `catalogo` para equipos, accesorios y servicios.
- `proyectos` para proyectos realizados.

Los clientes pueden ver las fotos publicadas porque esos buckets están configurados como públicos en `database.sql`. Solo usuarios autenticados pueden modificar las imágenes.

## 5. Prefactura PDF

El formulario solicita:

- Nombre completo
- WhatsApp/teléfono
- Correo electrónico (opcional)
- Dirección
- Entrega a domicilio / recogida en tienda
- Notas

**No solicita carnet de identidad.**

El PDF incluye:

- Número de prefactura
- Fecha
- Datos del cliente
- Productos/servicios
- Cantidades
- Precios
- Total
- Firma del cliente
- Firma de la empresa
- “Prefactura generada electrónicamente”

## 6. Envío automático del PDF por WhatsApp

El navegador por sí solo no puede adjuntar automáticamente un PDF a un mensaje de WhatsApp. Para hacerlo de forma automática se incluye una **Supabase Edge Function**.

Ruta:

```text
supabase/functions/send-whatsapp-prefactura/index.ts
```

La función:

1. Recibe el PDF generado en el navegador.
2. Lo sube temporalmente a WhatsApp Cloud API.
3. Envía el PDF como documento al número de WhatsApp configurado.

### Configuración de WhatsApp Cloud API

Necesitas una cuenta de Meta/WhatsApp Business y un número habilitado para WhatsApp Cloud API.

Configura los secretos en Supabase, nunca en `index.html`:

```text
WHATSAPP_ACCESS_TOKEN=tu_token_de_meta
WHATSAPP_PHONE_NUMBER_ID=tu_phone_number_id
```

Luego despliega la función:

```bash
supabase functions deploy send-whatsapp-prefactura --no-verify-jwt
```

El archivo `supabase/config.toml` ya contiene:

```toml
[functions.send-whatsapp-prefactura]
verify_jwt = false
```

Esto permite que el cliente de la tienda invoque la función sin iniciar sesión. Antes de usarla en producción se recomienda añadir controles antispam/rate-limit y restricciones de origen.

## 7. Qué falta para una puesta en producción profesional

- Configurar Supabase real.
- Crear el usuario administrador.
- Configurar las fotos reales de productos y proyectos.
- Configurar Meta/WhatsApp Cloud API si se desea envío automático del PDF.
- Probar el flujo completo de prefactura y entrega.
- Revisar las políticas comerciales, privacidad y requisitos fiscales aplicables en Cuba.

## 8. Datos públicos

La página utiliza:

**EcoSolarHub**  
**Cuba**  
**WhatsApp: +53 55496198**

La dirección física **no se muestra públicamente**.
