# Plantilla de documento IngenIA (Typst)

Convierte un documento en Markdown en un PDF con la identidad corporativa del manual v5.0
(`../identidad-corporativa/`): portada azul de página completa, cabecera con logo y línea verde,
Poppins 10,5 pt, títulos azules, tablas con cabecera azul y llamadas en menta.

## Uso

1. Instala [Typst](https://typst.app) (0.14 o superior). La primera compilación descarga el paquete `cmarker`.
2. Copia `ejemplo.typ` junto a tu `.md` y cambia `titulo`, `subtitulo`, `version`, `pie` y el nombre del `.md`.
3. Si tu `.md` empieza con un bloque YAML (`---`), quítalo como en `../H1-especificacion-inicial/H1.typ`.
4. Compila desde la **raíz del repo**:

```
typst compile --root . --font-path identidad-corporativa/fonts plantilla-documento/ejemplo.typ ejemplo.pdf
```

Si tu `.typ` está en otra carpeta, importa la plantilla con la ruta relativa (`../plantilla-documento/ingenia-doc.typ`);
`--root .` debe ser la raíz del repo.

## Notas

- Solo Poppins y la paleta del manual (sin naranja). Poppins no tiene la flecha →: la plantilla la dibuja.
- Las tablas no parten una fila entre dos páginas.
- La portada no cuenta en la numeración.
