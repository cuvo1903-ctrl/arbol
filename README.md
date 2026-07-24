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
