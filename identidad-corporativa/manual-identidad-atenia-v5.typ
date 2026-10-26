// Manual de identidad corporativa · Atenia Healthcare Robotics (v5.0, oct 2026)
// Build: typst compile --font-path ../fonts manual-identidad-atenia-v5.typ
// Sin naranja. Tamaños: 12 cuerpo · 11 pequeño · 16 apartado · 22 título · 26 sección.
// Cada página llena su altura: el contenido se reparte con filas 1fr.

#let navy = rgb("#13294B")
#let navy2 = rgb("#2A4470")
#let teal = rgb("#12A39A")
#let deep = rgb("#0B6F69")
#let mint = rgb("#E1F3F1")
#let slate = rgb("#5C6B7A")
#let mist = rgb("#F7F9FB")
#let fog = rgb("#D5DCE3")
#let red = rgb("#D64545")
#let soft = rgb("#AFB8C4")

#let S = 11pt
#let logo(name, ..args) = image("assets/" + name + ".svg", ..args)

#set document(title: "Manual de identidad corporativa · Atenia Healthcare Robotics", author: "IngenAI Robótica · Grupo 1")
#set text(font: "Poppins", size: 12pt, fill: navy, lang: "es")
#set par(leading: 0.55em, justify: false)
#show raw: set text(font: "Poppins", size: S)

#let footer-line() = {
  set text(size: S, fill: slate)
  grid(columns: (1fr, auto), align: (left, right),
    [Atenia Healthcare Robotics · Manual de identidad · v5.0 · octubre 2026],
    context text(weight: "semibold", fill: navy)[#str(counter(page).get().first()) / #str(counter(page).final().first())])
}

#set page(paper: "a4", flipped: true, margin: (x: 16mm, top: 14mm, bottom: 14mm),
  footer: context { if counter(page).get().first() > 1 { footer-line() } })

// ── Capítulos: cada grupo de secciones tiene su color de banner
#let chapter(num) = {
  let n = if num == "" or num == "·" { 99 } else { int(num) }
  if n == 0 or n == 99 { (slate, "Introducción") }
  else if n <= 4 { (navy, "Marca") }
  else if n <= 8 { (deep, "Identidad visual") }
  else { (teal, "Aplicación") }
}

#let section(num, name, title: none) = {
  let (c, grp) = chapter(num)
  pad(x: -16mm, top: -14mm, bottom: 3mm,
    block(fill: c, width: 100%, height: 30mm, inset: (x: 16mm),
      grid(columns: (auto, 1fr, auto), rows: (30mm,), column-gutter: 12pt, align: horizon,
        text(size: 44pt, weight: "semibold", fill: white)[#if num == "" [·] else [#num]],
        [#text(size: S, fill: white, tracking: 1.2pt, weight: "medium")[#upper(grp)] \ #text(size: 26pt, weight: "semibold", fill: white)[#name]],
        logo("logo-mono-blanco", width: 36mm))))
  if title != none { text(size: 22pt, weight: "semibold")[#title]; v(4pt) }
}

// Zona de contenido: ocupa todo el alto que queda en la página
#let area(body) = block(width: 100%, height: 1fr, body)

#let hd(t) = { v(2pt); text(size: 16pt, weight: "semibold")[#t]; v(1pt) }
#let sm(t) = text(size: S, t)
#let note(t) = text(size: S, fill: slate, t)
#let label(t) = text(size: S, fill: slate, weight: "medium", upper(t))
#let card(body, fill: mist, ..args) = block(fill: fill, radius: 8pt, inset: 12pt, width: 100%, ..args, body)
// Tarjeta que se estira a la altura de su celda
#let fcard(body, fill: mist, stroke: none, inset: 12pt, v: top) = block(width: 100%, height: 100%, fill: fill, stroke: stroke, radius: 8pt, inset: inset, align(v, body))
#let pill(t, fill: teal, fg: white) = box(fill: fill, radius: 50%, inset: (x: 9pt, y: 3.5pt), text(fill: fg, size: S, weight: "medium", t))
#let ok = box(fill: teal, radius: 50%, inset: (x: 6pt, y: 2pt), text(fill: white, size: S, weight: "semibold")[SÍ])
#let ko = box(fill: red, radius: 50%, inset: (x: 6pt, y: 2pt), text(fill: white, size: S, weight: "semibold")[NO])
#let cap(t, d) = { v(-2pt); text(weight: "semibold")[#t]; linebreak(); note(d) }

// Tabla con bordes redondeados. stretch: true la estira a la altura de su celda.
#let btable(cols, stretch: false, ..cells) = {
  let n = calc.ceil(cells.pos().len() / cols.len())
  block(clip: true, radius: 8pt, stroke: 0.8pt + fog, width: 100%, height: if stretch { 100% } else { auto },
    table(columns: cols, rows: if stretch { (auto,) + (1fr,) * (n - 1) } else { auto }, inset: (x: 9pt, y: 7pt),
      stroke: (x, y) => (bottom: if y == 0 { none } else { 0.5pt + fog }),
      fill: (x, y) => if y == 0 { navy } else if calc.odd(y) { white } else { mist },
      align: left + horizon, ..cells))
}
#let th(t) = text(fill: white, weight: "semibold", size: S, t)

#let arc(w, d, dir: 1, c: teal, t: 1.4pt) = box(width: w, height: d,
  curve(stroke: (paint: c, thickness: t, cap: "round"),
    curve.move((0pt, if dir == 1 { 0pt } else { d })),
    curve.quad((w / 2, if dir == 1 { d * 2 } else { -d }), (w, if dir == 1 { 0pt } else { d }))))

#let picto(kind, size: 11mm) = {
  box(width: size, height: size, radius: 50%, stroke: 1.6pt + navy, fill: white, {
    place(center + horizon, dy: -size * 0.12, stack(dir: ltr, spacing: size * 0.25, circle(radius: size * 0.08, fill: navy), circle(radius: size * 0.08, fill: navy)))
    if kind == "bien" { place(center + horizon, dy: size * 0.14, arc(size * 0.42, size * 0.1, c: navy, t: 1.6pt)) }
    else if kind == "poco" { place(center + horizon, dy: size * 0.2, box(width: size * 0.4, height: 1.6pt, fill: navy, radius: 1pt)) }
    else { place(center + horizon, dy: size * 0.26, arc(size * 0.42, size * 0.1, dir: -1, c: navy, t: 1.6pt)) }
  })
}

#let check(c: navy, s: 3.6mm) = box(width: s, height: s * 0.75,
  curve(stroke: (paint: c, thickness: 1.6pt, cap: "round", join: "round"),
    curve.move((0pt, s * 0.4)), curve.line((s * 0.38, s * 0.72)), curve.line((s, 0pt))))
#let arrow(c: slate, w: 6mm) = box(width: w, height: 3.4mm,
  curve(stroke: (paint: c, thickness: 1.2pt, cap: "round", join: "round"),
    curve.move((0pt, 1.7mm)), curve.line((w, 1.7mm)), curve.move((w - 1.5mm, 0.3mm)), curve.line((w, 1.7mm)), curve.line((w - 1.5mm, 3.1mm))))

#let cross(s: 6mm, c: navy) = box(width: s, height: s,
  place(center + horizon, box(width: s / 3, height: s, radius: s / 9, fill: c)) +
  place(center + horizon, box(width: s, height: s / 3, radius: s / 9, fill: c)))

// ───────────────────────── Portada ─────────────────────────
#page(fill: navy, margin: 0pt)[
  #place(top + left, dx: 22mm, dy: 20mm, text(fill: fog, size: S, weight: "medium", tracking: 1.5pt)[INGENIA ROBÓTICA · ETSII-UPM · CURSO 2026-27])
  #place(top + left, dx: 18mm, dy: 52mm, logo("logo-negativo", width: 150mm))
  #place(top + left, dx: 22mm, dy: 128mm, block(width: 150mm)[
    #text(fill: white, size: 28pt, weight: "semibold")[Manual de identidad]
    #v(-4pt)
    #text(fill: fog, size: 16pt)[Ingesta Atenta · de Atenia Healthcare Robotics]
  ])
  #place(bottom + left, dx: 22mm, dy: -18mm, text(fill: fog, size: S)[Versión 5.0 · octubre 2026 · Equipo IngenAI Robótica · Grupo 1])
  #place(top + right, dx: -24mm, dy: 40mm, box(width: 70mm, height: 18mm, radius: 9mm, fill: teal))
  #place(top + right, dx: -50mm, dy: 75mm, circle(radius: 6mm, fill: teal))
  #place(top + right, dx: -24mm, dy: 75mm, circle(radius: 6mm, fill: teal))
  #place(top + right, dx: -24mm, dy: 104mm, box(width: 44mm, height: 90mm, radius: 12mm, stroke: 1.2pt + navy2))
  #place(top + right, dx: -42.5mm, dy: 131mm, box(width: 7mm, height: 26mm, radius: 2mm, fill: navy2))
  #place(top + right, dx: -33mm, dy: 140.5mm, box(width: 26mm, height: 7mm, radius: 2mm, fill: navy2))
]

// ───────────────────────── 0 · Cómo usar ─────────────────────────
#section("0", "Cómo usar este manual", title: "Cinco reglas y contenido")

#area(grid(columns: (1.15fr, 1fr), rows: (1fr,), column-gutter: 16pt,
  grid(rows: (1fr,) * 5, row-gutter: 8pt,
    ..for (n, t) in (
      ("1", [*El robot informa;* la persona decide.]),
      ("2", [*Primero el niño.* Voz amable y breve.]),
      ("3", [*Un dato con su incertidumbre:* «≈ 30 % (± 10 %)».]),
      ("4", [*Azul, Verde y mucho blanco.* Sin naranja ni rojo.]),
      ("5", [*Sin caras ni datos* de menores.]),
    ) {
      (fcard(fill: mist, v: horizon, inset: 14pt,
        grid(columns: (auto, 1fr), column-gutter: 14pt, align: horizon,
          box(fill: teal, radius: 50%, width: 30pt, height: 30pt, align(center + horizon, text(fill: white, weight: "semibold", size: 16pt)[#n])), text(size: 16pt)[#t])),)
    }),
  grid(columns: (1fr, 1fr), rows: (1fr,) * 7, column-gutter: 8pt, row-gutter: 8pt,
    ..for (n, t, p) in (
      ("1", "La marca", "3"), ("2", "Públicos", "4"), ("3", "Voz y tono", "5"), ("4", "Nombres", "6"),
      ("5", "Logotipo", "7–8"), ("6", "Color", "9–10"), ("7", "Tipografía", "11"), ("8", "Elementos gráficos", "12"),
      ("9", "Documentos", "13–14"), ("10", "Producto", "15"), ("11", "Otras piezas", "16"), ("12", "Accesibilidad", "17"),
      ("·", "Archivos y versiones", "18"),
    ) {
      (fcard(fill: chapter(n).first(), v: horizon, inset: 10pt,
        text(fill: white)[#text(size: 22pt, weight: "semibold")[#n] #h(4pt) #text(weight: "semibold", size: S)[#t] #h(1fr) #text(size: S)[#p]]),)
    }),
))

#pagebreak()

// ───────────────────────── 1 · La marca ─────────────────────────
#section("1", "La marca", title: "Quiénes somos")

#area(grid(columns: (1fr, 1.1fr, 1fr), rows: (1fr,), column-gutter: 14pt,
  grid(rows: (1fr, 1fr, 1fr), row-gutter: 10pt,
    fcard(v: horizon, inset: 14pt)[#text(size: 34pt, weight: "semibold")[Aten#text(fill: deep)[IA]] \ #note[atención + IA]],
    fcard(fill: mint, v: horizon, inset: 14pt)[#label[Lema] \ #text(size: 20pt, weight: "semibold")[«Cada comida cuenta.»]],
    fcard(fill: navy, v: horizon, inset: 14pt)[#set text(fill: white); #text(size: 20pt, weight: "semibold")[El sistema informa, pero no decide.]],
  ),
  grid(rows: (1fr, 1fr), row-gutter: 10pt,
    fcard(v: horizon, inset: 14pt)[#text(size: 16pt, weight: "semibold")[Misión] \ #v(2pt) #text(style: "italic")[Construir un sistema de apoyo que proporcione el seguimiento nutricional del paciente al personal sanitario y mejore la información disponible para decidir, de forma segura e integrable en la planta.]],
    fcard(v: horizon, inset: 14pt)[#text(size: 16pt, weight: "semibold")[Visión] \ #v(2pt) #text(style: "italic")[Que, tras cada comida, el personal reciba un aviso fiable de los niños que han comido claramente menos de lo esperado y de sus motivos, sin añadir carga y respetando la decisión clínica.] \ #v(2pt) #note[Fuente: «Misión y visión de Ingesta Atenta», Drive del equipo.]],
  ),
  grid(rows: (1fr,) * 4, row-gutter: 10pt,
    ..for (t, c, d) in (
      ("Cuidado", teal, "El niño primero."),
      ("Rigor", navy, "Cada dato con su incertidumbre."),
      ("Discreción", slate, "Ni imágenes ni audio salen del robot."),
      ("Respeto", deep, "Un «no» siempre vale."),
    ) {
      (fcard(v: horizon, inset: 12pt,
        grid(columns: (7pt, 1fr), column-gutter: 12pt, rows: (auto,),
          block(width: 7pt, height: 44pt, radius: 3.5pt, fill: c),
          align(horizon)[#text(size: 18pt, weight: "semibold")[#t] \ #sm(d)])),)
    }),
))

#pagebreak()

// ───────────────────────── 2 · Públicos ─────────────────────────
#section("2", "Públicos", title: "A quién hablamos")

#area(grid(rows: (1.6fr, auto, 1fr), row-gutter: 8pt,
  btable((1.2fr, 2fr, 1.6fr), stretch: true,
    th[Público], th[Necesita], th[Tono],
    sm[*Enfermería y TCAE*], sm[Datos fiables, sin tareas nuevas], sm[Exacto, sin exclamaciones],
    sm[*Niños*], sm[Algo breve y amable], sm[Tú, positivo],
    sm[*Familias*], sm[Saber qué se guarda y poder decir no], sm[Cálido, explica el porqué],
    sm[*Pediatras y dietistas*], sm[Datos comparables entre días], sm[Preciso, con fuente],
    sm[*TI y mantenimiento*], sm[Poca carga de red, privacidad], sm[Técnico, con cifras],
    sm[*Profesorado*], sm[Hechos separados de hipótesis], sm[Académico claro],
  ),
  hd[Una comida, paso a paso],
  grid(columns: (1fr,) * 4, rows: (1fr,), column-gutter: 12pt,
    ..for (n, t, d) in (
      ("1", "Llega el carro", "El robot acompaña."),
      ("2", "Mira la bandeja", "Sin guardar imágenes."),
      ("3", "Pregunta breve", "Solo si el niño quiere."),
      ("4", "Aviso", "Porcentaje, kcal y motivo."),
    ) {
      (fcard(fill: white, stroke: 0.8pt + fog, v: horizon, inset: 14pt)[
        #text(size: 36pt, weight: "semibold", fill: teal)[#n] \
        #text(size: 16pt, weight: "semibold")[#t] \
        #sm(d)
      ],)
    }),
))

#pagebreak()

// ───────────────────────── 3 · Voz y tono ─────────────────────────
#section("3", "Voz y tono", title: "Cómo suena Atenia")

#area(grid(columns: (1fr, 1.45fr, 1fr), rows: (1fr,), column-gutter: 14pt,
  grid(rows: (1.25fr, 1fr, 1fr), row-gutter: 10pt,
    fcard(fill: mint, inset: 12pt)[#text(size: 16pt, weight: "semibold")[Somos] \ #v(4pt) #grid(columns: (auto, auto), column-gutter: 5pt, row-gutter: 5pt, ..("Cercanos", "Claros", "Serenos", "Honestos", "Respetuosos").map(t => pill(t, fill: teal)))],
    fcard(fill: mist, inset: 12pt)[#text(size: 16pt, weight: "semibold")[No somos] \ #v(4pt) #grid(columns: (auto, auto), column-gutter: 5pt, row-gutter: 5pt, ..("Infantiles", "Técnicos", "Alarmistas", "Exagerados").map(t => pill(t, fill: slate)))],
    fcard(fill: white, stroke: 0.8pt + fog, inset: 12pt)[#text(size: 16pt, weight: "semibold")[Reglas] \ #v(4pt) • Frases cortas. \ • Dato con fuente. \ • Lo pendiente se dice. \ • Un término por cosa.],
  ),
  {
    let ex(who, good, bad) = fcard(fill: white, stroke: 0.8pt + fog, v: horizon, inset: 12pt)[
      #label(who) \ #v(2pt)
      #ok #h(4pt) #text(weight: "medium")[#good] \ #v(3pt)
      #ko #h(4pt) #text(fill: slate)[#bad]
    ]
    grid(rows: (1fr,) * 4, row-gutter: 10pt,
      ex("Al niño", "«¡Hola! ¿Qué tal la comida?»", "«Debes terminar el plato.»"),
      ex("A enfermería", "«Hab. 204 · ≈ 30 % (± 10 %) · sin apetito»", "«¡ALERTA! Riesgo detectado.»"),
      ex("En documentos", "«El sistema informa; decide el personal.»", "«IA disruptiva, 100 % precisa.»"),
      ex("Ante un fallo", "«Comida no evaluada: bandeja fuera de vista.»", "«Error crítico.»"))
  },
  grid(rows: (auto, 1fr), row-gutter: 6pt,
    hd[Palabras],
    btable((1fr, 1fr), stretch: true,
      th[Usamos], th[Evitamos],
      sm[aviso], sm[alarma],
      sm[≈ 30 %], sm[come mal],
      sm[estado explícito], sm[fallo],
      sm[estimación], sm[medición exacta],
      sm[pendiente], sm[TBD],
      sm[interacción rechazada], sm[se negó],
    )),
))

#pagebreak()

// ───────────────────────── 4 · Nombres ─────────────────────────
#section("4", "Nombres", title: "Qué nombre va dónde")

#area(grid(rows: (auto, 1fr), row-gutter: 12pt,
  grid(columns: (1fr, 1fr, 1fr), column-gutter: 12pt,
    card(fill: navy, inset: 14pt)[#set text(fill: white); #text(size: S, fill: soft)[1 · EMPRESA] \ #text(size: 18pt, weight: "semibold")[Atenia Healthcare Robotics] \ #text(size: S, fill: fog)[Lleva el logotipo.]],
    card(fill: navy, inset: 14pt)[#set text(fill: white); #text(size: S, fill: soft)[2 · PRODUCTO] \ #text(size: 18pt, weight: "semibold")[Ingesta Atenta] \ #text(size: S, fill: fog)[Solo texto, sin logotipo.]],
    card(fill: navy, inset: 14pt)[#set text(fill: white); #text(size: S, fill: soft)[3 · EQUIPO] \ #text(size: 18pt, weight: "semibold")[IngenAI Robótica · Grupo 1] \ #text(size: S, fill: fog)[Solo en entregas.]],
  ),
  grid(columns: (1fr, 1fr, 1fr), rows: (1fr,), column-gutter: 12pt,
    grid(rows: (auto, 1fr), row-gutter: 6pt,
      hd[Los cinco modos],
      grid(rows: (1fr,) * 5, row-gutter: 6pt,
        ..for m in ("Reposo / Carga", "Tránsito / Navegación", "Operación de Comida", "Rechazo / Salida Amable", "Parada Segura") {
          (fcard(fill: if m == "Parada Segura" { navy2 } else { navy }, v: horizon, inset: 8pt, text(fill: white, weight: "semibold")[#m]),)
        })),
    grid(rows: (auto, 1fr), row-gutter: 6pt,
      hd[Cómo se escribe],
      btable((0.9fr, 1.3fr, 1.6fr), stretch: true,
        th[], th[Sí], th[No],
        sm[Empresa], sm[Atenia], sm[ATENIA],
        sm[Producto], sm[Ingesta Atenta], sm[IngestaAtenta],
        sm[Robot], sm[TIAGo], sm[Tiago],
        sm[Fase], sm[fase actual], sm[v1 suelta],
      )),
    grid(rows: (auto, 1fr, auto, 1.2fr), row-gutter: 6pt,
      hd[Códigos],
      btable((auto, 1fr), stretch: true,
        th[Código], th[Es],
        sm[*OP-xx*], sm[Escenario],
        sm[*RC-xx*], sm[Requisito candidato],
        sm[*DEC-xx*], sm[Decisión abierta],
        sm[*F-xx*], sm[Flujo de datos],
      ),
      hd[Archivos],
      fcard(v: horizon)[#text(weight: "semibold")[Tipo_vX.Y_Atenia_Grupo1] \ #sm[OpsCon_v0.1_Atenia_Grupo1.docx] \ #sm[Fechas: 2026-10-23]]),
  ),
))

#pagebreak()

// ───────────────────────── 5 · Logotipo ─────────────────────────
#section("5", "Logotipo", title: "Construcción y espacio")

#area(grid(columns: (1.35fr, 1fr), rows: (1fr,), column-gutter: 16pt,
  grid(rows: (1fr, auto), row-gutter: 8pt,
    fcard(inset: 0pt, v: horizon)[
      #align(center + horizon, box(stroke: (paint: teal, thickness: 1pt, dash: "dashed"), inset: 18pt,
        box(stroke: 0.4pt + fog, logo("logo-principal", width: 118mm))))
    ],
    grid(columns: (1fr, 1fr, 1fr), column-gutter: 10pt,
      [#text(weight: "semibold", size: 16pt)[Logotipo] \ #sm[Poppins SemiBold, Azul Atenia.]],
      [#text(weight: "semibold", size: 16pt)[Símbolo] \ #sm[El robot es la «i».]],
      [#text(weight: "semibold", size: 16pt)[Descriptor] \ #sm[Se quita en tamaños pequeños.]],
    ),
  ),
  grid(rows: (1fr, auto, 1fr), row-gutter: 10pt,
    fcard(v: horizon)[
      #text(size: 16pt, weight: "semibold")[Área de respeto] \ #v(4pt)
      #grid(columns: (38mm, 1fr), column-gutter: 12pt, align: horizon,
        box(stroke: (paint: teal, thickness: 1pt, dash: "dashed"), inset: 8pt, box(stroke: 0.4pt + fog, logo("logo-sin-lema", width: 22mm))),
        [Libre alrededor: *x* = altura de la cabeza del robot.])
    ],
    btable((1.3fr, 1fr, 1fr),
      th[Mínimo], th[Impreso], th[Pantalla],
      sm[Completo], sm[35 mm], sm[140 px],
      sm[Sin descriptor], sm[25 mm], sm[100 px],
      sm[Símbolo], sm[8 mm], sm[24 px],
    ),
    grid(columns: (1fr, 1fr), rows: (1fr, 1fr), column-gutter: 8pt, row-gutter: 8pt,
      fcard(fill: white, stroke: 0.8pt + fog, v: horizon, inset: 6pt, align(center, logo("logo-sin-lema", width: 30mm))),
      fcard(fill: mist, stroke: 0.8pt + fog, v: horizon, inset: 6pt, align(center, logo("logo-sin-lema", width: 30mm))),
      fcard(fill: navy, v: horizon, inset: 6pt, align(center, logo("logo-negativo", width: 30mm))),
      fcard(fill: teal, v: horizon, inset: 6pt, align(center, logo("logo-mono-blanco", width: 30mm))),
    ),
  ),
))

#pagebreak()

// ───────────────────────── 5 · Versiones ─────────────────────────
#section("5", "Logotipo", title: "Versiones y usos incorrectos")

#area(grid(columns: (1fr, 1.1fr), rows: (1fr,), column-gutter: 18pt,
  grid(rows: (1fr,) * 5, row-gutter: 8pt,
    ..for (body, name, use, fill) in (
      (logo("logo-principal", width: 42mm), "Principal", "Sobre claro.", white),
      (logo("logo-negativo", width: 42mm), "Negativo", "Sobre Azul Atenia.", navy),
      (logo("logo-mono-navy", width: 42mm), "1 color", "Ojos y cruz huecos.", white),
      (logo("logo-mono-blanco", width: 42mm), "1 color inverso", "Ojos y cruz huecos.", teal),
      (logo("simbolo", height: 24mm), "Símbolo", "Avatar e icono.", white),
    ) {
      (grid(columns: (58mm, 1fr), column-gutter: 12pt,
        fcard(fill: fill, stroke: if fill == white { 0.8pt + fog } else { none }, v: horizon, inset: 4pt, align(center, body)),
        align(horizon)[#text(weight: "semibold", size: 16pt)[#name] \ #note(use)]),)
    }),
  {
    let bad(body, c, fill: mist) = grid(rows: (1fr, auto), row-gutter: 4pt,
      block(fill: fill, radius: 6pt, width: 100%, height: 100%, clip: true, align(center + horizon, body)),
      [#ko #h(2pt) #text(size: S)[#c]])
    grid(columns: (1fr, 1fr, 1fr), rows: (1fr, 1fr, 1fr), column-gutter: 8pt, row-gutter: 8pt,
      bad(scale(x: 150%, y: 80%, reflow: true, logo("logo-sin-lema", width: 24mm)), "Deformar"),
      bad(rotate(-14deg, logo("logo-sin-lema", width: 26mm)), "Girar"),
      bad(image(bytes(read("assets/logo-sin-lema.svg").replace("#13294B", "#8E44AD").replace("#12A39A", "#F2B600")), width: 28mm), "Otros colores"),
      bad(logo("logo-sin-lema", width: 28mm), "Poco contraste", fill: teal),
      bad(text(font: "Georgia", size: 17pt, style: "italic")[Atenia #box(logo("simbolo", height: 14pt))], "Otra fuente"),
      bad(logo("logo-principal", width: 28mm), "Con ruido", fill: gradient.linear(navy2, teal, fog, angle: 30deg)),
      bad(box(stroke: 0.8pt + navy, inset: 4pt, radius: 3pt, logo("logo-sin-lema", width: 22mm)), "Con marco"),
      bad(stack(dir: ltr, spacing: 3pt, logo("simbolo", height: 13mm), logo("simbolo", height: 13mm), logo("simbolo", height: 13mm)), "Repetir"),
      bad(logo("logo-principal", width: 26mm), "Azul sobre azul", fill: navy))
  },
))

#pagebreak()

// ───────────────────────── 6 · Color ─────────────────────────
#section("6", "Color", title: "Paleta")

#area(grid(rows: (1.05fr, 1fr), row-gutter: 12pt,
  grid(columns: (1fr,) * 7, rows: (1fr,), column-gutter: 6pt,
    ..for (c, name, hex, role, fg) in (
      (navy, "Azul Atenia", "#13294B", "Textos, logo", white),
      (teal, "Verde cuidado", "#12A39A", "Acento", white),
      (deep, "Verde profundo", "#0B6F69", "Texto verde", white),
      (mint, "Menta", "#E1F3F1", "Llamadas", navy),
      (mist, "Blanco clínico", "#F7F9FB", "Fondo", navy),
      (slate, "Pizarra", "#5C6B7A", "Secundario", white),
      (fog, "Niebla", "#D5DCE3", "Bordes", navy),
    ) {
      (grid(rows: (1fr, auto),
        block(width: 100%, height: 100%, fill: c, radius: (top: 8pt), inset: 8pt, stroke: if c == mist or c == mint { 0.6pt + fog } else { none },
          align(bottom + left, text(fill: fg, weight: "semibold")[#name])),
        block(width: 100%, fill: white, stroke: 0.8pt + fog, radius: (bottom: 8pt), inset: 8pt, [#text(size: S, weight: "semibold")[#hex] \ #note(role)])),)
    }),
  grid(columns: (1.3fr, 1fr), rows: (1fr,), column-gutter: 18pt,
    grid(rows: (auto, auto, 1fr), row-gutter: 6pt,
      block(width: 100%, height: 14mm, radius: 6pt, clip: true, grid(columns: (50%, 8%, 24%, 12%, 6%), rows: 14mm,
        block(fill: mist, width: 100%, height: 100%, stroke: 0.6pt + fog, inset: 6pt, text(size: S)[Blanco 50 %]),
        block(fill: mint, width: 100%, height: 100%),
        block(fill: navy, width: 100%, height: 100%, inset: 6pt, text(fill: white, size: S)[Azul 24 %]),
        block(fill: teal, width: 100%, height: 100%, inset: 6pt, text(fill: white, size: S)[Verde]),
        block(fill: slate, width: 100%, height: 100%))),
      v(2pt),
      btable((1.5fr, 1fr, 1.4fr), stretch: true,
        th[Contraste], th[Ratio], th[Uso],
        sm[Azul / Blanco], sm[*14,5*], sm[Todo texto],
        sm[Pizarra / Blanco], sm[*5,5*], sm[Secundario],
        sm[Verde prof. / Blanco], sm[*6,0*], sm[Texto verde],
        sm[Verde / Azul], sm[*4,7*], sm[Titulares],
        sm[Verde / Blanco], sm[*3,1*], sm[Solo formas],
      )),
    fcard(v: horizon, inset: 16pt)[
      #text(size: 16pt, weight: "semibold")[Reglas] \ #v(4pt)
      #for t in ([Azul y blanco: tres cuartas partes.], [Verde: un bloque por página.], [*Sin naranja, amarillo ni rojo.*], [El color nunca va solo.], [Texto verde pequeño: Verde profundo.]) { [• #t]; linebreak(); v(2pt) }
    ],
  ),
))

#pagebreak()

// ───────────────────────── 6 · Color en uso ─────────────────────────
#section("6", "Color", title: "Estados, tintas y gráficos")

#area(grid(rows: (1fr, auto), row-gutter: 12pt,
  grid(columns: (1.15fr, 1fr), rows: (1fr,), column-gutter: 18pt,
    btable((1.7fr, 1.4fr), stretch: true,
      th[Estado], th[Cuándo],
      [#pill("Correcto", fill: teal)], sm[Ingesta esperada],
      [#pill("Aviso de baja ingesta", fill: navy)], sm[Bajo el umbral],
      [#box(stroke: 1.2pt + navy, radius: 50%, inset: (x: 9pt, y: 3.5pt), text(size: S, weight: "medium")[No evaluada])], sm[Estado explícito],
      [#box(stroke: (paint: slate, dash: "dashed", thickness: 1.2pt), radius: 50%, inset: (x: 9pt, y: 3.5pt), text(size: S, fill: slate, weight: "medium")[Rechazada])], sm[El niño dijo no],
      [#pill("Parada Segura", fill: navy2)], sm[Robot detenido],
      [#pill("Fuera de servicio", fill: slate)], sm[Autochequeo fallido],
    ),
    grid(rows: (1fr, 1.4fr), row-gutter: 10pt,
      grid(rows: (1fr,) * 3, row-gutter: 6pt,
        ..for c in (navy, teal, slate) {
          (grid(columns: (1fr,) * 5, column-gutter: 4pt,
            ..(100%, 70%, 40%, 20%, 8%).map(p => block(fill: c.transparentize(100% - p), width: 100%, height: 100%, radius: 5pt, stroke: 0.4pt + fog, align(center + horizon, text(size: S, fill: if p >= 70% { white } else { navy })[#int(p / 1%)])))),)
        }),
      fcard(fill: white, stroke: 0.8pt + fog, v: horizon, inset: 14pt)[
        #text(size: S, fill: slate, weight: "medium")[INGESTA POR COMIDA · DATOS FICTICIOS] \ #v(4pt)
        #for (n, p, c) in (("Desayuno", 78%, teal), ("Comida", 62%, teal), ("Merienda", 40%, navy2), ("Cena", 35%, navy)) {
          grid(columns: (26mm, 1fr, 13mm), column-gutter: 6pt, align: horizon,
            text(size: S)[#n], block(width: 100%, height: 6mm, radius: 3mm, fill: mist, block(width: p, height: 100%, radius: 3mm, fill: c)), text(size: S, weight: "semibold")[#int(p / 1%) %])
          v(2pt)
        }
      ],
    ),
  ),
  grid(columns: (1fr, 1fr, 1fr), column-gutter: 12pt,
    card(fill: mint, stroke: (left: 5pt + teal), inset: 14pt)[#text(size: 16pt, weight: "semibold")[Hecho] \ #sm[Menta, borde Verde.]],
    card(fill: mist, stroke: (left: 5pt + slate), inset: 14pt)[#text(size: 16pt, weight: "semibold")[Hipótesis] \ #sm[Blanco clínico, borde Pizarra.]],
    card(fill: white, stroke: (left: 5pt + navy, rest: 0.6pt + fog), inset: 14pt)[#text(size: 16pt, weight: "semibold")[Pendiente] \ #sm[Borde Azul, con responsable.]],
  ),
))

#pagebreak()

// ───────────────────────── 7 · Tipografía ─────────────────────────
#section("7", "Tipografía", title: "Poppins")

#area(grid(rows: (1.7fr, 1fr), row-gutter: 12pt,
  grid(columns: (1fr, 1.15fr), rows: (1fr,), column-gutter: 18pt,
    fcard(fill: white, stroke: 0.8pt + fog, inset: 16pt, v: horizon)[
      #text(size: 96pt, weight: "semibold")[Aa]
      #v(-10pt)
      #text(size: 17pt)[ABCDEFGHIJKLMNÑOPQRSTUVWXYZ] \
      #text(size: 17pt)[abcdefghijklmnñopqrstuvwxyz] \
      #text(size: 17pt)[0123456789 ≈ ± % kcal]
    ],
    btable((auto, 1.6fr, 1fr), stretch: true,
      th[Nivel], th[Ejemplo], th[Medida],
      sm[Sección], text(size: 26pt, weight: "semibold")[Logotipo], sm[26 pt],
      sm[Título], text(size: 22pt, weight: "semibold")[Versiones], sm[22 pt],
      sm[Apartado], text(size: 16pt, weight: "semibold")[Estados], sm[16 pt],
      sm[Texto], text(size: 12pt)[Un dato por frase.], sm[12 pt],
      sm[Pequeño], text(size: S)[Pies, etiquetas.], sm[11 pt],
    ),
  ),
  grid(columns: (1fr, 1fr, 1fr, 1fr), rows: (1fr,), column-gutter: 12pt,
    fcard(v: horizon, fill: navy)[#set text(fill: white); #text(size: 24pt, weight: "semibold")[SemiBold] \ #text(fill: fog, size: S)[Títulos]],
    fcard(v: horizon, fill: deep)[#set text(fill: white); #text(size: 24pt, weight: "medium")[Medium] \ #text(fill: fog, size: S)[Destacados]],
    fcard(v: horizon, fill: mist)[#text(size: 24pt, weight: "regular")[Regular] \ #note[Texto]],
    fcard(v: horizon, fill: mint)[#text(size: 24pt, style: "italic")[Italic] \ #note[Solo citas]],
  ),
))

#pagebreak()

// ───────────────────────── 8 · Elementos gráficos ─────────────────────────
#section("8", "Elementos gráficos", title: "Formas y estilo")

#area(grid(rows: (1fr, 1.1fr, 0.8fr), row-gutter: 12pt,
  grid(columns: (1fr, 1fr, 1fr, 1fr), rows: (1fr,), column-gutter: 10pt,
    fcard(v: horizon)[#align(center)[#box(width: 40mm, height: 10mm, radius: 5mm, fill: teal) \ #v(4pt) #text(weight: "semibold", size: 16pt)[Píldora] \ #sm[Botones y etiquetas.]]],
    fcard(v: horizon)[#align(center)[#stack(dir: ltr, spacing: 8pt, circle(radius: 5mm, fill: teal), circle(radius: 5mm, fill: teal)) \ #v(4pt) #text(weight: "semibold", size: 16pt)[Ojos] \ #sm[Motivo del logotipo.]]],
    fcard(v: horizon)[#align(center)[#cross(s: 11mm) \ #v(4pt) #text(weight: "semibold", size: 16pt)[Cruz] \ #sm[Solo para salud.]]],
    fcard(v: horizon)[#align(center)[#box(width: 20mm, height: 10mm, radius: (top: 10mm, bottom: 2mm), fill: navy) \ #v(4pt) #text(weight: "semibold", size: 16pt)[Cabeza] \ #sm[Cabeceras y tarjetas.]]],
  ),
  grid(columns: (1.15fr, 1fr), rows: (1fr,), column-gutter: 14pt,
    fcard(fill: white, stroke: 0.8pt + fog, v: horizon)[
      #text(size: 16pt, weight: "semibold")[Iconos] #h(8pt) #note[Trazo 1,5 pt, azul]
      #v(6pt)
      #grid(columns: (1fr,) * 5, row-gutter: 6pt, align: center,
        ..(
          box(width: 14mm, height: 14mm, radius: 50%, stroke: 1.6pt + navy, align(center + horizon, cross(s: 6mm))),
          box(width: 14mm, height: 14mm, radius: 50%, stroke: 1.6pt + navy, align(center + horizon, text(weight: "semibold", size: 18pt)[!])),
          box(width: 14mm, height: 14mm, radius: 50%, stroke: 1.6pt + navy, align(center + horizon, check())),
          box(width: 14mm, height: 14mm, radius: 50%, stroke: 1.6pt + navy, align(center + horizon, stack(dir: ltr, spacing: 1.6mm, box(width: 1.8mm, height: 6mm, radius: 0.9mm, fill: navy), box(width: 1.8mm, height: 6mm, radius: 0.9mm, fill: navy)))),
          box(width: 14mm, height: 14mm, radius: 50%, stroke: 1.6pt + navy, align(center + horizon, text(weight: "semibold", size: S)[kcal])),
          sm[Salud], sm[Aviso], sm[Correcto], sm[Pausa], sm[Energía],
        ))
    ],
    fcard(fill: white, stroke: 0.8pt + fog, v: horizon)[
      #text(size: 16pt, weight: "semibold")[Pictogramas] #h(8pt) #note[Siempre con texto]
      #v(6pt)
      #grid(columns: (1fr,) * 3, align: center, row-gutter: 6pt,
        picto("bien", size: 17mm), picto("poco", size: 17mm), picto("mal", size: 17mm),
        sm[Mucho], sm[Poco], sm[Nada])
    ],
  ),
  grid(columns: (1fr, 1fr, 1fr), rows: (1fr,), column-gutter: 12pt,
    fcard(fill: mint, v: horizon)[#text(weight: "semibold", size: 16pt)[Fotos: sí] \ #sm[Planta real o maqueta, luz cálida, manos y bandejas.]],
    fcard(fill: mist, v: horizon)[#text(weight: "semibold", size: 16pt)[Fotos: no] \ #sm[Caras de menores, nombres, historias clínicas.]],
    fcard(v: horizon)[#text(weight: "semibold", size: 16pt)[Espacio] \ #sm[Margen 2,5 cm, esquinas de 6 pt, un tercio libre.]],
  ),
))

#pagebreak()

// ───────────────────────── 9 · Documentos ─────────────────────────
#section("9", "Documentos y diapositivas", title: "Plantilla Word")

#area(grid(columns: (1.1fr, 1fr), rows: (1fr,), column-gutter: 20pt,
  grid(columns: (1fr, 1fr), rows: (1fr,), column-gutter: 12pt,
    fcard(fill: navy, inset: 14pt)[
      #logo("logo-mono-blanco", width: 36mm)
      #place(left + horizon, dy: 10pt, block(width: 100%)[
        #text(fill: white, size: 26pt, weight: "semibold")[Plantilla \ OpsCon] \ #v(2pt)
        #text(fill: fog, size: S)[Ingesta Atenta]
      ])
      #place(left + bottom, text(fill: fog, size: S)[v0.1 · oct 2026])
      #place(right + bottom, box(width: 30mm, height: 8mm, radius: 4mm, fill: teal))
    ],
    fcard(fill: white, stroke: 0.8pt + fog, inset: 12pt)[
      #logo("logo-sin-lema", width: 22mm)
      #v(-2pt) #line(length: 100%, stroke: 1.2pt + teal)
      #v(8pt)
      #text(size: 16pt, weight: "semibold")[1. Misión]
      #v(6pt)
      #box(width: 100%, fill: mint, radius: 4pt, inset: 8pt, stroke: (left: 3pt + teal), text(size: S)[Para qué sirve])
      #v(8pt)
      #for w in (100%, 92%, 96%, 60%) { box(width: w, height: 4pt, fill: fog, radius: 2pt); v(-3pt) }
      #v(10pt)
      #box(width: 100%, stroke: 0.4pt + fog, radius: 4pt, clip: true)[
        #box(width: 100%, height: 8mm, fill: navy)
        #for i in range(5) { box(width: 100%, height: 7mm, fill: if calc.odd(i) { mist } else { white }); v(-5pt) }
      ]
    ],
  ),
  grid(rows: (1.6fr, auto, 1fr), row-gutter: 8pt,
    btable((1fr, 2fr), stretch: true,
      th[Elemento], th[Regla],
      sm[Página], sm[A4 vertical, márgenes 2,5 cm],
      sm[Cabecera], sm[Logotipo a la izquierda, línea Verde],
      sm[Títulos], sm[Poppins SemiBold, Azul],
      sm[Cuerpo], sm[Poppins 10,5 pt, sin justificar],
      sm[Tablas], sm[Cabecera Azul, bordes redondeados],
      sm[Llamadas], sm[Menta, Pizarra o Azul],
      sm[Figuras], sm[Numeradas, con pie],
    ),
    hd[Cada apartado],
    grid(rows: (1fr,) * 5, row-gutter: 5pt,
      ..for (t, c) in (("Para qué sirve", teal), ("Qué debe incluir", teal), ("Preguntas", slate), ("Evidencia", slate), ("Contenido del equipo", navy)) {
        (fcard(fill: white, stroke: (left: 4pt + c, rest: 0.6pt + fog), v: horizon, inset: (x: 10pt, y: 3pt), text(size: S, weight: "semibold")[#t]),)
      }),
  ),
))

#pagebreak()

// ───────────────────────── 9 · Diapositivas ─────────────────────────
#section("9", "Documentos y diapositivas", title: "Diapositivas y diagramas")

#area(grid(rows: (1fr, 1.2fr), row-gutter: 14pt,
  grid(columns: (1fr, 1fr, 1fr), rows: (1fr,), column-gutter: 14pt,
    fcard(fill: navy, inset: 14pt)[
      #logo("logo-mono-blanco", width: 36mm)
      #place(left + horizon, dy: 12pt, text(fill: white, size: 26pt, weight: "semibold")[OpsCon v0.1])
      #place(right + bottom, box(width: 36mm, height: 8mm, radius: 4mm, fill: teal))
      #place(left + bottom, text(fill: fog, size: S)[Portada])
    ],
    fcard(fill: white, stroke: 0.8pt + fog, inset: 14pt)[
      #text(size: S, fill: deep, weight: "semibold")[2 · ACTORES]
      #v(4pt)
      #text(size: 16pt, weight: "semibold")[Enfermería recibe el aviso; el robot no decide.]
      #v(6pt)
      #box(fill: mint, radius: 4pt, inset: 7pt, text(size: S, weight: "semibold")[Decide el personal])
      #place(left + bottom, text(fill: slate, size: S)[Contenido])
    ],
    fcard(fill: mint, inset: 14pt)[
      #align(center + horizon)[
        #text(size: 48pt, weight: "semibold")[35 %] \
        #sm[280 de 800 kcal] \ #v(4pt)
        #pill("Ficticio", fill: navy)
      ]
      #place(left + bottom, text(fill: slate, size: S)[Dato])
    ],
  ),
  grid(columns: (1.5fr, 1fr), rows: (1fr,), column-gutter: 14pt,
    grid(rows: (1.5fr, 1fr), row-gutter: 10pt,
      fcard(fill: white, stroke: 0.8pt + fog, inset: 12pt, v: horizon,
        grid(columns: (1fr, 1.3fr, 1fr), column-gutter: 10pt, align: horizon,
          stack(dir: ttb, spacing: 6pt,
            ..for t in ("Niño", "Enfermería", "Cocina") { (box(width: 100%, stroke: 1.2pt + slate, radius: 5pt, inset: 6pt, align(center, text(size: S)[#t])),) }),
          box(width: 100%, fill: mint, stroke: 2pt + teal, radius: 10pt, inset: 10pt)[
            #align(center)[
              #text(size: S, weight: "semibold", fill: deep)[Ingesta Atenta] \
              #v(2pt)
              #stack(dir: ttb, spacing: 4pt,
                ..for t in ("Navegación", "Visión", "Avisos") { (box(width: 100%, fill: white, radius: 4pt, inset: 4pt, text(size: S)[#t]),) })
            ]
          ],
          stack(dir: ttb, spacing: 6pt,
            ..for t in ("Hospital", "Red", "Dietética") { (box(width: 100%, stroke: 1.2pt + slate, radius: 5pt, inset: 6pt, align(center, text(size: S)[#t])),) }),
        )),
      fcard(fill: white, stroke: 0.8pt + fog, inset: 12pt, v: horizon)[
        #grid(columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr), column-gutter: 6pt, align: horizon,
          ..for (i, t) in ("Reposo", "Tránsito", "Comida", "Salida").enumerate() {
            let node = box(width: 100%, fill: if i == 2 { mint } else { white }, stroke: if i == 2 { 2pt + teal } else { 1.2pt + slate }, radius: 7pt, inset: 8pt, align(center, text(size: S, weight: "semibold")[#t]))
            if i < 3 { (node, arrow()) } else { (node,) }
          })
        #v(6pt)
        #align(center, pill("Parada Segura · desde cualquier modo", fill: navy2))
      ],
    ),
    grid(rows: (1fr,) * 4, row-gutter: 8pt,
      ..for (t, d, c) in (("Sistema", "borde Verde, relleno Menta", teal), ("Entorno", "borde Pizarra", slate), ("Flujo", "flecha Azul", navy), ("Pendiente", "línea punteada", slate)) {
        (fcard(fill: white, stroke: (left: 5pt + c, rest: 0.6pt + fog), v: horizon, inset: 12pt)[#text(weight: "semibold", size: 16pt)[#t] \ #sm(d)],)
      }),
  ),
))

#pagebreak()

// ───────────────────────── 10 · Producto ─────────────────────────
#section("10", "Producto", title: "Pantalla y aviso")

#area(grid(rows: (1fr, auto), row-gutter: 12pt,
  grid(columns: (1fr, 1.4fr), rows: (1fr,), column-gutter: 20pt,
    grid(rows: (1fr, auto), row-gutter: 6pt,
      fcard(fill: navy, inset: 18pt, v: horizon)[
        #align(center)[
          #text(fill: white, size: 20pt, weight: "semibold")[¡Hola! ¿Puedo mirar tu bandeja?]
          #v(12pt)
          #stack(dir: ltr, spacing: 14pt, box(fill: teal, radius: 50%, inset: (x: 28pt, y: 10pt), text(fill: white, size: 18pt, weight: "semibold")[Sí]), box(fill: white, radius: 50%, inset: (x: 28pt, y: 10pt), text(fill: navy, size: 18pt, weight: "semibold")[No]))
          #v(20pt)
          #stack(dir: ltr, spacing: 18pt, picto("bien", size: 20mm), picto("poco", size: 20mm), picto("mal", size: 20mm))
        ]
      ],
      cap("Pantalla del robot", "Una pregunta, botones grandes."),
    ),
    grid(rows: (1fr, auto), row-gutter: 6pt,
      grid(columns: (1fr, 1fr), rows: (1fr,), column-gutter: 12pt,
        fcard(fill: white, stroke: 1pt + fog, inset: 14pt)[
          #grid(columns: (auto, 1fr), column-gutter: 8pt, align: horizon,
            logo("simbolo", height: 17mm), [#text(weight: "semibold", size: 16pt)[Hab. H-05] \ #note[Cena · 20:35]])
          #v(8pt)
          #pill("Aviso de baja ingesta", fill: navy)
          #v(8pt)
          #text(size: 44pt, weight: "semibold")[35 %] \
          #text(size: 12pt)[280 de 800 kcal] \ #v(2pt)
          #text(size: 12pt)[Confianza *media*] \
          #text(size: 12pt)[Motivo: *sin apetito*]
        ],
        fcard(fill: white, stroke: 1pt + fog, inset: 14pt)[
          #grid(columns: (auto, 1fr), column-gutter: 8pt, align: horizon,
            logo("simbolo", height: 17mm), [#text(weight: "semibold", size: 16pt)[Hab. H-08] \ #note[Cena · 20:41]])
          #v(8pt)
          #box(stroke: (paint: slate, dash: "dashed", thickness: 1.2pt), radius: 50%, inset: (x: 9pt, y: 3.5pt), text(size: S, fill: slate, weight: "medium")[Rechazada])
          #v(8pt)
          #text(size: 26pt, weight: "semibold")[No evaluado] \ #v(4pt)
          #text(size: 12pt)[No se insiste.]
        ],
      ),
      cap("Aviso a enfermería", "Datos ficticios. Sin imágenes ni audio."),
    ),
  ),
  grid(columns: (1fr,) * 6, column-gutter: 8pt,
    ..for t in ("Habitación", "Estado", "Dato", "Confianza", "Motivo", "Qué no hay") {
      (block(width: 100%, fill: mint, radius: 6pt, inset: 10pt, align(center, text(size: S, weight: "semibold")[#t])),)
    }),
))

#pagebreak()

// ───────────────────────── 11 · Otras piezas ─────────────────────────
#section("11", "Otras piezas", title: "Acreditación, correo, web y papel")

#area(grid(columns: (1fr, 1fr, 1fr), rows: (1fr, 1fr), column-gutter: 14pt, row-gutter: 14pt,
  grid(rows: (1fr, auto), row-gutter: 4pt,
    fcard(fill: white, stroke: 0.8pt + fog, inset: 0pt)[
      #block(fill: navy, width: 100%, height: 16mm, inset: 5pt, align(center + horizon, logo("logo-mono-blanco", width: 30mm)))
      #align(center)[
        #v(6pt)
        #circle(radius: 8mm, fill: mist, stroke: 0.6pt + fog)
        #v(-2pt)
        #text(size: 14pt, weight: "semibold")[Nombre] \
      ]
      #place(bottom, block(width: 100%, height: 6mm, fill: teal))
    ],
    cap("Acreditación", "Banda Verde.")),
  grid(rows: (1fr, auto), row-gutter: 4pt,
    fcard(fill: white, stroke: 0.8pt + fog, v: horizon, inset: 16pt)[
      #grid(columns: (auto, 1fr), column-gutter: 10pt, align: horizon,
        box(width: 2pt, height: 34mm, fill: teal),
        [#text(weight: "semibold", size: 16pt)[Nombre Apellido] \
         #text(size: S, fill: deep)[Simulation Manager] \
         #sm[Atenia Healthcare Robotics] \ #v(4pt)
         #logo("logo-sin-lema", width: 30mm)])
    ],
    cap("Firma de correo", "Una línea Verde.")),
  grid(rows: (1fr, auto), row-gutter: 4pt,
    fcard(fill: mint, inset: 16pt)[
      #place(left + horizon, block(width: 80%)[
        #text(size: 24pt, weight: "semibold")[Cada comida cuenta.] \ #v(6pt)
        #pill("Conoce el proyecto", fill: navy)
      ])
      #place(left + bottom, logo("logo-sin-lema", width: 30mm))
    ],
    cap("Banner web", "Fondo Menta.")),
  grid(rows: (1fr, auto), row-gutter: 4pt,
    fcard(fill: navy, inset: 12pt, v: horizon)[
      #align(center + horizon)[
        #logo("simbolo-negativo", height: 34mm)
        #v(4pt)
        #text(fill: white, weight: "semibold", size: 14pt)[Hola, soy el robot de Atenia.]
      ]
    ],
    cap("Cartel en planta", "Símbolo grande.")),
  grid(rows: (1fr, auto), row-gutter: 4pt,
    fcard(fill: white, stroke: 0.8pt + fog, inset: 14pt)[
      #text(size: 18pt, weight: "semibold")[Hoja para familias] \ #v(6pt)
      #text(size: S)[*¿Qué guarda?* Solo un porcentaje.] \ #v(2pt)
      #text(size: S)[*¿Es obligatorio?* No.] \ #v(2pt)
      #text(size: S)[*¿Quién decide?* El equipo médico.]
      #place(bottom + left, box(width: 60%, height: 6mm, radius: 3mm, fill: teal))
    ],
    cap("Hoja informativa", "Pregunta y respuesta corta.")),
  grid(rows: (1fr, auto), row-gutter: 4pt,
    fcard(fill: mist, stroke: 0.8pt + fog, inset: 14pt)[
      #grid(columns: (1fr, 1fr), column-gutter: 8pt, row-gutter: 8pt,
        ..for t in ("OpsCon", "SEMP", "SRS", "Gala") {
          (block(fill: white, radius: 6pt, inset: 10pt, width: 100%, stroke: 0.6pt + fog, text(size: 14pt, weight: "semibold")[#t]),)
        })
      #place(bottom + right, logo("simbolo", height: 18mm))
    ],
    cap("Carpetas", "Una por entregable.")),
))

#pagebreak()

// ───────────────────────── 12 · Accesibilidad ─────────────────────────
#section("12", "Accesibilidad", title: "Menores, datos y lista final")

#area(grid(columns: (1fr, 1fr, 1fr), rows: (1fr,), column-gutter: 14pt,
  grid(rows: (auto, 1fr), row-gutter: 6pt,
    hd[Perfiles],
    btable((1fr, 1.4fr), stretch: true,
      th[Perfil], th[Adaptación],
      sm[Bebés], sm[Habla al tutor],
      sm[Escolar], sm[Pictogramas],
      sm[Adolescente], sm[Sin tono infantil],
      sm[Oncología], sm[Mínima, sin insistir],
      sm[Otro idioma], sm[Pendiente],
      sm[Sensorial], sm[Texto grande, voz],
    )),
  grid(rows: (auto, 1fr, auto), row-gutter: 8pt,
    hd[Protección],
    grid(rows: (1fr,) * 5, row-gutter: 6pt,
      ..for t in ("Sin imágenes ni audio guardados.", "Sin caras de menores.", "Ejemplos siempre ficticios.", "Cada rol ve lo mínimo.", "El «no» siempre se respeta.") {
        (fcard(fill: mint, v: horizon, inset: 10pt, grid(columns: (auto, 1fr), column-gutter: 10pt, align: horizon, check(c: deep), text(size: S, weight: "medium")[#t])),)
      }),
    card(fill: navy, inset: 12pt)[#set text(fill: white); #text(weight: "semibold")[Si parece vigilar, ordenar o prometer certeza, no se publica.]],
  ),
  grid(rows: (auto, 1fr), row-gutter: 6pt,
    hd[Lista final],
    fcard(fill: white, stroke: 0.8pt + fog, v: horizon, inset: 12pt)[
      #for t in ("Logotipo oficial con espacio", "Sin naranja, amarillo ni rojo", "Poppins o Arial", "Contraste suficiente", "Frases cortas", "Datos con unidad y fuente", "Pendientes marcados", "Sin datos reales", "Sin órdenes clínicas", "Nombre y versión", "Segunda revisión") {
        grid(columns: (auto, 1fr), column-gutter: 10pt, align: horizon,
          box(width: 4.2mm, height: 4.2mm, radius: 1mm, stroke: 1.2pt + navy), sm(t))
        v(2pt)
      }
    ]),
))

#pagebreak()

// ───────────────────────── Archivos y versiones ─────────────────────────
#section("", "Archivos y versiones", title: "Dónde está todo")

#area(grid(columns: (1fr, 1fr), rows: (1fr,), column-gutter: 18pt,
  grid(rows: (1fr, 1.6fr), row-gutter: 12pt,
    fcard(fill: mint, v: horizon, inset: 16pt)[
      #text(weight: "semibold")[Carpeta del equipo en Drive] \
      #text(size: 22pt, weight: "semibold", fill: deep)[IngenAI Robótica] \ #v(2pt)
      #sm[Empezar por «00 LEEME · Contexto del proyecto».] \
      #sm[Marca: 03 Documentación interna › Identidad Visual.] \
      #sm[Misión y visión: 01 Entregas.]
    ],
    btable((1.6fr, 1fr), stretch: true,
      th[Archivo], th[Uso],
      sm[logo-principal], sm[Sobre claro],
      sm[logo-negativo], sm[Sobre Azul],
      sm[logo-mono-navy], sm[1 color],
      sm[logo-mono-blanco], sm[1 color inverso],
      sm[logo-sin-lema], sm[Tamaños pequeños],
      sm[simbolo, simbolo-negativo], sm[Icono],
    ),
  ),
  grid(rows: (1.6fr, 1fr), row-gutter: 12pt,
    btable((auto, auto, 1fr), stretch: true,
      th[Versión], th[Fecha], th[Cambio],
      sm[v1.0], sm[5 oct], sm[Logotipo],
      sm[v2.0], sm[oct], sm[Manual de 5 páginas],
      sm[v3.0], sm[25 oct], sm[Ampliado, sin naranja],
      sm[v4.0], sm[25 oct], sm[Banner por sección, menos texto],
      sm[*v5.0*], sm[*25 oct*], sm[*Páginas llenas, letra más grande*],
    ),
    fcard(v: horizon, inset: 16pt)[
      #text(weight: "semibold", size: 16pt)[Contacto] \
      #sm[Equipo IngenAI Robótica · Grupo 1 · ETSII-UPM]
    ],
  ),
))
