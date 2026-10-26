# Instrucciones para el agente: compilar un documento con la plantilla IngenIA

Objetivo: convertir un documento en Markdown (`.md`) en un PDF con la identidad corporativa de IngenIA
(manual v5.0). Todo está en este repo. No inventes colores, fuentes ni logos: usa solo lo que hay aquí.

## Qué necesitas

- Typst 0.14 o superior (`typst --version`). Instalación: https://typst.app (Windows: `winget install Typst.Typst`).
- Internet la primera vez: Typst descarga el paquete `@preview/cmarker:0.1.6`, que lee Markdown.
- Este repo clonado. Todos los comandos se ejecutan **desde la raíz del repo**.
- No necesitas instalar Poppins: está en `identidad-corporativa/fonts/`.

## Archivos que usarás

| Archivo | Para qué |
|---|---|
| `plantilla-documento/ingenia-doc.typ` | La plantilla (función `ingenia`). No la edites para un documento concreto. |
| `plantilla-documento/ejemplo.typ` y `ejemplo.md` | Punto de partida. Cópialos. |
| `H1-especificacion-inicial/H1.typ` | Ejemplo real de uso desde otra carpeta. |
| `identidad-corporativa/fonts/` | Tipografía Poppins (se pasa con `--font-path`). |

## Pasos

1. **Escribe o localiza el `.md`** del documento. Los encabezados llevan su numeración en el texto (`# 1. Introducción`);
   la plantilla no numera.
2. **Crea el `.typ`** junto al `.md`: copia `plantilla-documento/ejemplo.typ` a la carpeta del documento.
   - Si el `.typ` queda en `plantilla-documento/`, la importación `#import "ingenia-doc.typ": *` ya vale.
   - Si queda en otra carpeta, cambia la importación a la ruta relativa, por ejemplo
     `#import "../plantilla-documento/ingenia-doc.typ": *` (como en `H1-especificacion-inicial/H1.typ`).
3. **Rellena los parámetros** de `#show: ingenia.with(...)`:

   | Parámetro | Qué pone | Ejemplo |
   |---|---|---|
   | `titulo` | Título grande de la portada | `"VOICE-BITTLE"` |
   | `subtitulo` | Línea bajo el título | `"H1 — Análisis del problema y definición de requisitos"` |
   | `etiqueta` | Línea pequeña sobre el título y texto de la cabecera | `"IngenIA Robótica · ETSII–UPM · curso 2026–2027"` |
   | `version` | Texto abajo a la izquierda de la portada | `"v1.0 · octubre 2026 · Equipo IngenIA Robótica"` |
   | `pie` | Pie de cada página | `"VOICE-BITTLE · H1 · v1.0 · octubre 2026"` |

   Usa los datos del documento. Si falta uno, déjalo vacío o pregunta; no lo inventes.
4. **Apunta al `.md`**: la última línea del `.typ` es `#cmarker.render(read("NOMBRE.md"), blockquote: quote.with(block: true))`.
   Cambia `NOMBRE.md`. La ruta es relativa al `.typ`.
5. **Quita el bloque YAML** si el `.md` empieza con `---` ... `---` (el título ya va en la portada). Copia de `H1.typ` estas dos líneas
   y usa `md` en `cmarker.render`:
   ```
   #let md = read("NOMBRE.md")
   #let md = md.replace(regex("^---\r?\n[\s\S]*?\r?\n---\r?\n"), "")
   ```
6. **Compila** desde la raíz del repo:
   ```
   typst compile --root . --font-path identidad-corporativa/fonts RUTA/DEL/documento.typ RUTA/DEL/documento.pdf
   ```
   Ejemplo real: `typst compile --root . --font-path identidad-corporativa/fonts H1-especificacion-inicial/H1.typ H1-especificacion-inicial/Entregable-H1.pdf`
7. **Comprueba el resultado** (ver abajo) y enseña el PDF al usuario antes de darlo por bueno.

## Comprobaciones

- Compila sin errores. Si Typst avisa de una fuente desconocida, falta `--font-path identidad-corporativa/fonts`.
- `pdffonts documento.pdf`: solo debe aparecer Poppins. Si sale otra fuente, hay un carácter que Poppins no tiene
  (la flecha `→` ya la dibuja la plantilla); cámbialo en el `.md` o avisa.
- Página 1: portada azul de página completa, sin cabecera ni pie. Página 2 en adelante: logo y línea verde arriba, `n / total` abajo
  (la portada no cuenta).
- Tablas: cabecera azul, sin filas partidas entre páginas. Cita (`>`): caja menta con filete verde.
- Sin naranja en ningún sitio.

## Errores frecuentes

| Síntoma | Causa y arreglo |
|---|---|
| `file not found` / `access denied` al importar o leer | Falta `--root .` o el comando no se lanza desde la raíz del repo. |
| `failed to download package` | Sin internet en la primera compilación. Reintenta con red. |
| Sale una línea `---` y un `title:` al principio | El `.md` tiene YAML y no se quitó (paso 5). |
| Listas mal anidadas o tablas rotas | Falta línea en blanco antes de la lista o la tabla en el `.md`. Corrígelo en el `.md`. |
| El texto no es Poppins | Falta `--font-path identidad-corporativa/fonts`. |

## Reglas

- No cambies `ingenia-doc.typ`, los logos ni los colores para un documento concreto. Si hace falta un cambio en la plantilla,
  propónlo como cambio aparte y avisa al equipo.
- No cambies el contenido del `.md` al compilar. Lo que no se entienda en el texto se pregunta; no se reescribe.
- Guarda el PDF junto al `.md` y súbelo con el mismo commit que los cambios del texto, o recompílalo después de cada cambio del `.md`.
- Los colores y tamaños oficiales están en `identidad-corporativa/Manual-Identidad_v5.0_IngenIA_AtenIA.pdf`
  (sección 9, «Documentos y diapositivas»).
