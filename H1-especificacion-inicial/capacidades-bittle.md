# Capacidades del Petoi Bittle

Investigación técnica para H1 (punto 1). Fuentes: [Petoi Serial Protocol](https://docs.petoi.com/apis/serial-protocol), [Petoi Python API](https://docs.petoi.com/apis/python-api), [Voice Command Module](https://docs.petoi.com/extensible-modules/voice-command-module), [Mobile app controller](https://docs.petoi.com/mobile-app/controller), [Task queue y signal generator](https://docs.petoi.com/apis/serial-protocol/nested-task-queue-and-signal-generator) y [`OpenCat.h`](https://github.com/PetoiCamp/OpenCat/blob/main/src/OpenCat.h).

> **Estado:** borrador. Lo marcado con ⚠️ no sale en el texto de la documentación (está en imágenes o en Moodle) y hay que confirmarlo.

## 1. Vías de control

| Vía | Qué permite |
|---|---|
| Protocolo serie (USB o Bluetooth) | Enviar texto al robot. Es la base de las demás vías. |
| API de Python (`pyserial 3.5`, Python ≥ 3.6) | Lo mismo desde código: `autoConnect()`, `sendSkillStr('ksit', 3)`, `closePort()`. |
| App móvil | Marchas, posturas, control de articulaciones, botones propios. |
| Módulo de voz de Petoi | Unas 40 órdenes fijas (inglés/chino) y hasta 10 grabadas por el usuario. |
| Bloques Petoi, C++, Skill Composer | Programar y crear skills nuevos. |

## 2. Skills (token `k` + nombre)

Más de 35 acciones predefinidas. Se llama anteponiendo `k` al nombre y quitando el sufijo `I`/`N`: `sitI` → `ksit`.

- **Posturas:** `ksit`, `kbalance`, `krest`, `kup`, `kbuttUp`, `kcalib`, `kzero`.
- **Marchas:** caminar `wk`, trote `tr`, gateo `cr`, pasos en el sitio `vt`; también `bk`, `bd`, `ph`, `mh` ⚠️.
- **Dirección:** el penúltimo carácter es `F` (adelante) o `L` (izquierda). `R` (derecha) es el espejo de `L`. Ejemplos: `kwkF`, `kwkL`, `kwkR`, `ktrL`.
- **Reacciones y trucos:** `hi`, `pu`, `pu1`, `pee`, `ck`, `bf`, `jy`, `rc`, `ts`, `stp`, `fd`, `ff`, `rt`, `rl`, `pd`, `climbCeil` ⚠️.
- Lista completa (`InstinctBittle.h`): `bdFI, bkI, bkLI, crFI, crLI, hlwI, mhFI, mhLI, pcFI, phFI, phLI, trFI, trLI, vtFI, vtLI, wkFI, wkLI, balanceI, buttUpI, calibI, droppedI, liftedI, restI, sitI, strI, zeroN, bfI, ckI, climbCeilI, fdI, ffI, hiI, jyI, pdI, peeI, puI, pu1I, rcI, rlLI, rtI, stpI, tsI`.
- Solo `sit`, `balance`, `walk`, `trot`, `crawl` y `step` tienen significado explícito en la documentación. Los demás hay que probarlos en el robot o consultarlos en Moodle.

## 3. Articulaciones

16 articulaciones (índices 0–15). Los índices 0–3 son cabeza y cola. Ocho se usan para caminar. ⚠️ El mapa de índices está en una imagen.

| Token | Formato | Efecto |
|---|---|---|
| `m` | `m idx ang …` | Mueve las articulaciones una tras otra. |
| `i` | `i idx ang …` | Las mueve a la vez. |
| `M` / `I` | igual, en binario | Versión binaria de `m` e `i`. |
| `j` | `j` o `j idx` | Devuelve todos los ángulos o uno. |

Ángulos de −127 a 128. Los comandos se pueden encadenar (`m8 40 8 -35 0 50`), con posible límite del buffer serie.

## 4. Otros tokens (`OpenCat.h`)

| Token | Función |
|---|---|
| `d` | Reposo: se tumba y apaga los servos. |
| `p` | Pausa. |
| `G` / `g` | Equilibrio por giroscopio: activar o desactivar / ajustar finura. En la app, "Turbo" lo apaga para ir más rápido. |
| `v` / `V` | Imprime datos del giroscopio (una vez / continuo). |
| `z` | Comportamientos aleatorios. |
| `c`, `s`, `a` | Calibración: entrar, guardar, abortar. |
| `b` | Zumbador: `b nota duración …`. Melodías de hasta 64 caracteres, volumen 0–10. |
| `C` | Color de los ojos RGB del sensor ultrasónico. |
| `?` | Consulta. |
| `XA…` / `XU…` | Extensiones de voz / ultrasonidos. |
| `R` / `W` | Leer / escribir pines analógicos y digitales (Grove pass-through). |
| `K` | Enviar los datos de un skill en tiempo real. |

## 5. Secuencias y movimiento periódico

- **Cola de tareas `q`:** `qk sit:1000>m 8 0 8 -30 8 0:500>`. Cada subcomando lleva `:` y un retardo en ms, y termina en `>`.
- **Generador de señal `o`:** `o resolución velocidad,idx punto_medio amplitud frecuencia fase,…`. Mueve cada articulación con una onda seno.

## 6. Módulo de voz de Petoi

- Unas 40 órdenes fijas (inglés por defecto; chino solo en BiBoard) y hasta 10 órdenes propias de 6 sílabas como máximo.
- Se graban con "Start learning" / "Stop learning". "Clear the learning data" borra todas.
- Convierte el micrófono en un comando serie por `Serial2`. Las respuestas se definen en `voice.h` (`voice1`…`voice10`).
- Serie: `XAa`–`XAg` (idioma, tono de respuesta, grabar, borrar).
- La lista completa de las 40 órdenes, con su comando, está en [`ordenes-modulo-voz-petoi.md`](ordenes-modulo-voz-petoi.md).

## 7. API de Python (`robot.py`)

`autoConnect()`, `openPort(port)`, `closePort()`, `sendSkillStr(skill, delay)`, `sendCmdStr(cmd, delay)`, `sendLongCmd(token, var, delay)`, `loadSkill(file, delay)`, `rotateJoints(token, var, delay)`, `absValList(...)`, `relativeValList(...)`, `getAngleList()`, `getCurAng(idx)`, `play(token, var, delay)`, `deacGyro()`, `readAnalogValue/readDigitalValue/writeAnalogValue/writeDigitalValue`, `printSkillFileName()`.

Formato de lista de tareas: `[comando, argumentos…, retardo_en_segundos]`, por ejemplo `['kup', 2]`, `['d', 2]`, `['m', [0, -20], 1.5]`, `['b', [10, 2], 2]`.

## 8. Restricciones

- Superficie lisa. En alfombra el movimiento no es suave.
- No repetir botones sin esperar a que termine la acción anterior.
- El robot **no devuelve cuándo termina un skill** en lo que dice la documentación: hay que esperar un tiempo fijo (el `delay`). ⚠️ Confirmar.
- Sin giroscopio activo no corrige su inclinación ni detecta que está boca abajo.
- Con dos puertos serie visibles se está usando Bluetooth. ⚠️ Los pasos de emparejamiento están en Moodle.
- ⚠️ Faltan: velocidad de baudios y formato de respuesta.


## 9. Arquitectura de voz

> **En estudio, no decidido.**

- Nuestro robot es el Bittle normal (NyBoard), que no trae el módulo de voz de Petoi.
- Opción en estudio: el reconocimiento de voz se hace en un portátil, que envía la orden al robot (Bluetooth o USB).
