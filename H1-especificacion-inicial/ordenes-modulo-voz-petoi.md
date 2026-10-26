# Las 40 órdenes del módulo de voz de Petoi

Lista oficial de las órdenes fijas del [módulo de voz de Petoi](https://docs.petoi.com/extensible-modules/voice-command-module), que viene con el Bittle X. Fuente: la [hoja enlazada en esa página](https://docs.google.com/spreadsheets/d/1Lr6Cd1T-H9sSdUi_bI-OeMClkVOKjTQM/edit?usp=sharing) ("See this doc for the latest version"), consultada el 26/10/2026.

> **Cómo leerla.** *Frase en inglés* es lo que entiende el módulo de Petoi. Nuestro sistema hará lo mismo en español: reconocer la frase y enviar al robot el *comando* de la tercera columna. El cliente dijo que hay "40 programadas, más lo que añadáis" (respuestas del cliente, punto 5). Las acciones con riesgo de caída están marcadas con ⚠️.

> **Aviso.** Nuestro robot es el Bittle estándar, no el X. Tres de estas órdenes (`kclup`, `klpov`, `kx`) y la forma `kvtLX` no existen en su biblioteca de skills. El catálogo que usaremos está en [`comandos-bittle-estandar-seguros.md`](comandos-bittle-estandar-seguros.md).

## Las 40 órdenes

| Nº | Frase (inglés) | Significado | Comando | Respuesta sonora del módulo |
|---:|---|---|---|---|
| 1 | Stand up | ponerse en pie | `kup` | Ok |
| 2 | sit | sentarse | `ksit` | Ok |
| 3 | stretch | estirarse | `kstr` | Nice |
| 4 | push ups | flexiones | `kpu` | ok |
| 5 | Cheers | brindar | `kchr` | Cheers |
| 6 | Hello | saludar | `khi` | hello |
| 7 | Come here | "ven aquí" | `kcmh` | What's up? |
| 8 | check | mirar alrededor | `kck` | what's wrong? |
| 9 | step | pasos en el sitio | `kvtF` | Ok |
| 10 | spin | girar sobre sí mismo | `kvtLX` | Ok |
| 11 | crawl | gatear | `kcrF` | Ok |
| 12 | walk | caminar | `kwkF` | Ok |
| 13 | retreat | retroceder | `kbk` | Ok |
| 14 | push | empujar | `kphF` | Ok |
| 15 | kick | dar una patada | `kkc` | Get away! |
| 16 | play dead | hacerse el muerto | `kpd` | Ouch |
| 17 | pee | hacer pis | `kpee` | Mark |
| 18 | hug | abrazar | `khg` | hug me |
| 19 | hands up | manos arriba | `khu` | Agreed |
| 20 | handstand ⚠️ | pino | `khds` | Watch out |
| 21 | roll back up | recuperarse al ponerse en pie | `krc` | No problem |
| 22 | scratch | rascarse | `kscrh` | Nice |
| 23 | dig | cavar | `kdg` | good stuff |
| 24 | sniff | olfatear | `ksnf` | What's this? |
| 25 | go to sleep | irse a dormir | `kwh` | Oh, no |
| 26 | Do you want some food? | "¿quieres comida?" | `knd` | Of course! |
| 27 | high five | choca esos cinco | `kfiv` | Give me five |
| 28 | backflip ⚠️ | voltereta hacia atrás | `kbf` | Watch out |
| 29 | frontflip ⚠️ | voltereta hacia delante | `kff` | Let me try |
| 30 | handshake | dar la mano | `khsk` | Nice to meet you |
| 31 | Good boy | "buen chico" | `kgdb` | So happy! |
| 32 | Be table | hacer de mesa | `ktbl` | freeze |
| 33 | boxing | boxear | `kbx` | fighting |
| 34 | jump ⚠️ | saltar | `kjmp` | I can fly |
| 35 | climb up ⚠️ | trepar | `kclup` | Let me try |
| 36 | leap over ⚠️ | saltar por encima | `klpov` | Let me try |
| 37 | angry | enfadarse | `kang` | I'm angry! |
| 38 | Pet toy | juguete | `kx` | Di |
| 39 | attention | postura de calibración / firmes | `c` | Yes sir! |
| 40 | rest | tumbarse y apagar los motores | `d` | ok |

Los significados de la columna 3 son una traducción nuestra de la frase. Petoi no los explica en la hoja. Hay que verlos en el robot.

## Órdenes de configuración (no son movimientos)

| Frase | Efecto |
|---|---|
| Bing-Bing | Cambia a inglés (`XAA`) |
| Di-Di | Cambia a chino (`XAB`) |
| Play sound | Activa la respuesta sonora y las reacciones (`XAC`) |
| Be quiet | Las desactiva (`XAD`) |
| start learning | Empieza a grabar órdenes propias (`XAE`) |
| stop learning | Deja de grabar (`XAF`) |
| clear the learning data | Borra las órdenes grabadas (`XAG`) |

Además hay 10 huecos para órdenes propias (`To be defined 1` a `10`).

## Lo que cambia respecto a lo que habíamos supuesto

- **Faltaban 30 órdenes.** Solo habíamos recogido 10 del Nivel 1. La lista oficial tiene 40.
- **`khi` existe.** "Hello" lo usa, así que ya no es un comando por confirmar (sigue pendiente de comprobar en nuestro robot).
- **Cuatro comandos del Nivel 1 no están en la lista de voz:** `kwkL` (izquierda), `kwkR` (derecha), `kbalance` y `ktrF` (trotar). Existen como skills del robot (ver `capacidades-bittle.md`, apartado 2), pero Petoi no los asocia a una frase. La lista de voz solo tiene "spin" (`kvtLX`) para girar.
- **Protocolo interno del módulo.** Devuelve `XA` + un carácter + el comando por `Serial2` a 9600 baudios. Eso es entre el módulo y el robot, no afecta a nuestro sistema.
- **Dos listas distintas.** La lista de skills de `InstinctBittle.h` que consultamos antes no incluye varios de estos nombres (por ejemplo `kchr`, `khg`, `kjmp`). Corresponden a un firmware más reciente. Hay que ver cuáles tiene nuestro robot (`printSkillFileName()` en la API de Python los lista).

## Pendiente

- [ ] Comprobar en el robot cuáles de los 40 comandos existen y qué hacen.
- [ ] Decidir cuáles entran en el alcance. El cliente dijo en clase "tienes que poder hacer todas, menos la voltereta" (la transcripción es poco clara). **Confirmar con el cliente** si el límite son las 40, o las 40 menos `kbf`.
- [ ] Decidir qué hacer con las acciones con riesgo de caída (⚠️).
- [ ] Traducir cada frase a español y añadir sinónimos.
