# Arbol genealogico

Aplicacion HTML para crear un arbol genealogico y sincronizarlo con Supabase.

## Configurar Supabase

1. Abre tu proyecto en Supabase.
2. Ve a SQL Editor.
3. Ejecuta el contenido de `supabase-family-trees.sql`.

Los datos se guardan en tablas normalizadas:

- `people`: una fila por integrante.
- `relations`: una fila por relacion.

La tabla `family_trees` queda como respaldo/migracion del formato anterior.

## Configuracion publica

El HTML no contiene la URL ni la anon key de Supabase. Las carga desde la Edge Function `public-config`.

En Supabase configura estos secretos:

```powershell
supabase secrets set PUBLIC_SUPABASE_URL=https://TU_PROYECTO.supabase.co
supabase secrets set PUBLIC_SUPABASE_ANON_KEY=TU_ANON_KEY
```

Despliega la funcion:

```powershell
supabase functions deploy public-config --no-verify-jwt
```

La funcion debe responder en:

```text
https://TU_PROYECTO.supabase.co/functions/v1/public-config
```

## Login familiar

La pagina usa Supabase Auth y no muestra registro publico.

1. En Supabase, ve a Authentication > Users.
2. Crea manualmente los usuarios autorizados con su correo y clave.
3. En Authentication > Providers > Email, desactiva los registros publicos si no quieres que nadie cree cuentas.
4. Vuelve a ejecutar `supabase-family-trees.sql` para que la tabla solo permita acceso a usuarios autenticados.

En la pagina se entra con:

- Correo: el correo creado en Supabase Auth
- Clave: la clave familiar acordada

## Subir a GitHub

Cuando quieras publicarlo:

```powershell
git init
git add .
git commit -m "Conectar arbol genealogico con Supabase"
git branch -M main
git remote add origin URL_DE_TU_REPOSITORIO
git push -u origin main
```
