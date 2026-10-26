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

> **Borrador para revisión del equipo.** Sale de las notas del equipo y de las respuestas del cliente del 26/10 (`referencias/notas/respuestas-cliente-2026-10-26.md`). Lo marcado como *Por definir* está pendiente de decidir.

## 3.1 Identificación de stakeholders

| ID     | Stakeholder / clase        | Interés o responsabilidad                                                   | Fuentes                     |
|--------|----------------------------|-----------------------------------------------------------------------------|-----------------------------|
| STK-01 | Cliente (profesor)         | Que el robot obedezca órdenes de voz y que el sistema sea verificable.      | Encargo; cliente 26/10      |
| STK-02 | Usuario que da las órdenes | Que el robot le entienda y responda en el menor tiempo posible.             | Cliente 26/10, puntos 2 y 4 |
| STK-03 | Equipo (empresa)           | Que el sistema se pueda construir y probar sin el robot físico.             | Diapositiva H3              |

## 3.2 Escenarios operacionales

Reproducir una ficha por cada situación relevante, incluida la operación nominal, alternativas, errores de entrada, fallos de interacción y condiciones excepcionales que procedan. Los escenarios describen situaciones de uso, no tareas de programación.

**Fuera de alcance:** órdenes combinadas e interrupciones. El cliente da una orden cada vez y espera a que termine (cliente 26/10, punto 2).

| ID     | Tipo        | Escenario                                   |
|--------|-------------|---------------------------------------------|
| ESC-01 | Nominal     | Orden simple reconocida                     |
| ESC-02 | Alternativo | Orden sin el nombre del perro               |
| ESC-03 | Alternativo | Tiempo sin recibir órdenes                  |
| ESC-04 | Excepcional | Ruido alto o frase sin sentido              |
| ESC-05 | Excepcional | Orden imposible o fuera del catálogo        |
| ESC-06 | Excepcional | Orden mientras se ejecuta otra              |
| ESC-07 | Excepcional | Robot desconectado                          |
| ESC-08 | Excepcional | Batería baja                                |
| ESC-09 | Excepcional | Manipulación del robot durante una acción   |
| ESC-10 | Excepcional | Robot roto o con fallo mecánico             |

### ESC-01 · Orden simple reconocida

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-01 |
| Nombre y tipo                     | Orden simple reconocida · Nominal |
| Objetivo operacional              | Que el robot ejecute la orden que da el usuario. |
| Actores y sistemas externos       | Usuario (STK-02), ordenador con la interfaz, robot Bittle. |
| Precondiciones / estado inicial   | Robot encendido y conectado; sistema escuchando; robot sin ninguna acción en curso. |
| Disparador (trigger)              | El usuario dice el nombre del perro seguido de una orden del catálogo. |
| Secuencia de interacción          | 1. El usuario dice «[nombre] + orden». 2. El sistema reconoce la orden. 3. El sistema envía la orden al robot. 4. El robot ejecuta la acción. 5. El usuario espera a que termine antes de dar otra orden. |
| Resultado / estado final esperado | El robot ha ejecutado la acción pedida y el sistema queda listo para la siguiente orden. |
| Variantes y fallos relacionados   | ESC-02, ESC-04, ESC-05, ESC-06, ESC-07. |
| Fuente y cuestiones abiertas      | Cliente 26/10, puntos 2, 3 y 4. *Por definir:* nombre del perro; tiempo de respuesta («mínimo posible», hay que fijar un valor). |

### ESC-02 · Orden sin el nombre del perro

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-02 |
| Nombre y tipo                     | Orden sin el nombre del perro · Alternativo |
| Objetivo operacional              | Evitar que el robot actúe ante frases que no van dirigidas a él. |
| Actores y sistemas externos       | Usuario u otras personas cerca, ordenador, robot. |
| Precondiciones / estado inicial   | Sistema escuchando; robot sin acción en curso. |
| Disparador (trigger)              | Alguien dice una orden sin el nombre del perro delante. |
| Secuencia de interacción          | 1. Se dice una frase u orden sin el nombre. 2. El sistema no la trata como orden. |
| Resultado / estado final esperado | El robot no se mueve y el sistema sigue escuchando. |
| Variantes y fallos relacionados   | ESC-01, ESC-04. |
| Fuente y cuestiones abiertas      | Cliente 26/10, punto 3 («la voz interpreta todo: para llamarlo hay que decir el nombre»). *Por definir:* nombre del perro. |

### ESC-03 · Tiempo sin recibir órdenes

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-03 |
| Nombre y tipo                     | Tiempo sin recibir órdenes · Alternativo |
| Objetivo operacional              | Definir qué hace el sistema si pasa un tiempo t sin órdenes. |
| Actores y sistemas externos       | Ordenador, robot. |
| Precondiciones / estado inicial   | Robot conectado y sin acción en curso. |
| Disparador (trigger)              | Pasa un tiempo t sin que llegue ninguna orden. |
| Secuencia de interacción          | *Por definir.* |
| Resultado / estado final esperado | *Por definir:* sigue conectado permanentemente o entra en reposo. |
| Variantes y fallos relacionados   | ESC-07. |
| Fuente y cuestiones abiertas      | Notas del equipo («conectado permanentemente o si no recibe orden en t tiempo»). *Por definir:* valor de t y comportamiento. |

### ESC-04 · Ruido alto o frase sin sentido

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-04 |
| Nombre y tipo                     | Ruido alto o frase sin sentido · Excepcional |
| Objetivo operacional              | Que el usuario sepa que su orden no se ha entendido y pueda repetirla. |
| Actores y sistemas externos       | Usuario, entorno ruidoso, ordenador, robot. |
| Precondiciones / estado inicial   | Sistema escuchando; robot sin acción en curso. |
| Disparador (trigger)              | El sistema recibe audio que no puede interpretar como una orden válida. |
| Secuencia de interacción          | 1. El usuario dice algo con mucho ruido o sin sentido. 2. El sistema no entiende la orden. 3. El ordenador avisa «no se ha entendido bien» y pide repetir. |
| Resultado / estado final esperado | El robot no se mueve y el usuario recibe el aviso. |
| Variantes y fallos relacionados   | ESC-01, ESC-05. |
| Fuente y cuestiones abiertas      | Notas del equipo («ruido muy alto, cosas sin sentido → repite»); cliente 26/10, punto 8. |

### ESC-05 · Orden imposible o fuera del catálogo

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-05 |
| Nombre y tipo                     | Orden imposible o fuera del catálogo · Excepcional |
| Objetivo operacional              | Que el sistema no intente lo que el robot no puede hacer. |
| Actores y sistemas externos       | Usuario, ordenador, robot. |
| Precondiciones / estado inicial   | Sistema escuchando; robot sin acción en curso. |
| Disparador (trigger)              | El usuario pide algo que el robot no puede hacer (por ejemplo, seguir a alguien o navegar solo). |
| Secuencia de interacción          | 1. El usuario dice «[nombre] + orden imposible». 2. El sistema detecta que no está en el catálogo. 3. El ordenador avisa al usuario. |
| Resultado / estado final esperado | El robot no se mueve y el usuario recibe el aviso. |
| Variantes y fallos relacionados   | ESC-04. |
| Fuente y cuestiones abiertas      | Notas del equipo («no sigue a nadie ni navega solo»); cliente 26/10, punto 1 (el usuario conoce los comandos). *Por definir:* texto del aviso. |

### ESC-06 · Orden mientras se ejecuta otra

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-06 |
| Nombre y tipo                     | Orden mientras se ejecuta otra · Excepcional |
| Objetivo operacional              | Definir qué pasa si llega una orden con el robot ocupado. |
| Actores y sistemas externos       | Usuario, ordenador, robot. |
| Precondiciones / estado inicial   | El robot está ejecutando una acción. |
| Disparador (trigger)              | El usuario da otra orden antes de que termine la actual. |
| Secuencia de interacción          | *Por definir.* |
| Resultado / estado final esperado | *Por definir:* se ignora la orden nueva o se avisa de que está ocupado. |
| Variantes y fallos relacionados   | ESC-01. |
| Fuente y cuestiones abiertas      | Notas del equipo; cliente 26/10, punto 2 (el usuario espera a que termine). *Por definir:* comportamiento. |

### ESC-07 · Robot desconectado

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-07 |
| Nombre y tipo                     | Robot desconectado · Excepcional |
| Objetivo operacional              | Que el usuario sepa que el robot no está conectado. |
| Actores y sistemas externos       | Usuario, ordenador, robot. |
| Precondiciones / estado inicial   | Se pierde o no existe la conexión con el robot. |
| Disparador (trigger)              | El usuario da una orden, o el sistema comprueba la conexión. |
| Secuencia de interacción          | 1. El sistema detecta que el robot no está conectado. 2. El ordenador avisa al usuario. |
| Resultado / estado final esperado | No se envía ninguna orden y el usuario recibe el aviso. |
| Variantes y fallos relacionados   | ESC-01, ESC-03. |
| Fuente y cuestiones abiertas      | Notas del equipo («robot desconectado: detecta el robot»). *Por definir:* cómo y cada cuánto se comprueba la conexión. |

### ESC-08 · Batería baja

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-08 |
| Nombre y tipo                     | Batería baja · Excepcional |
| Objetivo operacional              | *Por definir.* |
| Actores y sistemas externos       | Robot, ordenador, usuario. |
| Precondiciones / estado inicial   | La batería del robot está baja. |
| Disparador (trigger)              | *Por definir.* |
| Secuencia de interacción          | *Por definir.* |
| Resultado / estado final esperado | *Por definir.* |
| Variantes y fallos relacionados   | ESC-10. |
| Fuente y cuestiones abiertas      | Notas del equipo. *Por definir:* si el sistema puede detectar la batería baja; si no, pasa al apartado 7. |

### ESC-09 · Manipulación del robot durante una acción

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-09 |
| Nombre y tipo                     | Manipulación del robot durante una acción · Excepcional |
| Objetivo operacional              | *Por definir.* |
| Actores y sistemas externos       | Persona que coge o mueve el robot, robot. |
| Precondiciones / estado inicial   | El robot está ejecutando una acción. |
| Disparador (trigger)              | Alguien coge, mueve o tumba el robot. |
| Secuencia de interacción          | *Por definir.* |
| Resultado / estado final esperado | *Por definir.* |
| Variantes y fallos relacionados   | ESC-10. |
| Fuente y cuestiones abiertas      | Notas del equipo. El Bittle tiene las skills `lifted` y `dropped` (ver `capacidades-bittle.md`). *Por definir:* si se usa esa detección. |

### ESC-10 · Robot roto o con fallo mecánico

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-10 |
| Nombre y tipo                     | Robot roto o con fallo mecánico · Excepcional |
| Objetivo operacional              | *Por definir.* |
| Actores y sistemas externos       | Robot, usuario. |
| Precondiciones / estado inicial   | El robot tiene un fallo mecánico. |
| Disparador (trigger)              | *Por definir.* |
| Secuencia de interacción          | *Por definir.* |
| Resultado / estado final esperado | *Por definir.* |
| Variantes y fallos relacionados   | ESC-08, ESC-09. |
| Fuente y cuestiones abiertas      | Notas del equipo. *Por definir:* si es detectable por el sistema; si no, pasa al apartado 7. |

## Ficha reutilizable de escenario

| Campo                             | Contenido                                      |
|-----------------------------------|------------------------------------------------|
| Identificador                     | ESC-[nn]                                       |
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

> **Borrador para revisión del equipo.**

| ID     | Stakeholder(s) | Necesidad expresada | Origen / escenario | Justificación / prioridad |
|--------|----------------|---------------------|--------------------|---------------------------|
| NEC-01 | STK-01, STK-02 | Dar órdenes al robot por voz y que las ejecute. | ESC-01; encargo | Es el objetivo del encargo. Alta. |
| NEC-02 | STK-02 | Activar al robot llamándolo por su nombre, para que no reaccione a conversaciones ajenas. | ESC-02; cliente 26/10, punto 3 | La voz lo interpreta todo; sin activación respondería a cualquier frase. Alta. |
| NEC-03 | STK-02 | Saber cuándo una orden no se ha entendido, para poder repetirla. | ESC-04; cliente 26/10, punto 8 | La entrada no reconocida es parte del mínimo exigido en H1. Alta. |
| NEC-04 | STK-02 | Que el robot responda a la orden en el menor tiempo posible. | ESC-01; cliente 26/10, punto 4 | El cliente pide el mínimo posible y considera inaceptable una respuesta de 10 s. Alta. |
| NEC-05 | STK-02 | Saber que una orden imposible no se va a ejecutar. | ESC-05; cliente 26/10, punto 1 | Evita que el usuario espere una acción que el robot no puede hacer. Media. |
| NEC-06 | STK-02 | Saber si el robot está conectado antes de dar órdenes. | ESC-07 | Sin conexión ninguna orden llega al robot. Media. |
| NEC-07 | STK-01 | Disponer de un repertorio de órdenes amplio (las 40 programadas y las que se añadan). | Cliente 26/10, punto 5 | El cliente valora positivamente ampliar las órdenes. Media (el mínimo son 2). |
| NEC-08 | STK-03 | Poder probar el sistema sin el robot físico. | Diapositiva H3 | H3 exige pruebas reproducibles sin el robot. Alta. |
| NEC-09 | STK-02 | Que una orden dada con el robot ocupado no provoque un comportamiento inesperado. | ESC-06 | *Por definir* (depende del comportamiento de ESC-06). |

## 4.2 Revisión de cobertura de necesidades

[Explicar qué situaciones, actores o riesgos han quedado cubiertos y cuáles siguen abiertos; justificar las exclusiones y la prioridad atribuida a necesidades relevantes.]

# 5. Requisitos del sistema

Los requisitos se redactan para el nivel del sistema de interés definido en 2.2. Cada requisito debe tener un identificador estable, un enunciado verificable y su trazabilidad de origen. Se organizan en categorías cuando ayuden a examinar la cobertura; ninguna categoría debe rellenarse artificialmente.

## 5.1 Requisitos funcionales

Alcance: una orden cada vez; el usuario espera a que termine antes de dar otra (Cliente 26/10, punto 2). «[NOMBRE]» es el nombre del perro, aún por definir (OPEN-01). Los requisitos de Nivel 1 son fijos. Los marcados *Opcional* son del Nivel 2 y se abordan si hay tiempo. La lista completa de niveles está en `propuesta-requisitos-funcionales-por-tiers.md`.

**Activación**

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-01 | El sistema deberá tratar como orden solo una frase que empiece por el nombre del perro «[NOMBRE]» seguido de una orden del catálogo, y deberá ignorar cualquier otra frase sin enviar ningún comando al robot. | ESC-01, ESC-02; Cliente 26/10 (3) | Prueba sin robot: 20 frases con el nombre se procesan como orden; 20 frases sin el nombre no producen ningún comando. | Esencial |

**Órdenes del Nivel 1**

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-02 | Ante la orden «[NOMBRE], siéntate», el sistema deberá enviar al robot el comando `ksit` (sentarse). | ESC-01; Cliente 26/10 (5); T1-01 | Prueba sin robot: el robot simulado recibe `ksit`. Demostración: el robot termina sentado. | Esencial (Nivel 1) |
| REQ-03 | Ante la orden «[NOMBRE], levántate», el sistema deberá enviar al robot el comando `kup` (ponerse en pie). | ESC-01; Cliente 26/10 (5); T1-02 | Prueba sin robot: el robot simulado recibe `kup`. Demostración: el robot termina de pie. | Esencial (Nivel 1) |
| REQ-04 | Ante la orden «[NOMBRE], camina», el sistema deberá enviar al robot el comando `kwkF` (caminar hacia delante). | ESC-01; Cliente 26/10 (5); T1-03 | Prueba sin robot: el robot simulado recibe `kwkF`. Demostración: el robot avanza. | Esencial (Nivel 1) |
| REQ-05 | Ante la orden «[NOMBRE], izquierda», el sistema deberá enviar al robot el comando `kwkL` (caminar hacia la izquierda). | ESC-01; Cliente 26/10 (5); T1-04 | Prueba sin robot: el robot simulado recibe `kwkL`. Demostración: el robot gira a la izquierda. | Esencial (Nivel 1) |
| REQ-06 | Ante la orden «[NOMBRE], derecha», el sistema deberá enviar al robot el comando `kwkR` (caminar hacia la derecha). | ESC-01; Cliente 26/10 (5); T1-05 | Prueba sin robot: el robot simulado recibe `kwkR`. Demostración: el robot gira a la derecha. | Esencial (Nivel 1) |
| REQ-07 | Ante la orden «[NOMBRE], para», el sistema deberá enviar al robot el comando `krest` (detenerse en postura de reposo). | ESC-01; Cliente 26/10 (5); T1-06 | Prueba sin robot: el robot simulado recibe `krest`. Demostración: el robot se detiene. | Esencial (Nivel 1) |
| REQ-08 | Ante la orden «[NOMBRE], túmbate», el sistema deberá enviar al robot el comando `d` (tumbarse y apagar los motores). | ESC-01; Cliente 26/10 (5); T1-07 | Prueba sin robot: el robot simulado recibe `d`. Demostración: el robot queda tumbado. | Esencial (Nivel 1) |
| REQ-09 | Ante la orden «[NOMBRE], saluda», el sistema deberá enviar al robot el comando `khi` (saludar). | ESC-01; Cliente 26/10 (5); T1-08 | Prueba sin robot: el robot simulado recibe `khi`. Demostración: el robot hace el gesto de saludo; comando por confirmar (OPEN-03). | Esencial (Nivel 1) |
| REQ-10 | Ante la orden «[NOMBRE], equilíbrate», el sistema deberá enviar al robot el comando `kbalance` (postura de equilibrio). | ESC-01; Cliente 26/10 (5); T1-09 | Prueba sin robot: el robot simulado recibe `kbalance`. Demostración: el robot queda en equilibrio. | Esencial (Nivel 1) |
| REQ-11 | Ante la orden «[NOMBRE], trota», el sistema deberá enviar al robot el comando `ktrF` (trotar hacia delante). | ESC-01; Cliente 26/10 (5); T1-10 | Prueba sin robot: el robot simulado recibe `ktrF`. Demostración: el robot trota; comando por confirmar (OPEN-03). | Esencial (Nivel 1) |

**Entradas que no son una orden válida**

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-12 | Ante una frase con ruido o sin sentido que no se interprete como una orden, el sistema deberá no enviar ningún comando de movimiento y deberá mostrar el aviso «no se ha entendido bien». | ESC-04; Cliente 26/10 (8); T1-11 | Prueba sin robot: 20 entradas de ruido o sin sentido → ningún comando y aviso mostrado cada vez. | Esencial |
| REQ-13 | Ante una orden que no está en el catálogo o que el robot no puede hacer (por ejemplo «sígueme»), el sistema deberá no enviar ningún comando y deberá mostrar un aviso de orden no disponible. | ESC-05; Cliente 26/10 (1) | Prueba sin robot: 10 órdenes fuera del catálogo → ningún comando y aviso mostrado cada vez. | Esencial |

**Órdenes opcionales (Nivel 2)**

Cada una cuenta como una sola orden para el usuario, aunque el sistema envíe varios comandos seguidos.

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-14 | Ante la orden «[NOMBRE], baila», el sistema deberá hacer que el robot ejecute una secuencia de movimientos fija y predefinida, y deberá terminar en una postura estable. | ESC-01; T2-09; Cliente 26/10 (5: «todo lo que añadáis será valorado») | Prueba sin robot: la lista de comandos enviada coincide con la secuencia definida (OPEN-08). Demostración: la secuencia se completa sin caída. | Opcional |
| REQ-15 | Ante la orden «[NOMBRE], media vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta quedar orientado en sentido contrario al inicial, con una desviación máxima de ±45° (valor provisional). | ESC-01; T2-01; Cliente 26/10 (5) | Prueba sin robot: comando `kwkL` durante la duración calibrada (OPEN-04). Demostración: 5 intentos con medida de la desviación. | Opcional |
| REQ-16 | Ante la orden «[NOMBRE], da una vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta completar una vuelta, con una desviación máxima de ±45° (valor provisional). | ESC-01; T2-01; aclaración 26/10 («combinar dos giros a la izquierda») | Prueba sin robot: dos giros seguidos de la duración calibrada (OPEN-04). Demostración: 5 intentos con medida de la desviación. | Opcional |

## 5.2 Requisitos de interfaces

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-17 | El sistema deberá recibir la voz del usuario desde el micrófono del ordenador del equipo. | Cliente 26/10 (9); ESC-01 | Demostración: una frase dicha ante el micrófono aparece como texto. | Esencial |
| REQ-18 | El sistema deberá obtener el texto de la voz mediante un módulo de transcripción ya existente, y deberá incluir un intérprete propio que convierta ese texto en una orden del catálogo. | Aclaración 26/10 (la transcripción no se desarrolla; el intérprete sí) | Inspección: el módulo de transcripción es una dependencia externa y el intérprete es código del equipo. Prueba: texto → orden esperada. | Esencial |
| REQ-19 | El sistema deberá ofrecer una interfaz de usuario (web o aplicación) que muestre el texto reconocido, la orden interpretada, el estado de la conexión con el robot y los avisos. | Cliente 26/10 (8, 9); ESC-04, ESC-05, ESC-07 | Demostración: los cuatro elementos son visibles en una sesión de prueba. | Esencial |
| REQ-20 | El sistema deberá enviar al robot los comandos en el formato del protocolo serie de Petoi (token y parámetros, por ejemplo `ksit`) a través de un puerto serie (Bluetooth o USB, OPEN-07). | REF-03 (Petoi Serial Protocol, Python API) | Prueba sin robot: el robot simulado recibe la cadena exacta. Demostración: el robot obedece. | Esencial |

## 5.3 Requisitos de prestaciones y calidad

Los valores numéricos son **provisionales**: el cliente pidió ponerlos «a ojo» con márgenes amplios y ajustarlos tras los prototipos (Cliente 26/10, aclaración). Ver OPEN-02.

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-21 | El tiempo desde que el usuario termina la frase hasta que el sistema envía el comando al robot deberá ser como máximo de 2 s (valor provisional). | Cliente 26/10 (4: «el mínimo posible»; 10 s no es aceptable) | Prueba sin robot: 20 mediciones, todas ≤ 2 s. | Esencial |
| REQ-22 | El sistema deberá reconocer y ejecutar correctamente al menos el 80 % de las órdenes válidas dichas en una sala tranquila (valor provisional). | ESC-01; Cliente 26/10 (7) | Prueba: 20 intentos por cada orden del Nivel 1; contar los aciertos. | Esencial |
| REQ-23 | Tras 20 entradas seguidas no reconocidas o fuera del catálogo, el sistema deberá seguir en funcionamiento y atender la siguiente orden válida. | ESC-04, ESC-05 | Prueba sin robot: 20 entradas inválidas seguidas y después una orden válida que se ejecuta. | Esencial |
| REQ-24 | El sistema no deberá guardar grabaciones de audio en el disco una vez transcrita la voz. | Cliente 26/10 (7: privacidad) | Inspección: tras una sesión de prueba no hay ficheros de audio; revisión del código. Ver OPEN-06. | Esencial |

## 5.4 Requisitos de seguridad y operación

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-25 | Si no hay conexión con el robot, el sistema no deberá enviar ningún comando y deberá mostrar el aviso «robot no conectado». | ESC-07 | Prueba sin robot: puerto cerrado → ningún comando y aviso mostrado. Demostración: desconectar el robot y dar una orden. | Esencial |
| REQ-26 | El sistema deberá poder ejecutarse con un robot simulado que registre los comandos recibidos, para realizar las pruebas sin el robot físico. | STK-03; hito H3 | Prueba: el conjunto de pruebas se ejecuta completo sin robot conectado. | Esencial |
| REQ-27 | El sistema deberá poder instalarse, ejecutarse y demostrarse en un ordenador del equipo. | Cliente 26/10 (9) | Demostración en el ordenador del equipo. | Esencial |
| REQ-28 | Los ensayos con el robot físico se harán sobre una superficie lisa y con una persona que vigile para evitar caídas. Es una medida física supervisada, no un comportamiento del software. | REF-03 (Petoi: superficies lisas); ESC-09 | Inspección del procedimiento de ensayo antes de cada sesión con el robot. | Esencial |

## 5.5 Ficha de requisito (duplicar por cada requisito)

Las tablas de 5.1 a 5.4 recogen los atributos principales de cada requisito. Esta ficha completa se usa si un requisito necesita más detalle (motivación, supuestos).

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
| REQ-01 | Funcional | Activación por el nombre del perro | ESC-01, ESC-02 | Prueba sin robot (20 + 20 frases) |
| REQ-02 | Funcional | «siéntate» → `ksit` | ESC-01 | Prueba sin robot + demostración |
| REQ-03 | Funcional | «levántate» → `kup` | ESC-01 | Prueba sin robot + demostración |
| REQ-04 | Funcional | «camina» → `kwkF` | ESC-01 | Prueba sin robot + demostración |
| REQ-05 | Funcional | «izquierda» → `kwkL` | ESC-01 | Prueba sin robot + demostración |
| REQ-06 | Funcional | «derecha» → `kwkR` | ESC-01 | Prueba sin robot + demostración |
| REQ-07 | Funcional | «para» → `krest` | ESC-01 | Prueba sin robot + demostración |
| REQ-08 | Funcional | «túmbate» → `d` | ESC-01 | Prueba sin robot + demostración |
| REQ-09 | Funcional | «saluda» → `khi` (por confirmar) | ESC-01 | Prueba sin robot + demostración |
| REQ-10 | Funcional | «equilíbrate» → `kbalance` | ESC-01 | Prueba sin robot + demostración |
| REQ-11 | Funcional | «trota» → `ktrF` (por confirmar) | ESC-01 | Prueba sin robot + demostración |
| REQ-12 | Funcional | Ruido o frase sin sentido: sin movimiento y aviso | ESC-04 | Prueba sin robot (20 entradas) |
| REQ-13 | Funcional | Orden fuera del catálogo: sin movimiento y aviso | ESC-05 | Prueba sin robot (10 órdenes) |
| REQ-14 | Funcional (opcional) | «baila»: secuencia fija | ESC-01 | Prueba sin robot + demostración |
| REQ-15 | Funcional (opcional) | «media vuelta»: giro de 180° (±45°) | ESC-01 | Demostración (5 intentos) |
| REQ-16 | Funcional (opcional) | «da una vuelta»: giro de 360° (±45°) | ESC-01 | Demostración (5 intentos) |
| REQ-17 | Interfaz | Voz desde el micrófono del ordenador | ESC-01 | Demostración |
| REQ-18 | Interfaz | Transcripción existente e intérprete propio | Aclaración 26/10 | Inspección + prueba |
| REQ-19 | Interfaz | Interfaz de usuario: texto, orden, estado y avisos | ESC-04, 05, 07 | Demostración |
| REQ-20 | Interfaz | Comandos del protocolo serie de Petoi | REF-03 | Prueba sin robot + demostración |
| REQ-21 | Prestación | Comando enviado en ≤ 2 s (provisional) | Cliente (4) | Prueba sin robot (20 mediciones) |
| REQ-22 | Fiabilidad | ≥ 80 % de órdenes válidas ejecutadas (provisional) | ESC-01 | Prueba (20 intentos por orden) |
| REQ-23 | Robustez | Sigue operativo tras 20 entradas inválidas | ESC-04, 05 | Prueba sin robot |
| REQ-24 | Privacidad | No guarda audio en disco | Cliente (7) | Inspección |
| REQ-25 | Operación | Robot desconectado: sin comandos y aviso | ESC-07 | Prueba sin robot + demostración |
| REQ-26 | Operación | Ejecución con robot simulado | STK-03, H3 | Prueba |
| REQ-27 | Operación | Funciona en el ordenador del equipo | Cliente (9) | Demostración |
| REQ-28 | Seguridad | Ensayos sobre superficie lisa y con vigilancia | REF-03, ESC-09 | Inspección del procedimiento |

# 6. Trazabilidad y estrategia inicial de verificación

## 6.1 Matriz de trazabilidad

| Escenario | Necesidad | Requisito(s) | Criterio / caso de verificación futuro           |
|-----------|-----------|--------------|--------------------------------------------------|
| ESC-01 | NEC-01, NEC-04, NEC-07 | REQ-01 a REQ-11, REQ-21, REQ-22; opcionales REQ-14 a REQ-16 | Cada orden llega como comando al robot simulado y el robot la ejecuta en la demostración; tiempo y aciertos dentro de los límites. |
| ESC-02 | NEC-02 | REQ-01 | Ninguna de las 20 frases sin el nombre produce un comando. |
| ESC-03 | — | — (OPEN-05) | Por definir. |
| ESC-04 | NEC-03 | REQ-12, REQ-19, REQ-23 | Ruido o frase sin sentido: sin movimiento y aviso visible; el sistema sigue operativo. |
| ESC-05 | NEC-05 | REQ-13, REQ-19, REQ-23 | Orden fuera del catálogo: sin movimiento y aviso visible. |
| ESC-06 | NEC-09 | — (OPEN-05) | Por definir. |
| ESC-07 | NEC-06 | REQ-19, REQ-25 | Sin conexión: ningún comando y aviso mostrado. |
| ESC-08, ESC-09, ESC-10 | — | REQ-28 (solo parcial) | Escenarios aún por definir (apartado 3). |
| H3 (pruebas sin robot) | NEC-08 | REQ-26 | El conjunto de pruebas se ejecuta completo sin robot conectado. |
| Transversales | NEC-01 | REQ-17, REQ-18, REQ-20, REQ-27 | Ver verificación en 5.1 a 5.4. |
| Cliente 26/10 (7) | — | REQ-24 | Inspección: sin ficheros de audio. |

## 6.2 Comprobación de cobertura

Estado actual (borrador):

- Necesidades sin requisito: NEC-09 (depende de ESC-06, OPEN-05).
- Escenarios sin requisito: ESC-03 y ESC-06 (comportamiento por definir, OPEN-05); ESC-08, ESC-09 y ESC-10 (escenarios por definir).
- Requisitos sin necesidad asociada: REQ-24 (privacidad), que viene de lo que dijo el cliente (punto 7), y REQ-28, que viene de la documentación de Petoi. Falta decidir si se crea una necesidad para cada uno.
- Todos los requisitos tienen origen y método de verificación previsto.

## 6.3 Enfoque inicial de verificación

[Indicar qué se podrá comprobar solo con software, qué requerirá integración y qué exigirá observar el Bittle físico. No declarar pruebas realizadas si solo se han planificado.]

# 7. Supuestos, decisiones pendientes y riesgos

| ID      | Supuesto / cuestión / riesgo  | Impacto            | Acción para resolverlo                     | Responsable / estado |
|---------|-------------------------------|--------------------|--------------------------------------------|----------------------|
| OPEN-01 | Nombre del perro (palabra de activación) y cómo se pronuncia | Condiciona REQ-01 y todas las órdenes | Decidir el nombre y comprobarlo con el reconocimiento de voz | Equipo / abierto |
| OPEN-02 | Valores numéricos provisionales de REQ-15, REQ-16, REQ-21 y REQ-22 | Cambian los criterios de aceptación | Medir con un prototipo y ajustar (el cliente lo permite) | Equipo / abierto |
| OPEN-03 | Los comandos `khi`, `ktrF` y el pitido `b` no están confirmados en nuestro robot | REQ-09, REQ-11; aviso sonoro | Probarlos con el robot en la sesión 2 | Equipo / abierto |
| OPEN-04 | Duración del giro de `kwkL`/`kwkR` y tolerancia aceptable | REQ-15, REQ-16 | Medir con el robot y fijar la duración calibrada | Equipo / abierto |
| OPEN-05 | Qué hace el sistema si llega una orden con el robot ocupado (ESC-06) y tras un tiempo sin órdenes (ESC-03) | Faltan requisitos para ESC-03 y ESC-06 | Decidir y, si hace falta, preguntar al cliente | Equipo / abierto |
| OPEN-06 | El módulo de transcripción puede enviar el audio a un servicio externo | Afecta a REQ-24 (privacidad) | Elegir el módulo y comprobar dónde se procesa el audio | Equipo / abierto |
| OPEN-07 | Conexión con el robot (Bluetooth o USB), modelo y placa | REQ-20 | Comprobar en el robot y, si hace falta, preguntar al cliente | Equipo / abierto |
| OPEN-08 | Secuencia concreta de «baila» | REQ-14 | Diseñar y probar la secuencia | Equipo / abierto |
| OPEN-09 | El aviso al usuario, ¿solo en pantalla o también hablado? | REQ-12, REQ-13, REQ-25 | Decidir; el cliente admite que lo diga el ordenador (punto 8) | Equipo / abierto |

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
