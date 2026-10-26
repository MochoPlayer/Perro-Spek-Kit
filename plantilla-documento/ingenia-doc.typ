// Plantilla de documento · IngenIA Robótica (identidad corporativa, manual v5.0)
// Reglas: A4 vertical, márgenes 2,5 cm, Poppins 10,5 pt sin justificar, títulos SemiBold Azul,
// tablas con cabecera Azul y bordes redondeados, llamadas Menta, sin naranja.
// Build (desde la raíz del repo): typst compile --root . --font-path identidad-corporativa/fonts plantilla-documento/ejemplo.typ

#let navy = rgb("#13294B")
#let teal = rgb("#12A39A")
#let deep = rgb("#0B6F69")
#let mint = rgb("#E1F3F1")
#let slate = rgb("#5C6B7A")
#let mist = rgb("#F7F9FB")
#let fog = rgb("#D5DCE3")

#let ingenia(titulo: "", subtitulo: "", etiqueta: "", pie: "", version: "", body) = {
  set document(title: titulo + " · " + subtitulo, author: "IngenIA Robótica")
  set text(font: "Poppins", size: 10.5pt, fill: navy, lang: "es")
  set par(leading: 0.65em, spacing: 1em, justify: false)
  set page(
    paper: "a4",
    margin: (x: 2.5cm, top: 3cm, bottom: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 8.5pt, fill: slate)
        grid(columns: (auto, 1fr), column-gutter: 10pt, align: (left + horizon, right + horizon),
          image("logo-sin-lema.svg", height: 0.9cm), [#etiqueta])
        v(-4pt)
        line(length: 100%, stroke: 1.2pt + teal)
      }
    },
    footer: {
      set text(size: 8.5pt, fill: slate)
      grid(columns: (1fr, auto), align: (left, right), [#pie],
        context text(weight: "semibold", fill: navy)[#counter(page).get().first() / #counter(page).final().first()])
    },
  )
  set smartquote(quotes: "“”")

  show strong: set text(weight: "semibold")
  // Poppins no trae la flecha →: se dibuja como en el manual (sin otra tipografía).
  show "→": context {
    let c = text.fill
    box(width: 3.6mm, height: 0.9em, baseline: 15%, curve(
      stroke: (paint: c, thickness: 0.9pt, cap: "round", join: "round"),
      curve.move((0pt, 0.45em)), curve.line((3.4mm, 0.45em)),
      curve.move((2.2mm, 0.2em)), curve.line((3.4mm, 0.45em)), curve.line((2.2mm, 0.7em))))
  }
  show raw: set text(font: "Poppins")
  show link: set text(fill: deep)
  show raw.where(block: false): it => box(fill: mint, radius: 3pt, inset: (x: 3pt), outset: (y: 3pt), text(size: 9pt, fill: deep, it))
  show raw.where(block: true): it => block(fill: mist, stroke: 0.6pt + fog, radius: 6pt, inset: 9pt, width: 100%, text(size: 9pt, it))

  show heading: set text(font: "Poppins", weight: "semibold", fill: navy)
  show heading.where(level: 1): it => {
    v(1.2em, weak: true)
    block(sticky: true, width: 100%, below: 0.8em)[
      #text(size: 17pt, it.body)
      #v(-4pt)
      #line(length: 100%, stroke: 1.2pt + teal)
    ]
  }
  show heading.where(level: 2): it => block(sticky: true, above: 1.4em, below: 0.7em, text(size: 13pt, it.body))
  show heading.where(level: 3): it => block(sticky: true, above: 1.2em, below: 0.6em, text(size: 11pt, fill: deep, it.body))

  set list(indent: 0.5em, body-indent: 0.6em, spacing: 0.7em, marker: text(fill: teal)[•])
  set enum(indent: 0.5em, body-indent: 0.6em, spacing: 0.7em)

  // Llamadas: las citas del Markdown pasan a caja Menta con filete Verde.
  show quote.where(block: true): it => block(width: 100%, fill: mint, radius: 4pt, inset: 10pt,
    stroke: (left: 3pt + teal), text(size: 9.5pt, it.body))

  // Tablas: cabecera Azul, filas alternas Niebla, bordes redondeados.
  set table(
    fill: (x, y) => if y == 0 { navy } else if calc.odd(y) { white } else { mist },
    stroke: 0.5pt + fog,
    inset: (x: 5pt, y: 4pt),
    align: left + horizon,
  )
  show table: set text(size: 8pt)
  show table.cell: it => block(breakable: false, it)
  show table.cell.where(y: 0): set text(fill: white, weight: "semibold")
  show table: it => block(radius: 6pt, clip: true, stroke: 0.6pt + fog, it)
  show figure.where(kind: table): set block(breakable: true)

  // Portada de página completa (manual v5.0, sección 9): fondo Azul, logo arriba a la izquierda,
  // título grande, versión abajo a la izquierda y píldora Verde abajo a la derecha.
  page(fill: navy, margin: 2.5cm, header: none, footer: none)[
    #image("logo-mono-blanco.svg", width: 52mm)
    #v(1fr)
    #text(fill: rgb("#AFB8C4"), size: 10pt, weight: "medium", tracking: 0.08em)[#upper(etiqueta)]
    #v(6pt)
    #text(fill: white, size: 34pt, weight: "semibold")[#titulo]
    #v(4pt)
    #text(fill: white, size: 17pt)[#subtitulo]
    #v(1.2fr)
    #grid(columns: (1fr, auto), align: (left + bottom, right + bottom),
      text(fill: fog, size: 11pt)[#version],
      box(width: 36mm, height: 8mm, radius: 4mm, fill: teal))
  ]
  counter(page).update(1)

  body
}
