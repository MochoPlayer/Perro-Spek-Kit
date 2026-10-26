# H1 · Especificación inicial — [Nombre de la empresa]

**Equipo:** [nombres] · **Fecha:** [dd/mm/aaaa] · **Versión:** 0.1

> Plantilla propia, basada en la tabla de contenidos de [`README.md`](README.md). La plantilla opcional de Moodle puede sustituirla. Las filas marcadas *(ejemplo)* se borran al rellenar.

## 0. Resumen del encargo

- **Qué nos piden (una frase):** [El robot Petoi Bittle debe obedecer órdenes de voz.]
- **Las dos órdenes válidas elegidas:** [orden 1] y [orden 2] (ver §4, decisión D-01).
- **Qué hace el sistema ante una entrada no reconocida:** [no se mueve y …].
- **Fuera de alcance (por ahora):** [lo que se queda para más adelante].

## 1. Investigación técnica

Resumen en [`capacidades-bittle.md`](capacidades-bittle.md). Rellenar solo lo propio de nuestra empresa.

### 1.1 El robot

| Aspecto | Dato | Fuente | ¿Confirmado en el robot real? |
|---|---|---|---|
| Modelo y placa | [Bittle / Bittle X; NyBoard / BiBoard] | [..] | [sí/no] |
| Movimientos disponibles | [lista] | Serial Protocol | [sí/no] |
| Conexión | [Bluetooth / USB; puerto; baudios] | [..] | [sí/no] |
| Sensores y extras | [ultrasonidos, zumbador, giroscopio…] | [..] | [sí/no] |
| Duración de cada movimiento usado | [segundos] | Medido | [sí/no] |

### 1.2 Reconocimiento de voz — alternativas

| Alternativa | Local u online | Idiomas | Ventajas | Inconvenientes | Elegida |
|---|---|---|---|---|---|
| [Módulo de voz de Petoi] | Local | EN/ZH | [..] | [..] | [ ] |
| [Reconocimiento en el PC] | [..] | [..] | [..] | [..] | [ ] |
| [..] | | | | | [ ] |

### 1.3 Integración y restricciones

- **Arquitectura mínima:** micrófono → reconocimiento → mapeo de órdenes → enlace al robot (Bluetooth) → robot.
- **Restricciones identificadas:** [superficie lisa, sin aviso de fin de movimiento, ruido…].
- **Dependencias:** [Python, `pyserial 3.5`, librería de voz…].

## 2. Escenarios operacionales

Formato por escenario (según Sommerville): quién, dónde, qué quiere, qué pasa, cómo termina.

| ID | Tipo | Título | Actor | Situación inicial | Flujo | Resultado esperado |
|---|---|---|---|---|---|---|
| ESC-01 | Nominal | *(ejemplo)* [Orden 1 en sala tranquila] | [Usuario] | [Robot encendido, conectado, en pie] | 1. [..] 2. [..] | [El robot hace X] |
| ESC-02 | Nominal | [Orden 2] | | | | |
| ESC-03 | Excepcional | [Entrada no reconocida] | | | | [No se mueve; aviso] |
| ESC-04 | Excepcional | [Robot desconectado] | | | | |
| ESC-05 | Excepcional | [Ruido de fondo] | | | | |
| ESC-06 | Excepcional | [Orden mientras ejecuta otra] | | | | |
| ESC-07 | Excepcional | [Batería baja] | | | | |

Escenarios a considerar: varios hablantes, orden dicha a medias, orden repetida, orden de parada, micrófono sin permiso, Bluetooth que se cae.

## 3. Necesidades de los stakeholders

| ID | Stakeholder | Necesidad | Justificación | Origen (escenario) |
|---|---|---|---|---|
| NEC-01 | *(ejemplo)* Cliente (profesor) | [Que el robot obedezca órdenes de voz] | [Encargo] | ESC-01, ESC-02 |
| NEC-02 | [Usuario] | [..] | [..] | [..] |
| NEC-03 | [Cliente] | [Que una entrada desconocida no cause un movimiento] | [Seguridad] | ESC-03 |

Stakeholders posibles: cliente, usuario que habla, equipo de desarrollo, evaluadores de la demostración.

## 4. Requisitos del sistema

Redacción tipo NASA (Apéndice C): "El sistema **deberá** …", una sola obligación por requisito, medible, sin ambigüedad.

### 4.1 Decisiones previas

| ID | Decisión | Motivo | Fecha |
|---|---|---|---|
| D-01 | Las dos órdenes válidas son [..] y [..] | [..] | [..] |

### 4.2 Requisitos funcionales

| ID | Requisito | Prioridad | Origen (NEC) |
|---|---|---|---|
| REQ-F-01 | *(ejemplo)* El sistema deberá enviar el token `[..]` al robot cuando reconozca la orden "[..]". | Alta | NEC-01 |
| REQ-F-02 | El sistema deberá enviar el token `[..]` cuando reconozca "[..]". | Alta | NEC-01 |
| REQ-F-03 | El sistema **no deberá** enviar ningún token de movimiento ante una entrada no reconocida. | Alta | NEC-03 |
| REQ-F-04 | El sistema deberá [avisar al usuario con …] ante una entrada no reconocida. | Media | NEC-03 |

### 4.3 Requisitos de calidad

| ID | Categoría | Requisito | Valor objetivo | Origen |
|---|---|---|---|---|
| REQ-Q-01 | Tiempo de respuesta | Desde el fin de la frase hasta el inicio del movimiento | [≤ ? s] | NEC-01 |
| REQ-Q-02 | Fiabilidad | Proporción de órdenes bien reconocidas | [≥ ? %] | NEC-01 |
| REQ-Q-03 | Seguridad | [Parada ante la palabra "[..]"] | [..] | [..] |
| REQ-Q-04 | Robustez | [Pérdida de conexión: el sistema avisa y no se bloquea] | [..] | [..] |
| REQ-Q-05 | Verificabilidad | Probar sin el robot físico | [..] | [..] |

### 4.4 Restricciones

| ID | Restricción | Origen |
|---|---|---|
| RES-01 | [Lenguaje, sistema operativo, conexión Bluetooth…] | [Encargo / cliente] |

## 5. Trazabilidad y verificación

### 5.1 Matriz de trazabilidad

| Escenario | Necesidad | Requisito | Método de verificación | ID de prueba |
|---|---|---|---|---|
| ESC-01 | NEC-01 | REQ-F-01 | [Prueba sin robot + demostración] | PRB-01 |
| ESC-02 | NEC-01 | REQ-F-02 | [..] | PRB-02 |
| ESC-03 | NEC-03 | REQ-F-03, REQ-F-04 | [..] | PRB-03 |

Cada escenario, necesidad y requisito debe aparecer al menos una vez. Ninguno puede quedar sin comprobar.

### 5.2 Matriz de verificación (NASA, Apéndice D)

| Requisito | Método (Prueba / Demostración / Inspección / Análisis) | Criterio de aceptación | Dónde se hace (sin robot / con robot) | Responsable |
|---|---|---|---|---|
| REQ-F-01 | [..] | [..] | [..] | [..] |

## 6. Cambios previstos (para CR-01)

- **Qué podría cambiar el cliente:** [órdenes, idioma, distancia, ruido…].
- **Qué requisitos se tocarían en cada caso:** [vía matriz §5.1].

## 7. Abierto

| ID | Pregunta o duda | A quién | Estado |
|---|---|---|---|
| Q-01 | [..] | Cliente | Abierta |

Lista de preguntas para el cliente en [`preguntas-para-el-cliente.md`](preguntas-para-el-cliente.md).
