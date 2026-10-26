# Especificación: control por voz del Petoi Bittle (VOICE-BITTLE)

**Hito**: H2 · **Estado**: borrador revisado con el equipo (26/10) · **Base**: `H1-especificacion-inicial/Entregable-H1.md` (rama `main`)

**Entrada**: el análisis de H1 (escenarios ESC, necesidades NEC, requisitos REQ) y las respuestas del cliente del 26/10 (`referencias/notas/respuestas-cliente-2026-10-26.md`).

> **Cómo leer este documento.** Sigue la plantilla oficial de `spec.md` de Spec Kit. Los identificadores `ESC-`, `NEC-`, `REQ-`, `CTX-` y `OPEN-` son los de H1, para que la trazabilidad se mantenga. Esta spec dice **qué** debe hacer el sistema, no **cómo**: las decisiones técnicas van en `plan.md`. Lo que sigue sin decidir se marca `[NEEDS CLARIFICATION]` y se recoge en «Asuntos abiertos». No se ha inventado ningún valor: los números provisionales llevan esa etiqueta.

## Escenarios de usuario y pruebas *(obligatorio)*

**Usuario**: la persona que da órdenes de voz al robot (STK-02). **Cliente**: el profesor (STK-01). **Equipo**: quien construye y prueba el sistema (STK-03). **Personas del entorno**: quien está cerca y puede hablar sin dar órdenes (STK-04). **Atenio** es el nombre del perro y la palabra de activación.

### Historia 1 · Dar una orden y que el robot la ejecute (Prioridad: P1)

El usuario dice «Atenio» seguido de una orden del catálogo, por ejemplo «Atenio, siéntate». El sistema la reconoce, la envía al robot y el robot ejecuta la acción.

**Por qué P1**: es el objetivo del encargo (NEC-01) y la mitad del criterio mínimo de aceptación (dos órdenes válidas).

**Prueba independiente**: con un robot simulado, decir cada orden del Nivel 1 y comprobar que el robot simulado recibe el comando esperado. En la demostración, comprobar que el robot físico hace el movimiento.

**Escenarios de aceptación**:

1. **Dado** el robot conectado y sin acción en curso, **cuando** el usuario dice «Atenio, siéntate», **entonces** el robot recibe `ksit` y queda sentado. *(ESC-01, REQ-02)*
2. **Dado** el mismo estado, **cuando** el usuario dice «Atenio, levántate», **entonces** el robot recibe `kup` y queda de pie. *(REQ-03)*
3. **Dado** el mismo estado, **cuando** el usuario dice cualquiera de las otras órdenes del Nivel 1 (REQ-04 a REQ-11), **entonces** el robot recibe el comando que le corresponde.
4. **Dado** el sistema escuchando, **cuando** alguien dice una orden **sin** «Atenio», **entonces** el robot no se mueve y el sistema sigue escuchando. *(ESC-02, REQ-01)*
5. **Dado** el sistema escuchando, **cuando** el usuario dice solo «Atenio» y, dentro de 5 s `[provisional]`, una orden válida, **entonces** el sistema la trata como orden y la ejecuta. Si no llega ninguna, vuelve a la escucha normal sin enviar nada. *(REQ-35)*

---

### Historia 2 · Saber que una entrada no es una orden válida (Prioridad: P1)

Si el sistema recibe ruido, una frase sin sentido o una orden que no está en el catálogo, no mueve el robot y avisa al usuario en pantalla para que pueda repetirla.

**Por qué P1**: la entrada no reconocida es la otra mitad del criterio mínimo de aceptación (NEC-03, prioridad Alta).

**Prueba independiente**: con un robot simulado, enviar entradas de ruido, sin sentido y fuera del catálogo; comprobar que no se envía ningún comando y que el aviso se muestra cada vez.

**Escenarios de aceptación**:

1. **Dado** el sistema escuchando, **cuando** recibe ruido alto o una frase sin sentido, **entonces** no se envía ningún comando de movimiento y se muestra el aviso «no se ha entendido bien». *(ESC-04, REQ-12)*
2. **Dado** el sistema escuchando, **cuando** el usuario dice «Atenio, sígueme» (u otra orden fuera del catálogo), **entonces** no se envía ningún comando y se muestra un aviso de orden no disponible. *(ESC-05, REQ-13)*
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

### Historia 4 · Varias órdenes seguidas y cola de acciones (Prioridad: P1)

El usuario puede encadenar órdenes en una misma frase («Atenio, camina y siéntate») y no tiene que esperar a que el robot termine: las órdenes que llegan con el robot ocupado se guardan en una cola y se envían en orden, cada una al terminar la anterior. Si una orden de la frase no está en el catálogo, se salta, se avisa y se ejecutan las demás.

**Por qué P1**: lo pidió el cliente como ajuste (NEC-10, prioridad Alta) y el equipo decidió el 26/10 que entra en el primer incremento. No es parte del criterio mínimo. La cola (NEC-09) va con ella.

**Prueba independiente**: con el robot simulado, frases con 2 y con 3 órdenes, una frase con una orden fuera del catálogo, y tres órdenes dadas con el robot ocupado; comprobar el orden de los comandos y el aviso.

**Escenarios de aceptación**:

1. **Dado** el robot sin acción en curso, **cuando** el usuario dice «Atenio, orden 1 y orden 2», **entonces** el robot recibe primero el comando de la orden 1 y, al terminar esta, el de la orden 2. *(ESC-10, REQ-29)*
2. **Dado** el mismo estado, **cuando** el usuario dice «Atenio, camina y bailoteo y siéntate» (con «bailoteo» fuera del catálogo), **entonces** el robot ejecuta «camina» y después «siéntate», y se muestra el aviso por «bailoteo». *(REQ-29)*
3. **Dado** el robot ejecutando una acción, **cuando** el usuario da otras órdenes, **entonces** el sistema las guarda en una cola y las envía en el orden de llegada, cada una al terminar la anterior. *(ESC-06, REQ-32)*

---

### Historia 5 · Detener el robot: «para» y parada de emergencia (Prioridad: P1)

El usuario puede detener al robot de dos formas. La orden «Atenio, para» es la única orden de voz que interrumpe la acción en curso. El botón de parada de emergencia de la interfaz deja al robot en reposo, vacía la cola y bloquea las órdenes de voz hasta que se vuelva a pulsar.

**Por qué P1**: es una medida de seguridad (REQ-30 es *Esencial* en H1) y «para» es una orden del Nivel 1.

**Prueba independiente**: con el robot simulado ocupado, decir «Atenio, para»; pulsar el botón, dar órdenes válidas y comprobar que no se envía nada; volver a pulsar y comprobar que la siguiente orden se ejecuta.

**Escenarios de aceptación**:

1. **Dado** el robot ejecutando una acción, **cuando** el usuario dice «Atenio, para», **entonces** el sistema envía `krest` y el robot interrumpe la acción y se detiene. Ninguna otra orden interrumpe. *(REQ-07)*
2. **Dado** el robot funcionando, **cuando** el usuario pulsa el botón de parada de emergencia, **entonces** el robot entra en reposo y la cola de acciones queda vacía. *(REQ-30)*
3. **Dado** la parada activa, **cuando** llega una orden de voz válida, **entonces** no se envía ningún comando y se muestra «parada de emergencia activa». *(REQ-30)*
4. **Dado** la parada activa, **cuando** el usuario vuelve a pulsar el botón, **entonces** la parada se desactiva y la siguiente orden válida se ejecuta. *(REQ-30)*

---

### Historia 6 · Ver el estado del sistema y de la conexión (Prioridad: P2)

El usuario ve en la interfaz el texto reconocido, la orden interpretada, el estado de la conexión con el robot y los avisos. Si el robot no está conectado, el sistema no envía comandos y lo avisa.

**Por qué P2**: no es parte del criterio mínimo, pero sin ello el usuario no sabe por qué no pasa nada (NEC-06, prioridad Media).

**Prueba independiente**: con el puerto del robot cerrado, dar una orden y comprobar que no sale ningún comando y que aparece el aviso.

**Escenarios de aceptación**:

1. **Dado** que no hay conexión con el robot, **cuando** el usuario da una orden válida, **entonces** no se envía ningún comando y se muestra «robot no conectado». *(ESC-07, REQ-25)*
2. **Dado** una sesión de prueba, **cuando** el usuario habla, **entonces** la interfaz muestra el texto reconocido, la orden interpretada, el estado de la conexión y los avisos, solo en pantalla. *(REQ-19)*

---

### Historia 7 · Reposo, batería baja y manipulación del robot (Prioridad: P2)

Tras un tiempo T sin órdenes el robot queda en reposo y una orden válida lo despierta. Si el robot avisa de batería baja, el sistema lo muestra. Si alguien coge o tumba al robot, este se detiene.

**Por qué P2**: son escenarios alternativos y excepcionales con prioridad *Media* en H1 (REQ-31, REQ-33, REQ-34).

**Prueba independiente**: con el robot simulado, reducir T y esperar; hacer que el simulador envíe «Low power». La manipulación solo se prueba con el robot físico.

**Escenarios de aceptación**:

1. **Dado** el robot conectado y sin acción en curso, **cuando** pasa el tiempo T sin ninguna orden (5 min en la demostración, 15 min en uso real), **entonces** el robot queda en reposo sin avisar. *(ESC-03, REQ-31)*
2. **Dado** el robot en reposo por inactividad, **cuando** el usuario da una orden válida, **entonces** el robot sale del reposo y la ejecuta. *(REQ-31)*
3. **Dado** que el robot envía el aviso «Low power», **cuando** el sistema lo recibe, **entonces** muestra al usuario que debe cargar el robot. *(ESC-08, REQ-33)*
4. **Dado** el robot ejecutando una acción, **cuando** alguien lo coge, lo mueve o lo tumba, **entonces** el robot se detiene y se queda quieto. *(ESC-09, REQ-34, por confirmar en el robot, OPEN-10)*

---

### Historia 8 · Órdenes extra opcionales (Prioridad: P3)

El usuario dispone de órdenes que van más allá del mínimo: «baila», «media vuelta» y «da una vuelta». El cliente valora ampliar el repertorio (NEC-07, prioridad Media). Se abordan solo si hay tiempo.

**Prueba independiente**: con el robot simulado, comprobar que la lista de comandos enviada coincide con la definida para cada orden; en la demostración, 5 intentos con medida de la desviación en los giros.

**Escenarios de aceptación**:

1. **Dado** el robot sin acción en curso, **cuando** el usuario dice «Atenio, baila», **entonces** el robot ejecuta una secuencia fija y predefinida y termina en una postura estable. *(REQ-14)*
2. **Dado** el mismo estado, **cuando** el usuario dice «Atenio, media vuelta», **entonces** el robot gira a la izquierda hasta quedar en sentido contrario al inicial, con una desviación máxima de ±45° `[provisional]`. *(REQ-15)*
3. **Dado** el mismo estado, **cuando** el usuario dice «Atenio, da una vuelta», **entonces** el robot completa una vuelta, con una desviación máxima de ±45° `[provisional]`. *(REQ-16)*

### Casos límite

- **Solo «Atenio» sin orden**: el sistema espera 5 s `[provisional]`; si llega una orden, la ejecuta; si no, vuelve a escuchar con normalidad (REQ-35).
- **Orden encadenada con una no reconocida**: se salta la no reconocida, se avisa y se ejecutan las demás (REQ-29).
- **Número máximo de órdenes por frase y palabras de enlace aceptadas** («y», «luego»…). H1 lo deja *por definir* en REQ-29.
- **Cómo sabe el sistema que una acción ha terminado.** El robot no avisa al terminar (CTX-05): el software debe estimar un retardo por orden. Afecta a REQ-29 y REQ-32.
- **«Atenio, para» con órdenes en la cola.** «Para» interrumpe la acción en curso y no se encola (REQ-07, REQ-32). `[NEEDS CLARIFICATION: ¿«para» también vacía la cola o siguen las órdenes guardadas? (OPEN-12)]`
- **«Para» dentro de una frase encadenada**, por ejemplo «camina y para». `[NEEDS CLARIFICATION: ¿cancela las órdenes que quedan en la frase?]`
- **Parada de emergencia y reposo por inactividad**: con la parada activa, REQ-30 manda sobre REQ-31 (una orden no despierta al robot).
- **Voces de otras personas**: solo cuenta como orden la frase que empieza por «Atenio» (REQ-01). Se acepta como riesgo conocido; no se añade requisito.
- **Pérdida de conexión durante una acción.** H1 cubre solo la conexión ausente al dar una orden (REQ-25). `[NEEDS CLARIFICATION]`
- **Ruido durante la demostración.** Condiciones de ruido sin definir.

## Requisitos *(obligatorio)*

Los requisitos mantienen el identificador y la prioridad de H1. Todo requisito debe poder derivarse a una prueba concreta (cliente 26/10, punto 7). La columna «Prueba» resume la verificación prevista en H1. Los requisitos de dominio no aplican en estas entregas (cliente 26/10, punto 7).

### Requisitos funcionales

**Activación y entradas no válidas**

| ID | Enunciado | Origen | Prueba |
|----|-----------|--------|--------|
| REQ-01 | El sistema deberá tratar como orden solo una frase que empiece por el nombre del perro «Atenio» seguido de una orden del catálogo, y deberá ignorar cualquier otra frase sin enviar ningún comando al robot, salvo lo previsto en REQ-35. | ESC-01, ESC-02 | Sin robot: 20 frases con el nombre se procesan como orden; 20 sin el nombre no producen comando. |
| REQ-35 | Si el usuario dice solo «Atenio» sin orden, el sistema deberá esperar una orden durante 5 s `[provisional]` y tratar como orden la frase que llegue en ese tiempo aunque no empiece por «Atenio». Si no llega ninguna, deberá volver a la escucha normal sin enviar ningún comando. | NEC-02; decisión 26/10 | Sin robot: «Atenio» y una orden válida dentro de 5 s → el simulador recibe el comando; «Atenio» sin orden → ningún comando y la siguiente orden con nombre se atiende. |
| REQ-12 | Ante una frase con ruido o sin sentido que no se interprete como una orden, el sistema deberá no enviar ningún comando de movimiento y deberá mostrar el aviso «no se ha entendido bien». | ESC-04 | Sin robot: 20 entradas → ningún comando y aviso cada vez. |
| REQ-13 | Ante una orden que no está en el catálogo o que el robot no puede hacer, el sistema deberá no enviar ningún comando y deberá mostrar un aviso de orden no disponible. | ESC-05 | Sin robot: 10 órdenes fuera del catálogo → ningún comando y aviso cada vez. |

**Órdenes del Nivel 1** (fijas, esenciales). Cada orden se dice como «Atenio, <orden>» y el sistema envía el comando indicado.

| ID | Orden dicha | Comando enviado | Efecto esperado | Prueba |
|----|-------------|-----------------|-----------------|--------|
| REQ-02 | siéntate | `ksit` | Sentarse | Sin robot: el simulador recibe `ksit`. Demo: queda sentado. |
| REQ-03 | levántate | `kup` | Ponerse en pie | Sin robot: `kup`. Demo: queda de pie. |
| REQ-04 | camina | `kwkF` | Caminar hacia delante | Sin robot: `kwkF`. Demo: avanza. |
| REQ-05 | izquierda | `kwkL` | Caminar hacia la izquierda | Sin robot: `kwkL`. Demo: gira a la izquierda. |
| REQ-06 | derecha | `kwkR` | Caminar hacia la derecha | Sin robot: `kwkR`. Demo: gira a la derecha. |
| REQ-07 | para | `krest` | Detenerse en reposo. Es la única orden que interrumpe: se envía aunque el robot esté ocupado y detiene la acción en curso | Sin robot: `krest`, también con una acción en curso. Demo: se detiene. |
| REQ-08 | túmbate | `d` | Tumbarse y apagar los motores | Sin robot: `d`. Demo: queda tumbado. |
| REQ-09 | saluda | `khi` | Saludar | Sin robot: `khi`. Demo: gesto de saludo. `[NEEDS CLARIFICATION: comando por confirmar en el robot, OPEN-03]` |
| REQ-10 | equilíbrate | `kbalance` | Postura de equilibrio | Sin robot: `kbalance`. Demo: queda en equilibrio. |
| REQ-11 | trota | `ktrF` | Trotar hacia delante | Sin robot: `ktrF`. Demo: trota. `[NEEDS CLARIFICATION: comando por confirmar en el robot, OPEN-03]` |

**Órdenes opcionales (Nivel 2)**. Cada una cuenta como una sola orden para el usuario, aunque el sistema envíe varios comandos seguidos.

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-14 | Ante «Atenio, baila», el sistema deberá hacer que el robot ejecute una secuencia fija y predefinida y termine en una postura estable. | Sin robot: la lista de comandos coincide con la secuencia (OPEN-08). Demo: sin caída. |
| REQ-15 | Ante «Atenio, media vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta quedar en sentido contrario al inicial, con una desviación máxima de ±45° `[provisional, OPEN-02]`. | Sin robot: `kwkL` durante la duración calibrada (OPEN-04). Demo: 5 intentos con medida. |
| REQ-16 | Ante «Atenio, da una vuelta», el sistema deberá hacer que el robot gire a la izquierda hasta completar una vuelta, con una desviación máxima de ±45° `[provisional, OPEN-02]`. | Sin robot: dos giros seguidos de la duración calibrada. Demo: 5 intentos con medida. |

**Órdenes encadenadas y cola de acciones** (ajuste del cliente, 26/10)

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-29 | Ante una frase «Atenio, orden 1 y orden 2…» con varias órdenes del catálogo, el sistema deberá enviar al robot los comandos de cada orden en el orden dicho, y deberá enviar cada uno solo cuando haya terminado la acción anterior. Si una de las órdenes no está en el catálogo, el sistema deberá saltarla, avisar al usuario y ejecutar las demás en el orden dicho. | Sin robot: frases con 2 y con 3 órdenes → los comandos llegan en orden. Frase con una orden fuera del catálogo → se salta esa, se ejecutan las demás y se muestra el aviso. Demo: acciones seguidas y en orden. |
| REQ-32 | Si llega una orden mientras el robot ejecuta otra, el sistema deberá guardarla en una cola de acciones y enviarla al robot cuando termine la acción en curso, respetando el orden de llegada. La orden «para» (REQ-07) no se guarda en la cola: interrumpe la acción en curso. La parada de emergencia vacía la cola (REQ-30). | Sin robot: tres órdenes dadas con el robot simulado ocupado → recibe los comandos en el orden dado, cada uno al terminar el anterior. |

**Comportamientos de operación** (decididos el 26/10)

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-31 | Tras un tiempo T sin recibir órdenes, el sistema deberá poner el robot en reposo sin avisar. T deberá ser configurable: 5 min en la demostración y 15 min en un entorno real. Una orden válida posterior deberá sacar al robot del reposo y ejecutarse. | Sin robot con T reducido: al cumplirse T, el simulador recibe el comando de reposo (OPEN-11); una orden válida posterior → recibe su comando. Demo con T = 5 min. |
| REQ-33 | Al recibir del robot por el puerto serie el aviso de batería baja («Low power»), el sistema deberá mostrar al usuario un aviso de que debe cargar el robot. | Sin robot: el simulador envía «Low power: 6.5V» → aparece el aviso. |
| REQ-34 | El sistema deberá mantener activado el giroscopio del robot, de forma que, si lo cogen o se cae durante una acción, el robot ejecute su reacción (`lifted` / `dropped`) y se quede quieto. | Demo con el robot: levantarlo durante una acción → se detiene y queda quieto. Por confirmar en el robot (OPEN-10). |

**Seguridad**

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-30 | La interfaz deberá ofrecer un botón de parada de emergencia. Al pulsarlo, el sistema deberá poner el robot en modo reposo, vaciar la cola de acciones y no enviarle ningún otro comando hasta que el usuario vuelva a pulsar el mismo botón. Mientras la parada esté activa, las órdenes de voz no producen ningún comando y se muestra el aviso «parada de emergencia activa». | Sin robot: al pulsar, el simulador recibe el comando de reposo (OPEN-11), la cola queda vacía y ninguna orden posterior produce comando, y se muestra el aviso; al volver a pulsar, se atienden de nuevo. Demo con el robot. |
| REQ-25 | Si no hay conexión con el robot, el sistema no deberá enviar ningún comando y deberá mostrar el aviso «robot no conectado». | Sin robot: puerto cerrado → ningún comando y aviso. Demo: desconectar el robot y dar una orden. |

### Requisitos de interfaces

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-17 | El sistema deberá recibir la voz del usuario desde el micrófono del ordenador del equipo. | Demo: una frase dicha ante el micrófono aparece como texto. |
| REQ-18 | El sistema deberá obtener el texto de la voz mediante un módulo de transcripción ya existente, y deberá incluir un intérprete propio que convierta ese texto en una orden del catálogo. | Inspección: la transcripción es una dependencia externa y el intérprete es código del equipo. Prueba: texto → orden esperada. |
| REQ-19 | El sistema deberá ofrecer una interfaz de usuario (web o aplicación) que muestre el texto reconocido, la orden interpretada, el estado de la conexión con el robot y los avisos, y que incluya el botón de parada de emergencia (REQ-30). Los avisos se muestran solo en pantalla. | Demo: los cuatro elementos son visibles y el botón está disponible en una sesión de prueba. |
| REQ-20 | El sistema deberá enviar al robot los comandos en el formato del protocolo serie de Petoi (token y parámetros, por ejemplo `ksit`) a través de un puerto serie (Bluetooth o USB, OPEN-07). | Sin robot: el simulador recibe la cadena exacta. Demo: el robot obedece. |

### Requisitos de prestaciones y calidad

Los valores numéricos son **provisionales**: el cliente pidió ponerlos «a ojo» con márgenes amplios y ajustarlos tras los prototipos (OPEN-02).

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-21 | El tiempo desde que el usuario termina la frase hasta que el sistema envía el comando al robot deberá ser inferior a 1,5 s `[provisional, CTX-04]`. | Sin robot: 20 mediciones, todas < 1,5 s. |
| REQ-22 | El sistema deberá reconocer y ejecutar correctamente al menos el 80 % de las órdenes válidas dichas en una sala tranquila `[provisional]`. | 20 intentos por cada orden del Nivel 1; contar aciertos. |
| REQ-23 | Tras 20 entradas seguidas no reconocidas o fuera del catálogo, el sistema deberá seguir en funcionamiento y atender la siguiente orden válida. | Sin robot: 20 entradas inválidas y después una orden válida que se ejecuta. |
| REQ-24 | El sistema no deberá guardar grabaciones de audio en el disco una vez transcrita la voz. | Inspección: sin ficheros de audio tras una sesión; revisión del código. Ver OPEN-06. |

### Requisitos de operación y verificación

| ID | Enunciado | Prueba |
|----|-----------|--------|
| REQ-26 | El sistema deberá poder ejecutarse con un robot simulado que registre los comandos recibidos, para realizar las pruebas sin el robot físico. | El conjunto de pruebas se ejecuta completo sin robot conectado. |
| REQ-27 | El sistema deberá poder instalarse, ejecutarse y demostrarse en un ordenador del equipo. | Demo en el ordenador del equipo. |

### Restricciones externas (no son comportamiento del sistema)

- **REQ-28.** Los ensayos con el robot físico se harán sobre una superficie lisa y con una persona que vigile para evitar caídas. Se verifica por inspección del procedimiento antes de cada sesión con el robot.
- El robot es un Bittle normal (placa NyBoard), sin módulo de voz (CTX-01).
- No hay requisitos de dominio en estas entregas (cliente 26/10, punto 7).
- Fuera del alcance: interrupciones (cancelar una acción en curso), salvo la orden «para» (REQ-07); navegación autónoma y seguir a personas.

### Entidades clave

- **Orden del catálogo**: acción que el usuario puede pedir. Tiene una o más palabras que la dicen, un comando del robot y un efecto esperado. El catálogo mínimo es el Nivel 1 (REQ-02 a REQ-11); el repertorio amplía hasta las 40 órdenes programadas y las que añada el equipo (NEC-07).
- **Palabra de activación**: «Atenio». Sin ella la frase no es una orden, salvo la espera de REQ-35.
- **Frase reconocida**: el texto que sale de la transcripción de la voz.
- **Orden interpretada**: la orden del catálogo, o varias en secuencia, que el intérprete saca de la frase. Puede ser «no entendida» o «fuera del catálogo».
- **Cola de acciones**: órdenes pendientes de enviar, en orden de llegada. La vacía la parada de emergencia.
- **Aviso**: mensaje al usuario en pantalla («no se ha entendido bien», orden no disponible, «robot no conectado», «parada de emergencia activa», batería baja).
- **Estado del robot**: conectado o desconectado; con una acción en curso o libre; en reposo.
- **Parada de emergencia**: estado activado y desactivado con el botón de la interfaz. Mientras está activo, bloquea las órdenes de voz.

## Criterios de éxito *(obligatorio)*

### Resultados medibles

- **SC-001** *(criterio mínimo del reto)*: en la demostración, el robot ejecuta correctamente **dos órdenes válidas** y el sistema trata correctamente **una entrada no reconocida** (sin mover el robot y con aviso).
- **SC-002**: cada una de las 10 órdenes del Nivel 1 llega al robot simulado como el comando esperado (REQ-02 a REQ-11).
- **SC-003**: de 20 intentos por orden en una sala tranquila, al menos el 80 % se ejecutan correctamente `[provisional]` (REQ-22).
- **SC-004**: el comando llega al robot en menos de 1,5 s desde el final de la frase, en las 20 mediciones `[provisional]` (REQ-21).
- **SC-005**: las 20 frases sin «Atenio» y las 20 entradas sin sentido no producen ningún comando de movimiento (REQ-01, REQ-12).
- **SC-006**: el sistema sigue operativo y atiende una orden válida después de 20 entradas inválidas seguidas (REQ-23).
- **SC-007**: el conjunto de pruebas se ejecuta completo sin ningún robot conectado, y se puede repetir con el mismo resultado (REQ-26).
- **SC-008**: tras una sesión de prueba no queda ningún fichero de audio en el disco (REQ-24).
- **SC-009**: frases encadenadas de 2 y 3 órdenes llegan al robot simulado en el orden dicho, y la orden fuera del catálogo se salta con aviso (REQ-29).
- **SC-010**: tres órdenes dadas con el robot ocupado se envían en el orden de llegada, cada una al terminar la anterior (REQ-32).
- **SC-011**: con la parada de emergencia activa, ninguna de 10 órdenes válidas produce un comando, y tras desactivarla la siguiente se ejecuta (REQ-30).
- **SC-012**: «Atenio, para» con una acción en curso envía `krest` y nunca queda en cola (REQ-07, REQ-32).

## Supuestos

- El robot es un Bittle normal con placa NyBoard y sin módulo de voz (CTX-01, comprobado).
- La prueba se hace en un ordenador del equipo, con interfaz web o aplicación (cliente 26/10, punto 9).
- El usuario conoce las órdenes que el robot reconoce (cliente 26/10, punto 1) y puede darlas sin esperar: las que lleguen con el robot ocupado van a la cola (CTX-02).
- La transcripción de la voz no se desarrolla: se usa un módulo existente. El intérprete de órdenes sí es del equipo (REQ-18).
- El cliente acepta valores numéricos provisionales y su ajuste tras los prototipos (OPEN-02).
- La conexión es por Bluetooth o USB. Falta validar el emparejamiento Bluetooth (CTX-07).
- El robot se mueve bien solo sobre superficie lisa (CTX-06).
- El robot no avisa al terminar una acción (CTX-05): el software estima un retardo por orden.
- El robot detecta por sí mismo la batería baja y la manipulación (firmware): es una afirmación del equipo, por observar en la sesión 2 (OPEN-10).

## Asuntos abiertos

Vienen de H1 §7 y de la revisión de esta spec. Hay que cerrarlos o aceptarlos como riesgo antes de entregar.

| ID | Cuestión | Afecta a | Estado |
|----|----------|----------|--------|
| OPEN-01 | Nombre «Atenio» decidido; falta comprobar que la transcripción lo reconoce bien | REQ-01 y todas las órdenes | Por comprobar |
| OPEN-02 | Valores numéricos provisionales (incluye los 5 s de REQ-35) | REQ-15, REQ-16, REQ-21, REQ-22, REQ-35 | Abierto |
| OPEN-03 | `khi`, `ktrF` y el pitido `b` no están confirmados en el robot | REQ-09, REQ-11 | Abierto |
| OPEN-04 | Duración del giro de `kwkL`/`kwkR` y tolerancia | REQ-15, REQ-16 | Abierto |
| OPEN-05 | Cola de acciones y reposo tras T | REQ-31, REQ-32 | Cerrado |
| OPEN-06 | El módulo de transcripción puede enviar el audio a un servicio externo | REQ-24 | Abierto |
| OPEN-07 | Conexión (Bluetooth o USB), modelo y placa | REQ-20 | Abierto |
| OPEN-08 | Secuencia concreta de «baila» | REQ-14 | Abierto |
| OPEN-09 | Avisos solo en pantalla (decidido) | REQ-12, REQ-13, REQ-25 | Cerrado |
| OPEN-10 | Que las skills `lifted` y `dropped` detengan el robot cuando lo cogen o se cae | REQ-34 | Abierto |
| OPEN-11 | Comando de reposo de REQ-30 y REQ-31 (`krest` o `d`) | REQ-30, REQ-31 | Abierto |
| OPEN-12 | Qué hace «para» con la cola de acciones, y dentro de una frase encadenada | REQ-07, REQ-29, REQ-32 | Abierto |
| Nuevo | Pérdida de conexión durante una acción | REQ-25 | Abierto |
| Nuevo | Número máximo de órdenes por frase, palabras de enlace y detección del fin de una acción | REQ-29, REQ-32 | Abierto |

## Trazabilidad con H1

| Escenario | Necesidad | Requisitos en esta spec | Historia |
|-----------|-----------|-------------------------|----------|
| ESC-01 | NEC-01, NEC-04, NEC-07 | REQ-01 a REQ-11, REQ-21, REQ-22; opcionales REQ-14 a REQ-16 | 1, 8 |
| ESC-02 | NEC-02 | REQ-01, REQ-35 | 1 |
| ESC-03 | NEC-13 | REQ-31 | 7 |
| ESC-04 | NEC-03 | REQ-12, REQ-19, REQ-23 | 2, 6 |
| ESC-05 | NEC-05 | REQ-13, REQ-19, REQ-23 | 2, 6 |
| ESC-06 | NEC-09 | REQ-32, REQ-07 | 4, 5 |
| ESC-07 | NEC-06 | REQ-19, REQ-25 | 6 |
| ESC-08 | NEC-11 | REQ-33 | 7 |
| ESC-09 | NEC-12 | REQ-34, REQ-28 | 7 |
| ESC-10 | NEC-10 | REQ-29 | 4 |
| Sin escenario (parada de emergencia) | — | REQ-30, REQ-19 | 5 |
| H3 (sin robot) | NEC-08 | REQ-26 | 3 |
| Transversales | NEC-01 | REQ-17, REQ-18, REQ-20, REQ-27 | 1, 3, 6 |
| Cliente 26/10 (7) | — | REQ-24 | SC-008 |
