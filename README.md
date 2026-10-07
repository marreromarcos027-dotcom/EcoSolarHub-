# EcoSolarHub v4

Versión de prueba de la tienda de EcoSolarHub (Cuba).

## Incluye
- Portada visual con imágenes de fondo y estilo moderno.
- Navegación: Inicio, Equipos, Accesorios, Servicios y Proyectos.
- Equipos, accesorios y servicios con foto, descripción y precio.
- Selector de cantidad por artículo; especialmente pensado para accesorios.
- Carrito con cantidades y totales.
- Prefactura con nombre, teléfono, correo, dirección, modalidad y notas.
- Sin carnet de identidad.
- Panel de administrador de prueba para agregar, editar y eliminar equipos, accesorios, servicios y proyectos.
- Subida de fotos desde Android en el panel de prueba.
- Usuario de prueba: `admin`
- Clave temporal: `EcoSolarHub2026!`

## IMPORTANTE SOBRE EL ADMINISTRADOR
Esta v4 es una versión de prueba para GitHub Pages. Los cambios del panel se guardan en `localStorage` del navegador del dispositivo donde se hacen. Por tanto, no es todavía un administrador multiusuario seguro ni sincronizado.

Para producción hay que conectar el panel a Supabase:
- Authentication para el usuario administrador.
- Database para productos/proyectos.
- Storage para las fotografías.
- Políticas RLS para impedir escrituras públicas.

No publiques una contraseña real dentro de `index.html`. La clave anterior es únicamente de demostración.

## WhatsApp y PDF
El botón de prefactura prepara el pedido y abre WhatsApp con el número +53 55496198. El envío automático del PDF como archivo adjunto no se puede realizar únicamente desde GitHub Pages: requiere un backend/Edge Function y WhatsApp Cloud API. La arquitectura queda preparada para esa siguiente etapa.

## GitHub Pages
Sube `index.html`, `database.sql`, `README.md` y `assets/logo.png`. En Settings > Pages usa:
- Deploy from a branch
- main
- /(root)

## Identidad
EcoSolarHub · Cuba
WhatsApp: +53 55496198
La dirección física se comparte de forma privada por WhatsApp.
