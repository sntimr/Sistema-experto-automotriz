/*================================================================================
 * INSTITUTO POLITÉCNICO NACIONAL
 * ESCUELA SUPERIOR DE CÓMPUTO (ESCOM)
 * DEPARTAMENTO DE INGENIERÍA EN SISTEMAS COMPUTACIONALES
 *
 * TÍTULO:
 *   AutoCheck-Prolog — Sistema Experto de Pre-Diagnóstico Automotriz mediante
 *   Sensaciones de Conducción e Inspección Física (Sin Escáner OBD-II).
 *
 * DESCRIPCIÓN:
 *   Base de conocimientos (hechos axiomáticos) y motor de inferencia híbrido
 *   (Vía 1: Reglas lógicas deductivas exactas mediante resolución SLD;
 *    Vía 2: Motor recursivo de ponderación matemática acumulativa por sistema
 *    mecánico mediante retroceso cronológico / Backtracking).
 *   Permite diagnosticar fallas mecánicas en 7 subsistemas automotrices a partir
 *   de síntomas estáticos (observacion/3) y dinámicos (sensacion/3), evaluando
 *   el nivel de riesgo vial y emitiendo recomendaciones técnicas paso a paso.
 *
 * UNIDAD DE APRENDIZAJE:
 *   Paradigmas de Programación (1er Parcial - Práctica Integradora)
 *   Estándar de Documentación:
 *   - Normativa de Cabeceras, Especificación Formal (Recibe / Devuelve /
 *     Observaciones) y Análisis de Complejidad: Prof. Edgardo Adrián Franco Martínez.
 *   - Normativa de Semántica Declarativa vs. Operacional, Resolución SLD,
 *     Unificación de Robinson y Modelo de Cajas de Byrd (Call, Exit, Redo, Fail):
 *     Prof.ª Úrsula Samantha Morales Rodríguez / Academia de Programación Lógica.
 *
 * AUTOR:
 * Martinez Ramirez Santiago  
 * Ortega Prieto Emilio Ramon
 *
 * FECHA:
 *   24 de octubre de 2026
 *
 * VERSIÓN:
 *   4.0 (Refactorización de Vía 2 por ponderación matemática pura con asociación
 *        primaria de sistema mecánico mediante menu_falla/5, compatible con SWISH).
 *
 * OBSERVACIONES:
 *   1. Se omite intencionalmente la directiva ':- encoding(utf8).' para garantizar
 *      compatibilidad total con el entorno web SWISH (Pengines), el cual restringe
 *      la modificación de flujos de entrada/salida (set_stream/2).
 *   2. La Base de Hechos respeta íntegramente los identificadores atómicos
 *      conectados al Frontend Web: sistema_carro/3, observacion/3, sensacion/3,
 *      pertenece_sistema/2, menu_falla/5 (con alias falla/5) y evidencia/4.
 *   3. En la Vía 2 (diagnosticar_por_evidencia/6), el motor identifica primero el
 *      sistema mecánico al que pertenece la falla mediante menu_falla/5 y evalúa
 *      recursivamente la suma aritmética de ponderaciones (PuntosTotales) usando
 *      el operador 'is/2', prescindiendo de cualquier bifurcación sobre el tipo
 *      de evidencia (primaria/secundaria).
 *
 * EJECUCIÓN / CONSULTA EN SWI-PROLOG O SWISH:
 *   1. Cargar archivo: ?- [autocheck_prolog_documentado].
 *   2. Consulta de diagnóstico completo (Vía 1):
 *      diagnosticar_vehiculo([humo_blanco, anticongelante_lechoso], Falla, Sistema, Riesgo, Explicacion, Recomendacion).
 *   3. Consulta de diagnóstico ponderado por evidencia (Vía 2):
 *      diagnosticar_vehiculo([jaloneo_al_acelerar, perdida_potencia_subida], Falla, Sistema, Riesgo, Explicacion, Recomendacion).
 *================================================================================*/


/*================================================================================
 * SECCIÓN 1: BASE DE CONOCIMIENTOS — HECHOS AXIOMÁTICOS DE DOMINIO
 *--------------------------------------------------------------------------------
 * Fundamento Teórico (Paradigma Lógico):
 *   En la Lógica de Primer Orden (Cláusulas de Horn), los hechos constituyen
 *   cláusulas definidas sin cuerpo (Cabeza :- true.) que representan conocimiento
 *   declarativo incondicionalmente verdadero dentro del universo de discurso.
 *   En la Máquina Abstracta de Warren (WAM), estos axiomas se indexan por su
 *   primer argumento (First-Argument Indexing), permitiendo búsquedas en O(1)
 *   amortizado cuando el identificador se encuentra instanciado.
 *================================================================================*/

/*--------------------------------------------------------------------------------
 * 1.1 Subsistemas Mecánicos del Vehículo
 * Predicado: sistema_carro(?IdSistema, ?NombreSistema, ?Descripcion)
 * Aridad:    3 (7 axiomas)
 * Descripción:
 *   Define el catálogo de subsistemas mecánicos, hidráulicos y eléctricos que
 *   integran el automóvil. Actúa como llave foránea relacional para agrupar
 *   síntomas (pertenece_sistema/2) y fallas (menu_falla/5).
 * Argumentos:
 *   - IdSistema     (Átomo):  Identificador único del sistema (llave primaria).
 *   - NombreSistema (Átomo):  Nombre técnico formal para visualización en UI.
 *   - Descripcion   (Átomo):  Función física y operativa del subsistema.
 *--------------------------------------------------------------------------------*/
sistema_carro(enfriamiento, 'Sistema de Enfriamiento y Sellado de Culata', 'Regula la temperatura del motor y evita la mezcla de refrigerante con aceite o combustión.').
sistema_carro(lubricacion, 'Sistema de Lubricación Interna del Motor', 'Mantiene la película de aceite entre pistones, anillos, válvulas y cigüeñal.').
sistema_carro(alimentacion_combustible, 'Sistema de Inyección y Mezcla de Combustible', 'Dosifica la cantidad de gasolina y aire hacia la cámara de combustión.').
sistema_carro(encendido_electrico, 'Sistema de Encendido, Carga y Arranque Eléctrico', 'Proporciona la chispa en bujías y mantiene la carga de batería.').
sistema_carro(frenos, 'Sistema de Frenado Hidráulico y Fricción', 'Transforma la presión del pedal en fuerza de detención mediante líquido, discos y balatas.').
sistema_carro(direccion_suspension, 'Sistema de Dirección, Suspensión y Rodamiento', 'Absorbe irregularidades del camino y mantiene la estabilidad y trayectoria del vehículo.').
sistema_carro(transmision_embrague, 'Sistema de Transmisión y Embrague Clutch', 'Transfiere el par del motor hacia las ruedas a través de la caja de velocidades.').


/*--------------------------------------------------------------------------------
 * 1.2 Síntomas Estáticos de Inspección Física y Visual (Sin Escáner OBD-II)
 * Predicado: observacion(?IdSintoma, ?CategoriaInspeccion, ?DetalleObservacion)
 * Aridad:    3 (25 axiomas)
 * Descripción:
 *   Modela la evidencia empírica observable con el vehículo detenido y sin
 *   herramientas de diagnóstico electrónico: coloración de gases de escape,
 *   comportamiento en ralentí, testigos del tablero, niveles de fluidos y olores.
 * Argumentos:
 *   - IdSintoma           (Átomo): Identificador formal del síntoma estático.
 *   - CategoriaInspeccion (Átomo): Zona de inspección (humo_escape,
 *                                  comportamiento_motor, testigos_tablero,
 *                                  niveles_liquidos, olores_fugas).
 *   - DetalleObservacion  (Átomo): Descripción fenomenológica para el usuario.
 *--------------------------------------------------------------------------------*/
observacion(humo_blanco, humo_escape, 'Sale humo blanco denso y continuo por el escape incluso con el motor ya caliente').
observacion(humo_azul, humo_escape, 'Sale humo con tono azulado o gris-azulado por el tubo de escape al arrancar o acelerar').
observacion(humo_negro, humo_escape, 'Sale humo negro oscuro tipo hollín por el escape al acelerar').
observacion(motor_tiembla, comportamiento_motor, 'El motor tiembla o sacude fuertemente la cabina cuando está detenido en neutral/parking').
observacion(rpm_inestables, comportamiento_motor, 'La aguja de revoluciones sube y baja sola en ralentí o el motor amenaza con apagarse').
observacion(marcha_lenta, comportamiento_motor, 'Al girar la llave el motor da marcha lento o requiere varios intentos para encender').
observacion(no_da_marcha, comportamiento_motor, 'Al girar la llave solo se escucha un chasquido o click y el motor no gira').
observacion(cascabeleo_metalico, comportamiento_motor, 'Se escucha un golpeteo o traqueteo metálico constante dentro del motor').
observacion(check_engine, testigos_tablero, 'Testigo Check Engine (motor amarillo) encendido o parpadeando en el tablero').
observacion(temperatura_alta, testigos_tablero, 'Testigo rojo de temperatura encendido o aguja en la zona roja (sobrecalentamiento)').
observacion(presion_aceite, testigos_tablero, 'Testigo rojo de la aceitera (baja presión de aceite) encendido en el tablero').
observacion(testigo_bateria, testigos_tablero, 'Testigo rojo con ícono de batería encendido mientras el motor estÃ¡ en marcha').
observacion(frenos_abs, testigos_tablero, 'Testigo rojo de sistema de frenos (!) o ABS encendido en el tablero').
observacion(luces_tenues, testigos_tablero, 'Las luces del tablero y los faros se ven débiles o parpadean al encender accesorios').
observacion(anticongelante_bajo, niveles_liquidos, 'El nivel del depósito de anticongelante/refrigerante disminuye constantemente').
observacion(anticongelante_lechoso, niveles_liquidos, 'El anticongelante o la bayoneta de aceite presentan una espuma café/blanca de aspecto lechoso').
observacion(nivel_aceite_bajo, niveles_liquidos, 'La bayoneta marca nivel de aceite de motor por debajo del mínimo').
observacion(liquido_frenos_bajo, niveles_liquidos, 'El depósito de líquido de frenos está por debajo del nivel mínimo').
observacion(liquido_direccion_bajo, niveles_liquidos, 'El depósito de líquido de dirección hidráulica está bajo').
observacion(olor_gasolina_cruda, olores_fugas, 'Se percibe olor fuerte a gasolina sin quemar cerca del escape o en la cabina').
observacion(olor_dulce_vapor, olores_fugas, 'Huele a jarabe dulce caliente o sale vapor del cofre').
observacion(olor_pasta_quemada, olores_fugas, 'Huele a pasta o embrague quemado después de subir pendientes o hacer cambios').
observacion(olor_aceite_quemado, olores_fugas, 'Huele a aceite caliente quemado proveniente del motor o escape').
observacion(desgaste_llantas, olores_fugas, 'Las llantas delanteras muestran desgaste liso de un solo borde (interno o externo)').
observacion(bornes_bateria_sulfatados, olores_fugas, 'Las terminales de la batería tienen polvo blanco/verdoso (sulfatación) o están flojas').


/*--------------------------------------------------------------------------------
 * 1.3 Síntomas Dinámicos de Sensación de Conducción
 * Predicado: sensacion(?IdSintoma, ?CategoriaConduccion, ?DetalleSensacion)
 * Aridad:    3 (18 axiomas)
 * Descripción:
 *   Modela las anomalías kinestésicas, acústicas y mecánicas percibidas por el
 *   conductor con el vehículo en movimiento bajo distintos regímenes de carga.
 * Argumentos:
 *   - IdSintoma           (Átomo): Identificador formal del síntoma dinámico.
 *   - CategoriaConduccion (Átomo): Momento operativo (al_acelerar, al_frenar,
 *                                  en_direccion, en_baches_curvas, en_cambios).
 *   - DetalleSensacion    (Átomo): Descripción clara de la sensación física.
 *--------------------------------------------------------------------------------*/
sensacion(jaloneo_al_acelerar, al_acelerar, 'El vehículo da tirones o se jalonea al pisar el acelerador').
sensacion(perdida_potencia_subida, al_acelerar, 'El auto pierde fuerza notablemente en subidas o al intentar rebasar').
sensacion(motor_revoluciona_no_avanza, al_acelerar, 'El motor sube de revoluciones (hace más ruido) pero el auto no gana velocidad proporcionalmente').
sensacion(respuesta_lenta_acelerador, al_acelerar, 'Hay un retraso o ahogamiento desde que se pisa el acelerador hasta que el auto responde').
sensacion(freno_pedal_esponjoso, al_frenar, 'El pedal de freno se siente blando, esponjoso o se hunde casi hasta el fondo').
sensacion(freno_pedal_duro, al_frenar, 'El pedal de freno está excesivamente duro y requiere mucha fuerza para detener el auto').
sensacion(vibracion_al_frenar, al_frenar, 'El volante o el pedal de freno vibran fuertemente al frenar a velocidad media o alta').
sensacion(jaloneo_al_frenar, al_frenar, 'El vehículo se desvía o jala bruscamente hacia un lado cuando se frena').
sensacion(chillido_al_frenar, al_frenar, 'Se escucha un rechinido o chillido metálico agudo cada vez que se pisa el freno').
sensacion(volante_duro, en_direccion, 'El volante se siente muy pesado o duro al girar a baja velocidad').
sensacion(desvio_en_recta, en_direccion, 'En calle plana el auto tiende a irse solo hacia la izquierda o derecha si sueltas un poco el volante').
sensacion(vibracion_alta_velocidad, en_direccion, 'El volante vibra de forma constante al superar los 80-90 km/h aunque no se frene').
sensacion(golpeteo_baches, en_baches_curvas, 'Se siente y escucha un golpe seco (clonk) debajo del auto al pasar topes o baches').
sensacion(rebote_inestable, en_baches_curvas, 'El carro se siente inestable y sigue rebotando varias veces después de pasar un tope').
sensacion(zumbido_constante, en_baches_curvas, 'Se percibe un zumbido o ronquido en las ruedas que crece conforme aumenta la velocidad').
sensacion(velocidad_raspa, en_cambios, 'Las velocidades entran duras o raspan al hacer el cambio').
sensacion(golpe_en_cambio, en_cambios, 'Se siente un golpe o pateo brusco cuando la transmisión cambia de marcha').
sensacion(pedal_clutch_sin_presion, en_cambios, 'El pedal del clutch se queda abajo o corta muy pegado al piso').


/*--------------------------------------------------------------------------------
 * 1.4 Relación Topológica Síntoma-Sistema
 * Predicado: pertenece_sistema(?IdSintoma, ?IdSistema)
 * Aridad:    2 (43 axiomas)
 * Descripción:
 *   Establece la correspondencia taxonómica primaria entre cada uno de los 43
 *   síntomas (25 estáticos + 18 dinámicos) y su subsistema automotriz principal.
 *--------------------------------------------------------------------------------*/
pertenece_sistema(humo_blanco, enfriamiento).
pertenece_sistema(temperatura_alta, enfriamiento).
pertenece_sistema(anticongelante_bajo, enfriamiento).
pertenece_sistema(anticongelante_lechoso, enfriamiento).
pertenece_sistema(olor_dulce_vapor, enfriamiento).
pertenece_sistema(humo_azul, lubricacion).
pertenece_sistema(cascabeleo_metalico, lubricacion).
pertenece_sistema(presion_aceite, lubricacion).
pertenece_sistema(nivel_aceite_bajo, lubricacion).
pertenece_sistema(olor_aceite_quemado, lubricacion).
pertenece_sistema(humo_negro, alimentacion_combustible).
pertenece_sistema(rpm_inestables, alimentacion_combustible).
pertenece_sistema(olor_gasolina_cruda, alimentacion_combustible).
pertenece_sistema(jaloneo_al_acelerar, alimentacion_combustible).
pertenece_sistema(perdida_potencia_subida, alimentacion_combustible).
pertenece_sistema(respuesta_lenta_acelerador, alimentacion_combustible).
pertenece_sistema(motor_tiembla, encendido_electrico).
pertenece_sistema(marcha_lenta, encendido_electrico).
pertenece_sistema(no_da_marcha, encendido_electrico).
pertenece_sistema(check_engine, encendido_electrico).
pertenece_sistema(testigo_bateria, encendido_electrico).
pertenece_sistema(luces_tenues, encendido_electrico).
pertenece_sistema(bornes_bateria_sulfatados, encendido_electrico).
pertenece_sistema(frenos_abs, frenos).
pertenece_sistema(liquido_frenos_bajo, frenos).
pertenece_sistema(freno_pedal_esponjoso, frenos).
pertenece_sistema(freno_pedal_duro, frenos).
pertenece_sistema(vibracion_al_frenar, frenos).
pertenece_sistema(jaloneo_al_frenar, frenos).
pertenece_sistema(chillido_al_frenar, frenos).
pertenece_sistema(liquido_direccion_bajo, direccion_suspension).
pertenece_sistema(desgaste_llantas, direccion_suspension).
pertenece_sistema(volante_duro, direccion_suspension).
pertenece_sistema(desvio_en_recta, direccion_suspension).
pertenece_sistema(vibracion_alta_velocidad, direccion_suspension).
pertenece_sistema(golpeteo_baches, direccion_suspension).
pertenece_sistema(rebote_inestable, direccion_suspension).
pertenece_sistema(zumbido_constante, direccion_suspension).
pertenece_sistema(olor_pasta_quemada, transmision_embrague).
pertenece_sistema(motor_revoluciona_no_avanza, transmision_embrague).
pertenece_sistema(velocidad_raspa, transmision_embrague).
pertenece_sistema(golpe_en_cambio, transmision_embrague).
pertenece_sistema(pedal_clutch_sin_presion, transmision_embrague).


/*--------------------------------------------------------------------------------
 * 1.5 Catálogo Maestro de Fallas Diagnosticables y Recomendaciones Técnicas
 * Predicado: menu_falla(?IdFalla, ?IdSistema, ?DetalleFalla, ?RiesgoBase, ?Recomendacion)
 * Alias:     falla/5 (se incluye cláusula puente para compatibilidad retroactiva)
 * Aridad:    5 (15 axiomas)
 * Descripción:
 *   Almacena las 15 conclusiones diagnósticas del sistema experto. Vincula cada
 *   avería con su sistema mecánico (IdSistema), su descripción técnica, su nivel
 *   de criticidad intrínseco (critico, moderado, leve) y una estructura de datos
 *   tipo lista propia de Prolog con los 4 pasos secuenciales de solución.
 *--------------------------------------------------------------------------------*/
menu_falla(empaque_culata_danado, enfriamiento,
    'Falla en Empaque de Cabeza (Culata) / Paso de Refrigerante a Combustión',
    critico,
    [
        '1. DETENER EL VEHÍCULO: No continúe conduciendo para evitar que la cabeza del motor se tuerza o se desbiele.',
        '2. Con el motor completamente FRÍO, verificar si hay mezcla lechosa en el tapón de aceite o burbujeo en el radiador.',
        '3. Realizar prueba de compresión de cilindros y prueba química de fugas de CO2 en el sistema de enfriamiento.',
        '4. Rectificar la planicidad de la cabeza del motor, reemplazar el empaque de culata y cambiar aceite y anticongelante.'
    ]).

menu_falla(termostato_bomba_agua, enfriamiento,
    'Sobrecalentamiento por Termostato Pegado, Fuga o Bomba de Agua Deficiente',
    critico,
    [
        '1. Apagar el motor de inmediato y esperar al menos 40 minutos antes de abrir el depósito de anticongelante.',
        '2. Inspeccionar mangueras del radiador (si una está muy caliente y otra fría, el termostato está cerrado/pegado).',
        '3. Verificar que el motoventilador encienda automáticamente y buscar fugas en radiador o bomba de agua.',
        '4. Reemplazar el termostato, purgar el aire del sistema de enfriamiento y rellenar con anticongelante adecuado.'
    ]).

menu_falla(desgaste_anillos_valvulas, lubricacion,
    'Quema de Aceite Interna por Desgaste de Sellos de Válvulas o Anillos de Pistón',
    moderado,
    [
        '1. Revisar y rellenar el nivel de aceite del motor para evitar quedarse sin lubricación.',
        '2. Observar cuándo sale el humo azul: si es solo al arrancar en frío apunta a sellos de válvulas; si es continuo al acelerar apunta a anillos.',
        '3. Verificar el estado de la válvula PCV (ventilación positiva del cárter), ya que si se obstruye pasa aceite a la admisión.',
        '4. Realizar prueba de compresión en seco y con aceite en los cilindros para programar cambio de sellos o anillado.'
    ]).

menu_falla(baja_presion_lubricacion, lubricacion,
    'Falla Crítica de Presión de Aceite (Bomba de Aceite o Coladera Obstruida)',
    critico,
    [
        '1. APAGAR EL MOTOR INMEDIATAMENTE: Circular con el testigo de aceite y ruido metálico fundirá los metales del motor en minutos.',
        '2. Revisar el nivel de aceite con la bayoneta en una superficie plana y buscar fugas masivas en el cárter o filtro.',
        '3. Si el nivel de aceite es correcto, medir la presión real con manómetro mecánico en el bulbo de aceite.',
        '4. Limpiar el cedazo (coladera) del cárter o reemplazar la bomba de aceite y el filtro.'
    ]).

menu_falla(mezcla_rica_combustible, alimentacion_combustible,
    'Mezcla Rica de Combustible (Exceso de Gasolina por Inyectores Abiertos o Sensor MAF/O2)',
    moderado,
    [
        '1. Inspeccionar y reemplazar el filtro de aire si se encuentra saturado de polvo (resta oxígeno a la mezcla).',
        '2. Revisar si algún inyector está goteando o quedando abierto mediante laboratorio de inyectores.',
        '3. Limpiar el sensor MAF/MAP y verificar el regulador de presión de gasolina.',
        '4. Limpiar las bujías hollinadas y revisar el estado del sensor de oxígeno primario.'
    ]).

menu_falla(falla_encendido_cilindros, encendido_electrico,
    'Falla de Encendido en Cilindro (Misfire por Bujías, Cables o Bobina Dañada)',
    moderado,
    [
        '1. Evitar acelerar a fondo porque la gasolina no quemada en el cilindro muerto puede dañar el convertidor catalítico.',
        '2. Retirar e inspeccionar las bujías buscando electrodos desgastados, porcelana fisurada o exceso de carbonilla.',
        '3. Verificar si los cables de bujía o capuchones de bobina tienen fugas de corriente (arqueo eléctrico).',
        '4. Reemplazar el juego de bujías calibradas según especificación o sustituir la bobina del cilindro que no trabaja.'
    ]).

menu_falla(baja_presion_combustible, alimentacion_combustible,
    'Baja Presión de Gasolina (Filtro de Combustible Obstruido o Bomba Débil)',
    moderado,
    [
        '1. Escuchar al poner el switch en ON (sin dar marcha) si zumba la bomba de gasolina durante 2-3 segundos.',
        '2. Reemplazar el filtro de gasolina externo si no se ha cambiado en los últimos 20,000 km.',
        '3. Medir la presión y caudal en el riel de inyectores (si cae al acelerar, el repuesto de la bomba está perdiendo fuerza).',
        '4. Limpiar el cuerpo de aceleración y verificar el relevador (relay) de la bomba de combustible.'
    ]).

menu_falla(falla_alternador, encendido_electrico,
    'Falla del Alternador o Banda de Accesorios (El Vehículo No Está Cargando la Batería)',
    critico,
    [
        '1. Apagar aire acondicionado, luces no esenciales y radio para conservar la reserva de la batería y llegar a un lugar seguro.',
        '2. Inspeccionar visualmente que la banda de accesorios no esté rota o floja en la polea del alternador.',
        '3. Medir con multímetro el voltaje en batería con el motor encendido (debe estar entre 13.8V y 14.4V; si es menor a 12.5V no carga).',
        '4. Reparar el regulador de voltaje/carbón del alternador o reemplazar el alternador.'
    ]).

menu_falla(bateria_descargada_bornes, encendido_electrico,
    'Batería Descargada, Fin de Vida Útil o Falso Contacto en Terminales Sulfatadas',
    leve,
    [
        '1. Con el motor apagado, limpiar el polvo blanco/verdoso de los bornes usando agua tibia con bicarbonato y un cepillo.',
        '2. Apretar firmemente las terminales positiva y negativa asegurando que no giren con la mano.',
        '3. Si el auto arranca pasando corriente y carga bien (>13.8V) pero al día siguiente vuelve a fallar, la batería ya no retiene carga.',
        '4. Reemplazar el acumulador (batería) por uno del amperaje de arranque en frío (CCA) recomendado.'
    ]).

menu_falla(fuga_frenos_hidraulicos, frenos,
    'Fuga Hidráulica, Aire en las Líneas o Falla de Bomba Principal de Frenos (Cilindro Maestro)',
    critico,
    [
        '1. PELIGRO VIAL: No conduzca en carretera ni a velocidad; bombee el pedal varias veces si necesita detenerse de emergencia.',
        '2. Revisar el nivel de líquido de frenos DOT3/DOT4 e inspeccionar la cara interna de las 4 ruedas buscando manchas húmedas de líquido.',
        '3. Si hay fuga en manguera, cáliper o cilindro de rueda trasero, reparar la pieza y rellenar líquido nuevo.',
        '4. Purgar el aire de las 4 líneas de freno; si el pedal sigue yéndose al fondo sin fugas externas, reemplazar el cilindro maestro.'
    ]).

menu_falla(discos_deformados_balatas, frenos,
    'Discos de Freno Alabeados (Deformados por Calor) y/o Balatas Desgastadas',
    moderado,
    [
        '1. Desmontar las ruedas delanteras para medir el espesor restante de la pasta de las balatas (cambiar si es menor a 3 mm).',
        '2. Inspeccionar la superficie de los discos de freno buscando surcos profundos o cristalización.',
        '3. Rectificar los discos en torno (si están dentro del grosor mínimo de seguridad) o instalar discos nuevos para eliminar la vibración al volante.',
        '4. Engrasar los pernos guía de los cálipers para evitar que frenen disparejo.'
    ]).

menu_falla(desgaste_suspension, direccion_suspension,
    'Desgaste en Amortiguadores, Rótulas, Terminales de Dirección o Bujes de Horquilla',
    moderado,
    [
        '1. Empujar una esquina del auto hacia abajo y soltar: si rebota más de 1.5 veces o el amortiguador está manchado de aceite, está vencido.',
        '2. Levantar el vehículo de forma segura y mover la llanta a las 12 y 6 horas (verifica rótulas/balero) y a las 3 y 9 horas (verifica terminales).',
        '3. Reemplazar los amortiguadores por par (ambos delanteros o ambos traseros) y cambiar los bujes o rótulas con juego.',
        '4. Realizar alineación después de cambiar componentes de suspensión.'
    ]).

menu_falla(desbalanceo_desalineacion, direccion_suspension,
    'Falta de Alineación y Balanceo de Ruedas o Presión Incorrecta de Neumáticos',
    leve,
    [
        '1. Verificar en frío que las 4 llantas tengan exactamente la presión en PSI indicada en la etiqueta de la puerta del conductor.',
        '2. Revisar que los rines no tengan golpes o plomos de balanceo caídos.',
        '3. Acudir a servicio de balanceo por computadora para eliminar la vibración del volante a más de 80 km/h.',
        '4. Realizar alineación de convergencia y camber para corregir que el volante se jale de lado y evitar el desgaste irregular de llantas.'
    ]).

menu_falla(desgaste_embrague_clutch, transmision_embrague,
    'Desgaste del Disco de Embrague (Clutch Patinando) o Falta de Presión en Collarín/Caja',
    moderado,
    [
        '1. Evitar mantener el pie apoyado en el pedal del clutch mientras se conduce y no sostener el auto en subidas con el embrague.',
        '2. Revisar el nivel de líquido en el depósito del cilindro maestro del clutch (a menudo compartido con frenos) o el ajuste del chicote.',
        '3. Si al meter 3ra o 4ta velocidad y acelerar el motor sube de RPM pero el auto no acelera y huele a pasta quemada, el disco está liso.',
        '4. Reemplazar el kit de embrague completo (disco, plato opresor y collarín) y rectificar el volante motriz.'
    ]).

menu_falla(direccion_hidraulica_bomba, direccion_suspension,
    'Falla en Asistencia de Dirección Hidráulica (Bajo Nivel de Fluido, Fuga o Bomba de Dirección)',
    moderado,
    [
        '1. Verificar el nivel del depósito de líquido de dirección hidráulica y rellenar con el fluido especificado si está bajo.',
        '2. Inspeccionar mangueras de alta presión y cubrepolvos de la cremallera buscando fugas de aceite.',
        '3. Revisar que la banda de accesorios impulse correctamente la polea de la bomba de dirección sin patinar.',
        '4. Purgar el aire del sistema girando el volante de tope a tope con el frente levantado o reemplazar la bomba si continúa pesada.'
    ]).

% Cláusula puente (Alias): Garantiza compatibilidad si algún módulo invoca falla/5.
falla(IdFalla, IdSistema, Detalle, RiesgoBase, Pasos) :-
    menu_falla(IdFalla, IdSistema, Detalle, RiesgoBase, Pasos).


/*--------------------------------------------------------------------------------
 * 1.6 Matriz de Ponderación Matemática de Evidencias por Falla
 * Predicado: evidencia(?IdFalla, ?IdSintoma, ?PesoPorcentual, ?CategoriaEvidencia)
 * Aridad:    4 (63 axiomas)
 * Descripción:
 *   Asigna un peso cuantitativo (en escala de 0 a 100%, donde la suma de todos
 *   los síntomas asociados a cada falla converge exactamente a 100%) para la
 *   inferencia heurística de la Vía 2.
 * Nota de Refactorización:
 *   El cuarto argumento se conserva en los hechos para no alterar el esquema de
 *   la base de datos, pero es ignorado mediante variable anónima (_) durante el
 *   cálculo matemático en diagnosticar_por_evidencia/6.
 *--------------------------------------------------------------------------------*/
evidencia(empaque_culata_danado, humo_blanco, 25, primaria).
evidencia(empaque_culata_danado, anticongelante_lechoso, 30, primaria).
evidencia(empaque_culata_danado, temperatura_alta, 15, secundaria).
evidencia(empaque_culata_danado, anticongelante_bajo, 10, secundaria).
evidencia(empaque_culata_danado, olor_dulce_vapor, 10, secundaria).
evidencia(empaque_culata_danado, motor_tiembla, 10, secundaria).

evidencia(termostato_bomba_agua, temperatura_alta, 35, primaria).
evidencia(termostato_bomba_agua, anticongelante_bajo, 30, primaria).
evidencia(termostato_bomba_agua, olor_dulce_vapor, 20, secundaria).
evidencia(termostato_bomba_agua, perdida_potencia_subida, 15, secundaria).

evidencia(desgaste_anillos_valvulas, humo_azul, 40, primaria).
evidencia(desgaste_anillos_valvulas, nivel_aceite_bajo, 30, primaria).
evidencia(desgaste_anillos_valvulas, olor_aceite_quemado, 15, secundaria).
evidencia(desgaste_anillos_valvulas, perdida_potencia_subida, 15, secundaria).

evidencia(baja_presion_lubricacion, presion_aceite, 40, primaria).
evidencia(baja_presion_lubricacion, cascabeleo_metalico, 35, primaria).
evidencia(baja_presion_lubricacion, nivel_aceite_bajo, 15, secundaria).
evidencia(baja_presion_lubricacion, olor_aceite_quemado, 10, secundaria).

evidencia(mezcla_rica_combustible, humo_negro, 30, primaria).
evidencia(mezcla_rica_combustible, olor_gasolina_cruda, 30, primaria).
evidencia(mezcla_rica_combustible, jaloneo_al_acelerar, 15, secundaria).
evidencia(mezcla_rica_combustible, check_engine, 15, secundaria).
evidencia(mezcla_rica_combustible, rpm_inestables, 10, secundaria).

evidencia(falla_encendido_cilindros, motor_tiembla, 25, primaria).
evidencia(falla_encendido_cilindros, jaloneo_al_acelerar, 25, primaria).
evidencia(falla_encendido_cilindros, check_engine, 20, secundaria).
evidencia(falla_encendido_cilindros, perdida_potencia_subida, 15, secundaria).
evidencia(falla_encendido_cilindros, marcha_lenta, 15, secundaria).

evidencia(baja_presion_combustible, perdida_potencia_subida, 30, primaria).
evidencia(baja_presion_combustible, respuesta_lenta_acelerador, 30, primaria).
evidencia(baja_presion_combustible, jaloneo_al_acelerar, 20, secundaria).
evidencia(baja_presion_combustible, marcha_lenta, 20, secundaria).

evidencia(falla_alternador, testigo_bateria, 40, primaria).
evidencia(falla_alternador, luces_tenues, 30, primaria).
evidencia(falla_alternador, rpm_inestables, 15, secundaria).
evidencia(falla_alternador, marcha_lenta, 15, secundaria).

evidencia(bateria_descargada_bornes, no_da_marcha, 35, primaria).
evidencia(bateria_descargada_bornes, bornes_bateria_sulfatados, 30, primaria).
evidencia(bateria_descargada_bornes, marcha_lenta, 20, secundaria).
evidencia(bateria_descargada_bornes, luces_tenues, 15, secundaria).

evidencia(fuga_frenos_hidraulicos, freno_pedal_esponjoso, 35, primaria).
evidencia(fuga_frenos_hidraulicos, liquido_frenos_bajo, 30, primaria).
evidencia(fuga_frenos_hidraulicos, frenos_abs, 20, secundaria).
evidencia(fuga_frenos_hidraulicos, jaloneo_al_frenar, 15, secundaria).

evidencia(discos_deformados_balatas, vibracion_al_frenar, 35, primaria).
evidencia(discos_deformados_balatas, chillido_al_frenar, 30, primaria).
evidencia(discos_deformados_balatas, jaloneo_al_frenar, 20, secundaria).
evidencia(discos_deformados_balatas, freno_pedal_duro, 15, secundaria).

evidencia(desgaste_suspension, golpeteo_baches, 35, primaria).
evidencia(desgaste_suspension, rebote_inestable, 30, primaria).
evidencia(desgaste_suspension, desgaste_llantas, 20, secundaria).
evidencia(desgaste_suspension, zumbido_constante, 15, secundaria).

evidencia(desbalanceo_desalineacion, vibracion_alta_velocidad, 40, primaria).
evidencia(desbalanceo_desalineacion, desvio_en_recta, 35, primaria).
evidencia(desbalanceo_desalineacion, desgaste_llantas, 25, secundaria).

evidencia(desgaste_embrague_clutch, motor_revoluciona_no_avanza, 30, primaria).
evidencia(desgaste_embrague_clutch, olor_pasta_quemada, 25, primaria).
evidencia(desgaste_embrague_clutch, velocidad_raspa, 15, secundaria).
evidencia(desgaste_embrague_clutch, pedal_clutch_sin_presion, 15, secundaria).
evidencia(desgaste_embrague_clutch, golpe_en_cambio, 15, secundaria).

evidencia(direccion_hidraulica_bomba, volante_duro, 50, primaria).
evidencia(direccion_hidraulica_bomba, liquido_direccion_bajo, 50, primaria).


/*================================================================================
 * SECCIÓN 2: PREDICADOS AUXILIARES Y MANIPULACIÓN RECURSIVA DE LISTAS
 *================================================================================*/

/*--------------------------------------------------------------------------------
 * Predicado:   pertenece(?Elemento, ?Lista)
 * Aridad:      2
 * Descripción:
 *   Verifica declarativamente (o genera mediante retroceso cronológico) la
 *   inclusión de un término lógico X dentro de una estructura de datos lineal
 *   tipo Lista propia de Prolog [Cabeza|Cola].
 * Recibe:
 *   - Elemento (?X):     Término atómico o compuesto a localizar.
 *   - Lista    (+Lista): Lista de síntomas de longitud finita n.
 * Devuelve:
 *   - true / false (o ligadura de variable libre X en modo generativo).
 * Complejidad Temporal y Espacial (Análisis de Algoritmos - Prof. Franco):
 *   - Operación Básica: Unificación sintáctica de términos en la cabeza de la
 *                       cláusula (algoritmo de unificación de Robinson).
 *   - Mejor Caso:       O(1) — El elemento X se localiza en la primera posición
 *                       (cabeza de la lista), resolviendo en el axioma base.
 *   - Peor Caso:        O(n) — El elemento se ubica al final de la lista o no
 *                       pertenece a ella, agotando las n celdas Cons hasta [].
 *   - Caso Medio:       O(n/2) = O(n) bajo distribución equiprobable.
 *   - Complejidad Espacial: O(1) en Pila Local gracias a la Optimización de
 *                       Recursión de Cola (Last Call Optimization - LCO) en WAM.
 * Semántica Operacional y Modelo de Cajas de Byrd (Prof.ª Úrsula):
 *   - Cláusula 1 (Axioma Base Inductivo): Utiliza unificación implícita de
 *     patrones (pattern matching) repitiendo la variable X en ambos argumentos.
 *     La cola se descarta con la variable anónima (_) para evitar reservar un
 *     registro innecesario en el entorno local.
 *   - Cláusula 2 (Paso Recursivo): Si el puerto Call falla en la cláusula 1
 *     (X \= Cabeza), el motor desestructura [_|Cola] e invoca recursivamente
 *     pertenece(X, Cola). Si llega a la lista vacía [], la deconstrucción
 *     [_|Cola] colapsa y se emite el puerto Fail.
 *--------------------------------------------------------------------------------*/
pertenece(X, [X|_]).
pertenece(X, [_|Cola]) :-
    pertenece(X, Cola).


/*--------------------------------------------------------------------------------
 * Predicado:   longitud_lista(+Lista, -Longitud)
 * Aridad:      2
 * Descripción:
 *   Calcula recursivamente la cardinalidad (número de elementos) de una lista.
 * Recibe:
 *   - Lista    (+Lista): Lista propia de entrada.
 * Devuelve:
 *   - Longitud (-N):     Valor escalar entero >= 0 con la cardinalidad de Lista.
 * Complejidad Temporal (Prof. Franco):
 *   - Operación Básica: Evaluación aritmética de incremento (is/2).
 *   - Mejor, Peor y Caso Medio: Theta(n), ya que invariablemente debe recorrer
 *     los n nodos hasta alcanzar el axioma terminal de lista vacía [].
 * Semántica Operacional (Prof.ª Úrsula):
 *   - Distinción '=' vs 'is/2': En Prolog, escribir 'N = N1 + 1' construiría el
 *     Árbol de Sintaxis Abstracta (AST) inerte +(N1, 1) sin activar la ALU.
 *     Por ello se emplea obligatoriamente el predicado predefinido 'is/2', que
 *     fuerza la reducción aritmética de 'N1 + 1' durante el ascenso por los
 *     puertos Exit tras tocar fondo en el axioma longitud_lista([], 0).
 *--------------------------------------------------------------------------------*/
longitud_lista([], 0).
longitud_lista([_|Cola], N) :-
    longitud_lista(Cola, N1),
    N is N1 + 1.


/*--------------------------------------------------------------------------------
 * Predicado:   sintoma_reconocido(?IdSintoma, ?TipoSintoma, ?Categoria, ?Detalle)
 * Aridad:      4
 * Descripción:
 *   Predicado polimórfico que abstrae y unifica en una sola interfaz de consulta
 *   tanto los síntomas dinámicos (sensacion/3) como los estáticos (observacion/3).
 * Recibe / Devuelve:
 *   - IdSintoma   (?Átomo): Identificador del síntoma.
 *   - TipoSintoma (?Átomo): Discriminador ('sensacion_conduccion' o 'inspeccion_fisica').
 *   - Categoria   (?Átomo): Categoría operativa o física.
 *   - Detalle     (?Átomo): Descripción textual del síntoma.
 * Complejidad Temporal: O(1) con IdSintoma instanciado por indexación de 1er argumento.
 *--------------------------------------------------------------------------------*/
sintoma_reconocido(Id, sensacion_conduccion, Categoria, Desc) :-
    sensacion(Id, Categoria, Desc).
sintoma_reconocido(Id, inspeccion_fisica, Categoria, Desc) :-
    observacion(Id, Categoria, Desc).


/*================================================================================
 * SECCIÓN 3: VÍA 1 — REGLAS LÓGICAS DE INFERENCIA DIRECTA (15 REGLAS EXACTAS)
 *================================================================================
 * Predicado:   diagnostico(+Sintomas, -IdFalla, -IdRegla, -Explicacion)
 * Aridad:      4 (15 cláusulas deductivas no triviales)
 * Descripción:
 *   Implementa el motor deductivo de certeza absoluta (Vía 1). Cada cláusula
 *   modela una firma clínica automotriz combinando síntomas estáticos y dinámicos
 *   mediante operadores de conjunción lógica (',' = AND), disyunción (';' = OR)
 *   y negación por fallo ('\+' = Negation as Failure bajo Hipótesis de Mundo Cerrado).
 * Recibe:
 *   - Sintomas    (+Lista): Lista de átomos con los síntomas reportados.
 * Devuelve:
 *   - IdFalla     (-Átomo): Identificador de la falla diagnosticada.
 *   - IdRegla     (-Átomo): Identificador de trazabilidad de la regla activada.
 *   - Explicacion (-Átomo): Justificación lógica deductiva del diagnóstico.
 * Complejidad Temporal (Prof. Franco):
 *   - Operación Básica: Búsqueda de pertenencia en lista pertenece/2.
 *   - Para una lista de usuario con k síntomas, cada regla realiza un número
 *     acotado de verificaciones pertenece/2, resultando en complejidad O(k)
 *     por regla evaluada.
 * Semántica Operacional y Control de Backtracking (Prof.ª Úrsula):
 *   - Encapsulamiento con meta-predicado once/1: Cuando una regla utiliza
 *     disyunciones lógicas (A ; B) y el usuario presenta simultáneamente ambos
 *     síntomas A y B, el árbol SLD dejaría un Punto de Elección (Choice Point)
 *     abierto que produciría la misma falla duplicada en el puerto Redo.
 *     Al envolver el cuerpo en once((...)), se poda el subárbol interno tras el
 *     primer puerto Exit exitoso de esa regla, preservando limpio el retroceso
 *     externo entre las 15 reglas distintas.
 *================================================================================*/

% Regla 01: Daño en empaque de culata (humo blanco + evidencia de contaminación o calor)
diagnostico(Sintomas, empaque_culata_danado, regla_01,
    'Se infiere daño en empaque de cabeza porque existe humo blanco espeso acompañado de anticongelante lechoso o sobrecalentamiento con pérdida de refrigerante.') :-
    once((
        pertenece(humo_blanco, Sintomas),
        (   pertenece(anticongelante_lechoso, Sintomas)
        ;   (pertenece(temperatura_alta, Sintomas), pertenece(anticongelante_bajo, Sintomas))
        )
    )).

% Regla 02: Termostato o bomba de agua (sobrecalentamiento sin contaminación de culata)
% Nota Lógica: Usa Negación por Fallo (\+) para garantizar exclusión mutua con regla_01.
diagnostico(Sintomas, termostato_bomba_agua, regla_02,
    'Se infiere falla en termostato, radiador o bomba de agua por temperatura alta y bajo nivel/vapor dulce, sin evidencia de humo blanco en el escape.') :-
    once((
        pertenece(temperatura_alta, Sintomas),
        (pertenece(anticongelante_bajo, Sintomas) ; pertenece(olor_dulce_vapor, Sintomas)),
        \+ pertenece(humo_blanco, Sintomas),
        \+ pertenece(anticongelante_lechoso, Sintomas)
    )).

% Regla 03: Desgaste de anillos de pistón o sellos de válvulas (quema de aceite)
diagnostico(Sintomas, desgaste_anillos_valvulas, regla_03,
    'Se infiere paso de aceite a la cámara de combustión (anillos o sellos de válvulas) por la presencia de humo azulado combinada con consumo de aceite u olor a aceite quemado.') :-
    once((
        pertenece(humo_azul, Sintomas),
        (pertenece(nivel_aceite_bajo, Sintomas) ; pertenece(olor_aceite_quemado, Sintomas) ; pertenece(perdida_potencia_subida, Sintomas))
    )).

% Regla 04: Baja presión de lubricación crítica (riesgo inminente de desbielado)
diagnostico(Sintomas, baja_presion_lubricacion, regla_04,
    'Se infiere falla crítica de lubricación porque se encendió el testigo de presión de aceite junto con cascabeleo/golpeteo metálico o nivel de aceite crítico.') :-
    once((
        pertenece(presion_aceite, Sintomas),
        (pertenece(cascabeleo_metalico, Sintomas) ; pertenece(nivel_aceite_bajo, Sintomas))
    )).

% Regla 05: Mezcla rica de combustible (exceso de gasolina sin quemar)
diagnostico(Sintomas, mezcla_rica_combustible, regla_05,
    'Se infiere exceso de combustible no quemado (mezcla rica por inyectores abiertos o sensor MAF/O2) debido a humo negro en el escape y olor a gasolina cruda o tirones al acelerar.') :-
    once((
        pertenece(humo_negro, Sintomas),
        (pertenece(olor_gasolina_cruda, Sintomas) ; pertenece(jaloneo_al_acelerar, Sintomas) ; pertenece(rpm_inestables, Sintomas))
    )).

% Regla 06: Falla de encendido en cilindros (Misfire en bujías o bobinas)
diagnostico(Sintomas, falla_encendido_cilindros, regla_06,
    'Se infiere falla de chispa en al menos un cilindro (bujías o bobinas) porque el motor tiembla en neutral y además se jalonea o pierde potencia al exigirle en marcha.') :-
    once((
        pertenece(motor_tiembla, Sintomas),
        (pertenece(jaloneo_al_acelerar, Sintomas) ; pertenece(check_engine, Sintomas)),
        (pertenece(perdida_potencia_subida, Sintomas) ; pertenece(marcha_lenta, Sintomas) ; pertenece(jaloneo_al_acelerar, Sintomas))
    )).

% Regla 07: Baja presión de combustible (bomba débil o filtro tapado, sin humo negro)
diagnostico(Sintomas, baja_presion_combustible, regla_07,
    'Se infiere deficiencia en el suministro de gasolina (bomba débil o filtro tapado) porque el vehículo se ahoga al pisar el acelerador y pierde fuerza en subidas sin sacar humo negro.') :-
    once((
        pertenece(perdida_potencia_subida, Sintomas),
        (pertenece(respuesta_lenta_acelerador, Sintomas) ; pertenece(jaloneo_al_acelerar, Sintomas)),
        \+ pertenece(humo_negro, Sintomas)
    )).

% Regla 08: Falla del alternador o sistema de carga eléctrica
diagnostico(Sintomas, falla_alternador, regla_08,
    'Se infiere falla en el alternador o banda de accesorios porque el testigo de batería permanece encendido en marcha acompañado de luces tenues o inestabilidad eléctrica.') :-
    once((
        pertenece(testigo_bateria, Sintomas),
        (pertenece(luces_tenues, Sintomas) ; pertenece(rpm_inestables, Sintomas) ; pertenece(marcha_lenta, Sintomas))
    )).

% Regla 09: Batería descargada o terminales sulfatadas
diagnostico(Sintomas, bateria_descargada_bornes, regla_09,
    'Se infiere batería descargada o falso contacto en bornes porque el auto no da marcha (solo hace click o gira muy lento) y presenta terminales sulfatadas o luces débiles.') :-
    once((
        (pertenece(no_da_marcha, Sintomas) ; pertenece(marcha_lenta, Sintomas)),
        (pertenece(bornes_bateria_sulfatados, Sintomas) ; pertenece(luces_tenues, Sintomas))
    )).

% Regla 10: Fuga hidráulica o aire en líneas de freno
diagnostico(Sintomas, fuga_frenos_hidraulicos, regla_10,
    'Se infiere pérdida de presión hidráulica en frenos (fuga o aire en líneas/cilindro maestro) porque el conductor siente el pedal esponjoso al fondo y hay bajo nivel de líquido o testigo activo.') :-
    once((
        pertenece(freno_pedal_esponjoso, Sintomas),
        (pertenece(liquido_frenos_bajo, Sintomas) ; pertenece(frenos_abs, Sintomas) ; pertenece(jaloneo_al_frenar, Sintomas))
    )).

% Regla 11: Discos de freno alabeados y/o balatas desgastadas
diagnostico(Sintomas, discos_deformados_balatas, regla_11,
    'Se infiere deformación de discos de freno (alabeo) o desgaste de balatas porque el volante vibra específicamente al pisar el freno y/o se escucha chillido metálico.') :-
    once((
        (pertenece(vibracion_al_frenar, Sintomas), (pertenece(chillido_al_frenar, Sintomas) ; pertenece(jaloneo_al_frenar, Sintomas)))
        ;
        (pertenece(chillido_al_frenar, Sintomas), pertenece(freno_pedal_duro, Sintomas))
    )).

% Regla 12: Desgaste en suspensión (amortiguadores, rótulas o bujes)
diagnostico(Sintomas, desgaste_suspension, regla_12,
    'Se infiere holgura en componentes de suspensión (amortiguadores vencidos, rótulas o bujes) porque al pasar topes o baches se siente un golpeteo seco y rebote excesivo.') :-
    once((
        pertenece(golpeteo_baches, Sintomas),
        (pertenece(rebote_inestable, Sintomas) ; pertenece(desgaste_llantas, Sintomas) ; pertenece(zumbido_constante, Sintomas))
    )).

% Regla 13: Desbalanceo y desalineación de neumáticos
diagnostico(Sintomas, desbalanceo_desalineacion, regla_13,
    'Se infiere desbalanceo de neumáticos y pérdida de alineación porque el volante vibra a velocidad constante (>80 km/h) y el auto tiende a desviarse en línea recta o gasta llanta de un lado.') :-
    once((
        (pertenece(vibracion_alta_velocidad, Sintomas) ; pertenece(desvio_en_recta, Sintomas)),
        (pertenece(desgaste_llantas, Sintomas) ; (pertenece(vibracion_alta_velocidad, Sintomas), pertenece(desvio_en_recta, Sintomas)))
    )).

% Regla 14: Desgaste del disco de embrague (clutch) o transmisión
diagnostico(Sintomas, desgaste_embrague_clutch, regla_14,
    'Se infiere desgaste en el disco de embrague (clutch) o sistema de transmisión porque el motor se revoluciona sin ganar velocidad o las marchas raspan con olor a pasta quemada.') :-
    once((
        (pertenece(motor_revoluciona_no_avanza, Sintomas), (pertenece(olor_pasta_quemada, Sintomas) ; pertenece(perdida_potencia_subida, Sintomas)))
        ;
        (pertenece(velocidad_raspa, Sintomas), (pertenece(pedal_clutch_sin_presion, Sintomas) ; pertenece(golpe_en_cambio, Sintomas)))
    )).

% Regla 15: Falla en asistencia de dirección hidráulica
diagnostico(Sintomas, direccion_hidraulica_bomba, regla_15,
    'Se infiere falla en el sistema de asistencia de dirección hidráulica (fuga de fluido o bomba deficiente) porque el volante se siente excesivamente pesado a baja velocidad y el nivel de líquido de dirección está bajo.') :-
    once((
        pertenece(volante_duro, Sintomas),
        pertenece(liquido_direccion_bajo, Sintomas)
    )).


/*================================================================================
 * SECCIÓN 4: VÍA 2 — MOTOR RECURSIVO DE PONDERACIÓN MATEMÁTICA (REFACTORIZADO)
 *================================================================================*/

/*--------------------------------------------------------------------------------
 * Predicado:   evaluar_evidencias_falla(+ListaEvidencias, +SintomasUsuario,
 *                                       -Coincidentes, -Faltantes, -PuntosTotales)
 * Aridad:      5
 * Descripción:
 *   Recorre recursivamente el catálogo de evidencias asociadas a una falla
 *   específica, particionando los síntomas en dos listas disjuntas (Coincidentes
 *   y Faltantes) y calculando exclusivamente la suma aritmética de los pesos
 *   porcentuales (PuntosTotales) sin evaluar el tipo de evidencia.
 * Recibe:
 *   - ListaEvidencias (+Lista): Lista de términos compuestos ev(Sintoma, Peso).
 *   - SintomasUsuario (+Lista): Lista de síntomas ingresados por el usuario.
 * Devuelve:
 *   - Coincidentes    (-Lista): Subconjunto de síntomas presentes en el vehículo.
 *   - Faltantes       (-Lista): Subconjunto de síntomas no reportados.
 *   - PuntosTotales   (-Int):   Suma matemática total de la ponderación (0..100).
 * Complejidad Temporal (Prof. Franco):
 *   - Operación Básica: Búsqueda pertenece/2 sobre SintomasUsuario (tamaño k)
 *                       y adición aritmética con is/2 por cada una de las m
 *                       evidencias de la falla.
 *   - Complejidad:      Theta(m * k), donde m <= 6 es el número de evidencias por
 *                       falla y k es el número de síntomas del usuario.
 * Semántica Operacional y Modelo de Cajas de Byrd (Prof.ª Úrsula):
 *   - Cláusula 1 (Axioma Base): Al agotarse ListaEvidencias ([]), instancia los
 *     acumuladores de listas a [] y el acumulador numérico a 0 en el puerto Exit.
 *   - Cláusula 2 (Rama de Inclusión con Corte '!'): Si Sintoma pertenece a
 *     SintomasUsuario, el operador de corte (!) compromete al motor WAM con esta
 *     cláusula (Mutua Exclusión), evitando que en un Redo posterior el mismo
 *     síntoma caiga erróneamente en la Cláusula 3 como síntoma faltante.
 *     En el retorno recursivo (Exit), 'PuntosTotales is PuntosResto + Peso'
 *     fuerza la evaluación en la ALU.
 *   - Cláusula 3 (Rama de Exclusión): Si el síntoma no fue reportado, lo inyecta
 *     en la cabeza de [Sintoma|Faltantes] mediante colas diferidas (hole in the
 *     list) y conserva intacto el puntaje PuntosTotales.
 *--------------------------------------------------------------------------------*/
evaluar_evidencias_falla([], _, [], [], 0).

evaluar_evidencias_falla([ev(Sintoma, Peso)|Resto], SintomasUsuario, [Sintoma|Coincidentes], Faltantes, PuntosTotales) :-
    pertenece(Sintoma, SintomasUsuario), !,
    evaluar_evidencias_falla(Resto, SintomasUsuario, Coincidentes, Faltantes, PuntosResto),
    PuntosTotales is PuntosResto + Peso.

evaluar_evidencias_falla([ev(Sintoma, _)|Resto], SintomasUsuario, Coincidentes, [Sintoma|Faltantes], PuntosTotales) :-
    evaluar_evidencias_falla(Resto, SintomasUsuario, Coincidentes, Faltantes, PuntosTotales).


/*--------------------------------------------------------------------------------
 * Predicado:   diagnosticar_por_evidencia(+SintomasUsuario, -IdFalla, -IdSistema,
 *                                         -Puntaje, -Coincidentes, -Faltantes)
 * Aridad:      6 (Con sobrecarga de aridad 5 para compatibilidad directa)
 * Descripción:
 *   Motor de inferencia heurística por ponderación (Vía 2 Refactorizada):
 *   1. Primero identifica la falla y el sistema mecánico al que pertenece
 *      utilizando menu_falla/5 y verificando su enlace en sistema_carro/3.
 *   2. Posteriormente recolecta todas las evidencias asociadas a dicha falla
 *      ignorando el tipo de evidencia (primaria/secundaria) mediante variable
 *      anónima (_) y calcula únicamente la suma matemática de puntos (Puntaje).
 * Recibe:
 *   - SintomasUsuario (+Lista): Lista de síntomas reportados por el conductor.
 * Devuelve:
 *   - IdFalla         (-Átomo): Identificador de la falla evaluada.
 *   - IdSistema       (-Átomo): Sistema mecánico al que pertenece la falla.
 *   - Puntaje         (-Int):   Suma total de la ponderación matemática (> 0).
 *   - Coincidentes    (-Lista): Síntomas del usuario que coincidieron con la falla.
 *   - Faltantes       (-Lista): Síntomas restantes de esa falla por verificar.
 * Complejidad Temporal (Prof. Franco):
 *   - Para F = 15 fallas en menu_falla/5, evalúa cada falla en O(m * k),
 *     arrojando una complejidad total de O(F * m * k) al explorar el espacio
 *     completo de búsqueda mediante Backtracking.
 * Semántica Operacional (Prof.ª Úrsula):
 *   - Como menu_falla/5 consta de 15 hechos sin operador de corte (!), actúa como
 *     un generador no determinista de Puntos de Elección (Choice Points). Cada
 *     vez que el usuario o el predicado findall/3 solicita una re-satisfacción
 *     en el puerto Redo, Prolog retrocede cronológicamente al siguiente hecho de
 *     menu_falla/5, identifica su sistema mecánico y calcula su puntaje.
 *--------------------------------------------------------------------------------*/
diagnosticar_por_evidencia(SintomasUsuario, IdFalla, IdSistema, Puntaje, Coincidentes, Faltantes) :-
    menu_falla(IdFalla, IdSistema, _, _, _),
    sistema_carro(IdSistema, _, _),
    findall(ev(S, P), evidencia(IdFalla, S, P, _), ListaEvidencias),
    evaluar_evidencias_falla(ListaEvidencias, SintomasUsuario, Coincidentes, Faltantes, Puntaje),
    Puntaje > 0.

% Sobrecarga de aridad 5 (Mantiene compatibilidad si se invoca sin IdSistema explícito)
diagnosticar_por_evidencia(SintomasUsuario, IdFalla, Puntaje, Coincidentes, Faltantes) :-
    diagnosticar_por_evidencia(SintomasUsuario, IdFalla, _, Puntaje, Coincidentes, Faltantes).


/*--------------------------------------------------------------------------------
 * Predicado:   formatear_posibles_causas(+ParesOrdenados, -ListaTextosCausas)
 * Aridad:      2
 * Descripción:
 *   Transforma recursivamente la lista ordenada de pares 'Puntaje-info(...)' en
 *   cadenas descriptivas legibles con su porcentaje de ponderación acumulada.
 * Recibe:
 *   - ParesOrdenados    (+Lista): Lista de pares [Puntaje-info(IdFalla, Detalle, IdSis)|...].
 * Devuelve:
 *   - ListaTextosCausas (-Lista): Lista de átomos formateados con el % de cada causa.
 * Complejidad Temporal: Theta(c), donde c es el número de causas con Puntaje > 0.
 *--------------------------------------------------------------------------------*/
formatear_posibles_causas([], []).
formatear_posibles_causas([ Puntaje-info(IdFalla, DetalleFalla, _) | Resto ], [ TextoCausa | TextosResto ]) :-
    format(atom(TextoCausa), '~w (~w) - Ponderación acumulada: ~w%', [DetalleFalla, IdFalla, Puntaje]),
    formatear_posibles_causas(Resto, TextosResto).


/*--------------------------------------------------------------------------------
 * Predicado:   calcular_causas_probables(+SintomasUsuario, -IdFallaMasProbable,
 *                                        -DetalleMasProbable, -IdSistemaMasProbable,
 *                                        -PuntajeMax, -ListaPosiblesCausas)
 * Aridad:      6
 * Descripción:
 *   Reúne todas las fallas candidatas evaluadas por diagnosticar_por_evidencia/6,
 *   las ordena de mayor a menor según su suma matemática de ponderación (Puntaje)
 *   y extrae tanto la causa más probable como el listado jerarquizado de causas.
 * Recibe:
 *   - SintomasUsuario      (+Lista): Síntomas ingresados por el usuario.
 * Devuelve:
 *   - IdFallaMasProbable   (-Átomo): Identificador de la falla con mayor puntaje.
 *   - DetalleMasProbable   (-Átomo): Nombre técnico de la falla más probable.
 *   - IdSistemaMasProbable (-Átomo): Sistema mecánico de la falla más probable.
 *   - PuntajeMax           (-Int):   Ponderación máxima alcanzada (%).
 *   - ListaPosiblesCausas  (-Lista): Lista ordenada descendentemente por puntaje.
 * Complejidad Temporal (Prof. Franco):
 *   - Recolección por backtracking (findall/3): O(F * m * k).
 *   - Ordenamiento por llaves (keysort/2 utiliza MergeSort estable sobre listas):
 *     O(c log c), donde c <= 15 es el número de causas coincidentes.
 *   - Inversión lineal (reverse/2) y formateo: O(c).
 *--------------------------------------------------------------------------------*/
calcular_causas_probables(SintomasUsuario, IdFallaMasProbable, DetalleMasProbable, IdSistemaMasProbable, PuntajeMax, ListaPosiblesCausas) :-
    findall(
        Puntaje-info(IdFalla, DetalleFalla, IdSistema),
        (
            diagnosticar_por_evidencia(SintomasUsuario, IdFalla, IdSistema, Puntaje, _, _),
            menu_falla(IdFalla, IdSistema, DetalleFalla, _, _)
        ),
        ParesPuntajeFalla
    ),
    ParesPuntajeFalla \= [],
    keysort(ParesPuntajeFalla, OrdenAscendente),
    reverse(OrdenAscendente, [ PuntajeMax-info(IdFallaMasProbable, DetalleMasProbable, IdSistemaMasProbable) | RestoCausas ]),
    formatear_posibles_causas([ PuntajeMax-info(IdFallaMasProbable, DetalleMasProbable, IdSistemaMasProbable) | RestoCausas ], ListaPosiblesCausas).


/*================================================================================
 * SECCIÓN 5: REGLAS DE EVALUACIÓN DE RIESGO Y SEGURIDAD VIAL UNIFICADA
 *================================================================================
 * Predicado:   evaluar_riesgo(+SintomasUsuario, +IdFalla, -RiesgoUnificado)
 * Aridad:      3 (3 cláusulas mutuamente excluyentes mediante corte '!')
 * Descripción:
 *   Evalúa el riesgo operativo combinando la gravedad base de la falla en
 *   menu_falla/5 con la presencia de síntomas críticos de seguridad vial en la
 *   entrada del usuario, devolviendo un único mensaje unificado de riesgo y alerta.
 * Recibe:
 *   - SintomasUsuario (+Lista): Lista de síntomas presentes en el vehículo.
 *   - IdFalla         (+Átomo): Identificador de la falla diagnosticada o más probable.
 * Devuelve:
 *   - RiesgoUnificado (-Átomo): Cadena con el nivel de riesgo y la alerta vial.
 * Semántica Operacional (Prof.ª Úrsula):
 *   - Implementa una estructura condicional escalonada mediante el operador de
 *     corte (!). Si una falla moderada viene acompañada de un síntoma crítico
 *     (como 'freno_pedal_esponjoso', 'presion_aceite' o 'temperatura_alta'),
 *     la Cláusula 1 se activa primero, escala la severidad a RIESGO CRÍTICO y
 *     ejecuta el corte (!) para impedir que el backtracking descienda a las
 *     cláusulas moderada o leve.
 *================================================================================*/
evaluar_riesgo(SintomasUsuario, IdFalla,
    'RIESGO CRÍTICO (PELIGRO INMEDIATO - DETENERSE): ¡ALERTA CRÍTICA! Detenga el vehículo en un lugar seguro y apague el motor de inmediato. Continuar conduciendo representa un riesgo grave de accidente o daño catastrófico al motor.') :-
    menu_falla(IdFalla, _, _, GravedadBase, _),
    (   GravedadBase == critico
    ;   pertenece(freno_pedal_esponjoso, SintomasUsuario)
    ;   pertenece(presion_aceite, SintomasUsuario)
    ;   pertenece(temperatura_alta, SintomasUsuario)
    ), !.

evaluar_riesgo(_, IdFalla,
    'RIESGO MODERADO (PRECAUCIÓN - ACUDIR AL TALLER): Puede trasladar el vehículo a baja velocidad únicamente hacia su domicilio o taller mecánico cercano, evitando exigirlo en subidas o autopista.') :-
    menu_falla(IdFalla, _, _, moderado, !), !.

evaluar_riesgo(_, IdFalla,
    'RIESGO MODERADO (PRECAUCIÓN - ACUDIR AL TALLER): Puede trasladar el vehículo a baja velocidad únicamente hacia su domicilio o taller mecánico cercano, evitando exigirlo en subidas o autopista.') :-
    menu_falla(IdFalla, _, _, moderado, _), !.

evaluar_riesgo(_, IdFalla,
    'RIESGO LEVE (MANTENIMIENTO PROGRAMADO): El vehículo puede operar con precaución, pero se recomienda programar la revisión preventiva a la brevedad para evitar desgaste mayor.') :-
    menu_falla(IdFalla, _, _, leve, _).


/*================================================================================
 * SECCIÓN 6: PREDICADO MAESTRO DE DIAGNÓSTICO INTEGRAL (PUNTO DE ENTRADA)
 *================================================================================
 * Predicado:   diagnosticar_vehiculo(+Sintomas, -DiagnosticoFalla, -NombreSistema,
 *                                    -Riesgo, -Explicacion, -Recomendacion)
 * Aridad:      6
 * Descripción:
 *   Punto de entrada maestro del Sistema Experto AutoCheck-Prolog para consola
 *   y Frontend Web. Orquesta la arquitectura de doble vía de inferencia:
 *   - VÍA 1 (Diagnóstico Completo): Si los síntomas satisfacen una regla exacta
 *     en diagnostico/4, unifica el detalle exacto de la falla, el nombre del
 *     sistema mecánico, el riesgo unificado, la explicación deductiva y los
 *     4 pasos de recomendación de menu_falla/5.
 *   - VÍA 2 (Diagnóstico Probable por Ponderación Matemática): Si ninguna regla
 *     exacta se cumple, activa calcular_causas_probables/6 (basado en
 *     diagnosticar_por_evidencia/6), devolviendo en DiagnosticoFalla la lista de
 *     posibles causas con su ponderación (%), el sistema más probable, el riesgo
 *     asociado, la explicación matemática y la recomendación de análisis
 *     mecánico profundo y profesional.
 * Recibe:
 *   - Sintomas         (+Lista): Lista no vacía de átomos de síntomas.
 * Devuelve:
 *   - DiagnosticoFalla (-Átomo/Lista): Detalle de la falla (Vía 1) o lista de
 *                                      posibles causas con su % (Vía 2).
 *   - NombreSistema    (-Átomo):       Nombre del sistema mecánico donde ocurrió.
 *   - Riesgo           (-Átomo):       Nivel de riesgo y alerta de seguridad unificados.
 *   - Explicacion      (-Átomo):       Justificación lógica o matemática del resultado.
 *   - Recomendacion    (-Lista):       Pasos técnicos de solución o análisis profesional.
 *================================================================================*/
diagnosticar_vehiculo(Sintomas, DiagnosticoFalla, NombreSistema, Riesgo, Explicacion, Recomendacion) :-
    Sintomas \= [],
    (   % VÍA 1: Diagnóstico Completo mediante Regla Lógica Exacta
        diagnostico(Sintomas, IdFalla, _, Explicacion), !,
        menu_falla(IdFalla, IdSistema, DiagnosticoFalla, _, Recomendacion),
        sistema_carro(IdSistema, NombreSistema, _),
        evaluar_riesgo(Sintomas, IdFalla, Riesgo)
    ;   % VÍA 2: Diagnóstico Probable mediante Suma de Ponderaciones por Sistema Mecánico
        calcular_causas_probables(Sintomas, IdFallaMax, DetalleMax, IdSistemaMax, PuntajeMax, DiagnosticoFalla),
        sistema_carro(IdSistemaMax, NombreSistemaBase, _),
        format(atom(NombreSistema), 'Sistema más probable: ~w', [NombreSistemaBase]),
        evaluar_riesgo(Sintomas, IdFallaMax, Riesgo),
        format(atom(Explicacion),
            'Los síntomas ingresados no determinan un diagnóstico único definitivo. Evaluando la suma de ponderaciones por sistema mecánico, la causa más probable es "~w" con ~w% de coincidencia.',
            [DetalleMax, PuntajeMax]),
        Recomendacion = [
            '1. Se recomienda realizar un análisis mecánico más profundo y profesional en un taller especializado para confirmar cuál de las posibles causas ponderadas es el origen exacto.',
            '2. Solicite pruebas físicas específicas sobre el sistema mecánico más probable antes de reemplazar componentes.',
            '3. Verifique si se presenta algún otro síntoma estático o dinámico en el vehículo para acotar el diagnóstico.'
        ]
    ).