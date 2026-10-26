---
title: "VOICE-BITTLE | H1 — Análisis del problema y definición de requisitos"
---

> PLANTILLA DOCENTE ADAPTADA. Inspirada en los productos de trabajo de ISO/IEC/IEEE 15288:2023 y en la estructura de una especificación de requisitos de sistema (SyRS) tratada por ISO/IEC/IEEE 29148:2018. No es una reproducción literal de una plantilla ISO ni implica conformidad formal con dichas normas.

| Control documental         | Valor                                                     |
|----------------------------|-----------------------------------------------------------|
| Código documental          | [Código de la empresa / documento]                      |
| Proyecto / sistema         | VOICE-BITTLE / [Nombre del sistema de interés]          |
| Empresa / autores          | [Nombres y responsabilidades]                           |
| Versión / estado           | [v0.1 / borrador H1]                                    |
| Fecha                      | [AAAA-MM-DD]                                            |
| Repositorio / revisión Git | [URL o ruta del repositorio propio; hash del commit H1] |
| Aprobación o revisión      | [Responsable y resultado de la revisión]                |

# Historial de revisiones

| Versión  | Fecha     | Cambios                | Autor      |
|----------|-----------|------------------------|------------|
| [v0.1] | [Fecha] | [Resumen del cambio] | [Nombre] |

# Cómo utilizar esta plantilla

Completar los apartados aplicables al sistema estudiado, duplicando filas y fichas cuando sea necesario. No hay números máximos ni mínimos prefijados de escenarios, necesidades o requisitos: la extensión debe justificarse por la cobertura del problema. Un campo desconocido se registra como asunto abierto, indicando su impacto y cómo se resolverá; no se sustituye por una afirmación inventada.

La trazabilidad propuesta relaciona las fuentes y el OpsCon con los escenarios, las necesidades y los requisitos. Los métodos de verificación se identifican inicialmente, pero en H1 no se exige ejecutar pruebas ni implementar software.

# 1. Introducción

## 1.1 Propósito del documento

[Describir qué decisiones y necesidades recoge este documento, a quién va dirigido y cómo se empleará en las etapas posteriores.]

## 1.2 Referencias y documentos de entrada

| ID     | Documento / fuente               | Versión / enlace   | Información utilizada                       |
|--------|----------------------------------|--------------------|---------------------------------------------|
| REF-01 | Encargo VOICE-BITTLE             | [Referencia]     | [Condiciones y objetivos]                 |
| REF-02 | OpsCon del proyecto              | [Versión]        | [Contexto y situaciones de uso]           |
| REF-03 | Documentación técnica consultada | [Fuente y fecha] | [Capacidades y restricciones verificadas] |

## 1.3 Términos, siglas y convenciones

| Término                  | Significado en este documento                                                                         |
|--------------------------|-------------------------------------------------------------------------------------------------------|
| SoI (System of Interest) | Sistema cuya frontera y comportamiento se especifican en este trabajo.                                |
| Stakeholder              | Persona, grupo u organización con intereses o necesidades relacionados con el sistema.                |
| Escenario operacional    | Descripción de una situación de utilización del sistema, sus condiciones, interacciones y resultados. |
| Necesidad                | Capacidad, resultado o característica que un stakeholder precisa en el contexto de uso.               |
| Requisito del sistema    | Enunciado verificable que expresa una obligación o característica exigible al sistema.                |
| [Añadir]               | [Definir términos propios del proyecto]                                                             |

# 2. Descripción del sistema y contexto operacional

## 2.1 Problema, objetivos y alcance

[Resumir el problema a resolver y el valor buscado. Precisar qué parte del sistema completo se estudia en este documento y qué queda fuera. Referenciar el OpsCon, sin reescribirlo íntegramente.]

## 2.2 Frontera del sistema e interfaces externas

[Identificar los elementos incluidos en el SoI y las entidades externas con las que intercambia información, energía, mandos u otros flujos. Incluir un diagrama de contexto si aporta claridad.]

| Elemento externo | Interacción / interfaz | Dentro o fuera del SoI | Fuente / incertidumbre |
|------------------|------------------------|------------------------|------------------------|
| [Elemento]     | [Intercambio]        | [Dentro/Fuera]       | [Referencia]         |

## 2.3 Condiciones de operación y restricciones conocidas

| ID     | Condición, capacidad o restricción       | Procedencia | Estado de conocimiento                   |
|--------|------------------------------------------|-------------|------------------------------------------|
| CTX-01 | [Condición relevante del uso previsto] | [Fuente]  | [Documentado / comprobado / pendiente] |

## 2.4 Investigación técnica de viabilidad

Registrar los hallazgos que condicionan lo que puede especificarse: capacidades documentadas del cuadrúpedo, alternativas de voz, posibilidades de conexión e integración, limitaciones y riesgos. No convertir decisiones de implementación todavía abiertas en requisitos arbitrarios.

| Cuestión                    | Alternativas o hallazgo        | Evidencia / referencia  | Impacto en escenarios o requisitos |
|-----------------------------|--------------------------------|-------------------------|------------------------------------|
| [Movimientos disponibles] | [Resultado de consulta]      | [URL, sección, fecha] | [Implicación]                    |
| [Reconocimiento de voz]   | [Alternativas identificadas] | [Fuentes]             | [Implicación]                    |

# 3. Stakeholders y escenarios operacionales

## 3.1 Identificación de stakeholders

| ID     | Stakeholder / clase | Interés o responsabilidad                 | Fuentes    |
|--------|---------------------|-------------------------------------------|------------|
| STK-01 | [Quién]           | [Por qué interviene o resulta afectado] | [Fuente] |

## 3.2 Escenarios operacionales

Reproducir una ficha por cada situación relevante, incluida la operación nominal, alternativas, errores de entrada, fallos de interacción y condiciones excepcionales que procedan. Los escenarios describen situaciones de uso, no tareas de programación.

## Ficha reutilizable de escenario

| Campo                             | Contenido                                      |
|-----------------------------------|------------------------------------------------|
| Identificador                     | ESC-[nn]                                     |
| Nombre y tipo                     | [Nominal / alternativo / excepcional]        |
| Objetivo operacional              | [Qué pretende lograr el actor]               |
| Actores y sistemas externos       | [Quién o qué participa]                      |
| Precondiciones / estado inicial   | [Situación que permite iniciar el escenario] |
| Disparador (trigger)              | [Evento que lo inicia]                       |
| Secuencia de interacción          | [Pasos observables actor–sistema–entorno]    |
| Resultado / estado final esperado | [Condiciones observables de cierre]          |
| Variantes y fallos relacionados   | [Otros escenarios referenciados]             |
| Fuente y cuestiones abiertas      | [OpsCon / evidencia / incertidumbre]         |

# 4. Necesidades de los stakeholders

Recoger necesidades justificadas por el uso y por las condiciones del problema. Evitar confundir una necesidad con una tecnología concreta o con una instrucción de implementación.

## 4.1 Registro de necesidades

| ID     | Stakeholder(s) | Necesidad expresada                       | Origen / escenario | Justificación / prioridad                       |
|--------|----------------|-------------------------------------------|--------------------|-------------------------------------------------|
| NEC-01 | [STK-…]      | [Necesita disponer de / ser capaz de …] | [ESC-…, REF-…]   | [Por qué es necesaria; criterio de prioridad] |

## 4.2 Revisión de cobertura de necesidades

[Explicar qué situaciones, actores o riesgos han quedado cubiertos y cuáles siguen abiertos; justificar las exclusiones y la prioridad atribuida a necesidades relevantes.]

# 5. Requisitos del sistema

Los requisitos se redactan para el nivel del sistema de interés definido en 2.2. Cada requisito debe tener un identificador estable, un enunciado verificable y su trazabilidad de origen. Se organizan en categorías cuando ayuden a examinar la cobertura; ninguna categoría debe rellenarse artificialmente.

## 5.1 Requisitos funcionales

[Obligaciones relativas a lo que el sistema debe hacer ante entradas, situaciones y estados.]

## 5.2 Requisitos de interfaces

[Interacciones exigidas entre el SoI y operadores, robot, fuentes de voz u otros sistemas.]

## 5.3 Requisitos de prestaciones y calidad

[Características medibles cuando correspondan: prestaciones, fiabilidad, disponibilidad, usabilidad, etc. No inventar umbrales sin fuente o justificación.]

## 5.4 Requisitos de seguridad y operación

[Condiciones relevantes para una operación segura, gestión de estados, fallos y restricciones. Separar medidas físicas supervisadas de comportamientos de software verificables.]

## 5.5 Ficha de requisito (duplicar por cada requisito)

| Atributo                                    | Contenido                                                                  |
|---------------------------------------------|----------------------------------------------------------------------------|
| Identificador único                         | REQ-[nn]                                                                 |
| Clase                                       | [Funcional / interfaz / prestación / seguridad / otra]                   |
| Enunciado                                   | [El sistema deberá … bajo [condición] … con resultado comprobable]     |
| Motivación / rationale                      | [Por qué existe; riesgo o necesidad atendida]                            |
| Origen y trazabilidad                       | [NEC-… / ESC-… / REF-…]                                                  |
| Criterio o método de verificación previsto  | [Prueba / análisis / inspección / demostración; qué habría que observar] |
| Supuestos, restricciones y asuntos abiertos | [Referencias o “Ninguno identificado”]                                   |
| Estado / revisión                           | [Propuesto / revisado / pendiente de aclaración]                         |

## 5.6 Registro consolidado de requisitos

| ID     | Clase     | Enunciado breve        | Origen (NEC/ESC) | Verificación prevista  |
|--------|-----------|------------------------|------------------|------------------------|
| REQ-01 | [Clase] | [Resumen inequívoco] | [NEC-…, ESC-…] | [Método/observación] |

# 6. Trazabilidad y estrategia inicial de verificación

## 6.1 Matriz de trazabilidad

| Escenario | Necesidad | Requisito(s) | Criterio / caso de verificación futuro           |
|-----------|-----------|--------------|--------------------------------------------------|
| ESC-01    | NEC-01    | REQ-…        | [Qué resultado permitirá evaluar el requisito] |

## 6.2 Comprobación de cobertura

[Identificar escenarios sin necesidades asociadas; necesidades sin requisito derivado; requisitos sin fuente o sin método de verificación plausible. Resolver las omisiones o justificarlas.]

## 6.3 Enfoque inicial de verificación

[Indicar qué se podrá comprobar solo con software, qué requerirá integración y qué exigirá observar el Bittle físico. No declarar pruebas realizadas si solo se han planificado.]

# 7. Supuestos, decisiones pendientes y riesgos

| ID      | Supuesto / cuestión / riesgo  | Impacto            | Acción para resolverlo                     | Responsable / estado |
|---------|-------------------------------|--------------------|--------------------------------------------|----------------------|
| OPEN-01 | [Información no confirmada] | [Qué condiciona] | [Consulta, inspección o ensayo previsto] | [Quién / estado]   |

# 8. Revisión y estado de H1

Este apartado registra el resultado de la revisión de la empresa; no implica necesariamente aprobación formal del profesor ni cierre definitivo de los requisitos.

| Comprobación                                          | Resultado / evidencia      |
|-------------------------------------------------------|----------------------------|
| Cobertura de escenarios nominales y excepcionales     | [Análisis / referencias] |
| Relación entre necesidades, stakeholders y escenarios | [Análisis]               |
| Claridad, coherencia y verificabilidad de requisitos  | [Análisis]               |
| Trazabilidad y método de verificación previsto        | [Análisis]               |
| Incertidumbres identificadas y documentadas           | [Registro OPEN-…]        |
| Versión recuperable del repositorio                   | [Hash de commit]         |

# 9. Referencias metodológicas y grado de adaptación

ISO/IEC/IEEE 15288:2023, apdos. 6.4.2 (Stakeholder needs and requirements definition) y 6.4.3 (System requirements definition): referencia para identificación de stakeholders, escenarios, necesidades, requisitos, trazabilidad y resultados de proceso. Fuente: copia del estándar facilitada para la asignatura.

ISO/IEC/IEEE 29148:2018, Systems and software engineering — Life cycle processes — Requirements engineering: referencia principal para información y estructura de especificaciones de requisitos. Consulta pública del alcance: https://www.iso.org/standard/72089.html . No se ha reproducido ni afirmado cumplir la estructura íntegra de la SyRS de la norma; consultar el texto licenciado para una conformidad formal.

NASA Systems Engineering Handbook, NASA/SP-2016-6105 Rev. 2, especialmente 4.2, apéndice C (calidad de requisitos) y apéndice D (matriz de verificación): https://www.nasa.gov/reference/systems-engineering-handbook/

Adaptación docente explícita: la investigación preliminar y el registro de riesgos se integran en un único documento H1 para facilitar la transición posterior a Spec Kit; el control documental, las tablas y la nomenclatura ESC/NEC/REQ son convenciones de esta plantilla, no códigos impuestos por las normas citadas.
