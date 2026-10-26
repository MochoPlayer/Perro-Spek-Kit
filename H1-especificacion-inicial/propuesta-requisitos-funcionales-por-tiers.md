# Propuesta de requisitos funcionales por niveles

**Reto Bittle · Control por voz · Propuesta del equipo para el cliente**

Este documento propone **qué órdenes de voz** podría atender el sistema y **en qué orden las abordaremos**. Está pensado para validarlo con el cliente antes de cerrar los requisitos.

## En una página

| Nivel | Qué es | Cuántas | Propuesta |
|---|---|---|---|
| **1 · Base** | Una frase, una acción del robot. | 11 | **Compromiso mínimo.** De aquí salen las dos órdenes válidas. |
| **2 · Ampliación** | Combina órdenes o añade repeticiones, tiempos o cabeza. | 13 | **Mejora** si el tiempo lo permite. |
| **3 · Reto** | Pide medir o decidir algo que el robot no hace solo. | 12 | **Fuera de alcance**, salvo que el cliente lo pida. |

**Cómo se lee.** Cada fila es un requisito funcional con un identificador (por ejemplo `T1-03`). La columna *Comando* es lo que el sistema envía al robot por el puerto serie. Un asterisco (\*) indica un comando que aún tenemos que comprobar en nuestro robot.

**Cadena general:** `voz → texto → frase reconocida → comando → robot`.

---

## Nivel 1 · Base

Una frase de voz produce una acción. No hay estado ni tiempos que coordinar.

| ID | El usuario dice | El sistema deberá… | Comando | Cómo se comprueba |
|---|---|---|---|---|
| T1-01 | "siéntate" | hacer que el robot se siente. | `ksit` | El robot termina sentado. |
| T1-02 | "levántate" / "arriba" | hacer que el robot se ponga en pie. | `kup` | El robot termina de pie. |
| T1-03 | "camina" / "adelante" | hacer que el robot camine hacia delante. | `kwkF` | El robot avanza. |
| T1-04 | "izquierda" | hacer que el robot camine hacia la izquierda. | `kwkL` | El robot gira a la izquierda. |
| T1-05 | "derecha" | hacer que el robot camine hacia la derecha. | `kwkR` | El robot gira a la derecha. |
| T1-06 | "para" / "stop" | detener el robot. | `krest` | El robot se detiene. |
| T1-07 | "túmbate" / "descansa" | tumbar el robot y apagar sus motores. | `d` | El robot queda tumbado. |
| T1-08 | "saluda" | hacer que el robot salude. | `khi`\* | El robot hace el gesto. |
| T1-09 | "equilíbrate" | poner el robot en postura de equilibrio. | `kbalance` | El robot queda equilibrado. |
| T1-10 | "trota" | hacer que el robot trote hacia delante. | `ktrF`\* | El robot trota. |
| T1-11 | Una frase que no es una orden | **no enviar ningún movimiento** y avisar con un pitido. | ninguno + `b`\* | El robot no se mueve y suena el aviso. |

**Dos órdenes válidas para H1:** se eligen entre las filas T1-01 a T1-10. La fila T1-11 es el tratamiento obligatorio de la entrada no reconocida.

## Nivel 2 · Ampliación

Más posibilidades, con más cosas que resolver. Ejemplo: "da una vuelta" son dos giros a la izquierda seguidos.

| ID | El usuario dice | El sistema deberá… | Cómo | Qué hay que resolver |
|---|---|---|---|---|
| T2-01 | "da una vuelta" | encadenar dos giros a la izquierda. | `kwkL`, espera, `kwkL` | Medir cuánto dura cada giro. Sin eso la vuelta no cierra. |
| T2-02 | "gira a la derecha dos veces" | repetir una orden N veces. | Bucle sobre `kwkR` | Entender el número dicho en voz ("dos", "tres"). |
| T2-03 | "camina y siéntate" | ejecutar dos órdenes seguidas. | `kwkF`, espera, `ksit` | Separar la frase por "y" / "luego". |
| T2-04 | "saluda y siéntate" | ejecutar dos órdenes seguidas. | `khi`\*, espera, `ksit` | Igual que T2-03. |
| T2-05 | "levántate y camina" | ejecutar dos órdenes seguidas. | `kup`, espera, `kwkF` | Tiempo de espera entre ambas. |
| T2-06 | "da dos pasos" | avanzar un tiempo limitado y detenerse. | `kwkF`, espera, `krest` | La marcha es continua: se corta por tiempo. |
| T2-07 | "mueve la cabeza a la izquierda" | mover la cabeza un ángulo concreto. | `m idx ang`\* | Confirmar el índice de la cabeza y el rango. |
| T2-08 | "ve más rápido" / "más despacio" | cambiar el modo de marcha. | `kwk` ↔ `ktr`, o `G`\* | Definir qué significa "más rápido". |
| T2-09 | "baila" | ejecutar una secuencia fija. | Cola `q` o lista de tareas | Elegir y probar la secuencia. |
| T2-10 | "haz un cuadrado" | repetir cuatro veces avanzar y girar. | `kwkF`, `kwkL` ×4 | Los errores de tiempo se acumulan. |
| T2-11 | (cualquier orden entendida) | confirmar que ha entendido la orden. | Pitido `b`\* | Distinguir "entendido" de "no entendido". |
| T2-12 | "para" durante una secuencia | cancelar la secuencia en curso. | Abortar la cola y `krest` | La cola no se cancela sola: lo hace nuestro programa. |
| T2-13 | "sentado", "a sentarse" | aceptar sinónimos de una misma orden. | Tabla de sinónimos | Normalizar tildes y mayúsculas. |

## Nivel 3 · Reto

Peticiones que el robot **no puede cumplir por sí solo** o que necesitan componentes que quizá no tenemos. Las listamos para acotar el alcance y para valorar un posible cambio posterior.

| ID | Petición | Por qué es difícil | Qué haría falta |
|---|---|---|---|
| T3-01 | "gira 90 grados" | El robot no informa de su orientación. | Leer el giroscopio y corregir en bucle. |
| T3-02 | "avanza un metro" | No mide la distancia recorrida. | Un sensor o una medida externa. |
| T3-03 | "da una vuelta exacta" / cuadrado preciso | El error crece en cada giro. | Control con realimentación. |
| T3-04 | "haz algo divertido" | Hay que interpretar la intención. | Un modelo de lenguaje y un filtro que solo deje pasar comandos válidos. |
| T3-05 | "otra vez", "lo mismo a la derecha" | Requiere recordar la orden anterior. | Memoria de la conversación. |
| T3-06 | "esquiva el obstáculo" / "para si hay algo delante" | Necesita ver. | Sensor de ultrasonidos. |
| T3-07 | "ven aquí" | Hay que saber de dónde viene la voz. | Varios micrófonos. |
| T3-08 | "haz la ola", "moonwalk" | Hay que diseñar movimientos nuevos. | Skill Composer o generador de señal, con pruebas de estabilidad. |
| T3-09 | Reconocer con ruido o con varias personas | La voz se confunde con facilidad. | Micrófono dedicado y pruebas en la sala. |
| T3-10 | Que el robot conteste hablando | El robot no tiene estado fiable ni voz. | Síntesis de voz en el ordenador. |
| T3-11 | Varios robots a la vez | Hay que dirigir cada orden. | Gestión de varias conexiones. |
| T3-12 | "cuando diga X haz Y" | Aprender órdenes nuevas en marcha. | Validación de seguridad y almacenamiento. |

---

## Lo que queremos confirmar con el cliente

1. ¿Qué **dos órdenes** prefiere para H1, o las elegimos nosotros entre las del Nivel 1?
2. ¿En qué **idioma** y con qué **sinónimos**?
3. ¿Qué debe hacer el sistema ante una **frase no reconocida**? Proponemos no mover el robot y emitir un pitido.
4. ¿Debe haber una orden de **parada** que corte cualquier acción?
5. ¿Cuenta el **Nivel 2** (órdenes combinadas) o nos limitamos al Nivel 1?
6. ¿Qué conexión usamos (**Bluetooth** o **USB**) y qué modelo de robot es?

## Pendiente en el robot

Antes de cerrar la lista hay que probar en el robot real:

- que existen los comandos marcados con \* (`khi`, `ktrF`, el pitido `b` y el índice de la cabeza);
- cuánto dura cada giro (`kwkL`, `kwkR`) y cada postura;
- qué ocurre si llega una orden mientras otra se ejecuta.

*Fuentes técnicas: documentación de Petoi (protocolo serie, API de Python, módulo de voz) y `OpenCat.h`. Detalle en [`capacidades-bittle.md`](capacidades-bittle.md).*
