// Ejemplo mínimo: copia este archivo, cambia los textos y el nombre del .md.
#import "@preview/cmarker:0.1.6"
#import "ingenia-doc.typ": *

#show: ingenia.with(
  titulo: "Título del documento",
  subtitulo: "Subtítulo o hito",
  etiqueta: "IngenIA Robótica · ETSII–UPM · curso 2026–2027",
  version: "v0.1 · octubre 2026 · Equipo IngenIA Robótica",
  pie: "Título corto · v0.1 · octubre 2026",
)

#cmarker.render(read("ejemplo.md"), blockquote: quote.with(block: true))
