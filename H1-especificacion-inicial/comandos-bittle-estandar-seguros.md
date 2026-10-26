# Comandos seguros del Bittle estándar (45)

Lista de los comandos que el sistema podrá enviar al Bittle estándar (placa NyBoard). Es el catálogo cerrado de órdenes del sistema: **todo lo que no esté aquí se trata como "orden no disponible"**.

**Fuente.** Biblioteca de skills de OpenCat, `src/InstinctBittle.h` (56 skills, [repositorio de Petoi](https://github.com/PetoiCamp/OpenCat/blob/main/src/InstinctBittle.h)), cruzada con la [lista de órdenes de voz de Petoi](ordenes-modulo-voz-petoi.md). El reconocimiento de voz es externo: el sistema solo **envía el comando** por el puerto serie.

> **Pendiente de comprobar en el robot.** La biblioteca depende del firmware cargado, no del modelo. Ejecutad `printSkillFileName()` (API de Python) y comparad. Los comandos de la columna *Estado* marcados "por probar" no están en la lista de voz de Petoi y su significado sale solo del nombre.

## Cómo se envía

Se antepone `k` al nombre del skill y se manda por serie. Ejemplo: `sit` → `ksit`. La versión derecha de un giro (`kwkR`, `ktrR`, `kcrR`, `kvtR`, `kbkR`, `kphR`) es el espejo de la izquierda, según la documentación de Petoi. Esas versiones no se cuentan aparte y hay que probarlas.

## Los 45 comandos

### Marchas (14)

| Nº | Comando | Qué hace | Estado |
|---:|---|---|---|
| 1 | `kwkF` | Caminar hacia delante | En la lista de voz de Petoi |
| 2 | `kwkL` | Caminar hacia la izquierda | Por probar |
| 3 | `ktrF` | Trotar hacia delante | Por probar |
| 4 | `ktrL` | Trotar hacia la izquierda | Por probar |
| 5 | `kcrF` | Gatear hacia delante | En la lista de voz |
| 6 | `kcrL` | Gatear hacia la izquierda | Por probar |
| 7 | `kvtF` | Pasos en el sitio | En la lista de voz |
| 8 | `kvtL` | Pasos en el sitio girando a la izquierda | Por probar |
| 9 | `kbk` | Retroceder | En la lista de voz |
| 10 | `kbkL` | Retroceder girando a la izquierda | Por probar |
| 11 | `kphF` | Empujar hacia delante | En la lista de voz |
| 12 | `kphL` | Empujar hacia la izquierda | Por probar |
| 13 | `kbdF` | Marcha de galope ("bound") | Por probar; puede ser brusca |
| 14 | `kjpF` | Marcha con saltos ("jump") | Por probar; puede ser brusca |

### Posturas (8)

| Nº | Comando | Qué hace | Estado |
|---:|---|---|---|
| 15 | `kup` | Ponerse en pie | En la lista de voz |
| 16 | `ksit` | Sentarse | En la lista de voz |
| 17 | `kstr` | Estirarse | En la lista de voz |
| 18 | `krest` | Reposo (tumbado) | Por probar |
| 19 | `kbalance` | Postura de equilibrio | Por probar |
| 20 | `kbuttUp` | Trasero levantado | Por probar |
| 21 | `kzero` | Postura cero | Por probar |
| 22 | `klnd` | Aterrizaje ("landing") | Por probar |

### Gestos (9)

| Nº | Comando | Qué hace | Estado |
|---:|---|---|---|
| 23 | `khi` | Saludar | En la lista de voz |
| 24 | `kfiv` | Chocar los cinco | En la lista de voz |
| 25 | `khsk` | Dar la mano | En la lista de voz |
| 26 | `kchr` | Brindar | En la lista de voz |
| 27 | `khg` | Abrazar | En la lista de voz |
| 28 | `khu` | Manos arriba | En la lista de voz |
| 29 | `kgdb` | "Buen chico" | En la lista de voz |
| 30 | `kcmh` | "Ven aquí" | En la lista de voz |
| 31 | `kck` | Mirar alrededor ("check") | En la lista de voz |

### Comportamientos de animal (9)

| Nº | Comando | Qué hace | Estado |
|---:|---|---|---|
| 32 | `kpee` | Hacer pis | En la lista de voz |
| 33 | `kscrh` | Rascarse | En la lista de voz |
| 34 | `kdg` | Cavar | En la lista de voz |
| 35 | `ksnf` | Olfatear | En la lista de voz |
| 36 | `kwh` | Irse a dormir | En la lista de voz |
| 37 | `knd` | "¿Quieres comida?" | En la lista de voz |
| 38 | `kpd` | Hacerse el muerto | En la lista de voz |
| 39 | `kang` | Enfadarse | En la lista de voz |
| 40 | `ktbl` | Hacer de mesa | En la lista de voz |

### Ejercicios (5)

| Nº | Comando | Qué hace | Estado |
|---:|---|---|---|
| 41 | `kpu` | Flexiones | En la lista de voz |
| 42 | `kpu1` | Flexión con una mano | Por probar |
| 43 | `kbx` | Boxear | En la lista de voz |
| 44 | `kkc` | Dar una patada | En la lista de voz |
| 45 | `krc` | Recuperarse y ponerse en pie | En la lista de voz |

**Resumen del estado:** 30 comandos están en la lista de voz de Petoi y 15 solo en el firmware (por probar).

## Fuera de la lista (11 de los 56 skills)

| Comando | Motivo |
|---|---|
| `kbf` (voltereta atrás), `kff` (voltereta adelante) | Riesgo de caída. El cliente excluyó la voltereta. |
| `khds` (pino), `kjmp` (salto) | Riesgo de caída. |
| `kdropped`, `klifted` | Reacciones internas del robot al soltarlo o levantarlo. No son órdenes. |
| `kmw`, `krl`, `kts`, `kzz` | No sabemos qué hacen. Se pueden incluir cuando se prueben. |
| `kcalib` | Postura de calibración. Es de mantenimiento, no una orden de usuario. |

**Tampoco están** `kclup` (trepar), `klpov` (saltar por encima) y `kx` (juguete). Salen en la lista de voz de Petoi pero no existen en la biblioteca estándar. Lo mismo ocurre con la forma `kvtLX` ("spin"), que lleva una `X` que la biblioteca no usa.

## Otros comandos que no cuentan entre los 45

No son skills. Siguen disponibles para el sistema:

| Token | Qué hace |
|---|---|
| `d` | Tumbarse y apagar los motores |
| `p` | Pausa |

Son tokens del protocolo serie, no skills. `d` es la orden de "túmbate" del Nivel 1.

## Relación con los requisitos del H1

Las órdenes del Nivel 1 (REQ-02 a REQ-11 de `Entregable-H1.md`) usan `kup`, `ksit`, `kwkF`, `kwkL`, `kwkR`, `krest`, `d`, `khi`, `kbalance` y `ktrF`. Todas están en esta lista (`kwkR` como espejo de `kwkL`, y `d` como token). Los 37 comandos restantes son candidatos a ampliar el catálogo (la necesidad NEC-07: un repertorio amplio de órdenes). Hace falta decidir cuáles entran en el alcance antes de pasarlos a requisitos.
