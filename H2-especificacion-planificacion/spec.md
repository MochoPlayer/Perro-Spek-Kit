# Especificación: control por voz del Petoi Bittle (VOICE-BITTLE)

**Hito**: H2 · **Estado**: borrador para revisión del equipo · **Base**: `H1-especificacion-inicial/Entregable-H1.md` (rama `main`, commit `04155b8`)

**Entrada**: el análisis de H1 (escenarios ESC, necesidades NEC, requisitos REQ) y las respuestas del cliente del 26/10 (`referencias/notas/respuestas-cliente-2026-10-26.md`).

> **Cómo leer este documento.** Sigue la plantilla oficial de `spec.md` de Spec Kit. Los identificadores `ESC-`, `NEC-` y `REQ-` son los de H1, para que la trazabilidad se mantenga. Esta spec dice **qué** debe hacer el sistema, no **cómo**: las decisiones técnicas van en `plan.md`. Lo que H1 deja abierto se marca `[NEEDS CLARIFICATION]` y se recoge en el apartado «Asuntos abiertos». No se ha inventado ningún valor: los números provisionales llevan esa etiqueta.

## Escenarios de usuario y pruebas *(obligatorio)*

**Usuario**: la persona que da órdenes de voz al robot (STK-02). **Cliente**: el profesor (STK-01). **Equipo**: quien construye y prueba el sistema (STK-03). **Personas del entorno**: quien está cerca y puede hablar sin dar órdenes (STK-04).

### Historia 1 · Dar una orden y que el robot la ejecute (Prioridad: P1)

El usuario dice el nombre del perro seguido de una orden del catálogo, por ejemplo «[NOMBRE], siéntate». El sistema la reconoce, la envía al robot y el robot ejecuta la acción. El usuario espera a que termine antes de dar otra orden.

**Por qué P1**: es el objetivo del encargo (NEC-01) y la mitad del criterio mínimo de aceptación (dos órdenes válidas).

**Prueba independiente**: con un robot simulado, decir cada orden del Nivel 1 y comprobar que el robot simulado recibe el comando esperado. En la demostración, comprobar que el robot físico hace el movimiento.

**Escenarios de aceptación**:

1. **Dado** el robot conectado y sin acción en curso, **cuando** el usuario dice «[NOMBRE], siéntate», **entonces** el robot recibe `ksit` y queda sentado. *(ESC-01, REQ-02)*
2. **Dado** el mismo estado, **cuando** el usuario dice «[NOMBRE], levántate», **entonces** el robot recibe `kup` y queda de pie. *(REQ-03)*
3. **Dado** el mismo estado, **cuando** el usuario dice cualquiera de las otras órdenes del Nivel 1 (tabla de REQ-04 a REQ-11), **entonces** el robot recibe el comando que le corresponde.
4. **Dado** el sistema escuchando, **cuando** alguien dice una orden **sin** el nombre del perro, **entonces** el robot no se mueve y el sistema sigue escuchando. *(ESC-02, REQ-01)*

---

### Historia 2 · Saber que una entrada no es una orden válida (Prioridad: P1)

Si el sistema recibe ruido, una frase sin sentido o una orden que no está en el catálogo, no mueve el robot y avisa al usuario para que pueda repetirla.

**Por qué P1**: la entrada no reconocida es la otra mitad del criterio mínimo de aceptación (NEC-03, prioridad Alta).

**Prueba independiente**: con un robot simulado, enviar entradas de ruido, sin sentido y fuera del catálogo; comprobar que no se envía ningún comando y que el aviso se muestra cada vez.

**Escenarios de aceptación**:

1. **Dado** el sistema escuchando, **cuando** recibe ruido alto o una frase sin sentido, **entonces** no se envía ningún comando de movimiento y se muestra el aviso «no se ha entendido bien». *(ESC-04, REQ-12)*
2. **Dado** el sistema escuchando, **cuando** el usuario dice «[NOMBRE], sígueme» (u otra orden fuera del catálogo), **entonces** no se envía ningún comando y se muestra un aviso de orden no disponible. *(ESC-05, REQ-13)*
3. **Dado** que ha habido 20 entradas inválidas seguidas, **cuando** el usuario da una orden válida, **entonces** el sistema la ejecuta con normalidad. *(REQ-23)*

---

### Historia 3 · Probar el sistema sin el robot físico (Prioridad: P1)

El equipo puede ejecutar el sistema y todas sus pruebas con un robot simulado que registra los comandos recibidos.

**Por qué P1**: el hito H3 exige pruebas reproducibles sin el robot (NEC-08, prioridad Alta). Sin esto, ninguna otra historia se puede verificar de forma repetible.

**Prueba independiente**: ejecutar el conjunto completo de pruebas con ningún robot conectado y comprobar que termina.

**Escenarios de aceptación**:

1. **Dado** que no hay ningún robot conectado, **cuando** se ejecuta el conjunto de pruebas con el robot simulado, **entonces** las pruebas se ejecutan completas. *(REQ-26)*
2. **Dado** el robot simulado, **cuando** el sistema envía un comando, **entonces** el simulador lo registra con la cadena exacta enviada. *(REQ-20)*

---

### Historia 4 · Ver el estado del sistema y de la conexión (Prioridad: P2)

El usuario ve en la interfaz el texto reconocido, la orden interpretada, el estado de la conexión con el robot y los avisos. Si el robot no está conectado, el sistema no envía comandos y lo avisa.

**Por qué P2**: no es parte del criterio mínimo, pero sin ello el usuario no sabe por qué no pasa nada (NEC-06, prioridad Media).

**Prueba independiente**: con el puerto del robot cerrado, dar una orden y comprobar que no sale ningún comando y que aparece el aviso.

**Escenarios de aceptación**:

1. **Dado** que no hay conexión con el robot, **cuando** el usuario da una orden válida, **entonces** no se envía ningún comando y se muestra «robot no conectado». *(ESC-07, REQ-25)*
2. **Dado** una sesión de prueba, **cuando** el usuario habla, **entonces** la interfaz muestra el texto reconocido, la orden interpretada, el estado de la conexión y los avisos. *(REQ-19)*

---

### Historia 5 · Dar varias órdenes seguidas en una frase (Prioridad: P2)

El usuario encadena órdenes en una misma frase, por ejemplo «[NOMBRE], camina y siéntate». El sistema las envía una a una, en el orden dicho, cada una cuando termina la anterior.

**Por qué P2**: lo pidió el cliente como ajuste (NEC-10). H1 deja su prioridad *por definir*; se propone P2 porque el cliente la pidió, pero no es parte del mínimo. `[NEEDS CLARIFICATION: confirmar la prioridad]`

**Prueba independiente**: con el robot simulado, frases con 2 y con 3 órdenes; comprobar que los comandos llegan en el orden dicho.

**Escenarios de aceptación**:

1. **Dado** el robot sin acción en curso, **cuando** el usuario dice «[NOMBRE], orden 1 y orden 2», **entonces** el robot recibe primero el comando de la orden 1 y, al terminar esta, el de la orden 2. *(ESC-10, REQ-29)*

---

### Historia 6 · Casos de operación del robot (Prioridad: P2)

El robot mantiene un comportamiento definido ante un tiempo largo sin órdenes, la batería baja, una orden con el robot ocupado y la manipulación física. El equipo decidió el comportamiento el 26/10 en H1, pero H1 aún no tiene requisito para ninguno de estos cuatro casos (ver REQ-31 a REQ-34 más abajo).

**Por qué P2**: son escenarios excepcionales que pide la revisión de H2 («incluidos los comportamientos excepcionales»), pero no forman parte del mínimo.

**Prueba independiente**: cada caso se prueba por separado con el robot simulado, salvo la batería y la manipulación, que dependen del robot físico (ver Asuntos abiertos).

**Escenarios de aceptación**:

1. **Dado** el robot conectado y sin acción en curso, **cuando** pasan 15 minutos sin ninguna orden, **entonces** el robot queda en reposo. *(ESC-03)*
2. **Dado** el robot ejecutando una acción, **cuando** el usuario da otra orden, **entonces** el sistema no hace caso a la orden nueva y el robot sigue con la acción en curso. *(ESC-06)*
3. **Dado** que la batería llega al 10 %, **cuando** esto ocurre, **entonces** el robot emite un sonido y entra en modo reposo. *(ESC-08)*
4. **Dado** el robot ejecutando una acción, **cuando** alguien lo coge, lo mueve o lo tumba, **entonces** el robot hace una parada de emergencia y se queda quieto. *(ESC-09)*

---

### Historia 7 · Órdenes extra opcionales (Prioridad: P3)

El usuario dispone de órdenes que van más allá del mínimo: «baila», «media vuelta» y «da una vuelta». El cliente valora ampliar el repertorio (NEC-07, prioridad Media). Se abordan solo si hay tiempo.

**Prueba independiente**: con el robot simulado, comprobar que la lista de comandos enviada coincide con la definida para cada orden; en la demostración, 5 intentos con medida de la desviación en los giros.

**Escenarios de aceptación**:

1. **Dado** el robot sin acción en curso, **cuando** el usuario dice «[NOMBRE], baila», **entonces** el robot ejecuta una secuencia fija y predefinida y termina en una postura estable. *(REQ-14)*
2. **Dado** el mismo estado, **cuando** el usuario dice «[NOMBRE], media vuelta», **entonces** el robot gira a la izquierda hasta quedar en sentido contrario al inicial, con una desviación máxima de ±45° `[valor provisional]`. *(REQ-15)*
3. **Dado** el mismo estado, **cuando** el usuario dice «[NOMBRE], da una vuelta», **entonces** el robot completa una vuelta, con una desviación máxima de ±45° `[valor provisional]`. *(REQ-16)*

### Casos límite

- **Palabra de activación sola.** El usuario dice solo «[NOMBRE]» sin orden. `[NEEDS CLARIFICATION: H1 no lo define; ¿se trata como entrada no reconocida?]`
- **Orden encadenada con una orden no reconocida.** «[NOMBRE], camina y bailoteo». H1 lo deja abierto en REQ-29 y OPEN-05. `[NEEDS CLARIFICATION: ¿se ejecuta la parte válida o se rechaza la frase entera?]`
- **Número máximo de órdenes por frase y palabras de enlace aceptadas** («y», «luego»…). H1 lo deja *por definir* en REQ-29.
- **Cómo sabe el sistema que una acción ha terminado.** El robot no avisa al terminar (CTX-06, pendiente de comprobar). Afecta a REQ-29 y a REQ-32.
- **Pérdida de conexión durante una acción.** H1 cubre solo la conexión ausente al dar una orden (REQ-25).
- **Fallo mecánico del robot.** El sistema no deberá moverlo (REQ-30). `[NEEDS CLARIFICATION: H1 no dice cómo se detecta el fallo]`
- **Ruido durante la demostración (CTX-09).** Condiciones de ruido sin definir.
- **Voz de varias personas a la vez.** H1 cita a las personas del entorno (STK-04), pero no define qué pasa con voces solapadas. `[NEEDS CLARIFICATION]`

## Requisitos *(obligatorio)*

Los requisitos mantienen el identificador de H1. Todo requisito debe poder derivarse a una prueba concreta (cliente 26/10, punto 7). La columna «Prueba» resume la verificación prevista en H1. Los requisitos de dominio no aplican en estas entregas (cliente 26/10, punto 7).

### Requisitos funcionales

**Activación y entradas no válidas**

| ID | Enunciado | Origen | Prueba |
|----|-----------|--------|--------|
| REQ-01 | El sistema deberá tratar como orden solo una frase que empiece por el nombre del perro «[NOMBRE]» seguido de una orden del catálogo, y deberá ignorar cualquier otra frase sin enviar ningún comando al robot. | ESC-01, ESC-02 | Sin robot: 20 frases con el nombre se procesan como orden; 20 sin el nombre no producen comando. |
| REQ-12 | Ante una frase con ruido o sin sentido que no se interprete como una orden, el sistema deberá no enviar ningún comando de movimiento y deberá mostrar el aviso «no se ha entendido bien». | ESC-04 | Sin robot: 20 entradas → ningún comando y aviso cada vez. |
| REQ-13 | Ante una orden que no está en el catálogo o que el robot no puede hacer, el sistema deberá no enviar ningún comando y deberá mostrar un aviso de orden no disponible. | ESC-05 | Sin robot: 10 órdenes fuera del catálogo → ningún comando y aviso cada vez. |

**Órdenes del Nivel 1** (fijas, esenciales). Cada orden se dice como «[NOMBRE], <orden>» y el sistema envía el comando indicado.

| ID | Orden dicha | Comando enviado | Efecto esperado | Prueba |
|----|-------------|-----------------|-----------------|--------|
| REQ-02 | siéntate | `ksit` | Sentarse | Sin robot: el simulador recibe `ksit`. Demo: queda sentado. |
| REQ-03 | levántate | `kup` | Ponerse en pie | Sin robot: `kup`. Demo: queda de pie. |
| REQ-04 | camina | `kwkF` | Caminar hacia delante | Sin robot: `kwkF`. Demo: avanza. |
| REQ-05 | izquierda | `kwkL` | Caminar hacia la izquierda | Sin robot: `kwkL`. Demo: gira a la izquierda. |
| REQ-06 | derecha | `kwkR` | Caminar hacia la derecha | Sin robot: `kwkR`. Demo: gira a la derecha. |
| REQ-07 | para | `krest` | Detenerse en reposo | Sin robot: `krest`. Demo: se detiene. |
| REQ-08 | túmbate | `d` | Tumbarse y apagar los motores | Sin robot: `d`. Demo: queda tumbado. |
| REQ-09 | saluda | `khi` | Saludar | Sin robot: `khi`. Demo: gesto de saludo. `[NEEDS CLARIFICATION: comando por confirmar en el robot, OPEN-03]` |
| REQ-10 | equilíbrate | `kbalance` | Postura de equilibrio | Sin robot: `kbalance`. Demo: queda en equilibrio. |
| REQ-11 | trota | `ktrF` | Trotar hacia delante | Sin robot: `ktrF`. Demo: trota. `[NEEDS CLARIFICATION: comando por confirmar en el robot, OPEN-03]` |

**Órdenes opcionales (Nivel 2)**. Cada una cuenta como una sola orden para el usuario, aunque el sistema envíe varios comandos seguidos.

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-14 | Ante «[NOMBRE], baila», el sistema deberá hacer que el robot ejecute una secuencia fija y predefinida y termine en una postura estable. | Sin robot: la lista de comandos coincide con la secuencia (OPEN-08). Demo: sin caída. |
| REQ-15 | Ante «[NOMBRE], media vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta quedar en sentido contrario al inicial, con una desviación máxima de ±45° `[valor provisional, OPEN-02]`. | Sin robot: `kwkL` durante la duración calibrada (OPEN-04). Demo: 5 intentos con medida. |
| REQ-16 | Ante «[NOMBRE], da una vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta completar una vuelta, con una desviación máxima de ±45° `[valor provisional, OPEN-02]`. | Sin robot: dos giros seguidos de la duración calibrada. Demo: 5 intentos con medida. |

**Órdenes encadenadas** (ajuste del cliente, 26/10)

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-29 | Ante una frase «[NOMBRE], orden 1 y orden 2…» con varias órdenes del catálogo, el sistema deberá enviar al robot los comandos de cada orden en el orden dicho, y deberá enviar cada uno solo cuando haya terminado la acción anterior. | Sin robot: frases con 2 y con 3 órdenes → los comandos llegan en orden. Demo: acciones seguidas y en orden. |

**Comportamientos excepcionales sin requisito en H1.** Los escenarios ESC-03, ESC-06, ESC-08 y ESC-09 están definidos en H1 (decisión del equipo, 26/10) pero H1 no tiene un REQ para ellos (H1 §6.2). Aquí se redactan **como propuesta**, usando solo lo que dicen los escenarios. Hay que **añadirlos a H1** (con la misma numeración) o descartarlos antes de entregar.

| ID (propuesto) | Enunciado propuesto | Origen | Prueba prevista |
|----------------|---------------------|--------|-----------------|
| REQ-31 | Tras 15 minutos sin recibir ninguna orden, el sistema deberá dejar el robot en reposo. | ESC-03 | Sin robot: avanzar el reloj 15 min → el simulador recibe el comando de reposo. `[NEEDS CLARIFICATION: ¿qué comando? ¿avisa al usuario? El escenario dice «se apaga sin avisar». ¿Hay NEC asociada?]` |
| REQ-32 | Si llega una orden mientras el robot ejecuta otra acción, el sistema no deberá hacer caso a la orden nueva y el robot deberá seguir con la acción en curso. | ESC-06, NEC-09 | Sin robot: durante una acción, enviar otra orden → el simulador no recibe comando nuevo. Depende de saber cuándo termina una acción (CTX-06). |
| REQ-33 | Cuando la batería llegue al 10 %, el robot deberá emitir un sonido y entrar en modo reposo. | ESC-08, NEC-11 | Demo con robot físico. `[NEEDS CLARIFICATION: ¿lo hace el firmware del robot o debe hacerlo el sistema? ¿cómo se lee la batería? El pitido «b» no está confirmado (OPEN-03)]` |
| REQ-34 | Si alguien coge, mueve o tumba el robot durante una acción, el robot deberá hacer una parada de emergencia y quedarse quieto. | ESC-09, NEC-12 | Demo con robot físico. `[NEEDS CLARIFICATION: ¿lo hace el firmware (skills lifted y dropped) o el sistema? ¿qué comando?]` |

**Seguridad**

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-25 | Si no hay conexión con el robot, el sistema no deberá enviar ningún comando y deberá mostrar el aviso «robot no conectado». | Sin robot: puerto cerrado → ningún comando y aviso. Demo: desconectar el robot y dar una orden. |
| REQ-30 | Ante un fallo mecánico del robot, el sistema no deberá moverlo, para evitar más daños. | *Por definir* (cómo se detecta el fallo). |

### Requisitos de interfaces

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-17 | El sistema deberá recibir la voz del usuario desde el micrófono del ordenador del equipo. | Demo: una frase dicha ante el micrófono aparece como texto. |
| REQ-18 | El sistema deberá obtener el texto de la voz mediante un módulo de transcripción ya existente, y deberá incluir un intérprete propio que convierta ese texto en una orden del catálogo. | Inspección: la transcripción es una dependencia externa y el intérprete es código del equipo. Prueba: texto → orden esperada. |
| REQ-19 | El sistema deberá ofrecer una interfaz de usuario (web o aplicación) que muestre el texto reconocido, la orden interpretada, el estado de la conexión con el robot y los avisos. | Demo: los cuatro elementos son visibles en una sesión de prueba. |
| REQ-20 | El sistema deberá enviar al robot los comandos en el formato del protocolo serie de Petoi (token y parámetros, por ejemplo `ksit`) a través de un puerto serie (Bluetooth o USB, OPEN-07). | Sin robot: el simulador recibe la cadena exacta. Demo: el robot obedece. |

### Requisitos de prestaciones y calidad

Los valores numéricos son **provisionales**: el cliente pidió ponerlos «a ojo» con márgenes amplios y ajustarlos tras los prototipos (OPEN-02).

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-21 | El tiempo desde que el usuario termina la frase hasta que el sistema envía el comando al robot deberá ser como máximo de 2 s `[valor provisional]`. | Sin robot: 20 mediciones, todas ≤ 2 s. |
| REQ-22 | El sistema deberá reconocer y ejecutar correctamente al menos el 80 % de las órdenes válidas dichas en una sala tranquila `[valor provisional]`. | 20 intentos por cada orden del Nivel 1; contar aciertos. |
| REQ-23 | Tras 20 entradas seguidas no reconocidas o fuera del catálogo, el sistema deberá seguir en funcionamiento y atender la siguiente orden válida. | Sin robot: 20 entradas inválidas y después una orden válida que se ejecuta. |
| REQ-24 | El sistema no deberá guardar grabaciones de audio en el disco una vez transcrita la voz. | Inspección: sin ficheros de audio tras una sesión; revisión del código. Ver OPEN-06. |

### Requisitos de operación y verificación

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-26 | El sistema deberá poder ejecutarse con un robot simulado que registre los comandos recibidos, para realizar las pruebas sin el robot físico. | El conjunto de pruebas se ejecuta completo sin robot conectado. |
| REQ-27 | El sistema deberá poder instalarse, ejecutarse y demostrarse en un ordenador del equipo. | Demo en el ordenador del equipo. |

### Restricciones externas (no son comportamiento del software)

- **REQ-28.** Los ensayos con el robot físico se harán sobre una superficie lisa y con una persona que vigile para evitar caídas. Se verifica por inspección del procedimiento antes de cada sesión con el robot.
- El robot es un Bittle normal (placa NyBoard), sin módulo de voz (CTX-03).
- No hay requisitos de dominio en estas entregas (CTX-08).
- Fuera del alcance: interrupciones (cancelar una acción en curso), navegación autónoma y seguir a personas.

### Entidades clave

- **Orden del catálogo**: acción que el usuario puede pedir. Tiene una o más palabras que la dicen, un comando del robot y un efecto esperado. El catálogo mínimo es el Nivel 1 (REQ-02 a REQ-11); el repertorio amplía hasta las 40 órdenes programadas y las que añada el equipo (NEC-07).
- **Palabra de activación**: el nombre del perro. Sin ella, la frase no es una orden (OPEN-01).
- **Frase reconocida**: el texto que sale de la transcripción de la voz.
- **Orden interpretada**: la orden del catálogo, o varias en secuencia, que el intérprete saca de la frase. Puede ser «no entendida» o «fuera del catálogo».
- **Aviso**: mensaje al usuario («no se ha entendido bien», orden no disponible, «robot no conectado»). `[NEEDS CLARIFICATION: ¿solo en pantalla o también hablado? (OPEN-09)]`
- **Estado del robot**: conectado o desconectado; con una acción en curso o libre; en reposo.

## Criterios de éxito *(obligatorio)*

### Resultados medibles

- **SC-001** *(criterio mínimo del reto)*: en la demostración, el robot ejecuta correctamente **dos órdenes válidas** y el sistema trata correctamente **una entrada no reconocida** (sin mover el robot y con aviso).
- **SC-002**: cada una de las 10 órdenes del Nivel 1 llega al robot simulado como el comando esperado (REQ-02 a REQ-11).
- **SC-003**: de 20 intentos por orden en una sala tranquila, al menos el 80 % se ejecutan correctamente `[provisional]` (REQ-22).
- **SC-004**: el comando llega al robot en 2 s o menos desde el final de la frase, en las 20 mediciones `[provisional]` (REQ-21).
- **SC-005**: las 20 frases sin el nombre del perro y las 20 entradas sin sentido no producen ningún comando de movimiento (REQ-01, REQ-12).
- **SC-006**: el sistema sigue operativo y atiende una orden válida después de 20 entradas inválidas seguidas (REQ-23).
- **SC-007**: el conjunto de pruebas se ejecuta completo sin ningún robot conectado, y se puede repetir con el mismo resultado (REQ-26).
- **SC-008**: tras una sesión de prueba no queda ningún fichero de audio en el disco (REQ-24).

## Supuestos

- El robot es un Bittle normal con placa NyBoard y sin módulo de voz (CTX-03, comprobado).
- La prueba se hace en un ordenador del equipo, con interfaz web o aplicación (cliente 26/10, punto 9).
- El usuario conoce las órdenes que el robot reconoce (cliente 26/10, punto 1) y espera a que termine una acción antes de dar otra, salvo que las encadene en la misma frase (cliente 26/10, punto 2 y ajuste posterior).
- La transcripción de la voz no se desarrolla: se usa un módulo existente. El intérprete de órdenes sí es del equipo (REQ-18).
- El cliente acepta valores numéricos provisionales y su ajuste tras los prototipos (OPEN-02).
- La conexión es por Bluetooth o USB. Falta confirmar que el equipo tiene el adaptador Bluetooth (CTX-04).
- El robot se mueve bien solo sobre superficie lisa (CTX-05).
- El robot no avisa al terminar una acción (CTX-06, pendiente de comprobar).

## Asuntos abiertos

Vienen de H1 §7 y de la revisión de esta spec. Hay que cerrarlos o aceptarlos como riesgo antes de entregar. **Ninguno está decidido por esta spec.**

| ID | Cuestión | Afecta a |
|----|----------|----------|
| OPEN-01 | Nombre del perro (palabra de activación) y cómo se pronuncia | REQ-01 y todas las órdenes |
| OPEN-02 | Valores numéricos provisionales | REQ-15, REQ-16, REQ-21, REQ-22 |
| OPEN-03 | `khi`, `ktrF` y el pitido `b` no están confirmados en el robot | REQ-09, REQ-11, REQ-33 |
| OPEN-04 | Duración del giro de `kwkL`/`kwkR` y tolerancia | REQ-15, REQ-16 |
| OPEN-05 | Requisitos de ESC-03 y ESC-06: el comportamiento está decidido, pero falta añadir su REQ a H1 | REQ-31, REQ-32 |
| OPEN-06 | El módulo de transcripción puede enviar el audio a un servicio externo | REQ-24 |
| OPEN-07 | Conexión (Bluetooth o USB), modelo y placa | REQ-20 |
| OPEN-08 | Secuencia concreta de «baila» | REQ-14 |
| OPEN-09 | Aviso: solo en pantalla o también hablado | REQ-12, REQ-13, REQ-25 |
| Nuevo | Hueco de H1: ESC-08 (NEC-11) y ESC-09 (NEC-12) no tienen REQ; aquí aparecen como REQ-33 y REQ-34 propuestos | REQ-33, REQ-34 |
| Nuevo | Hueco de H1: ESC-03 no tiene necesidad asociada | REQ-31 |
| Nuevo | Casos límite sin definir: nombre sin orden, orden encadenada con una no reconocida, voces solapadas, pérdida de conexión durante una acción | Casos límite |

## Trazabilidad con H1

| Escenario | Necesidad | Requisitos en esta spec | Historia |
|-----------|-----------|-------------------------|----------|
| ESC-01 | NEC-01, NEC-04, NEC-07 | REQ-01 a REQ-11, REQ-21, REQ-22; opcionales REQ-14 a REQ-16 | 1, 7 |
| ESC-02 | NEC-02 | REQ-01 | 1 |
| ESC-03 | — | REQ-31 (propuesto) | 6 |
| ESC-04 | NEC-03 | REQ-12, REQ-19, REQ-23 | 2, 4 |
| ESC-05 | NEC-05 | REQ-13, REQ-19, REQ-23 | 2, 4 |
| ESC-06 | NEC-09 | REQ-32 (propuesto) | 6 |
| ESC-07 | NEC-06 | REQ-19, REQ-25 | 4 |
| ESC-08 | NEC-11 | REQ-33 (propuesto) | 6 |
| ESC-09 | NEC-12 | REQ-34 (propuesto), REQ-28 (parcial) | 6 |
| ESC-10 | NEC-10 | REQ-29 | 5 |
| Sin escenario | — | REQ-30 | Casos límite |
| H3 (sin robot) | NEC-08 | REQ-26 | 3 |
| Transversales | NEC-01 | REQ-17, REQ-18, REQ-20, REQ-27 | 1, 3, 4 |
| Cliente 26/10 (7) | — | REQ-24 | Criterios SC-008 |
