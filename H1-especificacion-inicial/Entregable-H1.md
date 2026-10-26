---
title: "VOICE-BITTLE | H1 — Análisis del problema y definición de requisitos"
---

> PLANTILLA DOCENTE ADAPTADA. Inspirada en los productos de trabajo de ISO/IEC/IEEE 15288:2023 y en la estructura de una especificación de requisitos de sistema (SyRS) tratada por ISO/IEC/IEEE 29148:2018. No es una reproducción literal de una plantilla ISO ni implica conformidad formal con dichas normas.

| Control documental         | Valor                                                     |
|----------------------------|-----------------------------------------------------------|
| Código documental          | [Código de la empresa / documento]                      |
| Proyecto / sistema         | VOICE-BITTLE / Sistema de control por voz del Bittle («Atenio») |
| Empresa / autores          | [Nombres y responsabilidades]                           |
| Versión / estado           | v1.0 / entrega H1 |
| Fecha                      | 2026-10-26 |
| Repositorio / revisión Git | https://github.com/MochoPlayer/Perro-Spek-Kit-IngenIA (rama `main`; commit de entrega indicado en Moodle) |
| Aprobación o revisión      | Revisión interna del equipo, 26/10/2026 |

# Historial de revisiones

| Versión  | Fecha     | Cambios                | Autor      |
|----------|-----------|------------------------|------------|
| v0.1 | 2026-10-26 | Borrador inicial: apartados 1 a 7 | Equipo |
| v1.0 | 2026-10-26 | Revisión del equipo, ajustes del cliente y versión de entrega H1 | Equipo |

# 1. Introducción

## 1.1 Propósito del documento


Este documento recoge el análisis del problema del reto VOICE-BITTLE: contexto, stakeholders, escenarios, necesidades y requisitos del sistema de control por voz del Bittle, con su trazabilidad y el método de verificación previsto. Va dirigido al cliente y al equipo. Servirá de entrada a Spec Kit en el H2 (`spec.md`, `plan.md`, `tasks.md`) y para analizar la solicitud de cambio CR-01.

## 1.2 Referencias y documentos de entrada

| ID     | Documento / fuente               | Versión / enlace   | Información utilizada                       |
|--------|----------------------------------|--------------------|---------------------------------------------|
| REF-01 | Encargo VOICE-BITTLE | Presentación «Semana 7 – Bittle» (Moodle) | Objetivo, hitos H1–H4 y criterio mínimo |
| REF-02 | OpsCon del proyecto | v0.1, entregado el 26/10/2026 (*por referenciar*) | Contexto y situaciones de uso |
| REF-03 | Documentación técnica de Petoi | Doc Center, Serial Protocol, Python API, Voice Command Module y firmware OpenCat (`InstinctBittle.h`); resumen en `capacidades-bittle.md` | Capacidades, skills disponibles y restricciones |
| REF-04 | Respuestas del cliente del 26/10/2026 | `referencias/notas/respuestas-cliente-2026-10-26.md` y transcripción de la aclaración | Alcance, activación por nombre, tipos de requisitos e interfaz |

## 1.3 Términos, siglas y convenciones

| Término                  | Significado en este documento                                                                         |
|--------------------------|-------------------------------------------------------------------------------------------------------|
| SoI (System of Interest) | Sistema cuya frontera y comportamiento se especifican en este trabajo.                                |
| Stakeholder              | Persona, grupo u organización con intereses o necesidades relacionados con el sistema.                |
| Escenario operacional    | Descripción de una situación de utilización del sistema, sus condiciones, interacciones y resultados. |
| Necesidad                | Capacidad, resultado o característica que un stakeholder precisa en el contexto de uso.               |
| Requisito del sistema    | Enunciado verificable que expresa una obligación o característica exigible al sistema.                |
| Bittle                   | Robot cuadrúpedo de Petoi (modelo normal, placa NyBoard). |
| Skill                    | Acción predefinida en el firmware del robot (sentarse, caminar…). |
| Comando serie            | Texto que se envía al robot para ejecutar una skill (por ejemplo, `ksit`). |
| Nombre de activación     | Palabra con la que hay que llamar al robot antes de una orden. |
| Catálogo de órdenes      | Conjunto de órdenes de voz que el sistema acepta. |
| Entrada no reconocida    | Frase que el sistema no interpreta como una orden válida. |
| OpsCon                   | Concepto de operaciones del proyecto. |

# 2. Descripción del sistema y contexto operacional

## 2.1 Problema, objetivos y alcance

### Problema
El robot cuadrúpedo Petoi Bittle opera de forma predeterminada mediante comandos manuales. El reto **VOICE-BITTLE** surge de la necesidad de proporcionar una interfaz natural de control por voz que permita a un usuario interactuar con el robot en un entorno real , logrando que el cuadrúpedo ejecute órdenes sin manipulación física.

### Objetivos
1. **Captura y reconocimiento de voz:** Recibir la señal de voz del usuario a través del micrófono del puesto de control (el dispostivo con micrófono) y transcribirla a texto con la mínima latencia perceptible.
2. **Activación discriminada:** Filtrar conversaciones ajenas mediante una palabra clave de activación («nombre del perro»: *Atenio*), procesando únicamente las locuciones dirigidas al robot.
3. **Mapeo y despacho de comandos:** Interpretar la intención del usuario y traducirla al repertorio de comandos válidos del protocolo OpenCat del Petoi Bittle, asegurando el cumplimiento mínimo de dos órdenes válidas canónicas.
4. **Respuesta ante entradas no reconocidas:** Identificar frases fuera de catálogo o ininteligibles por ruido ambiental, garantizando que el robot permanezca en reposo seguro e informando al usuario mediante retroalimentación visual en el ordenador.
5. **Verificabilidad desacoplada:** Garantizar que la arquitectura del sistema permita la simulación y verificación automatizada de software sin requerir la presencia permanente del hardware físico.

### Alcance (Scope)
- **Dentro del alcance:**
  - Adquisición de audio y procesamiento de voz en el ordenador host.
  - Detección de palabra de activación («nombre del perro») y mapeo unívoco de órdenes a tokens del protocolo serie Petoi (`ksit`, `kup`, `krest`).
  - Implementación y verificación de al menos **dos órdenes válidas nominales** y el **tratamiento de la entrada no reconocida**.
  - Órdenes encadenadas en una misma frase, ejecutadas en el orden dicho (ajuste del cliente).
  - Canal de comunicación bidireccional host–robot mediante Bluetooth.
  - Emisión de retroalimentación de estado y avisos de error desde el propio ordenador host.

- **Fuera del alcance:**
  - Procesamiento del habla en la placa del robot.
  - Reconocimiento concurrente o interrupción en tiempo real de movimientos ya iniciados, salvo la orden «para» (REQ-07).
  - Movimientos gimnásticos de alto riesgo dinámico.
  - Navegación autónoma con evasión reactiva de obstáculos o seguimiento de personas.

---

## 2.2 Frontera del sistema e interfaces externas

El **Sistema de Interés (SoI - System of Interest)** está constituido por el software del sistema VOICE-BITTLE alojado en el ordenador host.

### Tabla de interfaces externas

| Elemento externo | Interacción / interfaz | Dentro o fuera del SoI | Fuente / incertidumbre |
|------------------|------------------------|------------------------|------------------------|
| **Usuario (Operador)** | Emite las locuciones de voz humana y observa visual/acústicamente el comportamiento del sistema. | Fuera | Cliente; requisitos de interacción y ergonomía. |
| **Micrófono del Host** | Captura la presión acústica y suministra el flujo de audio digitalizado al SoI mediante la API de audio del SO. | Fuera | Hardware del portátil; nivel de ruido ambiental. |
| **Servicio / Motor STT** | Transcripción de audio a texto (modelo local ligero o biblioteca STT). | Dentro (componente lógico integrado) | Viabilidad evaluada en 2.4; requiere latencia < 1.5 s. |
| **Interfaz de Pantalla del Host** | Presenta mensajes de estado y avisos en pantalla cuando la orden es inválida («no entendido»). Los avisos se muestran solo en pantalla (decidido el 26/10). | Fuera (recurso hardware controlado por el SoI) | Respuesta cliente, punto 8. |
| **Enlace de Comunicación (USB / Bluetooth)** | Puerto COM serie virtual  para transmisión de tramas de control. | Frontera de comunicación del SoI | Petoi Serial Protocol; emparejamiento Bluetooth en PC. |
| **Robot Petoi Bittle (NyBoard)** | Microcontrolador embebido que ejecuta el firmware OpenCat, decodifica los tokens recibidos y acciona los servos. | Fuera | Documentación Petoi; hardware físico del kit. |
| **Superficie de Apoyo** | Mesa o suelo liso donde el cuadrúpedo apoya sus patas y tracciona. | Fuera | Restricción física documentada en `capacidades-bittle.md`. |

---

## 2.3 Condiciones de operación y restricciones conocidas

| ID | Condición, capacidad o restricción | Procedencia | Estado de conocimiento |
|---|---|---|---|
| **CTX-01** | **Arquitectura de cómputo desacoplada:** El procesamiento de voz (STT) y la lógica de decisión residen en el PC portátil del equipo; el Bittle actúa exclusivamente como receptor cinemático. | `capacidades-bittle.md`; Hardware disponible (NyBoard sin módulo de voz) | Comprobado y acordado con el cliente. |
| **CTX-02** | **Interacción monousuario con cola de acciones:** El usuario da una orden, o varias encadenadas en una misma frase, sin tener que esperar a que el robot termine. Las órdenes que llegan con el robot ocupado se guardan en una cola y se ejecutan en el orden dado, cada una al terminar la anterior. No se contemplan órdenes concurrentes ni interrupciones dinámicas, salvo la orden «para» (REQ-07), que interrumpe la acción en curso. | Respuestas cliente, punto 2 (ajustado después por el cliente) | Confirmado por el cliente. |
| **CTX-03** | **Palabra de activación previa obligatoria (Wake-word):** Toda orden debe ir precedida por el nombre del perro (*Atenio*). Cualquier locución o ruido sin dicha palabra clave se ignora para evitar reacciones espurias. | Respuestas cliente , punto 3 | Confirmado por el cliente. |
| **CTX-04** | **Latencia acotada (Mínimo tiempo posible):** El retardo entre la finalización de la locución y el envío del comando al robot debe ser mínimo (objetivo orientativo < 1.5 s; el cliente descarta por inaceptables retardos de 10 s). | Transcripción reunión, punto 4 | Confirmado por el cliente; pendiente de ensayo de rendimiento. |
| **CTX-05** | **Ausencia de telemetría de fin de acción (Open-loop):** El protocolo OpenCat estándar no emite acuse de recibo de finalización de un skill; el software debe calcular o asociar un retardo preventivo (`delay`) antes de procesar un nuevo movimiento. | `capacidades-bittle.md`, sección 8 | Documentado en API; pendiente de confirmación física de respuesta serie. |
| **CTX-06** | **Superficie de deslizamiento y estabilidad:** El robot debe operar sobre suelo o mesa lisa y plana; alfombras o irregularidades provocan pérdida de adherencia y desequilibrio dinámico. | `capacidades-bittle.md`, sección 8 | Documentado en fabricante. |
| **CTX-07** | **Canal de enlace serie:** Comunicación serie asíncrona mediante cable micro-USB o Bluetooth clásico SPP, a una tasa fija (115200 baudios en OpenCat estándar). | `capacidades-bittle.md`; documentación de Moodle | Documentado; requiere validar emparejamiento Bluetooth en aula. |
| **CTX-08** | **Testabilidad reproducible sin hardware:** El sistema debe diseñarse de forma modular con soporte para pruebas automatizadas sin el robot físico conectado (requisito obligatorio para H3). | Guía del reto y diapositivas H3 | Requisito metodológico de la asignatura. |
| **CTX-09** | **Tratamiento pasivo y feedback ante error:** Ante una frase ininteligible, ruido o comando inexistente, el robot debe permanecer inmóvil y el ordenador debe notificar al usuario («no se ha entendido»). | Respuestas cliente, punto 8 | Confirmado por el cliente. |

---

## 2.4 Investigación técnica de viabilidad

| Cuestión técnica | Alternativas analizadas o hallazgo principal | Evidencia / referencia técnica | Impacto en escenarios o requisitos |
|---|---|---|---|
| **Catálogo de movimientos del Bittle** | El robot soporta más de 45 habilidades predefinidas mediante el token serie `k` (ej. `ksit`, `kup`, `kbalance`, `krest`, `kwkF`, `kwkL`, `kwkR`, `ktrF`). | [`capacidades-bittle.md`](capacidades-bittle.md), sección 2; `OpenCat.h` de PetoiCamp | Permite seleccionar como mínimo 2 órdenes de alta estabilidad (Tier 1: `ksit` y `kup`) para la entrega H1, reduciendo riesgos de vuelco. |
| **Motor de Reconocimiento de Voz (STT)** | Tres alternativas: 1) Módulo hardware Petoi (no disponible en NyBoard); 2) Servicios Cloud (latencia dependiente de la red de la UPM y credenciales); 3) STT local en PC (bibliotecas Python ligeras como Vosk o Faster-Whisper base/tiny). | [`capacidades-bittle.md`](capacidades-bittle.md), sección 9; análisis de latencia | Se opta por STT ejecutado en el ordenador host con motor local offline para garantizar latencia mínima (< 1.5 s) e independencia de conexión a internet durante la demo. |
| **Protocolo de comunicación serie** | Protocolo ASCII / binario mediante comandos serie breves (carácter token + argumentos + salto de línea). Soporte nativo en Python vía `pyserial` y funciones auxiliares de Petoi (`sendSkillStr`). | [Petoi Serial Protocol Doc](https://docs.petoi.com/apis/serial-protocol); [`capacidades-bittle.md`](capacidades-bittle.md), sección 7 | El SoI solo necesita transmitir strings simples (ej. `ksit\n`), simplificando el driver serie y facilitando su sustitución por un mock en las pruebas de H3. |
| **Detección de activación (Wake-Word)** | Detección mediante emparejamiento fonético/léxico en el texto transcrito (ej. comprobar presencia de `"atenio"` al inicio de la frase normalizada). | Respuestas cliente 26/10, punto 3; [`opciones-ordenes-de-voz.md`](opciones-ordenes-de-voz.md) | Evita que conversaciones aleatorias activen al robot. Obliga a rechazar cualquier orden emitida sin la palabra clave de activación previa. |
| **Tolerancia a ruido y acentos** | El vocabulario de control se reduce a comandos específicos del catálogo mediante normalización de texto (minúsculas, sin tildes) y tabla de sinónimos (ej. "arriba" = "levántate" = `kup`). | [`opciones-ordenes-de-voz.md`](opciones-ordenes-de-voz.md), sección Tier 1 | Aumenta la robustez en la sala de demostración ruidosa. Si la similitud fonética es insuficiente, se deriva directamente a escenario excepcional ESC-04. |
| **Gestión de temporizaciones y ocupación** | El robot no avisa por el puerto serie al concluir una acción motriz. El host debe mantener un modelo de temporización estimado (`delay`) por cada skill (ej. 2 s para `ksit`) antes de permitir el despacho de una nueva orden. | [`capacidades-bittle.md`](capacidades-bittle.md), sección 8; cliente 26/10, punto 2 | Impide saturar el buffer serie del microcontrolador de la placa NyBoard y evita colisiones mecánicas por órdenes simultáneas. |


# 3. Stakeholders y escenarios operacionales


## 3.1 Identificación de stakeholders

| ID     | Stakeholder / clase        | Interés o responsabilidad                                                   | Fuentes                     |
|--------|----------------------------|-----------------------------------------------------------------------------|-----------------------------|
| STK-01 | Cliente (profesor)         | Que el robot obedezca órdenes de voz y que el sistema sea verificable.      | Encargo; cliente 26/10      |
| STK-02 | Usuario que da las órdenes | Que el robot le entienda y responda en el menor tiempo posible.             | Cliente 26/10, puntos 2 y 4 |
| STK-03 | Equipo (empresa)           | Que el sistema se pueda construir y probar sin el robot físico.             | Diapositiva H3              |
| STK-04 | Personas del entorno | Están cerca del robot y pueden hablar o interactuar con él sin darle órdenes. | Ajuste del equipo (26/10) |

## 3.2 Escenarios operacionales

Reproducir una ficha por cada situación relevante, incluida la operación nominal, alternativas, errores de entrada, fallos de interacción y condiciones excepcionales que procedan. Los escenarios describen situaciones de uso, no tareas de programación.

**Fuera de alcance:** interrupciones (cancelar una acción en curso), salvo la orden «para» (REQ-07).

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
| ESC-10 | Alternativo | Órdenes encadenadas                         |

### ESC-01 · Orden simple reconocida

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-01 |
| Nombre y tipo                     | Orden simple reconocida · Nominal |
| Objetivo operacional              | Que el robot ejecute la orden que da el usuario. |
| Actores y sistemas externos       | Usuario (STK-02), ordenador con la interfaz, robot Bittle. |
| Precondiciones / estado inicial   | Robot encendido y conectado; sistema escuchando; robot sin ninguna acción en curso. |
| Disparador (trigger)              | El usuario dice el nombre del perro seguido de una orden del catálogo. |
| Secuencia de interacción          | 1. El usuario dice «Atenio + orden». 2. El sistema reconoce la orden. 3. El sistema envía la orden al robot. 4. El robot ejecuta la acción. |
| Resultado / estado final esperado | El robot ha ejecutado la acción pedida y el sistema queda listo para la siguiente orden. |
| Variantes y fallos relacionados   | ESC-02, ESC-04, ESC-05, ESC-06, ESC-07, ESC-10. |
| Fuente y cuestiones abiertas      | Cliente 26/10, puntos 2, 3 y 4. Tiempo de respuesta: objetivo < 1,5 s (CTX-04). |

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
| Fuente y cuestiones abiertas      | Cliente 26/10, punto 3 («la voz interpreta todo: para llamarlo hay que decir el nombre»). Nombre decidido: «Atenio». |

### ESC-03 · Tiempo sin recibir órdenes

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-03 |
| Nombre y tipo                     | Tiempo sin recibir órdenes · Alternativo |
| Objetivo operacional              | Ahorrar energía cuando el robot está activo sin recibir órdenes. |
| Actores y sistemas externos       | Ordenador, robot. |
| Precondiciones / estado inicial   | Robot conectado y sin acción en curso. |
| Disparador (trigger)              | Pasa un tiempo T sin que llegue ninguna orden: 5 min en la demostración y 15 min en un entorno real. |
| Secuencia de interacción          | 1. Pasa el tiempo T sin órdenes. 2. El robot se apaga sin avisar. |
| Resultado / estado final esperado | El robot queda en reposo. |
| Variantes y fallos relacionados   | ESC-07. |
| Fuente y cuestiones abiertas      | Notas del equipo; ajuste del equipo (26/10): T = 5 min en la demostración (para poder comprobarlo) y 15 min en un entorno real. |

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
| Secuencia de interacción          | 1. El usuario dice «Atenio + orden imposible». 2. El sistema detecta que no está en el catálogo. 3. El ordenador avisa al usuario. |
| Resultado / estado final esperado | El robot no se mueve y el usuario recibe el aviso. |
| Variantes y fallos relacionados   | ESC-04. |
| Fuente y cuestiones abiertas      | Notas del equipo («no sigue a nadie ni navega solo»); cliente 26/10, punto 1 (el usuario conoce los comandos). *Por definir:* texto del aviso. |

### ESC-06 · Orden mientras se ejecuta otra

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-06 |
| Nombre y tipo                     | Orden mientras se ejecuta otra · Excepcional |
| Objetivo operacional              | Que una orden dada con el robot ocupado no se pierda y se ejecute después. |
| Actores y sistemas externos       | Usuario, ordenador, robot. |
| Precondiciones / estado inicial   | El robot está ejecutando una acción. |
| Disparador (trigger)              | El usuario da otra orden antes de que termine la actual. |
| Secuencia de interacción          | 1. El robot está ejecutando una acción. 2. El usuario da otra orden. 3. El sistema la guarda en una cola de acciones. 4. Cuando el robot termina, el sistema envía la siguiente orden de la cola. |
| Resultado / estado final esperado | El robot ejecuta todas las órdenes en el orden en que se dieron. |
| Variantes y fallos relacionados   | ESC-01, ESC-10. |
| Fuente y cuestiones abiertas      | Notas del equipo; ajuste del equipo (26/10). La parada de emergencia vacía la cola (REQ-30). |

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
| Objetivo operacional              | Avisar al usuario de que debe cargar el robot. |
| Actores y sistemas externos       | Robot, ordenador, usuario. |
| Precondiciones / estado inicial   | La batería del robot está baja. |
| Disparador (trigger)              | La tensión de la batería baja del umbral que vigila el firmware del robot. |
| Secuencia de interacción          | 1. El robot detecta la batería baja. 2. El robot envía el aviso al ordenador por el puerto serie. 3. El ordenador muestra el aviso al usuario. |
| Resultado / estado final esperado | El usuario sabe que debe cargar el robot. |
| Variantes y fallos relacionados   | — |
| Fuente y cuestiones abiertas      | Notas del equipo; ajuste del equipo (26/10). El firmware envía el mensaje «Low power: X V» cuando la batería baja del umbral (REF-03, `reaction.h`). |

### ESC-09 · Manipulación del robot durante una acción

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-09 |
| Nombre y tipo                     | Manipulación del robot durante una acción · Excepcional |
| Objetivo operacional              | No sufrir daños durante la manipulación. |
| Actores y sistemas externos       | Persona que coge o mueve el robot, robot. |
| Precondiciones / estado inicial   | El robot está ejecutando una acción. |
| Disparador (trigger)              | Alguien coge, mueve o tumba el robot. |
| Secuencia de interacción          | 1. Alguien coge, mueve o tumba el robot. 2. El robot ejecuta una parada de emergencia. |
| Resultado / estado final esperado | El robot se queda quieto. |
| Variantes y fallos relacionados   | — |
| Fuente y cuestiones abiertas      | Notas del equipo; ajuste del equipo (26/10). Se detecta con las skills `lifted` y `dropped` del firmware, que usan el giroscopio (ver `capacidades-bittle.md`). Por confirmar en el robot (OPEN-10). |

### ESC-10 · Órdenes encadenadas

| Campo                             | Contenido |
|-----------------------------------|-----------|
| Identificador                     | ESC-10 |
| Nombre y tipo                     | Órdenes encadenadas · Alternativo |
| Objetivo operacional              | Que el robot ejecute varias órdenes seguidas dadas en una misma frase. |
| Actores y sistemas externos       | Usuario (STK-02), ordenador con la interfaz, robot Bittle. |
| Precondiciones / estado inicial   | Robot encendido y conectado; sistema escuchando; robot sin ninguna acción en curso. |
| Disparador (trigger)              | El usuario dice el nombre del perro seguido de varias órdenes del catálogo (por ejemplo, «Atenio, camina y siéntate»). |
| Secuencia de interacción          | 1. El usuario dice «Atenio + orden 1 + orden 2…». 2. El sistema reconoce las órdenes y su orden. 3. El sistema envía la primera orden al robot. 4. Cuando termina, envía la siguiente, hasta la última. |
| Resultado / estado final esperado | El robot ha ejecutado todas las órdenes en el orden dicho y el sistema queda listo para la siguiente. |
| Variantes y fallos relacionados   | ESC-01, ESC-04, ESC-05. |
| Fuente y cuestiones abiertas      | Ajuste del cliente (26/10). *Por definir:* número máximo de órdenes por frase; palabras de enlace aceptadas («y», «luego»…); qué pasa si una de las órdenes no se reconoce; cómo se sabe que ha terminado una acción (CTX-05). |

# 4. Necesidades de los stakeholders

Recoger necesidades justificadas por el uso y por las condiciones del problema. Evitar confundir una necesidad con una tecnología concreta o con una instrucción de implementación.

## 4.1 Registro de necesidades


| ID     | Stakeholder(s) | Necesidad expresada | Origen / escenario | Justificación / prioridad |
|--------|----------------|---------------------|--------------------|---------------------------|
| NEC-01 | STK-01, STK-02 | Dar órdenes al robot por voz y que las ejecute. | ESC-01; encargo | Es el objetivo del encargo. Alta. |
| NEC-02 | STK-02, STK-04 | Activar al robot llamándolo por su nombre, para que no reaccione a conversaciones ajenas. | ESC-02; cliente 26/10, punto 3 | La voz lo interpreta todo; sin activación respondería a cualquier frase. Alta. |
| NEC-03 | STK-02 | Saber cuándo una orden no se ha entendido, para poder repetirla. | ESC-04; cliente 26/10, punto 8 | La entrada no reconocida es parte del mínimo exigido en H1. Alta. |
| NEC-04 | STK-02 | Que el robot responda a la orden en el menor tiempo posible. | ESC-01; cliente 26/10, punto 4 | El cliente pide el mínimo posible y considera inaceptable una respuesta de 10 s. Alta. |
| NEC-05 | STK-02 | Saber que una orden imposible no se va a ejecutar. | ESC-05; cliente 26/10, punto 1 | Evita que el usuario espere una acción que el robot no puede hacer. Media. |
| NEC-06 | STK-02 | Saber si el robot está conectado antes de dar órdenes. | ESC-07 | Sin conexión ninguna orden llega al robot. Media. |
| NEC-07 | STK-01 | Disponer de un repertorio de órdenes amplio (las 40 programadas y las que se añadan). | Cliente 26/10, punto 5 | El cliente valora positivamente ampliar las órdenes. Media (el mínimo son 2). |
| NEC-08 | STK-03 | Poder probar el sistema sin el robot físico. | Diapositiva H3 | H3 exige pruebas reproducibles sin el robot. Alta. |
| NEC-09 | STK-02 | Que una orden dada con el robot ocupado no se pierda y se ejecute después. | ESC-06 | El sistema la guarda en una cola y la ejecuta al terminar la acción en curso. Alta (va con las órdenes encadenadas). |
| NEC-10 | STK-01, STK-02 | Dar varias órdenes seguidas en una misma frase y que el robot las ejecute en orden. | ESC-10; ajuste del cliente (26/10) | Lo ha pedido el cliente como requisito mínimo. Alta. |
| NEC-11 | STK-02 | Saber cuándo hay que cargar el robot. | ESC-08 | Con poca batería el robot avisa al ordenador y este al usuario. Media. |
| NEC-12 | STK-01, STK-02 | Que el robot no sufra daños si alguien lo manipula. | ESC-09 | Ante la manipulación el robot hace una parada de emergencia. Media. |
| NEC-13 | STK-02 | Que el robot no gaste batería mientras está encendido sin recibir órdenes. | ESC-03 | Tras un tiempo sin órdenes (5 min en la demostración, 15 min en uso real) el robot pasa a reposo para ahorrar energía. Media. |

## 4.2 Revisión de cobertura de necesidades


**Cubierto:**
- Todos los escenarios (ESC-01 a ESC-10) tienen al menos una necesidad asociada.
- Los cuatro stakeholders (STK-01 a STK-04) tienen al menos una necesidad.

**Abierto:**

**Exclusiones:**
- Interrupciones (cancelar una acción en curso): fuera de alcance (apartado 2.1), salvo la orden «para» (REQ-07).
- Requisitos de dominio: no aplican en estas entregas (cliente 26/10, punto 7).
- El fallo mecánico del robot no se trata como escenario: lo detecta el usuario y lo comunica con la parada de emergencia de la interfaz (REQ-30), por decisión del equipo.

**Criterio de prioridad:**
- *Alta*: lo exige el criterio mínimo del H1 (NEC-01, NEC-02, NEC-03), lo pide el cliente de forma explícita (NEC-04, NEC-10 y NEC-09, que va con ella) o lo exige el H3 (NEC-08).
- *Media*: mejora el uso pero no forma parte del mínimo (NEC-05, NEC-06, NEC-07, NEC-11, NEC-12, NEC-13).

# 5. Requisitos del sistema

Los requisitos se redactan para el nivel del sistema de interés definido en 2.2. Cada requisito debe tener un identificador estable, un enunciado verificable y su trazabilidad de origen. Se organizan en categorías cuando ayuden a examinar la cobertura; ninguna categoría debe rellenarse artificialmente.

## 5.1 Requisitos funcionales

Alcance: una orden o varias encadenadas en una misma frase; cada orden empieza cuando termina la anterior (Cliente 26/10, punto 2, ajustado por el cliente). «Atenio» es el nombre del perro (palabra de activación). Los requisitos de Nivel 1 son fijos. Los marcados *Opcional* son del Nivel 2 y se abordan si hay tiempo. La lista completa de niveles está en `propuesta-requisitos-funcionales-por-tiers.md`.

**Activación**

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-01 | El sistema deberá tratar como orden solo una frase que empiece por el nombre del perro «Atenio» seguido de una orden del catálogo, y deberá ignorar cualquier otra frase sin enviar ningún comando al robot, salvo lo previsto en REQ-35. | ESC-01, ESC-02; Cliente 26/10 (3) | Prueba sin robot: 20 frases con el nombre se procesan como orden; 20 frases sin el nombre no producen ningún comando. | Esencial |

**Órdenes del Nivel 1**

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-02 | Ante la orden «Atenio, siéntate», el sistema deberá enviar al robot el comando `ksit` (sentarse). | ESC-01; Cliente 26/10 (5); T1-01 | Prueba sin robot: el robot simulado recibe `ksit`. Demostración: el robot termina sentado. | Esencial (Nivel 1) |
| REQ-03 | Ante la orden «Atenio, levántate», el sistema deberá enviar al robot el comando `kup` (ponerse en pie). | ESC-01; Cliente 26/10 (5); T1-02 | Prueba sin robot: el robot simulado recibe `kup`. Demostración: el robot termina de pie. | Esencial (Nivel 1) |
| REQ-04 | Ante la orden «Atenio, camina», el sistema deberá enviar al robot el comando `kwkF` (caminar hacia delante). | ESC-01; Cliente 26/10 (5); T1-03 | Prueba sin robot: el robot simulado recibe `kwkF`. Demostración: el robot avanza. | Esencial (Nivel 1) |
| REQ-05 | Ante la orden «Atenio, izquierda», el sistema deberá enviar al robot el comando `kwkL` (caminar hacia la izquierda). | ESC-01; Cliente 26/10 (5); T1-04 | Prueba sin robot: el robot simulado recibe `kwkL`. Demostración: el robot gira a la izquierda. | Esencial (Nivel 1) |
| REQ-06 | Ante la orden «Atenio, derecha», el sistema deberá enviar al robot el comando `kwkR` (caminar hacia la derecha). | ESC-01; Cliente 26/10 (5); T1-05 | Prueba sin robot: el robot simulado recibe `kwkR`. Demostración: el robot gira a la derecha. | Esencial (Nivel 1) |
| REQ-07 | Ante la orden «Atenio, para», el sistema deberá enviar al robot el comando `krest` (detenerse en postura de reposo). Es la única orden que interrumpe: deberá enviarse aunque el robot esté ejecutando otra acción, y la interrumpe. | ESC-01, ESC-06; Cliente 26/10 (5); T1-06; decisión del equipo (26/10) | Prueba sin robot: el robot simulado recibe `krest`, también con una acción en curso. Demostración: el robot se detiene. | Esencial (Nivel 1) |
| REQ-08 | Ante la orden «Atenio, túmbate», el sistema deberá enviar al robot el comando `d` (tumbarse y apagar los motores). | ESC-01; Cliente 26/10 (5); T1-07 | Prueba sin robot: el robot simulado recibe `d`. Demostración: el robot queda tumbado. | Esencial (Nivel 1) |
| REQ-09 | Ante la orden «Atenio, saluda», el sistema deberá enviar al robot el comando `khi` (saludar). | ESC-01; Cliente 26/10 (5); T1-08 | Prueba sin robot: el robot simulado recibe `khi`. Demostración: el robot hace el gesto de saludo; comando por confirmar (OPEN-03). | Esencial (Nivel 1) |
| REQ-10 | Ante la orden «Atenio, equilíbrate», el sistema deberá enviar al robot el comando `kbalance` (postura de equilibrio). | ESC-01; Cliente 26/10 (5); T1-09 | Prueba sin robot: el robot simulado recibe `kbalance`. Demostración: el robot queda en equilibrio. | Esencial (Nivel 1) |
| REQ-11 | Ante la orden «Atenio, trota», el sistema deberá enviar al robot el comando `ktrF` (trotar hacia delante). | ESC-01; Cliente 26/10 (5); T1-10 | Prueba sin robot: el robot simulado recibe `ktrF`. Demostración: el robot trota; comando por confirmar (OPEN-03). | Esencial (Nivel 1) |

**Entradas que no son una orden válida**

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-12 | Ante una frase con ruido o sin sentido que no se interprete como una orden, el sistema deberá no enviar ningún comando de movimiento y deberá mostrar el aviso «no se ha entendido bien». | ESC-04; Cliente 26/10 (8); T1-11 | Prueba sin robot: 20 entradas de ruido o sin sentido → ningún comando y aviso mostrado cada vez. | Esencial |
| REQ-13 | Ante una orden que no está en el catálogo o que el robot no puede hacer (por ejemplo «sígueme»), el sistema deberá no enviar ningún comando y deberá mostrar un aviso de orden no disponible. | ESC-05; Cliente 26/10 (1) | Prueba sin robot: 10 órdenes fuera del catálogo → ningún comando y aviso mostrado cada vez. | Esencial |

**Órdenes opcionales (Nivel 2)**

Cada una cuenta como una sola orden para el usuario, aunque el sistema envíe varios comandos seguidos.

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-14 | Ante la orden «Atenio, baila», el sistema deberá hacer que el robot ejecute una secuencia de movimientos fija y predefinida, y deberá terminar en una postura estable. | ESC-01; T2-09; Cliente 26/10 (5: «todo lo que añadáis será valorado») | Prueba sin robot: la lista de comandos enviada coincide con la secuencia definida (OPEN-08). Demostración: la secuencia se completa sin caída. | Opcional |
| REQ-15 | Ante la orden «Atenio, media vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta quedar orientado en sentido contrario al inicial, con una desviación máxima de ±45° (valor provisional). | ESC-01; T2-01; Cliente 26/10 (5) | Prueba sin robot: comando `kwkL` durante la duración calibrada (OPEN-04). Demostración: 5 intentos con medida de la desviación. | Opcional |
| REQ-16 | Ante la orden «Atenio, da una vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta completar una vuelta, con una desviación máxima de ±45° (valor provisional). | ESC-01; T2-01; aclaración 26/10 («combinar dos giros a la izquierda») | Prueba sin robot: dos giros seguidos de la duración calibrada (OPEN-04). Demostración: 5 intentos con medida de la desviación. | Opcional |

**Órdenes encadenadas y cola de acciones (ajuste del cliente)**

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-29 | Ante una frase «Atenio, orden 1 y orden 2…» con varias órdenes del catálogo, el sistema deberá enviar al robot los comandos de cada orden en el orden dicho, y deberá enviar cada uno solo cuando haya terminado la acción anterior. Si una de las órdenes no está en el catálogo, el sistema deberá saltarla, avisar al usuario y ejecutar las demás en el orden dicho. | ESC-10; NEC-10; ajuste del cliente (26/10) | Prueba sin robot: frases con 2 y con 3 órdenes → el robot simulado recibe los comandos en el orden dicho. Frase con una orden fuera del catálogo → se salta esa, se ejecutan las demás y se muestra el aviso. Demostración: el robot ejecuta las acciones seguidas y en orden. *Por definir:* número máximo de órdenes, palabras de enlace aceptadas y cómo se detecta el fin de cada acción (CTX-05). | Esencial (mínimo del cliente) |
| REQ-32 | Si llega una orden mientras el robot ejecuta otra, el sistema deberá guardarla en una cola de acciones y enviarla al robot cuando termine la acción en curso, respetando el orden de llegada. La orden «para» (REQ-07) no se guarda en la cola: interrumpe la acción en curso. La parada de emergencia vacía la cola (REQ-30). | ESC-06; NEC-09 | Prueba sin robot: tres órdenes dadas con el robot simulado ocupado → recibe los comandos en el orden dado, cada uno al terminar el anterior. | Esencial |
| REQ-35 | Si el usuario dice solo «Atenio» sin orden, el sistema deberá esperar una orden durante 5 s (valor provisional) y tratar como orden la frase que llegue en ese tiempo aunque no empiece por «Atenio». Si no llega ninguna, deberá volver a la escucha normal sin enviar ningún comando. | NEC-02; decisión del equipo (26/10) | Prueba sin robot: «Atenio» y una orden válida dentro de 5 s → el robot simulado recibe el comando; «Atenio» sin orden → ningún comando y la siguiente orden con nombre se atiende. | Media |

## 5.2 Requisitos de interfaces

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-17 | El sistema deberá recibir la voz del usuario desde el micrófono del ordenador del equipo. | Cliente 26/10 (9); ESC-01 | Demostración: una frase dicha ante el micrófono aparece como texto. | Esencial |
| REQ-18 | El sistema deberá obtener el texto de la voz mediante un módulo de transcripción ya existente, y deberá incluir un intérprete propio que convierta ese texto en una orden del catálogo. | Aclaración 26/10 (la transcripción no se desarrolla; el intérprete sí) | Inspección: el módulo de transcripción es una dependencia externa y el intérprete es código del equipo. Prueba: texto → orden esperada. | Esencial |
| REQ-19 | El sistema deberá ofrecer una interfaz de usuario (web o aplicación) que muestre el texto reconocido, la orden interpretada, el estado de la conexión con el robot y los avisos, y que incluya el botón de parada de emergencia (REQ-30). Los avisos se muestran solo en pantalla (decidido el 26/10). | Cliente 26/10 (8, 9); ESC-04, ESC-05, ESC-07 | Demostración: los cuatro elementos son visibles y el botón está disponible en una sesión de prueba. | Esencial |
| REQ-20 | El sistema deberá enviar al robot los comandos en el formato del protocolo serie de Petoi (token y parámetros, por ejemplo `ksit`) a través de un puerto serie (Bluetooth o USB, OPEN-07). | REF-03 (Petoi Serial Protocol, Python API) | Prueba sin robot: el robot simulado recibe la cadena exacta. Demostración: el robot obedece. | Esencial |

## 5.3 Requisitos de prestaciones y calidad

Los valores numéricos son **provisionales**: el cliente pidió ponerlos «a ojo» con márgenes amplios y ajustarlos tras los prototipos (Cliente 26/10, aclaración). Ver OPEN-02.

| ID | Enunciado | Origen | Verificación prevista | Prioridad |
|----|-----------|--------|-----------------------|-----------|
| REQ-21 | El tiempo desde que el usuario termina la frase hasta que el sistema envía el comando al robot deberá ser inferior a 1,5 s (valor provisional, CTX-04). | Cliente 26/10 (4: «el mínimo posible»; 10 s no es aceptable) | Prueba sin robot: 20 mediciones, todas < 1,5 s. | Esencial |
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
| REQ-30 | **Parada de emergencia.** La interfaz deberá ofrecer un botón de parada de emergencia. Al pulsarlo, el sistema deberá poner el robot en modo reposo, deberá vaciar la cola de acciones y no deberá enviarle ningún otro comando hasta que el usuario vuelva a pulsar el mismo botón. Mientras la parada esté activa, las órdenes de voz no producen ningún comando y se muestra el aviso «parada de emergencia activa». | Notas del equipo; ajuste del equipo (26/10): el usuario detecta el fallo y lo comunica por la interfaz | Prueba sin robot: al pulsar el botón, el robot simulado recibe el comando de reposo (OPEN-11), la cola queda vacía y no recibe ningún comando ante órdenes posteriores, y se muestra el aviso «parada de emergencia activa»; al volver a pulsarlo, se atienden de nuevo. Demostración con el robot. | Esencial |
| REQ-31 | Tras un tiempo T sin recibir órdenes, el sistema deberá poner el robot en reposo sin avisar. T deberá ser configurable: 5 min en la demostración y 15 min en un entorno real. Una orden válida posterior deberá sacar al robot del reposo y ejecutarse. | ESC-03; NEC-13 | Prueba sin robot con T reducido: al cumplirse T, el robot simulado recibe el comando de reposo (OPEN-11); una orden válida posterior → recibe su comando. Demostración con T = 5 min. | Media |
| REQ-33 | Al recibir del robot por el puerto serie el aviso de batería baja («Low power»), el sistema deberá mostrar al usuario un aviso de que debe cargar el robot. | ESC-08; NEC-11; REF-03 (`reaction.h`) | Prueba sin robot: el robot simulado envía «Low power: 6.5V» → aparece el aviso. | Media |
| REQ-34 | El sistema deberá mantener activado el giroscopio del robot, de forma que, si lo cogen o se cae durante una acción, el robot ejecute su reacción (`lifted` / `dropped`) y se quede quieto. | ESC-09; NEC-12; REF-03 | Demostración con el robot: levantarlo durante una acción → se detiene y queda quieto. Por confirmar en el robot (OPEN-10). | Media |

## 5.5 Ficha de requisito

Los atributos de la ficha (identificador, clase, enunciado, origen, verificación prevista y estado) se recogen para cada requisito en las tablas de 5.1 a 5.4 y en el registro de 5.6.

## 5.6 Registro consolidado de requisitos

| ID     | Clase     | Enunciado breve        | Origen (NEC/ESC) | Verificación prevista  |
|--------|-----------|------------------------|------------------|------------------------|
| REQ-01 | Funcional | Activación por el nombre del perro | ESC-01, ESC-02 | Prueba sin robot (20 + 20 frases) |
| REQ-02 | Funcional | «siéntate» → `ksit` | ESC-01 | Prueba sin robot + demostración |
| REQ-03 | Funcional | «levántate» → `kup` | ESC-01 | Prueba sin robot + demostración |
| REQ-04 | Funcional | «camina» → `kwkF` | ESC-01 | Prueba sin robot + demostración |
| REQ-05 | Funcional | «izquierda» → `kwkL` | ESC-01 | Prueba sin robot + demostración |
| REQ-06 | Funcional | «derecha» → `kwkR` | ESC-01 | Prueba sin robot + demostración |
| REQ-07 | Funcional | «para» → `krest`; interrumpe cualquier acción en curso | ESC-01, ESC-06 | Prueba sin robot + demostración |
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
| REQ-19 | Interfaz | Interfaz de usuario: texto, orden, estado, avisos y botón de parada | ESC-04, 05, 07 | Demostración |
| REQ-20 | Interfaz | Comandos del protocolo serie de Petoi | REF-03 | Prueba sin robot + demostración |
| REQ-21 | Prestación | Comando enviado en < 1,5 s (provisional) | Cliente (4) | Prueba sin robot (20 mediciones) |
| REQ-22 | Fiabilidad | ≥ 80 % de órdenes válidas ejecutadas (provisional) | ESC-01 | Prueba (20 intentos por orden) |
| REQ-23 | Robustez | Sigue operativo tras 20 entradas inválidas | ESC-04, 05 | Prueba sin robot |
| REQ-24 | Privacidad | No guarda audio en disco | Cliente (7) | Inspección |
| REQ-25 | Operación | Robot desconectado: sin comandos y aviso | ESC-07 | Prueba sin robot + demostración |
| REQ-26 | Operación | Ejecución con robot simulado | STK-03, H3 | Prueba |
| REQ-27 | Operación | Funciona en el ordenador del equipo | Cliente (9) | Demostración |
| REQ-28 | Seguridad | Ensayos sobre superficie lisa y con vigilancia | REF-03, ESC-09 | Inspección del procedimiento |
| REQ-29 | Funcional | Órdenes encadenadas: comandos en el orden dicho, cada uno al terminar el anterior; la no reconocida se salta con aviso | ESC-10, NEC-10 | Prueba sin robot + demostración |
| REQ-30 | Seguridad | Parada de emergencia: botón en la interfaz, vacía la cola y reposo hasta volver a pulsarlo | Notas del equipo | Prueba sin robot + demostración |
| REQ-31 | Operación | Reposo tras T sin órdenes (5 min demo / 15 min real) | ESC-03, NEC-13 | Prueba sin robot + demostración |
| REQ-32 | Funcional | Cola de acciones para órdenes dadas con el robot ocupado; «para» no se encola, interrumpe | ESC-06, NEC-09 | Prueba sin robot |
| REQ-33 | Interfaz | Aviso de batería baja al recibir «Low power» | ESC-08, NEC-11 | Prueba sin robot |
| REQ-34 | Seguridad | Giroscopio activo: el robot se detiene si lo cogen o se cae | ESC-09, NEC-12 | Demostración |
| REQ-35 | Funcional | «Atenio» solo: espera la orden 5 s (provisional) | NEC-02 | Prueba sin robot |

# 6. Trazabilidad y estrategia inicial de verificación

## 6.1 Matriz de trazabilidad

| Escenario | Necesidad | Requisito(s) | Criterio / caso de verificación futuro           |
|-----------|-----------|--------------|--------------------------------------------------|
| ESC-01 | NEC-01, NEC-04, NEC-07 | REQ-01 a REQ-11, REQ-21, REQ-22; opcionales REQ-14 a REQ-16 | Cada orden llega como comando al robot simulado y el robot la ejecuta en la demostración; tiempo y aciertos dentro de los límites. |
| ESC-02 | NEC-02 | REQ-01 | Ninguna de las 20 frases sin el nombre produce un comando. |
| ESC-03 | NEC-13 | REQ-31 | Sin órdenes durante T, el robot simulado recibe el comando de reposo. |
| ESC-04 | NEC-03 | REQ-12, REQ-19, REQ-23 | Ruido o frase sin sentido: sin movimiento y aviso visible; el sistema sigue operativo. |
| ESC-05 | NEC-05 | REQ-13, REQ-19, REQ-23 | Orden fuera del catálogo: sin movimiento y aviso visible. |
| ESC-06 | NEC-09 | REQ-32, REQ-07 | Órdenes dadas con el robot ocupado llegan después, en el orden dado; «para» interrumpe y envía `krest`. |
| ESC-07 | NEC-06 | REQ-19, REQ-25 | Sin conexión: ningún comando y aviso mostrado. |
| ESC-10 | NEC-10 | REQ-29 | Frases con varias órdenes: los comandos llegan al robot simulado en el orden dicho. |
| Parada de emergencia (sin escenario) | — | REQ-30 | Al pulsar el botón el robot pasa a reposo y no atiende órdenes hasta volver a pulsarlo. |
| «Atenio» solo (sin escenario) | NEC-02 | REQ-35 | Espera de 5 s: con orden dentro del tiempo se ejecuta; sin orden no se envía nada. |
| ESC-08 | NEC-11 | REQ-33 | El aviso «Low power» del robot se muestra al usuario. |
| ESC-09 | NEC-12 | REQ-34, REQ-28 | Al levantar el robot durante una acción, se detiene. |
| H3 (pruebas sin robot) | NEC-08 | REQ-26 | El conjunto de pruebas se ejecuta completo sin robot conectado. |
| Transversales | NEC-01 | REQ-17, REQ-18, REQ-20, REQ-27 | Ver verificación en 5.1 a 5.4. |
| Cliente 26/10 (7) | — | REQ-24 | Inspección: sin ficheros de audio. |

## 6.2 Comprobación de cobertura

Estado actual (borrador):

- Todas las necesidades tienen al menos un requisito.
- Todos los escenarios tienen al menos un requisito.
- Requisitos sin necesidad asociada: REQ-24 (privacidad), que viene de lo que dijo el cliente (punto 7), y REQ-28, que viene de la documentación de Petoi. Falta decidir si se crea una necesidad para cada uno.
- Todos los requisitos tienen origen y método de verificación previsto.

## 6.3 Enfoque inicial de verificación

> En el H1 no se ha ejecutado ninguna prueba: todo lo de este apartado está planificado.

| Nivel | Qué se comprueba | Requisitos |
|-------|------------------|------------|
| Solo software (robot simulado, REQ-26) | Activación por nombre, comando que se enviaría por cada orden, avisos ante entradas no válidas, robustez ante entradas inválidas seguidas, tiempo hasta el envío del comando, orden de los comandos encadenados y ausencia de ficheros de audio. | REQ-01 a REQ-13, REQ-21, REQ-23 a REQ-25, REQ-29 a REQ-33 |
| Integración (ordenador, micrófono y enlace con el robot) | Captación de la voz, transcripción e intérprete, interfaz de usuario, formato de los comandos en el puerto serie, tasa de reconocimiento con voz real y funcionamiento en el ordenador del equipo. | REQ-17 a REQ-20, REQ-22, REQ-27 |
| Robot físico (sesión 2, ensayos supervisados según REQ-28) | Que el robot ejecute cada orden, secuencias opcionales (baila, media vuelta, da una vuelta), desconexión real del robot y comportamiento ante batería baja y manipulación. | REQ-02 a REQ-11 (demostración), REQ-14 a REQ-16, REQ-25, REQ-30, REQ-34 |

# 7. Supuestos, decisiones pendientes y riesgos

| ID      | Supuesto / cuestión / riesgo  | Impacto            | Acción para resolverlo                     | Responsable / estado |
|---------|-------------------------------|--------------------|--------------------------------------------|----------------------|
| OPEN-01 | Nombre del perro (palabra de activación) y cómo se pronuncia | Condiciona REQ-01 y todas las órdenes | Decidido: «Atenio» (26/10). Falta comprobarlo con el reconocimiento de voz | Equipo / decidido |
| OPEN-02 | Valores numéricos provisionales de REQ-15, REQ-16, REQ-21, REQ-22 y REQ-35 (5 s) | Cambian los criterios de aceptación | Medir con un prototipo y ajustar (el cliente lo permite) | Equipo / abierto |
| OPEN-03 | Los comandos `khi`, `ktrF` y el pitido `b` no están confirmados en nuestro robot | REQ-09, REQ-11; aviso sonoro | Probarlos con el robot en la sesión 2 | Equipo / abierto |
| OPEN-04 | Duración del giro de `kwkL`/`kwkR` y tolerancia aceptable | REQ-15, REQ-16 | Medir con el robot y fijar la duración calibrada | Equipo / abierto |
| OPEN-05 | Qué hace el sistema si llega una orden con el robot ocupado (ESC-06) y tras un tiempo sin órdenes (ESC-03) | ESC-03, ESC-06 | Decidido (26/10): cola de acciones (REQ-32) y reposo tras 5 min en la demo / 15 min en uso real (REQ-31). La parada de emergencia vacía la cola (REQ-30) | Equipo / decidido |
| OPEN-06 | El módulo de transcripción puede enviar el audio a un servicio externo | Afecta a REQ-24 (privacidad) | Elegir el módulo y comprobar dónde se procesa el audio | Equipo / abierto |
| OPEN-07 | Conexión con el robot (Bluetooth o USB), modelo y placa | REQ-20 | Comprobar en el robot y, si hace falta, preguntar al cliente | Equipo / abierto |
| OPEN-08 | Secuencia concreta de «baila» | REQ-14 | Diseñar y probar la secuencia | Equipo / abierto |
| OPEN-09 | El aviso al usuario: solo en pantalla (decidido el 26/10) | REQ-12, REQ-13, REQ-25 | Ninguna; el cliente admite que lo diga el ordenador (punto 8), pero no se exige | Equipo / cerrado |
| OPEN-10 | Que las skills `lifted` y `dropped` detengan el robot cuando lo cogen o se cae | REQ-34 | Probarlo con el robot en la sesión 2 | Equipo / abierto |
| OPEN-11 | Comando de reposo que se envía al robot en REQ-30 y REQ-31 (`krest` o `d`) | REQ-30, REQ-31 | Decidir y probar en el robot en la sesión 2 | Equipo / abierto |
| OPEN-12 | Qué hace «para» con la cola de acciones: ¿la vacía o deja que sigan las órdenes guardadas? | REQ-07, REQ-32 | Decidir con el equipo | Equipo / abierto |

# 8. Revisión y estado de H1

Este apartado registra el resultado de la revisión de la empresa; no implica necesariamente aprobación formal del profesor ni cierre definitivo de los requisitos.

| Comprobación                                          | Resultado / evidencia      |
|-------------------------------------------------------|----------------------------|
| Cobertura de escenarios nominales y excepcionales     | 10 escenarios: 1 nominal (ESC-01), 3 alternativos (ESC-02, ESC-03, ESC-10) y 6 excepcionales (ESC-04 a ESC-09). Incluyen la entrada no reconocida (ESC-04, ESC-05). |
| Relación entre necesidades, stakeholders y escenarios | Los 4 stakeholders tienen al menos una necesidad, y los 10 escenarios están enlazados con alguna de las 13 necesidades (apartados 4.1 y 4.2). |
| Claridad, coherencia y verificabilidad de requisitos  | 34 requisitos con identificador, origen y verificación prevista. Los valores numéricos son provisionales y se ajustarán con el prototipo (OPEN-02). |
| Trazabilidad y método de verificación previsto        | Matriz escenario → necesidad → requisito completa (6.1); todos los escenarios y necesidades tienen requisito (6.2); niveles de verificación en 6.3. |
| Incertidumbres identificadas y documentadas           | OPEN-01 a OPEN-10 (apartado 7). |
| Versión recuperable del repositorio                   | Rama `main` de https://github.com/MochoPlayer/Perro-Spek-Kit-IngenIA; commit de entrega indicado en Moodle. |

# 9. Referencias metodológicas y grado de adaptación

ISO/IEC/IEEE 15288:2023, apdos. 6.4.2 (Stakeholder needs and requirements definition) y 6.4.3 (System requirements definition): referencia para identificación de stakeholders, escenarios, necesidades, requisitos, trazabilidad y resultados de proceso. Fuente: copia del estándar facilitada para la asignatura.

ISO/IEC/IEEE 29148:2018, Systems and software engineering — Life cycle processes — Requirements engineering: referencia principal para información y estructura de especificaciones de requisitos. Consulta pública del alcance: https://www.iso.org/standard/72089.html . No se ha reproducido ni afirmado cumplir la estructura íntegra de la SyRS de la norma; consultar el texto licenciado para una conformidad formal.

NASA Systems Engineering Handbook, NASA/SP-2016-6105 Rev. 2, especialmente 4.2, apéndice C (calidad de requisitos) y apéndice D (matriz de verificación): https://www.nasa.gov/reference/systems-engineering-handbook/

Adaptación docente explícita: la investigación preliminar y el registro de riesgos se integran en un único documento H1 para facilitar la transición posterior a Spec Kit; el control documental, las tablas y la nomenclatura ESC/NEC/REQ son convenciones de esta plantilla, no códigos impuestos por las normas citadas.
