# EcoSolarHub — sitio web final

## Identidad
- Empresa: **EcoSolarHub**
- País: **Cuba**
- WhatsApp: **+53 55496198**
- Dirección de la tienda física: **no se publica en el sitio; se entrega al cliente por WhatsApp de forma privada**.
- Logo: `assets/logo.png`

## Archivos
- `index.html` — sitio web.
- `assets/logo.png` — logo oficial generado para EcoSolarHub.
- `database.sql` — estructura inicial de Supabase.
- `README.md` — instrucciones.

## Publicar en GitHub Pages
1. Crea un repositorio en GitHub.
2. Sube `index.html`, la carpeta `assets` y `database.sql`.
3. Ve a Settings → Pages.
4. Selecciona Deploy from branch → `main` → `/ (root)`.
5. Guarda.

## Administración real
El sitio ya está preparado para Supabase. En `index.html` reemplaza:
- `TU_SUPABASE_URL`
- `TU_SUPABASE_ANON_KEY`

Luego ejecuta `database.sql` en el SQL Editor de Supabase y crea el usuario administrador en Authentication.

## WhatsApp
El número de EcoSolarHub está configurado como +53 55496198. El sitio abre WhatsApp con el pedido prellenado. Para enviar automáticamente el PDF al cliente y a la empresa se requiere WhatsApp Business Cloud API desde una función de servidor; nunca se debe poner el token secreto en el HTML.

## Privacidad
La dirección de la tienda no se muestra públicamente. El cliente recibe las instrucciones de recogida por WhatsApp.
Antes de almacenar datos reales de clientes, hay que revisar las obligaciones de privacidad y seguridad aplicables en Cuba.
