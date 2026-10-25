:- encoding(utf8).

% ==========================================
% 1. BASE DE HECHOS: Sistemas del Carro
% Formato: sistema_carro(IdSistema, Nombre, Descripcion).
% ==========================================
sistema_carro(enfriamiento, 'Sistema de Enfriamiento y Sellado de Culata',
    'Regula la temperatura del motor y evita la mezcla de refrigerante con aceite o combustión.').
sistema_carro(lubricacion, 'Sistema de Lubricación Interna del Motor',
    'Mantiene la película de aceite entre pistones, anillos, válvulas y cigüeñal.').
sistema_carro(alimentacion_combustible, 'Sistema de Inyección y Mezcla de Combustible',
    'Dosifica la cantidad de gasolina y aire hacia la cámara de combustión.').
sistema_carro(encendido_electrico, 'Sistema de Encendido, Carga y Arranque Eléctrico',
    'Proporciona la chispa en bujías/bobinas y mantiene la carga de batería mediante el alternador.').
sistema_carro(frenos, 'Sistema de Frenado Hidráulico y Fricción',
    'Transforma la presión del pedal en fuerza de detención mediante líquido, discos y balatas.').
sistema_carro(direccion_suspension, 'Sistema de Dirección, Suspensión y Rodamiento',
    'Absorbe irregularidades del camino y mantiene la estabilidad y trayectoria del vehículo.').
sistema_carro(transmision_embrague, 'Sistema de Transmisión y Embrague (Clutch)',
    'Transfiere el par del motor hacia las ruedas a través de la caja de velocidades.').

% ==========================================
% 2. CATEGORÍAS WEB: Clasificación para la interfaz
% Formato: categoria_opcion(IdCategoria, Grupo, Titulo, Instruccion) ""esto tambien lo investigue no sabia que se ocuapaba ya que como me dijiste para lo seleccionar instacias o opciones para simplificar el input""
% ==========================================
categoria_opcion(al_acelerar, sensacion_conduccion, 'Al pisar el acelerador',
    'Seleccione qué siente cuando pisa el acelerador o sube una pendiente:').
categoria_opcion(al_frenar, sensacion_conduccion, 'Al pisar el freno',
    'Seleccione cómo responde el pedal de freno y el vehículo al detenerse:').
categoria_opcion(en_direccion, sensacion_conduccion, 'En el volante y dirección',
    'Seleccione si percibe dureza, desvío o vibración en el volante al manejar:').
categoria_opcion(en_baches_curvas, sensacion_conduccion, 'Al pasar baches, topes o curvas',
    'Seleccione si escucha golpeteos secos, zumbidos o rebotes en el camino:').
categoria_opcion(en_cambios, sensacion_conduccion, 'Al hacer cambios o usar el clutch',
    'Seleccione cómo entran las velocidades y cómo se siente el pedal del embrague:').
categoria_opcion(humo_escape, inspeccion_fisica, 'Color del humo en el escape',
    'Seleccione si observa humo anormal saliendo por el tubo de escape:').
categoria_opcion(comportamiento_motor, inspeccion_fisica, 'Comportamiento del motor en neutral y arranque',
    'Seleccione cómo se comporta el motor al dar marcha o estando detenido en neutral:').
categoria_opcion(testigos_tablero, inspeccion_fisica, 'Testigos encendidos en el tablero',
    'Seleccione qué íconos de advertencia están encendidos en el tablero:').
categoria_opcion(niveles_liquidos, inspeccion_fisica, 'Estado y nivel de líquidos (bajo el cofre)',
    'Seleccione lo que observa al revisar visualmente los depósitos de fluidos:').
categoria_opcion(olores_fugas, inspeccion_fisica, 'Olores anormales y desgaste visual externo',
    'Seleccione si percibe algún olor específico o desgaste en llantas/batería:').

% ==========================================
% 3. SÍNTOMAS DINÁMICOS: Sensaciones al manejar
% Formato: sensacion_manejo(IdSintoma, Categoria, Descripcion).
% ==========================================
sensacion_manejo(jaloneo_al_acelerar, al_acelerar,
    'El vehículo da tirones o se jalonea al pisar el acelerador').
sensacion_manejo(perdida_potencia_subida, al_acelerar,
    'El auto pierde fuerza notablemente en subidas o al intentar rebasar').
sensacion_manejo(motor_revoluciona_no_avanza, al_acelerar,
    'El motor sube de revoluciones (hace más ruido) pero el auto no gana velocidad proporcionalmente').
sensacion_manejo(respuesta_lenta_acelerador, al_acelerar,
    'Hay un retraso o ahogamiento desde que se pisa el acelerador hasta que el auto responde').
sensacion_manejo(pedal_freno_esponjoso, al_frenar,
    'El pedal de freno se siente blando, esponjoso o se hunde casi hasta el fondo').
sensacion_manejo(pedal_freno_duro, al_frenar,
    'El pedal de freno está excesivamente duro y requiere mucha fuerza para detener el auto').
sensacion_manejo(vibracion_volante_frenar, al_frenar,
    'El volante o el pedal de freno vibran fuertemente al frenar a velocidad media o alta').
sensacion_manejo(auto_jala_lado_frenar, al_frenar,
    'El vehículo se desvía o jala bruscamente hacia un lado cuando se frena').
sensacion_manejo(chillido_metalico_frenar, al_frenar,
    'Se escucha un rechinido o chillido metálico agudo cada vez que se pisa el freno').
sensacion_manejo(volante_duro_pesado, en_direccion,
    'El volante se siente muy pesado o duro al girar a baja velocidad').
sensacion_manejo(auto_desvia_linea_recta, en_direccion,
    'En calle plana el auto tiende a irse solo hacia la izquierda o derecha si sueltas un poco el volante').
sensacion_manejo(vibracion_constante_velocidad, en_direccion,
    'El volante vibra de forma constante al superar los 80-90 km/h aunque no se frene').
sensacion_manejo(golpeteo_seco_baches, en_baches_curvas,
    'Se siente y escucha un golpe seco (clonk) debajo del auto al pasar topes o baches').
sensacion_manejo(rebote_excesivo_suspension, en_baches_curvas,
    'El carro se siente inestable y sigue rebotando varias veces después de pasar un tope').
sensacion_manejo(zumbido_aumenta_velocidad, en_baches_curvas,
    'Se percibe un zumbido o ronquido en las ruedas que crece conforme aumenta la velocidad').
sensacion_manejo(velocidad_raspa_entrar, en_cambios,
    'Las velocidades entran duras o raspan al hacer el cambio').
sensacion_manejo(golpe_brusco_cambio, en_cambios,
    'Se siente un golpe o pateo brusco cuando la transmisión cambia de marcha').
sensacion_manejo(pedal_clutch_sin_presion, en_cambios,
    'El pedal del clutch se queda abajo o corta muy pegado al piso').

% ==========================================
% 4. SÍNTOMAS ESTÁTICOS: Inspección física sin escáner OBD II
% Formato: observacion_fisica(IdSintoma, Categoria, Descripcion).
% ==========================================
observacion_fisica(humo_blanco_espeso, humo_escape,
    'Sale humo blanco denso y continuo por el escape incluso con el motor ya caliente').
observacion_fisica(humo_azul, humo_escape,
    'Sale humo con tono azulado o gris-azulado por el tubo de escape al arrancar o acelerar').
observacion_fisica(humo_negro, humo_escape,
    'Sale humo negro oscuro tipo hollín por el escape al acelerar').
observacion_fisica(motor_tiembla_ralenti, comportamiento_motor,
    'El motor tiembla o sacude fuertemente la cabina cuando está detenido en neutral/parking').
observacion_fisica(rpm_inestables, comportamiento_motor,
    'La aguja de revoluciones sube y baja sola en ralentí o el motor amenaza con apagarse').
observacion_fisica(tarda_dar_marcha, comportamiento_motor,
    'Al girar la llave el motor da marcha lento o requiere varios intentos para encender').
observacion_fisica(no_da_marcha_click, comportamiento_motor,
    'Al girar la llave solo se escucha un chasquido (click) y el motor no gira').
observacion_fisica(cascabeleo_metalico_motor, comportamiento_motor,
    'Se escucha un golpeteo o traqueteo metálico constante dentro del motor').
observacion_fisica(testigo_check_engine, testigos_tablero,
    'Testigo Check Engine (motor amarillo) encendido o parpadeando en el tablero').
observacion_fisica(testigo_temperatura_alta, testigos_tablero,
    'Testigo rojo de temperatura encendido o aguja en la zona roja (sobrecalentamiento)').
observacion_fisica(testigo_presion_aceite, testigos_tablero,
    'Testigo rojo de la aceitera (baja presión de aceite) encendido en el tablero').
observacion_fisica(testigo_bateria, testigos_tablero,
    'Testigo rojo con ícono de batería encendido mientras el motor está en marcha').
observacion_fisica(testigo_frenos_abs, testigos_tablero,
    'Testigo rojo de sistema de frenos (!) o ABS encendido en el tablero').
observacion_fisica(luces_tablero_tenues, testigos_tablero,
    'Las luces del tablero y los faros se ven débiles o parpadean al encender accesorios').
observacion_fisica(anticongelante_bajo, niveles_liquidos,
    'El nivel del depósito de anticongelante/refrigerante disminuye constantemente').
observacion_fisica(anticongelante_lechoso, niveles_liquidos,
    'El anticongelante o la bayoneta de aceite presentan una espuma café/blanca de aspecto lechoso').
observacion_fisica(nivel_aceite_bajo, niveles_liquidos,
    'La bayoneta marca nivel de aceite de motor por debajo del mínimo').
observacion_fisica(liquido_frenos_bajo, niveles_liquidos,
    'El depósito de líquido de frenos está por debajo del nivel mínimo').
observacion_fisica(liquido_direccion_bajo, niveles_liquidos,
    'El depósito de líquido de dirección hidráulica está bajo').
observacion_fisica(olor_gasolina_cruda, olores_fugas,
    'Se percibe olor fuerte a gasolina sin quemar cerca del escape o en la cabina').
observacion_fisica(olor_dulce_vapor, olores_fugas,
    'Huele a jarabe dulce caliente o sale vapor del cofre').
observacion_fisica(olor_pasta_quemada, olores_fugas,
    'Huele a pasta o embrague quemado después de subir pendientes o hacer cambios').
observacion_fisica(olor_aceite_quemado, olores_fugas,
    'Huele a aceite caliente quemado proveniente del motor o escape').
observacion_fisica(desgaste_irregular_llantas, olores_fugas,
    'Las llantas delanteras muestran desgaste liso de un solo borde (interno o externo)').
observacion_fisica(bornes_bateria_sulfatados, olores_fugas,
    'Las terminales de la batería tienen polvo blanco/verdoso (sulfatación) o están flojas').

% ==========================================
% 5. MENU DE FALLAS Y SOLUCIONES
% Formato: menu_falla(IdFalla, Sistema, Titulo, Riesgo, [Pasos]).
% ==========================================
menu_falla(empaque_culata_danado, enfriamiento,
    'Falla en Empaque de Cabeza (Culata) / Paso de Refrigerante a Combustión',
    critico,
    [
        '1. DETENER EL VEHÍCULO: No continúe conduciendo para evitar que la cabeza del motor se tuerza o se desbiele.',
        '2. Con el motor completamente FRÍO, verificar si hay mezcla lechosa en el tapón de aceite o burbujeo en el radiador.',
        '3. Realizar prueba de compresión de cilindros y prueba química de fugas de CO2 en el sistema de enfriamiento.',
        '4. Rectificar la planicidad de la cabeza del motor, reemplazar el empaque de culata y cambiar aceite y anticongelante.'
    ]).
menu_falla(termostato_bomba_agua_falla, enfriamiento,
    'Sobrecalentamiento por Termostato Pegado, Fuga o Bomba de Agua Deficiente',
    critico,
    [
        '1. Apagar el motor de inmediato y esperar al menos 40 minutos antes de abrir el depósito de anticongelante.',
        '2. Inspeccionar mangueras del radiador (si una está muy caliente y otra fría, el termostato está cerrado/pegado).',
        '3. Verificar que el motoventilador encienda automáticamente y buscar fugas en radiador o bomba de agua.',
        '4. Reemplazar el termostato, purgar el aire del sistema de enfriamiento y rellenar con anticongelante adecuado.'
    ]).
menu_falla(desgaste_anillos_sellos_valvulas, lubricacion,
    'Quema de Aceite Interna por Desgaste de Sellos de Válvulas o Anillos de Pistón',
    moderado,
    [
        '1. Revisar y rellenar el nivel de aceite del motor para evitar quedarse sin lubricación.',
        '2. Observar cuándo sale el humo azul: si es solo al arrancar en frío apunta a sellos de válvulas; si es continuo al acelerar apunta a anillos.',
        '3. Verificar el estado de la válvula PCV (ventilación positiva del cárter), ya que si se obstruye pasa aceite a la admisión.',
        '4. Realizar prueba de compresión en seco y con aceite en los cilindros para programar cambio de sellos o anillado.'
    ]).
menu_falla(baja_presion_lubricacion_critica, lubricacion,
    'Falla Crítica de Presión de Aceite (Bomba de Aceite o Coladera Obstruida)',
    critico,
    [
        '1. APAGAR EL MOTOR INMEDIATAMENTE: Circular con el testigo de aceite y ruido metálico fundirá los metales del motor en minutos.',
        '2. Revisar el nivel de aceite con la bayoneta en una superficie plana y buscar fugas masivas en el cárter o filtro.',
        '3. Si el nivel de aceite es correcto, medir la presión real con manómetro mecánico en el bulbo de aceite.',
        '4. Limpiar el cedazo (coladera) del cárter o reemplazar la bomba de aceite y el filtro.'
    ]).
menu_falla(mezcla_rica_inyectores_sensor, alimentacion_combustible,
    'Mezcla Rica de Combustible (Exceso de Gasolina por Inyectores Abiertos o Sensor MAF/O2)',
    moderado,
    [
        '1. Inspeccionar y reemplazar el filtro de aire si se encuentra saturado de polvo (resta oxígeno a la mezcla).',
        '2. Revisar si algún inyector está goteando o quedando abierto mediante laboratorio de inyectores.',
        '3. Limpiar el sensor MAF/MAP y verificar el regulador de presión de gasolina.',
        '4. Limpiar las bujías hollínadas y revisar el estado del sensor de oxígeno primario.'
    ]).
menu_falla(falla_encendido_bujias_bobinas, encendido_electrico,
    'Falla de Encendido en Cilindro (Misfire por Bujías, Cables o Bobina Dañada)',
    moderado,
    [
        '1. Evitar acelerar a fondo porque la gasolina no quemada en el cilindro muerto puede dañar el convertidor catalítico.',
        '2. Retirar e inspeccionar las bujías buscando electrodos desgastados, porcelana fisurada o exceso de carbonilla.',
        '3. Verificar si los cables de bujía o capuchones de bobina tienen fugas de corriente (arqueo eléctrico).',
        '4. Reemplazar el juego de bujías calibradas según especificación o sustituir la bobina del cilindro que no trabaja.'
    ]).
menu_falla(bomba_combustible_filtro_tapado, alimentacion_combustible,
    'Baja Presión de Gasolina (Filtro de Combustible Obstruido o Bomba Débil)',
    moderado,
    [
        '1. Escuchar al poner el switch en ON (sin dar marcha) si zumba la bomba de gasolina durante 2-3 segundos.',
        '2. Reemplazar el filtro de gasolina externo si no se ha cambiado en los últimos 20,000 km.',
        '3. Medir la presión y caudal en el riel de inyectores (si cae al acelerar, el repuesto de la bomba está perdiendo fuerza).',
        '4. Limpiar el cuerpo de aceleración y verificar el relevador (relay) de la bomba de combustible.'
    ]).
menu_falla(falla_alternador_sistema_carga, encendido_electrico,
    'Falla del Alternador o Banda de Accesorios (El Vehículo No Está Cargando la Batería)',
    critico,
    [
        '1. Apagar aire acondicionado, luces no esenciales y radio para conservar la reserva de la batería y llegar a un lugar seguro.',
        '2. Inspeccionar visualmente que la banda de accesorios no esté rota o floja en la polea del alternador.',
        '3. Medir con multímetro el voltaje en batería con el motor encendido (debe estar entre 13.8V y 14.4V; si es menor a 12.5V no carga).',
        '4. Reparar el regulador de voltaje/carbón del alternador o reemplazar el alternador.'
    ]).
menu_falla(bateria_agotada_bornes_sucios, encendido_electrico,
    'Batería Descargada, Fin de Vida Útil o Falso Contacto en Terminales Sulfatadas',
    leve,
    [
        '1. Con el motor apagado, limpiar el polvo blanco/verdoso de los bornes usando agua tibia con bicarbonato y un cepillo.',
        '2. Apretar firmemente las terminales positiva y negativa asegurando que no giren con la mano.',
        '3. Si el auto arranca pasando corriente y carga bien (>13.8V) pero al día siguiente vuelve a fallar, la batería ya no retiene carga.',
        '4. Reemplazar el acumulador (batería) por uno del amperaje de arranque en frío (CCA) recomendado.'
    ]).
menu_falla(fuga_aire_frenos_hidraulicos, frenos,
    'Fuga Hidráulica, Aire en las Líneas o Falla de Bomba Principal de Frenos (Cilindro Maestro)',
    critico,
    [
        '1. PELIGRO VIAL: No conduzca en carretera ni a velocidad; bombee el pedal varias veces si necesita detenerse de emergencia.',
        '2. Revisar el nivel de líquido de frenos DOT3/DOT4 e inspeccionar la cara interna de las 4 ruedas buscando manchas húmedas de líquido.',
        '3. Si hay fuga en manguera, cáliper o cilindro de rueda trasero, reparar la pieza y rellenar líquido nuevo.',
        '4. Purgar el aire de las 4 líneas de freno; si el pedal sigue yéndose al fondo sin fugas externas, reemplazar el cilindro maestro.'
    ]).
menu_falla(discos_alabeados_balatas_gastadas, frenos,
    'Discos de Freno Alabeados (Deformados por Calor) y/o Balatas Desgastadas',
    moderado,
    [
        '1. Desmontar las ruedas delanteras para medir el espesor restante de la pasta de las balatas (cambiar si es menor a 3 mm).',
        '2. Inspeccionar la superficie de los discos de freno buscando surcos profundos o cristalización.',
        '3. Rectificar los discos en torno (si están dentro del grosor mínimo de seguridad) o instalar discos nuevos para eliminar la vibración al volante.',
        '4. Engrasar los pernos guía de los cálipers para evitar que frenen disparejo.'
    ]).
menu_falla(desgaste_suspension_rotulas_amortiguadores, direccion_suspension,
    'Desgaste en Amortiguadores, Rótulas, Terminales de Dirección o Bujes de Horquilla',
    moderado,
    [
        '1. Empujar una esquina del auto hacia abajo y soltar: si rebota más de 1.5 veces o el amortiguador está manchado de aceite, está vencido.',
        '2. Levantar el vehículo de forma segura y mover la llanta a las 12 y 6 horas (verifica rótulas/balero) y a las 3 y 9 horas (verifica terminales).',
        '3. Reemplazar los amortiguadores por par (ambos delanteros o ambos traseros) y cambiar los bujes o rótulas con juego.',
        '4. Realizar alineación después de cambiar componentes de suspensión.'
    ]).
menu_falla(desbalanceo_desalineacion_ruedas, direccion_suspension,
    'Falta de Alineación y Balanceo de Ruedas o Presión Incorrecta de Neumáticos',
    leve,
    [
        '1. Verificar en frío que las 4 llantas tengan exactamente la presión en PSI indicada en la etiqueta de la puerta del conductor.',
        '2. Revisar que los rines no tengan golpes o plomos de balanceo caídos.',
        '3. Acudir a servicio de balanceo por computadora para eliminar la vibración del volante a más de 80 km/h.',
        '4. Realizar alineación de convergencia y camber para corregir que el volante se jale de lado y evitar el desgaste irregular de llantas.'
    ]).
menu_falla(desgaste_embrague_transmision, transmision_embrague,
    'Desgaste del Disco de Embrague (Clutch Patinando) o Falta de Presión en Collarín/Caja',
    moderado,
    [
        '1. Evitar mantener el pie apoyado en el pedal del clutch mientras se conduce y no sostener el auto en subidas con el embrague.',
        '2. Revisar el nivel de líquido en el depósito del cilindro maestro del clutch (a menudo compartido con frenos) o el ajuste del chicote.',
        '3. Si al meter 3ra o 4ta velocidad y acelerar el motor sube de RPM pero el auto no acelera y huele a pasta quemada, el disco está liso.',
        '4. Reemplazar el kit de embrague completo (disco, plato opresor y collarín) y rectificar el volante motriz.'
    ]).
menu_falla(falla_direccion_hidraulica_bomba, direccion_suspension,
    'Fuga o Baja Presión en el Sistema de Dirección Hidráulica (Bomba o Cremallera)',
    moderado,
    [
        '1. Revisar el nivel del depósito de líquido de dirección hidráulica y rellenar con el fluido especificado si está por debajo del mínimo.',
        '2. Inspeccionar mangueras de alta presión y guardapolvos de la cremallera buscando fugas de líquido rojizo/ámbar.',
        '3. Verificar la tensión y estado de la banda que mueve la bomba de dirección hidráulica.',
        '4. Purgar el aire girando el volante de tope a tope con el motor encendido o reemplazar la bomba si presenta zumbido y falta de asistencia.'
    ]).

% ==========================================
% 6. MATRIZ DE CASOS O EVIDENCIAS: Ponderación de síntomas
% Formato: evidencia_falla(IdFalla, IdSintoma, Puntos, TipoEvidencia).
% ==========================================
evidencia_falla(empaque_culata_danado, humo_blanco_espeso, 35, primaria).
evidencia_falla(empaque_culata_danado, anticongelante_lechoso, 40, primaria).
evidencia_falla(empaque_culata_danado, testigo_temperatura_alta, 20, secundaria).
evidencia_falla(empaque_culata_danado, anticongelante_bajo, 15, secundaria).
evidencia_falla(empaque_culata_danado, olor_dulce_vapor, 15, secundaria).
evidencia_falla(empaque_culata_danado, motor_tiembla_ralenti, 10, secundaria).
evidencia_falla(termostato_bomba_agua_falla, testigo_temperatura_alta, 40, primaria).
evidencia_falla(termostato_bomba_agua_falla, anticongelante_bajo, 30, primaria).
evidencia_falla(termostato_bomba_agua_falla, olor_dulce_vapor, 25, secundaria).
evidencia_falla(termostato_bomba_agua_falla, perdida_potencia_subida, 15, secundaria).
evidencia_falla(desgaste_anillos_sellos_valvulas, humo_azul, 45, primaria).
evidencia_falla(desgaste_anillos_sellos_valvulas, nivel_aceite_bajo, 30, primaria).
evidencia_falla(desgaste_anillos_sellos_valvulas, olor_aceite_quemado, 20, secundaria).
evidencia_falla(desgaste_anillos_sellos_valvulas, perdida_potencia_subida, 15, secundaria).
evidencia_falla(baja_presion_lubricacion_critica, testigo_presion_aceite, 45, primaria).
evidencia_falla(baja_presion_lubricacion_critica, cascabeleo_metalico_motor, 40, primaria).
evidencia_falla(baja_presion_lubricacion_critica, nivel_aceite_bajo, 25, secundaria).
evidencia_falla(baja_presion_lubricacion_critica, olor_aceite_quemado, 10, secundaria).
evidencia_falla(mezcla_rica_inyectores_sensor, humo_negro, 40, primaria).
evidencia_falla(mezcla_rica_inyectores_sensor, olor_gasolina_cruda, 35, primaria).
evidencia_falla(mezcla_rica_inyectores_sensor, jaloneo_al_acelerar, 20, secundaria).
evidencia_falla(mezcla_rica_inyectores_sensor, testigo_check_engine, 15, secundaria).
evidencia_falla(mezcla_rica_inyectores_sensor, rpm_inestables, 15, secundaria).
evidencia_falla(falla_encendido_bujias_bobinas, motor_tiembla_ralenti, 35, primaria).
evidencia_falla(falla_encendido_bujias_bobinas, jaloneo_al_acelerar, 35, primaria).
evidencia_falla(falla_encendido_bujias_bobinas, testigo_check_engine, 25, secundaria).
evidencia_falla(falla_encendido_bujias_bobinas, perdida_potencia_subida, 20, secundaria).
evidencia_falla(falla_encendido_bujias_bobinas, tarda_dar_marcha, 15, secundaria).
evidencia_falla(bomba_combustible_filtro_tapado, perdida_potencia_subida, 35, primaria).
evidencia_falla(bomba_combustible_filtro_tapado, respuesta_lenta_acelerador, 35, primaria).
evidencia_falla(bomba_combustible_filtro_tapado, jaloneo_al_acelerar, 25, secundaria).
evidencia_falla(bomba_combustible_filtro_tapado, tarda_dar_marcha, 20, secundaria).
evidencia_falla(falla_alternador_sistema_carga, testigo_bateria, 45, primaria).
evidencia_falla(falla_alternador_sistema_carga, luces_tablero_tenues, 35, primaria).
evidencia_falla(falla_alternador_sistema_carga, rpm_inestables, 15, secundaria).
evidencia_falla(falla_alternador_sistema_carga, tarda_dar_marcha, 15, secundaria).
evidencia_falla(bateria_agotada_bornes_sucios, no_da_marcha_click, 40, primaria).
evidencia_falla(bateria_agotada_bornes_sucios, bornes_bateria_sulfatados, 35, primaria).
evidencia_falla(bateria_agotada_bornes_sucios, tarda_dar_marcha, 25, secundaria).
evidencia_falla(bateria_agotada_bornes_sucios, luces_tablero_tenues, 20, secundaria).
evidencia_falla(fuga_aire_frenos_hidraulicos, pedal_freno_esponjoso, 45, primaria).
evidencia_falla(fuga_aire_frenos_hidraulicos, liquido_frenos_bajo, 35, primaria).
evidencia_falla(fuga_aire_frenos_hidraulicos, testigo_frenos_abs, 25, secundaria).
evidencia_falla(fuga_aire_frenos_hidraulicos, auto_jala_lado_frenar, 15, secundaria).
evidencia_falla(discos_alabeados_balatas_gastadas, vibracion_volante_frenar, 40, primaria).
evidencia_falla(discos_alabeados_balatas_gastadas, chillido_metalico_frenar, 35, primaria).
evidencia_falla(discos_alabeados_balatas_gastadas, auto_jala_lado_frenar, 20, secundaria).
evidencia_falla(discos_alabeados_balatas_gastadas, pedal_freno_duro, 15, secundaria).
evidencia_falla(desgaste_suspension_rotulas_amortiguadores, golpeteo_seco_baches, 40, primaria).
evidencia_falla(desgaste_suspension_rotulas_amortiguadores, rebote_excesivo_suspension, 35, primaria).
evidencia_falla(desgaste_suspension_rotulas_amortiguadores, desgaste_irregular_llantas, 20, secundaria).
evidencia_falla(desgaste_suspension_rotulas_amortiguadores, zumbido_aumenta_velocidad, 15, secundaria).
evidencia_falla(desbalanceo_desalineacion_ruedas, vibracion_constante_velocidad, 40, primaria).
evidencia_falla(desbalanceo_desalineacion_ruedas, auto_desvia_linea_recta, 35, primaria).
evidencia_falla(desbalanceo_desalineacion_ruedas, desgaste_irregular_llantas, 25, secundaria).
evidencia_falla(desgaste_embrague_transmision, motor_revoluciona_no_avanza, 45, primaria).
evidencia_falla(desgaste_embrague_transmision, olor_pasta_quemada, 30, primaria).
evidencia_falla(desgaste_embrague_transmision, velocidad_raspa_entrar, 25, secundaria).
evidencia_falla(desgaste_embrague_transmision, pedal_clutch_sin_presion, 25, secundaria).
evidencia_falla(desgaste_embrague_transmision, golpe_brusco_cambio, 20, secundaria).
evidencia_falla(falla_direccion_hidraulica_bomba, volante_duro_pesado, 45, primaria).
evidencia_falla(falla_direccion_hidraulica_bomba, liquido_direccion_bajo, 40, primaria).
evidencia_falla(falla_direccion_hidraulica_bomba, zumbido_aumenta_velocidad, 15, secundaria).

% ==========================================
% 7. PREDICADOS RECURSIVOS AUXILIARES AQUI ES EL MANEJO DE LISTAS
% ==========================================
% Verifica si un elemento (X) existe dentro de una lista
pertenece(X, [X|_]).
pertenece(X, [_|Cola]) :-
    pertenece(X, Cola).

% Elimina elementos duplicados de la lista de entrada
agregar_sin_duplicados([], []).
agregar_sin_duplicados([H|T], Resultado) :-
    pertenece(H, T), !,
    agregar_sin_duplicados(T, Resultado).
agregar_sin_duplicados([H|T], [H|Resultado]) :-
    agregar_sin_duplicados(T, Resultado).

% Cuenta la cantidad de elementos en una lista
longitud_lista([], 0).
longitud_lista([_|Cola], N) :-
    longitud_lista(Cola, N1),
    N is N1 + 1.

% Predicado puente: unifica sensaciones dinámicas y estáticas
sintoma_reconocido(Id, sensacion_conduccion, Momento, Desc) :-
    sensacion_manejo(Id, Momento, Desc).
sintoma_reconocido(Id, inspeccion_fisica, Zona, Desc) :-
    observacion_fisica(Id, Zona, Desc).

% ==========================================
% 8. FILTROS Y NORMALIZACIÓN WEB
% Prepara los datos que provienen de la interfaz web, no estoy muy seguro si estoy bien aqui ya que lo investigue esto
% ==========================================
opcion_seleccionable(IdOpcion, Grupo, IdCategoria, TituloCategoria, EtiquetaWeb) :-
    sintoma_reconocido(IdOpcion, Grupo, IdCategoria, EtiquetaWeb),
    categoria_opcion(IdCategoria, Grupo, TituloCategoria, _).

% Filtra únicamente los síntomas que existen en la base de conocimientos
filtrar_opciones_validas([], []).
filtrar_opciones_validas([H|T], [H|RestoValidas]) :-
    sintoma_reconocido(H, _, _, _), !,
    filtrar_opciones_validas(T, RestoValidas).
filtrar_opciones_validas([_|T], RestoValidas) :-
    filtrar_opciones_validas(T, RestoValidas).

% Filtra válidos y elimina repetidos
normalizar_opciones_seleccionadas(ListaSeleccionada, OpcionesUnicas) :-
    filtrar_opciones_validas(ListaSeleccionada, OpcionesValidas),
    agregar_sin_duplicados(OpcionesValidas, OpcionesUnicas).

% Detecta qué opciones no coinciden con los hechos declarados
detectar_sintomas_invalidos([], []).
detectar_sintomas_invalidos([H|T], Invalidos) :-
    sintoma_reconocido(H, _, _, _), !,
    detectar_sintomas_invalidos(T, Invalidos).
detectar_sintomas_invalidos([H|T], [H|Invalidos]) :-
    detectar_sintomas_invalidos(T, Invalidos).

% ==========================================
% 9. REGLAS LÓGICAS DE INFERENCIA DIRECTA DE TIPO VIA 1
% Reglas exactas protegidas con once/1 para evitar que haya duplicados
% ==========================================
regla_diagnostico(Sintomas, empaque_culata_danado, regla_culata_01,
    'Se infiere daño en empaque de cabeza porque se seleccionó humo blanco espeso acompañado de anticongelante lechoso o sobrecalentamiento con pérdida de refrigerante.') :-
    once((
        pertenece(humo_blanco_espeso, Sintomas),
        (   pertenece(anticongelante_lechoso, Sintomas)
        ;   (pertenece(testigo_temperatura_alta, Sintomas), pertenece(anticongelante_bajo, Sintomas))
        )
    )).
regla_diagnostico(Sintomas, termostato_bomba_agua_falla, regla_enfriamiento_02,
    'Se infiere falla en termostato, radiador o bomba de agua por temperatura alta y bajo nivel/vapor dulce, sin presencia de humo blanco en el escape.') :-
    once((
        pertenece(testigo_temperatura_alta, Sintomas),
        (pertenece(anticongelante_bajo, Sintomas) ; pertenece(olor_dulce_vapor, Sintomas)),
        \+ pertenece(humo_blanco_espeso, Sintomas),
        \+ pertenece(anticongelante_lechoso, Sintomas)
    )).
regla_diagnostico(Sintomas, desgaste_anillos_sellos_valvulas, regla_lubricacion_03,
    'Se infiere paso de aceite a la cámara de combustión (anillos o sellos de válvulas) por la selección de humo azulado combinada con consumo de aceite u olor a aceite quemado.') :-
    once((
        pertenece(humo_azul, Sintomas),
        (pertenece(nivel_aceite_bajo, Sintomas) ; pertenece(olor_aceite_quemado, Sintomas) ; pertenece(perdida_potencia_subida, Sintomas))
    )).
regla_diagnostico(Sintomas, baja_presion_lubricacion_critica, regla_lubricacion_critica_04,
    'Se infiere falla crítica de lubricación porque se seleccionó el testigo de presión de aceite junto con cascabeleo/golpeteo metálico o nivel de aceite crítico.') :-
    once((
        pertenece(testigo_presion_aceite, Sintomas),
        (pertenece(cascabeleo_metalico_motor, Sintomas) ; pertenece(nivel_aceite_bajo, Sintomas))
    )).
regla_diagnostico(Sintomas, mezcla_rica_inyectores_sensor, regla_combustible_rica_05,
    'Se infiere exceso de combustible no quemado (mezcla rica por inyectores abiertos o sensor MAF/O2) debido a humo negro en el escape y olor a gasolina cruda o tirones al acelerar.') :-
    once((
        pertenece(humo_negro, Sintomas),
        (pertenece(olor_gasolina_cruda, Sintomas) ; pertenece(jaloneo_al_acelerar, Sintomas) ; pertenece(rpm_inestables, Sintomas))
    )).
regla_diagnostico(Sintomas, falla_encendido_bujias_bobinas, regla_encendido_misfire_06,
    'Se infiere falla de chispa en al menos un cilindro (bujías o bobinas) porque el motor tiembla en neutral y además presenta jaloneo, Check Engine o pérdida de potencia.') :-
    once((
        pertenece(motor_tiembla_ralenti, Sintomas),
        (pertenece(jaloneo_al_acelerar, Sintomas) ; pertenece(testigo_check_engine, Sintomas)),
        (pertenece(perdida_potencia_subida, Sintomas) ; pertenece(tarda_dar_marcha, Sintomas) ; pertenece(jaloneo_al_acelerar, Sintomas))
    )).
regla_diagnostico(Sintomas, bomba_combustible_filtro_tapado, regla_alimentacion_bomba_07,
    'Se infiere deficiencia en el suministro de gasolina (bomba débil o filtro tapado) porque el vehículo se ahoga al pisar el acelerador y pierde fuerza en subidas sin sacar humo negro.') :-
    once((
        pertenece(perdida_potencia_subida, Sintomas),
        (pertenece(respuesta_lenta_acelerador, Sintomas) ; pertenece(jaloneo_al_acelerar, Sintomas)),
        \+ pertenece(humo_negro, Sintomas)
    )).
regla_diagnostico(Sintomas, falla_alternador_sistema_carga, regla_carga_alternador_08,
    'Se infiere falla en el alternador o banda de accesorios porque el testigo de batería permanece encendido en marcha acompañado de luces tenues o inestabilidad eléctrica.') :-
    once((
        pertenece(testigo_bateria, Sintomas),
        (pertenece(luces_tablero_tenues, Sintomas) ; pertenece(rpm_inestables, Sintomas) ; pertenece(tarda_dar_marcha, Sintomas))
    )).
regla_diagnostico(Sintomas, bateria_agotada_bornes_sucios, regla_arranque_bateria_09,
    'Se infiere batería descargada o falso contacto en bornes porque el auto no da marcha (solo hace click o gira muy lento) y presenta terminales sulfatadas o luces débiles.') :-
    once((
        (pertenece(no_da_marcha_click, Sintomas) ; pertenece(tarda_dar_marcha, Sintomas)),
        (pertenece(bornes_bateria_sulfatados, Sintomas) ; pertenece(luces_tablero_tenues, Sintomas))
    )).
regla_diagnostico(Sintomas, fuga_aire_frenos_hidraulicos, regla_frenos_hidraulicos_10,
    'Se infiere pérdida de presión hidráulica en frenos (fuga o aire en líneas/cilindro maestro) porque el conductor siente el pedal esponjoso al fondo y hay bajo nivel de líquido o testigo activo.') :-
    once((
        pertenece(pedal_freno_esponjoso, Sintomas),
        (pertenece(liquido_frenos_bajo, Sintomas) ; pertenece(testigo_frenos_abs, Sintomas) ; pertenece(auto_jala_lado_frenar, Sintomas))
    )).
regla_diagnostico(Sintomas, discos_alabeados_balatas_gastadas, regla_frenos_discos_11,
    'Se infiere deformación de discos de freno (alabeo) o desgaste de balatas porque el volante vibra específicamente al pisar el freno y/o se escucha chillido metálico.') :-
    once((
        (pertenece(vibracion_volante_frenar, Sintomas), (pertenece(chillido_metalico_frenar, Sintomas) ; pertenece(auto_jala_lado_frenar, Sintomas)))
        ;
        (pertenece(chillido_metalico_frenar, Sintomas), pertenece(pedal_freno_duro, Sintomas))
    )).
regla_diagnostico(Sintomas, desgaste_suspension_rotulas_amortiguadores, regla_suspension_12,
    'Se infiere holgura en componentes de suspensión (amortiguadores vencidos, rótulas o bujes) porque al pasar topes o baches se siente un golpeteo seco y rebote excesivo.') :-
    once((
        pertenece(golpeteo_seco_baches, Sintomas),
        (pertenece(rebote_excesivo_suspension, Sintomas) ; pertenece(desgaste_irregular_llantas, Sintomas) ; pertenece(zumbido_aumenta_velocidad, Sintomas))
    )).
regla_diagnostico(Sintomas, desbalanceo_desalineacion_ruedas, regla_alineacion_balanceo_13,
    'Se infiere desbalanceo de neumáticos y pérdida de alineación porque el volante vibra a velocidad constante (>80 km/h) y el auto tiende a desviarse en línea recta o gasta llanta de un lado.') :-
    once((
        (pertenece(vibracion_constante_velocidad, Sintomas) ; pertenece(auto_desvia_linea_recta, Sintomas)),
        (pertenece(desgaste_irregular_llantas, Sintomas) ; (pertenece(vibracion_constante_velocidad, Sintomas), pertenece(auto_desvia_linea_recta, Sintomas)))
    )).
regla_diagnostico(Sintomas, desgaste_embrague_transmision, regla_transmision_clutch_14,
    'Se infiere desgaste en el disco de embrague (clutch) o sistema de transmisión porque el motor se revoluciona sin ganar velocidad o las marchas raspan con olor a pasta quemada.') :-
    once((
        (pertenece(motor_revoluciona_no_avanza, Sintomas), (pertenece(olor_pasta_quemada, Sintomas) ; pertenece(perdida_potencia_subida, Sintomas)))
        ;
        (pertenece(velocidad_raspa_entrar, Sintomas), (pertenece(pedal_clutch_sin_presion, Sintomas) ; pertenece(golpe_brusco_cambio, Sintomas)))
    )).
regla_diagnostico(Sintomas, falla_direccion_hidraulica_bomba, regla_direccion_hidraulica_15,
    'Se infiere baja presión o fuga en la dirección hidráulica porque el volante se siente pesado a baja velocidad acompañado de bajo nivel de fluido o zumbido en la bomba.') :-
    once((
        pertenece(volante_duro_pesado, Sintomas),
        (pertenece(liquido_direccion_bajo, Sintomas) ; pertenece(zumbido_aumenta_velocidad, Sintomas))
    )).

% ==========================================
% 10. MOTOR DE EVIDENCIA PONDERADA (VÍA 2)
% Acumula puntos de hechos parciales por Backtracking
% ==========================================
evaluar_evidencias_falla([], _, [], [], 0, no).
evaluar_evidencias_falla([ev(Sintoma, Peso, Tipo)|Resto], SintomasUsuario, [Sintoma|Coincidentes], Faltantes, PuntosTotales, TienePrimaria) :-
    pertenece(Sintoma, SintomasUsuario), !,
    evaluar_evidencias_falla(Resto, SintomasUsuario, Coincidentes, Faltantes, PuntosResto, PrimariaResto),
    PuntosTotales is PuntosResto + Peso,
    (Tipo == primaria -> TienePrimaria = si ; TienePrimaria = PrimariaResto).
evaluar_evidencias_falla([ev(Sintoma, _, _)|Resto], SintomasUsuario, Coincidentes, [Sintoma|Faltantes], PuntosTotales, TienePrimaria) :-
    evaluar_evidencias_falla(Resto, SintomasUsuario, Coincidentes, Faltantes, PuntosTotales, TienePrimaria).

% Define umbrales dinámicos (1 síntoma=35pts, >2 síntomas=50pts)
diagnosticar_por_evidencia(SintomasUsuario, IdFalla, Puntaje, Coincidentes, Faltantes) :-
    menu_falla(IdFalla, _, _, _, _),
    findall(ev(S, P, T), evidencia_falla(IdFalla, S, P, T), ListaEvidencias),
    evaluar_evidencias_falla(ListaEvidencias, SintomasUsuario, Coincidentes, Faltantes, Puntaje, TienePrimaria),
    longitud_lista(SintomasUsuario, TotalSeleccionados),
    longitud_lista(Coincidentes, NumCoincidentes),
    (   (TotalSeleccionados == 1, TienePrimaria == si, Puntaje >= 35)
    ;   (TotalSeleccionados >= 2, TienePrimaria == si, NumCoincidentes >= 2, Puntaje >= 50)
    ).

% ==========================================
% 11. REGLAS DE SEGURIDAD VIAL
% ==========================================
evaluar_seguridad_conduccion(SintomasUsuario, IdFalla, peligro_inmediato_detenerse,
    '¡ALERTA CRÍTICA! Detenga el vehículo en un lugar seguro y apague el motor de inmediato. Continuar conduciendo representa un riesgo grave de accidente o daño catastrófico al motor.') :-
    menu_falla(IdFalla, _, _, GravedadBase, _),
    (   GravedadBase == critico
    ;   pertenece(pedal_freno_esponjoso, SintomasUsuario)
    ;   pertenece(testigo_presion_aceite, SintomasUsuario)
    ;   pertenece(testigo_temperatura_alta, SintomasUsuario)
    ), !.
evaluar_seguridad_conduccion(_, IdFalla, precaucion_acudir_taller,
    'PRECAUCIÓN MODERADA: Puede trasladar el vehículo a baja velocidad únicamente hacia su domicilio o taller mecánico cercano, evitando exigirlo en subidas o autopista.') :-
    menu_falla(IdFalla, _, _, moderado, _), !.
evaluar_seguridad_conduccion(_, IdFalla, mantenimiento_programado,
    'RIESGO LEVE: El vehículo puede operar con precaución, pero se recomienda programar la revisión preventiva a la brevedad para evitar desgaste mayor.') :-
    menu_falla(IdFalla, _, _, leve, _).

% ==========================================
% 12. VALIDACIÓN DE CONSULTAS Y PARTE PARA EL FORMULARIO
% ==========================================
validar_consulta([], datos_incompletos,
    'No se seleccionó ninguna opción en el formulario. Por favor marque al menos las fallas o síntomas que presenta el vehículo.') :- !.
validar_consulta(ListaSeleccionada, valores_no_validos, Mensaje) :-
    detectar_sintomas_invalidos(ListaSeleccionada, Invalidos),
    Invalidos \= [], !,
    atomic_list_concat(Invalidos, ', ', TextoInvalidos),
    atom_concat('Se recibieron opciones no registradas en el catálogo del sistema: ', TextoInvalidos, Mensaje).
validar_consulta(ListaSeleccionada, datos_insuficientes,
    'Se seleccionó únicamente 1 opción aislada. Aunque se mostrarán las posibles causas por backtracking, se recomienda marcar al menos 2 opciones (sensaciones o testigos) para acotar el diagnóstico.') :-
    normalizar_opciones_seleccionadas(ListaSeleccionada, [_UnicaOpcion]), !.
validar_consulta(ListaSeleccionada, consulta_valida,
    'Selección de opciones válida procesada directamente por el motor de inferencia en Prolog.') :-
    ListaSeleccionada \= [].

% ==========================================
% 13. PREDICADO MAESTRO PRINCIPAL
% Integra la traducción, la vía exacta, la vía de evidencia y la seguridad vial
% ==========================================
diagnosticar_vehiculo(OpcionesSeleccionadas, IdFalla, NombreSistema, TituloFalla, NivelRiesgo, AlertaSeguridad, PasosSolucion, MetodoInferencia, Explicacion, SintomasPorVerificar) :-
    normalizar_opciones_seleccionadas(OpcionesSeleccionadas, Sintomas),
    Sintomas \= [],
    (   % Vía 1: Regla Lógica Exacta
        regla_diagnostico(Sintomas, IdFalla, IdRegla, Explicacion),
        MetodoInferencia = regla_exacta(IdRegla),
        findall(S, (evidencia_falla(IdFalla, S, _, _), \+ pertenece(S, Sintomas)), SintomasPorVerificar)
    ;   % Vía 2: Inferencia Ponderada por Backtracking
        diagnosticar_por_evidencia(Sintomas, IdFalla, Puntaje, Coincidentes, SintomasPorVerificar),
        \+ regla_diagnostico(Sintomas, IdFalla, _, _),
        MetodoInferencia = inferencia_ponderada(Puntaje),
        atomic_list_concat(Coincidentes, ', ', TextoCoincidentes),
        format(atom(Explicacion),
            'Diagnóstico inferido por acumulación de evidencia (~w pts) a partir de las opciones seleccionadas: [~w].',
            [Puntaje, TextoCoincidentes])
    ),
    menu_falla(IdFalla, IdSistema, TituloFalla, _, PasosSolucion),
    sistema_carro(IdSistema, NombreSistema, _),
    evaluar_seguridad_conduccion(Sintomas, IdFalla, NivelRiesgo, AlertaSeguridad).

% ==========================================
% 14. BATERÍA DE CASOS DE PRUEBA
% ==========================================
caso_prueba(1, 'Caso 1: Empaque de culata dañado (Selección de humo blanco + anticongelante lechoso + temperatura)',
    [humo_blanco_espeso, anticongelante_lechoso, testigo_temperatura_alta]).
caso_prueba(2, 'Caso 2: Falla de encendido / Bujías o Bobinas (Selección de motor tiembla + jaloneo + pérdida de potencia)',
    [motor_tiembla_ralenti, jaloneo_al_acelerar, perdida_potencia_subida, testigo_check_engine]).
caso_prueba(3, 'Caso 3: Fuga hidráulica en frenos (Selección de pedal esponjoso + líquido bajo + testigo)',
    [pedal_freno_esponjoso, liquido_frenos_bajo, testigo_frenos_abs]).
caso_prueba(4, 'Caso 4: Discos de freno alabeados (Selección de vibración al frenar + chillido metálico)',
    [vibracion_volante_frenar, chillido_metalico_frenar]).
caso_prueba(5, 'Caso 5: Desgaste de embrague / Clutch patinando (Selección de revoluciona sin avanzar + olor a pasta)',
    [motor_revoluciona_no_avanza, olor_pasta_quemada, perdida_potencia_subida]).
caso_prueba(6, 'Caso 6: Desgaste en suspensión (Selección de golpeteo seco en baches + rebote excesivo)',
    [golpeteo_seco_baches, rebote_excesivo_suspension, desgaste_irregular_llantas]).
caso_prueba(7, 'Caso 7: Demostración de Backtracking (Múltiples soluciones al seleccionar jaloneo + falta de potencia + tarda en arrancar)',
    [jaloneo_al_acelerar, perdida_potencia_subida, tarda_dar_marcha]).
caso_prueba(8, 'Caso 8: Mezcla rica de combustible (Selección directa de opciones: humo negro + olor a gasolina cruda + jaloneo)',
    [humo_negro, olor_gasolina_cruda, jaloneo_al_acelerar]).
caso_prueba(9, 'Caso 9: Validación de formulario sin selección (Lista vacía)',
    []).
caso_prueba(10, 'Caso 10: Validación de opción inexistente fuera del catálogo',
    [parabrisas_sucio, radio_sin_senal]).

ejecutar_pruebas :-
    writeln('========================================================================'),
    writeln('  EJECUCIÓN DE LOS 10 CASOS DE PRUEBA - AUTOCHECK PROLOG (ESCOM-IPN)    '),
    writeln('========================================================================'),
    forall(caso_prueba(Num, Titulo, Entrada), (
        nl,
        format('--- [Prueba #~w] ~w ---~n', [Num, Titulo]),
        format('Opciones seleccionadas: ~w~n', [Entrada]),
        validar_consulta(Entrada, EstadoVal, MensajeVal),
        format('Validación: [~w] ~w~n', [EstadoVal, MensajeVal]),
        (   (EstadoVal == consulta_valida ; EstadoVal == datos_insuficientes)
        ->  findall(
                res(IdFalla, TituloFalla, NivelRiesgo, Metodo, Explicacion, Pasos),
                diagnosticar_vehiculo(Entrada, IdFalla, _, TituloFalla, NivelRiesgo, _, Pasos, Metodo, Explicacion, _),
                Soluciones
            ),
            (   Soluciones == []
            ->  writeln('Resultado: Sin coincidencias suficientes en la base de conocimientos.')
            ;   forall(member(res(IdF, TitF, Riesgo, Met, Exp, [PrimerPaso|_]), Soluciones), (
                    format('  -> Falla Inferida: ~w (~w)~n', [TitF, IdF]),
                    format('     Nivel de Riesgo: ~w | Método: ~w~n', [Riesgo, Met]),
                    format('     Explicación: ~w~n', [Exp]),
                    format('     Acción inicial: ~w~n', [PrimerPaso])
                ))
            )
        ;   true
        )
    )),
    nl,
    writeln('========================================================================'),
    writeln('  FIN DE LA BATERÍA DE PRUEBAS                                          '),
    writeln('========================================================================').
