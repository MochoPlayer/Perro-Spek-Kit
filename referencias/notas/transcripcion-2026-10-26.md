# Transcripción de la sesión — 2026-10-26

Fuente: Wispr Flow (https://notes.wisprflow.ai/shared/-9_ZDmdZGRtPsws4XzCQMR9uEYkOuC1SIBy4hhoDc1I). Texto tal cual, sin corregir.

Speaker 1: Y requisitos: requisitos no sabemos cómo hacerlos, pero os diré cómo los podéis hacer en vez de daros una charla interminable. También os voy a dar dónde encontrar información sobre eso, para que los podáis hacer de nuevo. Escenarios y requisitos: tenéis que hacerlo vosotros.

Speaker 1: Si no lo hacéis vosotros, lo que luego vayáis a hacer no va a funcionar, ya os lo digo yo. Luego le vais a pasar esos documentos a la IA, va a intentar hacer algo, y por experiencia os digo que eso no funciona, ¿vale?

Speaker 1: Así que: le podéis pasar los requisitos que hagáis para que los amplíe, para que los corrija, para que los coteje, etcétera. Todo eso sí.

Speaker 1: Incluso os va a dar más requisitos, perfecto, no hay problema. Pero los básicos importantes los tenéis que tener vosotros claros.

Speaker 1: Después vais a hacer la especificación de cómo va a ser vuestro sistema y cómo vais a planificar la implementación. Especificaciones de arquitectura, etcétera.

Speaker 1: Las decisiones que habéis tomado, cómo organizáis las tareas, cuál va a ser el primer paso que vais a dar en la implementación, cómo a partir de eso, de manera incremental, vais a desarrollar el sistema completo. Para eso hay una herramienta, SPECTIC, que es de IHA, que os va a ayudar.

Speaker 1: Vamos a hacer un desarrollo basado en requisitos. Hay desarrollos basados en modelos, desarrollos basados en mil cosas.

Speaker 1: Nosotros vamos a hacer un diseño basado en requisitos. Así que la parte más importante es eso: que tengáis claro los requisitos.

Speaker 1: El siguiente entregable que vais a tener que hacer es la implementación y las pruebas, es decir, el código ejecutable que desarrolléis, o que os desarrollen, más vuestras mejoras, y las pruebas de que eso realmente funciona. Y por último, vais a tener que hacer una demostración y una presentación de qué es lo que habéis hecho, todas las fases que habéis seguido, las decisiones que habéis tomado, etcétera, etcétera, etcétera.

Speaker 1: ¿Vale?

Speaker 2: ¿Puedes repetir lo último?

Speaker 1: ¿El qué?

Speaker 2: Demostración. No, lo último.

Speaker 1: Ah, lo último.

Speaker 2: Que tenemos que.

Speaker 1: Vais a hacer una demostración de cómo funciona.

Speaker 2: Sí, eso sí.

Speaker 1: Y me vais a hacer una presentación de todas las fases que habéis seguido y los highlights de cada.

Speaker 2: Evidencias. Vale.

Speaker 1: Entregado.

Speaker 1: ¿Cómo se divide esto? Hoy: tenéis que entender el encargo, hacer la especificación, empezar a juguetear con SPECTIC y hacer la planificación del sistema. El próximo día: veis cómo vais a querer demostrar las cosas, qué pruebas necesitáis para comprobar que eso funciona, implementáis el sistema, integráis, adaptáis aquellas cosas que no funcionen, y la demostración.

Speaker 1: ¿Vale? Si os fijáis, el 50% del tiempo lo que vamos a hacer hoy es pensar. Y un 25 va a ser implementar y otro 25 demostrar.

Speaker 3: El objetivo final es que me digáis qué se siente y qué no se siente, y ya está.

Speaker 1: Que obedezca órdenes.

Speaker 3: Que obedezca órdenes.

Speaker 1: Tenemos que tener documentos e información importante para comprender el encargo. Tenéis miradlo en Moodle a ver si tenéis acceso a los enlaces, entiendo que sí.

Speaker 3: Sí.

Speaker 1: Pero tenéis una API, sí, tenéis una API, tenéis el protocolo serio, pero también hay de Bluetooth, tenéis documentación del robot. Para los escenarios ya más o menos lo sabéis. Y cómo describir los escenarios, pues aquí en el libro de Somerville también lo explican muy bien.

Speaker 1: Hasta ahí bien. Esta parte es más o menos la que conocéis, simplemente tenéis que aprender sobre el robot antes de hacer nada.

Speaker 1: La siguiente: especificar. Es decir, vamos a, de nuevo, identificar las necesidades de los STF holders, que ya lo sabéis.

Speaker 1: Y aquí empieza lo nuevo: transformar necesidades en requisitos. Ahora tenemos necesidades, tenemos escenarios, pero eso hay que pasarlo a requisitos.

Speaker 1: Entonces vais a tener que buscar información en estos tres enlaces. Podéis usar cualquier otra fuente extra.

Speaker 1: Somerville tiene un montón de diapositivas hechas él, porque aparte de escritor se dedica a ingeniería de software y demás, y tiene un montón de transparencias de docencia prácticamente hechas, donde también hablan de requisitos y demás. Entonces, y si no, pues la NASA también os explica cómo hacer buenos requisitos y cómo verificarlos.

Speaker 1: ¿Vale? Esta fase es muy importante. Ya digo, la base la hacéis vosotros, luego la ampliáis con la IA, todo lo que queráis, pero si no, ya os digo que no va a funcionar.

Speaker 1: El primer entregable lo hacéis por Moodle, el H1, con esa definición de requisitos y escenarios. Tenéis una plantilla también en Moodle puesta, que podéis usar, podéis modificar, etcétera, etcétera.

Speaker 1: Lo que queráis. Simplemente a modo de ayuda.

Speaker 1: Si no os ayuda, la podéis cambiar. Ese es el entregable 1.

Speaker 1: Se compone de la investigación técnica, ver lo que habéis descubierto del robot, los escenarios operacionales, necesidades, y de esas necesidades cómo pasáis a los requisitos. Definición de requisitos y cómo unís esos requisitos a escenarios, necesidades, etcétera, etcétera.

Speaker 1: Para que si en la próxima clase os cambio algo, sepáis a qué requisitos hay que tocar, qué requisitos no hay que tocar, etcétera, etcétera. Y sea mucho más fácil luego la reimplementación.

Speaker 1: El paso tres: explorar SPECTIC. SPECTIC es una herramienta de GitHub que se basa en el desarrollo basado en especificación, requisitos, etcétera.

Speaker 1: Entonces, a SPECTIC lo primero que le dais es toda la documentación que tenéis, pero entre ella es los requisitos. Y veréis cómo a partir de eso os ayuda con la planificación, con la generación de tareas y luego os hace la implementación.

Speaker 1: Entre comillas. Habrá cosas que tendréis que tocar, así que nunca le dejéis funcionar solo porque crea monstruos que no sabréis controlar.

Speaker 1: ¿Qué vais a tener que hacer? Pues instalarlo y configurarlo. Yo lo he probado con Claude, Claude Code, y con Codex, y funciona muy bien.

Speaker 1: ¿Vale? Elegir el entorno en el que vais a trabajar. Y vais a tener que hacer un proyecto en GitHub.

Speaker 1: ¿Vale? Podéis ya hacer uno en vuestro equipo como empresa y dentro un trabajo ya propio de este reto. Luego allí podéis poner el resto que haremos.

Speaker 1: Y, bueno, vais a tener que desarrollar el SPECMD, que en base a esos requisitos que le habéis dado, pues GitHub va a generar eso de ahí, que tendréis que modificar también vosotros un poco, porque a veces entiende lo que le da la gana, pero os va a ayudar.

Speaker 1: El último paso: la planificación. Vais a seguir la guía de SPECTIC para hacer la planificación.

Speaker 1: Os va a generar este plan.md, que de nuevo os va a tocar retocar vosotros. Y a partir de ahí os va a definir una serie de tareas que va a ir realizando.

Speaker 1: Empezando por la primera, la implementa, comprueba que funciona, pasa a la siguiente tarea, la implementa, etcétera. Por ahora lo implementamos, nosotros nos quedamos en las tareas.

Speaker 1: A partir de esas tareas vais a poder definir la arquitectura del sistema.

Speaker 1: ¿Cómo vais a hacer la arquitectura del sistema? El robot ya ha dicho: se comunica por Bluetooth, vais a necesitar otro ordenador. La arquitectura no va a ser muy complicada, pero luego si vais a tener módulos internos, pues uno para la voz, otro para mandar las órdenes, etcétera, pues conviene que esa información también se la deis al SPECTIC, sobre todo para que sepáis cómo hacer las cosas.

Speaker 1: Porque ya digo, genera muchísimos ficheros de más. Os podéis volver locos y no decir vosotros cómo queréis que esté organizada las cosas.

Speaker 1: Genera mucha, mucha basura. Y luego ver la coherencia de los documentos, todo está claro y funciona, hay inconsistencias, etcétera.

Speaker 1: Para las inconsistencias también SPECTIC os va a ayudar. Os va a decir: "pues estos dos requisitos están cruzados, si hago uno no puedo hacer el otro, ¿qué hacemos?".

Speaker 1: Todo eso os va a ir guiando. El entregable 2 es un enlace a vuestro repositorio, donde tienen que estar todos los documentos que se han generado.

Speaker 1: Y sobre todo eso: la especificación, el esquema del sistema, el plan de implementación, el plan de tareas, y cómo habéis llevado esa coherencia y trazabilidad en el sistema.

Speaker 1: Hoy dos entregables: primero requisitos, escenarios, etcétera, y el segundo, el enlace al GitHub con todo el código, todos los documentos que vayáis generando con el SPECTIC, con vuestras modificaciones.

Speaker 1: Aquí os he puesto como una checklist de cosas que tenéis que tener en cuenta para la segunda entrega, cosas que tenéis que ir cumpliendo.

Speaker 1: ¿Vale? ¿Claro?

Speaker 1: Esto es la primera parte. La siguiente sesión será la implementación, etcétera, etcétera.

Speaker 1: O sea que hoy no vais a tocar el robot, lo tocaréis la próxima. Pero os ayuda a ver el ciclo completo que vamos a seguir en el curso, que yo creo que es más ilustrativo que lo dejéis ya aquí en la charla sobre requisitos.

Speaker 1: ¿Dudas?

Speaker 2: Está al revés.

Speaker 1: Y a su tiempo. Vale.

Speaker 1: Yo me voy. Voy a ser a partir de ahora cliente.

Speaker 2: Y el contexto del robot.

Speaker 1: En clases pasadas vimos cómo había que tratar al cliente y las cosas que había que ir haciendo.

Speaker 3: ¿Prefieres que te escribamos por Teams o por WhatsApp?

Speaker 1: Me podéis escribir por Teams, no hay problema. Si trabajáis independientes. Competición, ya sabéis.

Speaker 1: Si queréis reuniros con el cliente para aclarar ciertas cosas, nos podemos reunir. O sea, yo voy a estar en mi despacho, no mirando a la pared, pero básicamente si queréis reuniros conmigo, podéis.

Speaker 1: ¿Cómo nos organizamos?

Speaker 1: Son las 10 menos 10. Trabajaréis tan poco, luego tomaréis un café.
