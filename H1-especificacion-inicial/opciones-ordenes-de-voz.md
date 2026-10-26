# Opciones de órdenes de voz

**Propuesta de trabajo, no decisión.** Son candidatas para elegir las dos órdenes válidas de H1 y para ver hasta dónde se puede llegar después. Las frases habladas son ejemplos. Los tokens vienen de [`capacidades-bittle.md`](capacidades-bittle.md).

Cadena prevista: `micrófono → reconocimiento de voz → texto → normalizar y mapear → token serie → robot`.

Cada opción debe terminar como requisito verificable. Se puede probar **sin robot** comprobando el token que se enviaría (H3) y **con robot** en la demostración (H4).

## Tier 1 · Muy alcanzables

Una frase = un token = una acción. No hay estado ni tiempos. Son los candidatos naturales para las **dos órdenes válidas**.

| ID | Frase de ejemplo | Token | Qué hace | Cómo se verifica |
|---|---|---|---|---|
| T1-01 | "siéntate" | `ksit` | Se sienta. | El robot termina sentado. |
| T1-02 | "levántate" / "arriba" | `kup` | Se pone en pie. | El robot termina de pie. |
| T1-03 | "camina" / "adelante" | `kwkF` | Camina hacia delante. | El robot avanza. |
| T1-04 | "izquierda" | `kwkL` | Camina girando a la izquierda. | El robot gira a la izquierda. |
| T1-05 | "derecha" | `kwkR` | Camina girando a la derecha. | El robot gira a la derecha. |
| T1-06 | "para" / "stop" | `krest` o `p` | Se detiene. | El robot se detiene. |
| T1-07 | "túmbate" / "descansa" | `d` | Se tumba y apaga los servos. | El robot se tumba. |
| T1-08 | "saluda" | `khi` ⚠️ | Saluda. | Mueve la pata delantera. |
| T1-09 | "equilíbrate" | `kbalance` | Postura de equilibrio. | El robot queda en equilibrio. |
| T1-10 | "trota" | `ktrF` | Trota hacia delante. | El robot trota. |
| T1-11 | Frase no reconocida | ninguno + `b …` | No se mueve. Emite un pitido o aviso. | No sale ningún token de movimiento y suena el aviso. |

Riesgos de Tier 1: el reconocimiento de voz falla con ruido, con acento o con frases parecidas. Hay que decidir qué hacer ante una confianza baja (tratarla como "no reconocida").

## Tier 2 · Podríamos hacerlas

Combinan órdenes o añaden estado, parámetros o tiempos. Es la zona de mejora tras cumplir lo mínimo.

| ID | Frase de ejemplo | Cómo se haría | Qué hay que resolver |
|---|---|---|---|
| T2-01 | **"da una vuelta"** | Dos giros a la izquierda seguidos: `kwkL`, espera, `kwkL`. O con la cola: `qkwkL:t>kwkL:t>`. | Cuánto dura cada giro. Hay que **medirlo** en el robot y ajustar. Sin esa medida la vuelta no cierra. |
| T2-02 | "gira a la derecha dos veces" | Repetir un token N veces. | Interpretar números dichos en voz ("dos", "tres"). |
| T2-03 | "camina y siéntate" | Dos tokens en cadena (`kwkF` y `ksit`) con espera. | Separar frases con "y" / "luego". |
| T2-04 | "saluda y siéntate" | Igual que T2-03. | Igual que T2-03. |
| T2-05 | "levántate y camina" | `kup`, espera, `kwkF`. | Orden y tiempo de espera. |
| T2-06 | "da dos pasos" / "avanza un poco" | `kvt` o `kwkF` con tiempo limitado, y luego `krest`. | Un skill es una marcha continua: hay que cortarla por tiempo. |
| T2-07 | "mueve la cabeza a la izquierda" | `m idx ang` con el índice de cabeza ⚠️ (0–3). | Confirmar el índice y el rango del ángulo. |
| T2-08 | "ve más rápido" / "más despacio" | Cambiar de `kwk` a `ktr`, o activar o desactivar el giroscopio (`G`). | Definir qué significa "más rápido". |
| T2-09 | "baila" | Secuencia fija con la cola `q` o una lista de tareas de Python. | Elegir y probar la secuencia. |
| T2-10 | "haz un cuadrado" | Cuatro veces: avanzar y girar. | Mismo problema de tiempos que T2-01. Cuanto más largo, más se acumula el error. |
| T2-11 | Confirmación de la orden | Pitido o color de ojos (`b`, `C`) al entender una orden. | Requiere el sensor ultrasónico para el color. |
| T2-12 | Parada de emergencia | "para" cancela cualquier secuencia en curso. | Una cola en marcha no se cancela sola: el módulo de órdenes debe poder abortarla. |
| T2-13 | Sinónimos | "siéntate", "sentado", "a sentarse" → `ksit`. | Tabla de sinónimos y normalizar tildes y mayúsculas. |

## Tier 3 · Peticiones más difíciles

Piden algo que el robot no puede medir por sí solo, o necesitan componentes que quizá no tenemos. Útiles para valorar y para la solicitud de cambio CR-01.

| ID | Petición | Por qué es difícil |
|---|---|---|
| T3-01 | "gira 90 grados" | El robot no devuelve su orientación. Hace falta leer el giroscopio (`v`) y cerrar el lazo de control. |
| T3-02 | "avanza un metro" | No hay medida de distancia recorrida. Dependería de la superficie y de la batería. |
| T3-03 | "da una vuelta completa exacta" / cuadrado preciso | El error se acumula en cada giro. Pide control con realimentación. |
| T3-04 | Lenguaje libre: "haz algo divertido", "siéntate, pero con calma" | Hay que interpretar la intención (por ejemplo con un modelo de lenguaje) y asegurar que solo salgan tokens válidos. |
| T3-05 | Conversación con contexto: "otra vez", "lo mismo pero a la derecha" | Memoria de la orden anterior y resolución de referencias. |
| T3-06 | "esquiva el obstáculo" / "para si hay algo delante" | Requiere el sensor ultrasónico (`XU`), que quizá no tengamos. |
| T3-07 | "ven aquí" / seguir la voz | Localizar de dónde viene el sonido: micrófonos múltiples. |
| T3-08 | Skills nuevos (ola, moonwalk) | Diseñarlos con Skill Composer o con el generador de señal `o` y probarlos para que no se caiga. |
| T3-09 | Reconocimiento con ruido o varios hablantes | Reconocimiento fiable en una sala llena (demostración). Quizá hace falta micrófono dedicado. |
| T3-10 | El robot responde por voz ("me he sentado") | Síntesis de voz y estado fiable del robot, que hoy no devuelve. |
| T3-11 | Varios robots a la vez | La API de Python ya conecta a todos los robots detectados, pero hay que enrutar cada orden. |
| T3-12 | Aprender órdenes nuevas en marcha ("cuando diga X haz Y") | Gestión de estado, validación de seguridad y persistencia. |

## Pendiente de decidir

- [ ] Elegir las **dos órdenes válidas** (propuesta: dos de Tier 1).
- [ ] Decidir qué Tier 2 entran como mejora.
- [ ] Medir la duración de `kwkL`/`kwkR` en el robot (hace falta para T2-01).
- [ ] Decidir cómo se trata la baja confianza del reconocimiento.
- [ ] Confirmar con el cliente (por Teams) qué órdenes y qué idioma se esperan.
