# Reto Bittle — IngenIA Robótica (curso 2026-2027)

> **Objetivo:** el robot Petoi Bittle debe obedecer órdenes de voz.

Cada empresa trabaja en un único repositorio Git, que recoge los documentos, el código y las evidencias. Hay cuatro hitos de revisión, y cada uno tiene su carpeta en este repo.

## Hitos

| Hito | Carpeta | Entregable | Contenido mínimo |
|---|---|---|---|
| **H1** · Especificación inicial | [`H1-especificacion-inicial/`](H1-especificacion-inicial/) | Escenarios y requisitos elaborados por el equipo | Escenario nominal y excepcional; requisitos verificables para las dos órdenes válidas y la entrada no reconocida; relación entre escenarios, necesidades y requisitos. |
| **H2** · Especificación y planificación con Spec Kit | [`H2-especificacion-planificacion/`](H2-especificacion-planificacion/) | `spec.md`, `plan.md` y `tasks.md` | Especificación revisada, decisiones técnicas justificadas, esquema sencillo del sistema, tareas organizadas y primer incremento identificado. |
| **H3** · Implementación y pruebas | [`H3-implementacion-pruebas/`](H3-implementacion-pruebas/) | Código ejecutable y pruebas en el repositorio | Implementación generada con apoyo de IA, revisión del código y pruebas reproducibles sin necesidad del robot físico. |
| **H4** · Demostración y aceptación | [`H4-demostracion-aceptacion/`](H4-demostracion-aceptacion/) | Sistema integrado y evidencias de funcionamiento | Demostración de las dos órdenes válidas y del tratamiento de una entrada no reconocida; pruebas físicas observadas; respuesta a la solicitud de cambio CR-01 y resultados documentados. |

## Itinerario

**Sesión 1**
1. **Comprender el encargo:** definir escenarios de uso nominales y excepcionales, e investigar.
2. **Especificar:** identificar necesidades y definir requisitos. → **H1**
3. **Explorar Spec Kit:** crear el repositorio, elegir el entorno, y generar y revisar `spec.md`.
4. **Planificar:** definir un esquema sencillo del sistema y obtener `plan.md` y `tasks.md`. → **H2**

**Sesión 2**

5. **Preparar la verificación:** diseñar casos de prueba.
6. **Implementar:** generar código con IA y hacer pruebas sin robot. → **H3**
7. **Integrar y adaptar:** analizar una solicitud de cambio, ajustar la solución y hacer ensayos físicos seguros.
8. **Demostrar:** verificar las dos órdenes válidas y el tratamiento de entradas no reconocidas; defender las evidencias. → **H4**

## Flujo de trabajo

Vista general de todos los hitos. Cada carpeta tiene su parte del flujo y la lista de pasos con casillas. Cada caja indica en cursiva el documento que produce. Leyenda debajo del diagrama.

```mermaid
flowchart TB
  classDef eq fill:#ffffff,stroke:#334155,color:#0f172a
  classDef ia fill:#ede9fe,stroke:#7c3aed,color:#2e1065
  classDef check fill:#fef3c7,stroke:#d97706,color:#78350f
  classDef hito fill:#0f172a,stroke:#0f172a,color:#ffffff
  classDef par stroke-dasharray:5 4

  subgraph S1["1 · H1 — Entender y especificar"]
    direction LR
    A1["Investigar el Bittle<br/><i>capacidades-bittle.md</i>"]:::eq
    A2["Investigar comunicación<br/>serie · Bluetooth · Python<br/><i>capacidades-bittle.md</i>"]:::eq
    A3["Investigar voz<br/><i>capacidades-bittle.md</i>"]:::eq
    B["Definir órdenes<br/><i>opciones-ordenes-de-voz.md</i>"]:::eq
    C{"¿Cliente OK?"}:::check
    D["Escenarios<br/><i>Entregable-H1.md §3</i>"]:::eq
    E["Necesidades<br/><i>Entregable-H1.md §4</i>"]:::eq
    F["Requisitos<br/><i>Entregable-H1.md §5</i>"]:::eq
    G["Trazabilidad<br/><i>Entregable-H1.md §6</i>"]:::eq
    H{"¿Cumple<br/>checklist H1?"}:::check
    M1(["Entregar H1<br/>Moodle"]):::hito
    class A1,A2,A3 par
    A1 & A2 --> B --> C -- sí --> D
    C -- no --> B
    A3 --> D
    D --> E --> F --> G --> H -- sí --> M1
    H -- no --> F
  end

  subgraph S2["2 · H2 — Spec Kit"]
    direction LR
    I["Instalar Spec Kit<br/>(se puede adelantar)"]:::eq
    I2["Constitución<br/><i>constitution.md</i>"]:::eq
    J["Generar spec<br/><i>spec.md</i>"]:::ia
    J2["Clarify +<br/>revisión manual<br/><i>spec.md</i>"]:::eq
    K{"¿spec completa<br/>vs H1?"}:::check
    L["Arquitectura<br/>y esquema<br/><i>arquitectura.md</i>"]:::eq
    N["Plan técnico<br/><i>plan.md</i>"]:::ia
    O["Tareas<br/>+ 1er incremento<br/><i>tasks.md</i>"]:::ia
    O2["Analyze<br/><i>coherencia.md</i>"]:::ia
    P{"¿Coherente?"}:::check
    M2(["Tag H2<br/>+ enlace al repo"]):::hito
    class I par
    I --> I2 --> J --> J2 --> K -- sí --> L --> N --> O --> O2 --> P -- sí --> M2
    K -- no --> J2
    P -- no --> J2
  end

  subgraph S3["3 · H3 — Implementar y probar"]
    direction LR
    Q["Casos de prueba<br/><i>casos-de-prueba.md</i>"]:::eq
    R["Implementar<br/><i>src/</i>"]:::ia
    S{"¿Pasan las pruebas<br/>sin robot?<br/><i>tests/</i>"}:::check
    T["Revisión de código<br/><i>revision-codigo.md</i>"]:::eq
    M3(["H3"]):::hito
    class Q,R par
    Q & R --> S -- sí --> T --> M3
    S -- no --> R
  end

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
  style S1 fill:#f8fafc,stroke:#cbd5e1,color:#334155
  style S2 fill:#f8fafc,stroke:#cbd5e1,color:#334155
  style S3 fill:#f8fafc,stroke:#cbd5e1,color:#334155
  style S4 fill:#f8fafc,stroke:#cbd5e1,color:#334155
  S1 --> S2 --> S3 --> S4
  S4 ~~~ LEY
```

## Reglas de trabajo (sesión del 26/10)

- Desarrollo basado en requisitos: **los requisitos y escenarios básicos los hace el equipo, no la IA.** La IA puede ampliarlos, corregirlos y cotejarlos, pero sin una base propia el resultado no funciona.
- Con Spec Kit (probado con Claude Code y Codex): **no dejarlo funcionar solo**, genera mucha basura.
- Reparto del tiempo: 50 % pensar (sesión 1, sin tocar el robot), 25 % implementar y 25 % demostrar.
- La presentación final recoge las fases seguidas, las decisiones tomadas y los highlights de cada fase.
- El profesor actúa como **cliente**. Los equipos trabajan de forma independiente, en modo competición. Se puede pedir reunión con el cliente en su despacho. La comunicación con el cliente es por **Teams**.

## Estructura del repo

```
H1-especificacion-inicial/        Entregable-H1.md (documento principal) · capacidades-bittle · opciones-ordenes-de-voz · entregables/ (Word)
H2-especificacion-planificacion/  constitution · spec · arquitectura · plan · tasks · coherencia
H3-implementacion-pruebas/        casos-de-prueba · src/ · tests/ · revision-codigo
H4-demostracion-aceptacion/       cr-01-analisis · ensayos-fisicos · evidencias/ · presentación
referencias/                      Enlaces a fuentes y notas de las sesiones
```
