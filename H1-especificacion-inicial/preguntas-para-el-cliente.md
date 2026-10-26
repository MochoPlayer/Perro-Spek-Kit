# Preguntas para el cliente (profesor)

Borrador para acotar la especificación. Se contactará por Teams o en su despacho. Orden: de lo que más condiciona los requisitos a lo que menos.

## A. Órdenes y comportamiento

1. ¿Las **dos órdenes válidas** las fija el cliente o las elegimos nosotros?
2. ¿En qué **idioma** se dan las órdenes? ¿Se esperan sinónimos ("siéntate" y "sentado")?
3. ¿Qué debe hacer el sistema ante una **entrada no reconocida**: no hacer nada, avisar con un sonido, pedir que se repita?
4. ¿Cuánto debe **durar** una orden de movimiento (por ejemplo, "camina": hasta nueva orden, un número de pasos, un tiempo)?
5. ¿Una orden nueva **interrumpe** la anterior? ¿Debe existir una orden de **parada**?
6. ¿Las **órdenes compuestas** ("camina y siéntate") o con números ("dos veces") suman algo o están fuera de alcance?
7. ¿Qué pasa con una **orden dicha a medias** o con ruido de fondo?

## B. Voz y entorno

8. ¿Se puede usar un reconocimiento de voz **online** (servicio en la nube) o debe ser **local**? ¿Hay límite de coste?
9. ¿Debemos usar el **módulo de voz de Petoi** (si el robot lo lleva) o hacer el reconocimiento en el **ordenador**?
10. ¿Cómo se activa la escucha: siempre activa, palabra de activación o pulsar un botón?
11. En la demostración, ¿cuántos hablantes, qué **distancia** al micrófono y qué nivel de ruido esperáis?
12. ¿Vale cualquier hablante o solo uno concreto?
13. ¿Qué **micrófono** usaremos (el del portátil u otro)?
14. ¿Se permite grabar y guardar el audio (privacidad)?

## C. Robot y conexión

15. ¿Qué **modelo** exacto es (Bittle, Bittle X, X V2) y qué **placa** lleva (NyBoard o BiBoard)?
16. ¿Lleva **zumbador**, sensor de **ultrasonidos**, **cámara** o módulo de voz?
17. ¿Cómo se conecta: **Bluetooth** o USB? ¿Hace falta un adaptador? ¿Cuál es la velocidad (baudios)?
18. ¿Cada equipo tiene su **propio robot**? ¿Podemos usarlo **antes de la sesión 2** o fuera de clase?
19. ¿Podemos **actualizar el firmware** del robot o hay que dejarlo como está?
20. ¿El robot **avisa cuando termina** un movimiento o hay que esperar un tiempo fijo?
21. ¿Qué superficie y qué **espacio** tendremos en la demostración?
22. ¿Qué **límites de seguridad** hay (caídas, batería baja, no tocarlo mientras se mueve)?

## D. Rendimiento

23. ¿Cuál es el **tiempo máximo** entre acabar de hablar y que el robot empiece a moverse?
24. ¿Qué **tasa de acierto** mínima se espera en el reconocimiento?
25. ¿Cuántos intentos fallidos se toleran en la demostración?

## E. Plataforma y herramientas

26. ¿Hay un **lenguaje** o **sistema operativo** obligatorio? ¿Podemos usar librerías externas?
27. ¿Con qué **agente** debemos usar Spec Kit (Claude Code, Codex, otro) y qué ficheros espera ver en el repo?
28. ¿Basta con **pruebas sin robot** (simulación del envío de comandos) para H3, o se espera algo más?

## F. Entrega y evaluación

29. ¿Qué **formato** tiene H1 (PDF, Markdown, plantilla de Moodle) y qué **extensión** máxima?
30. ¿Cuáles son las **fechas y horas de entrega** de H1 y H2?
31. ¿Qué **criterios** puntúan en cada hito y cómo se decide el **ranking** de la competición?
32. ¿El repositorio puede ser **público** o debe ser privado? ¿Se da acceso al profesor?
33. ¿Hay un **peso** distinto entre escenarios, requisitos y trazabilidad en H1?
34. ¿Qué tipo de **cambio** podemos esperar en CR-01 (nuevas órdenes, otro idioma, otro entorno)? Solo si el cliente quiere decirlo.

## Lo que nos falta por rellenar (sin necesidad del cliente)

Datos que se obtienen del robot, de Moodle o del equipo:

- [ ] Mapa de **índices de articulaciones** (imagen en la documentación).
- [ ] **Significado** de cada skill (`khi`, `kbf`, `kbk`, …) y comprobar cuáles existen en nuestro robot.
- [ ] **Duración medida** de los skills que usemos (`kwkL`, `kwkR`, `kup`, `ksit`…).
- [ ] **Baudios**, formato de respuesta y pasos de **emparejamiento Bluetooth** (Moodle).
- [ ] Lista de las unas **40 órdenes** del módulo de voz de Petoi (imagen y hoja enlazada).
- [ ] Comprobar si el **zumbador** funciona (`b`).
- [ ] Decidir las **dos órdenes válidas** (ver [`opciones-ordenes-de-voz.md`](opciones-ordenes-de-voz.md)).
- [ ] Redactar **escenarios**, **necesidades**, **requisitos** y **trazabilidad** (los hace el equipo, no la IA).
- [ ] Elegir la **alternativa de reconocimiento de voz**.
- [ ] Definir la **arquitectura** mínima (voz, mapeo, enlace Bluetooth).
- [ ] Definir el **método de verificación** de cada requisito, con y sin robot.
- [ ] Rellenar la **plantilla de Moodle** o la nuestra ([`plantilla-H1.md`](plantilla-H1.md)).
