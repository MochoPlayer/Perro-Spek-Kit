# H4 · Demostración y aceptación

**Entregable:** sistema integrado y evidencias de funcionamiento.

**Mínimo exigido:**
- Demostración de las **dos órdenes válidas** y del tratamiento de una **entrada no reconocida**.
- Pruebas físicas observadas.
- Respuesta a la **solicitud de cambio CR-01**.
- Resultados documentados.

## Flujo de trabajo

Cada caja indica en cursiva el documento que produce. Leyenda debajo del diagrama.

```mermaid
flowchart TB
  classDef eq fill:#ffffff,stroke:#334155,color:#0f172a
  classDef ia fill:#ede9fe,stroke:#7c3aed,color:#2e1065
  classDef check fill:#fef3c7,stroke:#d97706,color:#78350f
  classDef hito fill:#0f172a,stroke:#0f172a,color:#ffffff
  classDef par stroke-dasharray:5 4

  subgraph S4["4 · H4 — Integrar y demostrar"]
    direction LR
    U["Llega CR-01:<br/>analizar impacto<br/><i>cr-01-analisis.md</i>"]:::eq
    V["Ajustar solución<br/><i>src/ · requisitos</i>"]:::eq
    W{"¿Ensayos físicos<br/>OK y seguros?<br/><i>ensayos-fisicos.md</i>"}:::check
    X["Demo: órdenes<br/>+ entrada no reconocida<br/><i>evidencias/</i>"]:::eq
    M4(["Presentación<br/>H4"]):::hito
    U --> V --> W -- sí --> X --> M4
    W -- no --> V
  end

  subgraph LEY["Leyenda"]
    direction LR
    L1["Tarea del equipo"]:::eq
    L2["La genera la IA,<br/>el equipo revisa"]:::ia
    L3{"Control"}:::check
    L4(["Entrega"]):::hito
    L5["Borde discontinuo:<br/>en paralelo"]:::eq
    L6["Paso<br/><i>documento que produce</i>"]:::eq
    class L5 par
    L1 ~~~ L2 ~~~ L3 ~~~ L4 ~~~ L5 ~~~ L6
  end

  style LEY fill:#ffffff,stroke:#cbd5e1,color:#334155
  style S4 fill:#f8fafc,stroke:#cbd5e1,color:#334155
  S4 ~~~ LEY
```

### Pasos

- [ ] Analizar la CR-01 con la trazabilidad: qué requisitos afecta → `cr-01-analisis.md`
- [ ] Ajustar la solución (requisitos, spec y código)
- [ ] Ensayos físicos seguros → `ensayos-fisicos.md`. Si fallan, se vuelve a ajustar.
- [ ] Demostración: órdenes válidas y entrada no reconocida → `evidencias/`
- [ ] Presentación: fases seguidas, decisiones tomadas y highlights

**Presentación final:** debe recoger las fases seguidas, las decisiones tomadas y los highlights de cada fase.

> El detalle de este hito se completará cuando se presente en clase.
