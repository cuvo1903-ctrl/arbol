# Arbol genealogico

Aplicacion HTML para crear un arbol genealogico y sincronizarlo con Supabase.

## Configurar Supabase

1. Abre tu proyecto en Supabase.
2. Ve a SQL Editor.
3. Ejecuta el contenido de `supabase-family-trees.sql`.
4. En `index.html`, reemplaza:
   - `PEGA_AQUI_TU_SUPABASE_URL`
   - `PEGA_AQUI_TU_SUPABASE_ANON_KEY`

Los datos se guardan en la tabla `family_trees`, dentro del campo `data`.

## Login familiar

La pagina usa Supabase Auth y no muestra registro publico.

1. En Supabase, ve a Authentication > Users.
2. Crea un usuario manual:
   - Email: `familia@arbol.local`
   - Password: la clave familiar acordada
   - Email confirm: confirmado
3. En Authentication > Providers > Email, desactiva los registros publicos si no quieres que nadie cree cuentas.
4. Vuelve a ejecutar `supabase-family-trees.sql` para que la tabla solo permita acceso a usuarios autenticados.

En la pagina se entra con:

- Usuario: `usuario familia`
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
