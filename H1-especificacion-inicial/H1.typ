#import "@preview/cmarker:0.1.6"
#import "../plantilla-documento/ingenia-doc.typ": *

#let md = read("Entregable-H1.md")
// Quita el bloque YAML inicial; el título va en la portada.
#let md = md.replace(regex("^---\r?\n[\s\S]*?\r?\n---\r?\n"), "")

#show: ingenia.with(
  titulo: "VOICE-BITTLE",
  subtitulo: "H1 — Análisis del problema y definición de requisitos",
  etiqueta: "IngenIA Robótica · ETSII–UPM · curso 2026–2027",
  version: "v1.0 · octubre 2026 · Equipo IngenIA Robótica",
  pie: "VOICE-BITTLE · H1 · v1.0 · octubre 2026",
)

#cmarker.render(md, blockquote: quote.with(block: true))
