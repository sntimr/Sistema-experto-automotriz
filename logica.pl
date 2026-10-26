:- encoding(utf8).

% 1. BASE DE HECHOS DEL SISTEMA
% sistema_carro(nombre_sistema, nombre del sistema, descripcion).
sistema_carro(enfriamiento, 'Sistema de Enfriamiento y Sellado de Culata', 'Regula la temperatura del motor y evita la mezcla de refrigerante con aceite o combustión.').
sistema_carro(lubricacion, 'Sistema de Lubricación Interna del Motor', 'Mantiene la película de aceite entre pistones, anillos, válvulas y cigüeñal.').
sistema_carro(alimentacion_combustible, 'Sistema de Inyección y Mezcla de Combustible', 'Dosifica la cantidad de gasolina y aire hacia la cámara de combustión.').
sistema_carro(encendido_electrico, 'Sistema de Encendido, Carga y Arranque Eléctrico', 'Proporciona la chispa en bujías y mantiene la carga de batería.').
sistema_carro(frenos, 'Sistema de Frenado Hidráulico y Fricción', 'Transforma la presión del pedal en fuerza de detención mediante líquido, discos y balatas.').
sistema_carro(direccion_suspension, 'Sistema de Dirección, Suspensión y Rodamiento', 'Absorbe irregularidades del camino y mantiene la estabilidad y trayectoria del vehículo.').
sistema_carro(transmision_embrague, 'Sistema de Transmisión y Embrague Clutch', 'Transfiere el par del motor hacia las ruedas a través de la caja de velocidades.').

% observacion(nombre_sintoma, categoria, detalle).
observacion(humo_blanco, humo_escape, 'Sale humo blanco denso y continuo por el escape incluso con el motor caliente').
observacion(humo_azul, humo_escape, 'Sale humo con tono azulado o gris-azulado por el tubo de escape al arrancar o acelerar').
observacion(humo_negro, humo_escape, 'Sale humo negro oscuro tipo hollín por el escape al acelerar').
observacion(motor_tiembla, comportamiento_motor, 'El motor tiembla o sacude fuertemente la cabina cuando está detenido en neutral').
observacion(rpm_inestables, comportamiento_motor, 'La aguja de revoluciones sube y baja sola en ralentí o el motor amenaza con apagarse').
observacion(marcha_lenta, comportamiento_motor, 'Al girar la llave el motor da marcha lento o requiere varios intentos para encender').
observacion(no_da_marcha, comportamiento_motor, 'Al girar la llave solo se escucha un chasquido click y el motor no gira').
observacion(cascabeleo_metalico, comportamiento_motor, 'Se escucha un golpeteo o traqueteo metálico constante dentro del motor').
observacion(check_engine, testigos_tablero, 'Testigo Check Engine encendido o parpadeando en el tablero').
observacion(temperatura_alta, testigos_tablero, 'Testigo rojo de temperatura encendido o aguja en la zona roja').
observacion(presion_aceite, testigos_tablero, 'Testigo rojo de la aceitera encendido en el tablero').
observacion(testigo_bateria, testigos_tablero, 'Testigo rojo con ícono de batería encendido mientras el motor está en marcha').
observacion(frenos_abs, testigos_tablero, 'Testigo rojo de sistema de frenos o ABS encendido en el tablero').
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
observacion(desgaste_llantas, olores_fugas, 'Las llantas delanteras muestran desgaste liso de un solo borde').
observacion(bornes_bateria_sulfatados, olores_fugas, 'Las terminales de la batería tienen polvo blanco/verdoso o están flojas').

% sensacion(nombre_sintoma, categoria, detalle).
sensacion(jaloneo_al_acelerar, al_acelerar, 'El vehículo da tirones o se jalonea al pisar el acelerador').
sensacion(perdida_potencia_subida, al_acelerar, 'El auto pierde fuerza notablemente en subidas o al intentar rebasar').
sensacion(motor_revoluciona_no_avanza, al_acelerar, 'El motor sube de revoluciones pero el auto no gana velocidad proporcional').
sensacion(respuesta_lenta_acelerador, al_acelerar, 'Hay un retraso o ahogamiento desde que se pisa el acelerador hasta que el auto responde').
sensacion(freno_pedal_esponjoso, al_frenar, 'El pedal de freno se siente blando, esponjoso o se hunde casi hasta el fondo').
sensacion(freno_pedal_duro, al_frenar, 'El pedal de freno está excesivamente duro y requiere mucha fuerza para detener el auto').
sensacion(vibracion_al_frenar, al_frenar, 'El volante o el pedal de freno vibran fuertemente al frenar a velocidad media o alta').
sensacion(jaloneo_al_frenar, al_frenar, 'El vehículo se desvía o jala bruscamente hacia un lado cuando se frena').
sensacion(chillido_al_frenar, al_frenar, 'Se escucha un chillido metálico cada vez que se pisa el freno').
sensacion(volante_duro, en_direccion, 'El volante se siente muy pesado o duro al girar a baja velocidad').
sensacion(desvio_en_recta, en_direccion, 'En calle plana el auto tiende cambiar de direccion si sueltas un poco el volante').
sensacion(vibracion_alta_velocidad, en_direccion, 'El volante vibra de forma constante al superar los 80-90 km/h aunque no se frene').
sensacion(golpeteo_baches, en_baches_curvas, 'Se siente y escucha un golpe seco debajo del auto al pasar topes o baches').
sensacion(rebote_inestable, en_baches_curvas, 'El carro se siente inestable y sigue rebotando varias veces después de pasar un tope').
sensacion(zumbido_constante, en_baches_curvas, 'Se percibe un zumbido o ronquido en las ruedas que crece conforme aumenta la velocidad').
sensacion(velocidad_raspa, en_cambios, 'Las velocidades entran duras o raspan al hacer el cambio').
sensacion(golpe_en_cambio, en_cambios, 'Se siente un golpe o pateo brusco cuando la transmisión cambia de marcha').
sensacion(pedal_clutch_sin_presion, en_cambios, 'El pedal del clutch se queda abajo o corta muy pegado al piso').

% menu_falla(nombre_falla, nombre_sistema, detalle, riesgo, lista de recomendaciones[]).
menu_falla(empaque_culata_danado, enfriamiento, 'Falla empaque de cabeza (culata) / paso de refrigerante a combustión', critico, [
    '1. DETENER EL VEHÍCULO: No continúe conduciendo para evitar que la cabeza del motor se tuerza o se desbiele.',
    '2. Con el motor completamente FRÍO, verificar si hay mezcla lechosa en el tapón de aceite o burbujeo en el radiador.',
    '3. Realizar prueba de compresión de cilindros y prueba química de fugas de CO2 en el sistema de enfriamiento.',
    '4. Rectificar la planicidad de la cabeza del motor, reemplazar el empaque de culata y cambiar aceite y anticongelante.']).

menu_falla(termostato_bomba_agua, enfriamiento, 'Sobrecalentamiento por termostato pegado, fuga o bomba de agua deficiente', critico, [
    '1. Apagar el motor de inmediato y esperar al menos 40 minutos antes de abrir el depósito de anticongelante.',
    '2. Inspeccionar mangueras del radiador (si una está muy caliente y otra fría, el termostato está cerrado/pegado).',
    '3. Verificar que el motoventilador encienda automáticamente y buscar fugas en radiador o bomba de agua.',
    '4. Reemplazar el termostato, purgar el aire del sistema de enfriamiento y rellenar con anticongelante adecuado.']).

menu_falla(desgaste_anillos_valvulas, lubricacion, 'Quema de aceite interna por desgaste de sellos de válvulas o anillos de pistón', moderado, [
    '1. Revisar y rellenar el nivel de aceite del motor para evitar quedarse sin lubricación.',
    '2. Observar cuándo sale el humo azul: si es solo al arrancar en frío apunta a sellos de válvulas; si es continuo al acelerar apunta a anillos.',
    '3. Verificar el estado de la válvula PCV (ventilación positiva del cárter), ya que si se obstruye pasa aceite a la admisión.',
    '4. Realizar prueba de compresión en seco y con aceite en los cilindros para programar cambio de sellos o anillado.']).

menu_falla(baja_presion_lubricacion, lubricacion, 'Falla crítica de presión de aceite (bomba de aceite o coladera obstruida)', critico, [
    '1. APAGAR EL MOTOR INMEDIATAMENTE: Circular con el testigo de aceite y ruido metálico fundirá los metales del motor en minutos.',
    '2. Revisar el nivel de aceite con la bayoneta en una superficie plana y buscar fugas masivas en el cárter o filtro.',
    '3. Si el nivel de aceite es correcto, medir la presión real con manómetro mecánico en el bulbo de aceite.',
    '4. Limpiar el cedazo (coladera) del cárter o reemplazar la bomba de aceite y el filtro.']).

menu_falla(mezcla_rica_combustible, alimentacion_combustible, 'Mezcla rica de combustible (exceso de gasolina por inyectores abiertos o sensor MAF/O2)', moderado, [
    '1. Inspeccionar y reemplazar el filtro de aire si se encuentra saturado de polvo (resta oxígeno a la mezcla).',
    '2. Revisar si algún inyector está goteando o quedando abierto mediante laboratorio de inyectores.',
    '3. Limpiar el sensor MAF/MAP y verificar el regulador de presión de gasolina.',
    '4. Limpiar las bujías hollinadas y revisar el estado del sensor de oxígeno primario.']).

menu_falla(falla_encendido_cilindros, encendido_electrico, 'Falla de encendido en cilindro (misfire por bujías, cables o bobina dañada)', moderado, [
    '1. Evitar acelerar a fondo porque la gasolina no quemada en el cilindro muerto puede dañar el convertidor catalítico.',
    '2. Retirar e inspeccionar las bujías buscando electrodos desgastados, porcelana fisurada o exceso de carbonilla.',
    '3. Verificar si los cables de bujía o capuchones de bobina tienen fugas de corriente (arqueo eléctrico).',
    '4. Reemplazar el juego de bujías calibradas según especificación o sustituir la bobina del cilindro que no trabaja.']).

menu_falla(baja_presion_combustible, alimentacion_combustible, 'Baja presión de gasolina (filtro de combustible obstruido o bomba débil)', moderado, [
    '1. Escuchar al poner el switch en ON (sin dar marcha) si zumba la bomba de gasolina durante 2-3 segundos.',
    '2. Reemplazar el filtro de gasolina externo si no se ha cambiado en los últimos 20,000 km.',
    '3. Medir la presión y caudal en el riel de inyectores (si cae al acelerar, el repuesto de la bomba está perdiendo fuerza).',
    '4. Limpiar el cuerpo de aceleración y verificar el relevador (relay) de la bomba de combustible.']).

menu_falla(falla_alternador, encendido_electrico, 'Falla del alternador o banda de accesorios (el vehículo no está cargando la batería)', critico, [
    '1. Apagar aire acondicionado, luces no esenciales y radio para conservar la reserva de la batería y llegar a un lugar seguro.',
    '2. Inspeccionar visualmente que la banda de accesorios no esté rota o floja en la polea del alternador.',
    '3. Medir con multímetro el voltaje en batería con el motor encendido (debe estar entre 13.8V y 14.4V; si es menor a 12.5V no carga).',
    '4. Reparar el regulador de voltaje/carbón del alternador o reemplazar el alternador.']).

menu_falla(bateria_descargada_bornes, encendido_electrico, 'Batería descargada, fin de vida útil o falso contacto en terminales sulfatadas', leve, [
    '1. Con el motor apagado, limpiar el polvo blanco/verdoso de los bornes usando agua tibia con bicarbonato y un cepillo.',
    '2. Apretar firmemente las terminales positiva y negativa asegurando que no giren con la mano.',
    '3. Si el auto arranca pasando corriente y carga bien (>13.8V) pero al día siguiente vuelve a fallar, la batería ya no retiene carga.',
    '4. Reemplazar el acumulador (batería) por uno del amperaje de arranque en frío (CCA) recomendado.']).

menu_falla(fuga_frenos_hidraulicos, frenos, 'Fuga hidráulica, aire en las líneas o falla de bomba principal de frenos (cilindro maestro)', critico, [
    '1. PELIGRO VIAL: No conduzca en carretera ni a velocidad; bombee el pedal varias veces si necesita detenerse de emergencia.',
    '2. Revisar el nivel de líquido de frenos DOT3/DOT4 e inspeccionar la cara interna de las 4 ruedas buscando manchas húmedas de líquido.',
    '3. Si hay fuga en manguera, cáliper o cilindro de rueda trasero, reparar la pieza y rellenar líquido nuevo.',
    '4. Purgar el aire de las 4 líneas de freno; si el pedal sigue yéndose al fondo sin fugas externas, reemplazar el cilindro maestro.']).

menu_falla(discos_deformados_balatas, frenos, 'Discos de freno alabeados (deformados por calor) y/o balatas desgastadas', moderado, [
    '1. Desmontar las ruedas delanteras para medir el espesor restante de la pasta de las balatas (cambiar si es menor a 3 mm).',
    '2. Inspeccionar la superficie de los discos de freno buscando surcos profundos o cristalización.',
    '3. Rectificar los discos en torno (si están dentro del grosor mínimo de seguridad) o instalar discos nuevos para eliminar la vibración al volante.',
    '4. Engrasar los pernos guía de los cálipers para evitar que frenen disparejo.']).

menu_falla(desgaste_suspension, direccion_suspension, 'Desgaste en amortiguadores, rótulas, terminales de dirección o bujes de horquilla', moderado, [
    '1. Empujar una esquina del auto hacia abajo y soltar: si rebota más de 1.5 veces o el amortiguador está manchado de aceite, está vencido.',
    '2. Levantar el vehículo de forma segura y mover la llanta a las 12 y 6 horas (verifica rótulas/balero) y a las 3 y 9 horas (verifica terminales).',
    '3. Reemplazar los amortiguadores por par (ambos delanteros o ambos traseros) y cambiar los bujes o rótulas con juego.',
    '4. Realizar alineación después de cambiar componentes de suspensión.']).

menu_falla(desbalanceo_desalineacion, direccion_suspension, 'Falta de alineación y balanceo de ruedas o presión incorrecta de neumáticos', leve, [
    '1. Verificar en frío que las 4 llantas tengan exactamente la presión en PSI indicada en la etiqueta de la puerta del conductor.',
    '2. Revisar que los rines no tengan golpes o plomos de balanceo caídos.',
    '3. Acudir a servicio de balanceo por computadora para eliminar la vibración del volante a más de 80 km/h.',
    '4. Realizar alineación de convergencia y camber para corregir que el volante se jale de lado y evitar el desgaste irregular de llantas.']).

menu_falla(desgaste_embrague_clutch, transmision_embrague, 'Desgaste del disco de embrague (clutch patinando) o falta de presión en collarín/caja', moderado, [
    '1. Evitar mantener el pie apoyado en el pedal del clutch mientras se conduce y no sostener el auto en subidas con el embrague.',
    '2. Revisar el nivel de líquido en el depósito del cilindro maestro del clutch (a menudo compartido con frenos) o el ajuste del chicote.',
    '3. Si al meter 3ra o 4ta velocidad y acelerar el motor sube de RPM pero el auto no acelera y huele a pasta quemada, el disco está liso.',
    '4. Reemplazar el kit de embrague completo (disco, plato opresor y collarín) y rectificar el volante motriz.']).

menu_falla(direccion_hidraulica_bomba, direccion_suspension, 'Falla en asistencia de dirección hidráulica (bajo nivel de fluido, fuga o bomba de dirección)', moderado, [
    '1. Verificar el nivel del depósito de líquido de dirección hidráulica y rellenar con el fluido especificado si está bajo.',
    '2. Inspeccionar mangueras de alta presión y cubrepolvos de la cremallera buscando fugas de aceite.',
    '3. Revisar que la banda de accesorios impulse correctamente la polea de la bomba de dirección sin patinar.',
    '4. Purgar el aire del sistema girando el volante de tope a tope con el frente levantado o reemplazar la bomba si continúa pesada.'
]).

% 2. PREDICADOS 
% pertenece_sistema(nombre_sintoma, nombre_sistema).
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

% evidencia(nombre_falla, nombre_sintoma, ponderacion).
evidencia(empaque_culata_danado, humo_blanco, 25).
evidencia(empaque_culata_danado, anticongelante_lechoso, 30).
evidencia(empaque_culata_danado, temperatura_alta, 15).
evidencia(empaque_culata_danado, anticongelante_bajo, 10).
evidencia(empaque_culata_danado, olor_dulce_vapor, 10).
evidencia(empaque_culata_danado, motor_tiembla, 10).
evidencia(termostato_bomba_agua, temperatura_alta, 35).
evidencia(termostato_bomba_agua, anticongelante_bajo, 30).
evidencia(termostato_bomba_agua, olor_dulce_vapor, 20).
evidencia(termostato_bomba_agua, perdida_potencia_subida, 15).
evidencia(desgaste_anillos_valvulas, humo_azul, 40).
evidencia(desgaste_anillos_valvulas, nivel_aceite_bajo, 30).
evidencia(desgaste_anillos_valvulas, olor_aceite_quemado, 15).
evidencia(desgaste_anillos_valvulas, perdida_potencia_subida, 15).
evidencia(baja_presion_lubricacion, presion_aceite, 40).
evidencia(baja_presion_lubricacion, cascabeleo_metalico, 35).
evidencia(baja_presion_lubricacion, nivel_aceite_bajo, 15).
evidencia(baja_presion_lubricacion, olor_aceite_quemado, 10).
evidencia(mezcla_rica_combustible, humo_negro, 30).
evidencia(mezcla_rica_combustible, olor_gasolina_cruda, 30).
evidencia(mezcla_rica_combustible, jaloneo_al_acelerar, 15).
evidencia(mezcla_rica_combustible, check_engine, 15).
evidencia(mezcla_rica_combustible, rpm_inestables, 10).
evidencia(falla_encendido_cilindros, motor_tiembla, 25).
evidencia(falla_encendido_cilindros, jaloneo_al_acelerar, 25).
evidencia(falla_encendido_cilindros, check_engine, 20).
evidencia(falla_encendido_cilindros, perdida_potencia_subida, 15).
evidencia(falla_encendido_cilindros, marcha_lenta, 15).
evidencia(baja_presion_combustible, perdida_potencia_subida, 30).
evidencia(baja_presion_combustible, respuesta_lenta_acelerador, 30).
evidencia(baja_presion_combustible, jaloneo_al_acelerar, 20).
evidencia(baja_presion_combustible, marcha_lenta, 20).
evidencia(falla_alternador, testigo_bateria, 40).
evidencia(falla_alternador, luces_tenues, 30).
evidencia(falla_alternador, rpm_inestables, 15).
evidencia(falla_alternador, marcha_lenta, 15).
evidencia(bateria_descargada_bornes, no_da_marcha, 35).
evidencia(bateria_descargada_bornes, bornes_bateria_sulfatados, 30).
evidencia(bateria_descargada_bornes, marcha_lenta, 20).
evidencia(bateria_descargada_bornes, luces_tenues, 15).
evidencia(fuga_frenos_hidraulicos, freno_pedal_esponjoso, 35).
evidencia(fuga_frenos_hidraulicos, liquido_frenos_bajo, 30).
evidencia(fuga_frenos_hidraulicos, frenos_abs, 20).
evidencia(fuga_frenos_hidraulicos, jaloneo_al_frenar, 15).
evidencia(discos_deformados_balatas, vibracion_al_frenar, 35).
evidencia(discos_deformados_balatas, chillido_al_frenar, 30).
evidencia(discos_deformados_balatas, jaloneo_al_frenar, 20).
evidencia(discos_deformados_balatas, freno_pedal_duro, 15).
evidencia(desgaste_suspension, golpeteo_baches, 35).
evidencia(desgaste_suspension, rebote_inestable, 30).
evidencia(desgaste_suspension, desgaste_llantas, 20).
evidencia(desgaste_suspension, zumbido_constante, 15).
evidencia(desbalanceo_desalineacion, vibracion_alta_velocidad, 40).
evidencia(desbalanceo_desalineacion, desvio_en_recta, 35).
evidencia(desbalanceo_desalineacion, desgaste_llantas, 25).
evidencia(desgaste_embrague_clutch, motor_revoluciona_no_avanza, 30).
evidencia(desgaste_embrague_clutch, olor_pasta_quemada, 25).
evidencia(desgaste_embrague_clutch, velocidad_raspa, 15).
evidencia(desgaste_embrague_clutch, pedal_clutch_sin_presion, 15).
evidencia(desgaste_embrague_clutch, golpe_en_cambio, 15).
evidencia(direccion_hidraulica_bomba, volante_duro, 50).
evidencia(direccion_hidraulica_bomba, liquido_direccion_bajo, 50).

% 3. REGLAS DE DIAGNÓSTICO Y EVALUACIÓN

evaluar_evidencias_falla([], _, [], [], 0).

evaluar_evidencias_falla([ev(Sintoma, Peso)|Resto], SintomasUsuario, [Sintoma|Coincidentes], Faltantes, PuntosTotales) :-
    member(Sintoma, SintomasUsuario), !,
    evaluar_evidencias_falla(Resto, SintomasUsuario, Coincidentes, Faltantes, PuntosResto),
    PuntosTotales is PuntosResto + Peso.

evaluar_evidencias_falla([ev(Sintoma, _)|Resto], SintomasUsuario, Coincidentes, [Sintoma|Faltantes], PuntosTotales) :-
    evaluar_evidencias_falla(Resto, SintomasUsuario, Coincidentes, Faltantes, PuntosTotales).

diagnosticar_por_evidencia(SintomasUsuario, IdFalla, IdSistema, Puntaje, Coincidentes, Faltantes) :-
    menu_falla(IdFalla, IdSistema, _, _, _),
    sistema_carro(IdSistema, _, _),
    findall(ev(S, P), evidencia(IdFalla, S, P), ListaEvidencias),
    evaluar_evidencias_falla(ListaEvidencias, SintomasUsuario, Coincidentes, Faltantes, Puntaje),
    Puntaje > 0.

diagnosticar_por_evidencia(SintomasUsuario, IdFalla, Puntaje, Coincidentes, Faltantes) :-
    diagnosticar_por_evidencia(SintomasUsuario, IdFalla, _, Puntaje, Coincidentes, Faltantes).

formatear_posibles_causas([], []).

formatear_posibles_causas([Puntaje-info(_, DetalleFalla, _) | Resto], [TextoCausa | TextosResto]) :-
    format(atom(TextoCausa), '~w - Porcentaje: ~w%', [DetalleFalla, Puntaje]),
    formatear_posibles_causas(Resto, TextosResto).

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

evaluar_riesgo(_, IdFalla, 'RIESGO CRÍTICO: Detenga el vehículo en un lugar seguro y apague el motor de inmediato. Continuar conduciendo representa un riesgo grave de accidente o daño catastrófico al motor.') :-
    menu_falla(IdFalla, _, _, critico, _), !.

evaluar_riesgo(_, IdFalla, 'RIESGO MODERADO: Se recomienda trasladar el vehículo a baja velocidad únicamente hacia su domicilio o taller mecánico cercano, evitando exigirlo en subidas o autopista.') :-
    menu_falla(IdFalla, _, _, moderado, _), !.

evaluar_riesgo(_, IdFalla, 'RIESGO LEVE: El vehículo puede operar con precaución, pero se recomienda programar la revisión preventiva a la brevedad para evitar desgaste mayor.') :-
    menu_falla(IdFalla, _, _, leve, _).

% 4. REGLAS DE DIAGNÓSTICO ESPECÍFICO (1-15)
% diagnostico(lista_de_sintomas, nombre_falla, detalle_diagnostico).
diagnostico(Sintomas, empaque_culata_danado, 'Se infiere daño en empaque de cabeza porque existe humo blanco espeso acompañado de anticongelante lechoso o sobrecalentamiento con pérdida de refrigerante.') :-
    member(humo_blanco, Sintomas),
    (member(anticongelante_lechoso, Sintomas);   
    (member(temperatura_alta, Sintomas), member(anticongelante_bajo, Sintomas))).

diagnostico(Sintomas, termostato_bomba_agua, 'Se infiere falla en termostato, radiador o bomba de agua por temperatura alta y bajo nivel/vapor dulce, sin evidencia de humo blanco en el escape.') :-
    member(temperatura_alta, Sintomas),
    (member(anticongelante_bajo, Sintomas); 
    member(olor_dulce_vapor, Sintomas)),
    \+ member(humo_blanco, Sintomas),
    \+ member(anticongelante_lechoso, Sintomas).

diagnostico(Sintomas, desgaste_anillos_valvulas, 'Se infiere paso de aceite a la cámara de combustión (anillos o sellos de válvulas) por la presencia de humo azulado combinada con consumo de aceite u olor a aceite quemado.') :-
    member(humo_azul, Sintomas),
    (member(nivel_aceite_bajo, Sintomas); 
    member(olor_aceite_quemado, Sintomas); 
    member(perdida_potencia_subida, Sintomas)).

diagnostico(Sintomas, baja_presion_lubricacion, 'Se infiere falla crítica de lubricación porque se encendió el testigo de presión de aceite junto con cascabeleo/golpeteo metálico o nivel de aceite crítico.') :-
    member(presion_aceite, Sintomas),
    (member(cascabeleo_metalico, Sintomas); 
    member(nivel_aceite_bajo, Sintomas)).

diagnostico(Sintomas, mezcla_rica_combustible, 'Se infiere exceso de combustible no quemado (mezcla rica por inyectores abiertos o sensor MAF/O2) debido a humo negro en el escape y olor a gasolina cruda o tirones al acelerar.') :-
    member(humo_negro, Sintomas),
    (member(olor_gasolina_cruda, Sintomas); 
    member(jaloneo_al_acelerar, Sintomas);
    member(rpm_inestables, Sintomas)).

diagnostico(Sintomas, falla_encendido_cilindros, 'Se infiere falla de chispa en al menos un cilindro (bujías o bobinas) porque el motor tiembla en neutral y además se jalonea o pierde potencia al exigirle en marcha.') :-
    member(motor_tiembla, Sintomas),
    (member(jaloneo_al_acelerar, Sintomas) ; member(check_engine, Sintomas)),
    (member(perdida_potencia_subida, Sintomas); 
    member(marcha_lenta, Sintomas); 
    member(jaloneo_al_acelerar, Sintomas)).

diagnostico(Sintomas, baja_presion_combustible, 'Se infiere deficiencia en el suministro de gasolina (bomba débil o filtro tapado) porque el vehículo se ahoga al pisar el acelerador y pierde fuerza en subidas sin sacar humo negro.') :-
    member(perdida_potencia_subida, Sintomas),
    (member(respuesta_lenta_acelerador, Sintomas); 
    member(jaloneo_al_acelerar, Sintomas)),
    \+ member(humo_negro, Sintomas).

diagnostico(Sintomas, falla_alternador, 'Se infiere falla en el alternador o banda de accesorios porque el testigo de batería permanece encendido en marcha acompañado de luces tenues o inestabilidad eléctrica.') :-
    member(testigo_bateria, Sintomas),
    (member(luces_tenues, Sintomas); 
    member(rpm_inestables, Sintomas); 
    member(marcha_lenta, Sintomas)).

diagnostico(Sintomas, bateria_descargada_bornes, 'Se infiere batería descargada o falso contacto en bornes porque el auto no da marcha (solo hace click o gira muy lento) y presenta terminales sulfatadas o luces débiles.') :-
    (member(no_da_marcha, Sintomas) ; member(marcha_lenta, Sintomas)),
    (member(bornes_bateria_sulfatados, Sintomas) ; member(luces_tenues, Sintomas)).

diagnostico(Sintomas, fuga_frenos_hidraulicos, 'Se infiere pérdida de presión hidráulica en frenos (fuga o aire en líneas/cilindro maestro) porque el conductor siente el pedal esponjoso al fondo y hay bajo nivel de líquido o testigo activo.') :-
    member(freno_pedal_esponjoso, Sintomas),
    (member(liquido_frenos_bajo, Sintomas); 
    member(frenos_abs, Sintomas); 
    member(jaloneo_al_frenar, Sintomas)).

diagnostico(Sintomas, discos_deformados_balatas, 'Se infiere deformación de discos de freno (alabeo) o desgaste de balatas porque el volante vibra específicamente al pisar el freno y/o se escucha chillido metálico.') :-
    (
        (member(vibracion_al_frenar, Sintomas), 
        (member(chillido_al_frenar, Sintomas); 
        member(jaloneo_al_frenar, Sintomas)));
        (member(chillido_al_frenar, Sintomas), member(freno_pedal_duro, Sintomas))
    ).

diagnostico(Sintomas, desgaste_suspension, 'Se infiere holgura en componentes de suspensión (amortiguadores vencidos, rótulas o bujes) porque al pasar topes o baches se siente un golpeteo seco y rebote excesivo.') :-
    member(golpeteo_baches, Sintomas),
    (member(rebote_inestable, Sintomas); 
    member(desgaste_llantas, Sintomas); 
    member(zumbido_constante, Sintomas)).

diagnostico(Sintomas, desbalanceo_desalineacion, 'Se infiere desbalanceo de neumáticos y pérdida de alineación porque el volante vibra a velocidad constante (>80 km/h) y el auto tiende a desviarse en línea recta o gasta llanta de un lado.') :-
    (member(vibracion_alta_velocidad, Sintomas) ; member(desvio_en_recta, Sintomas)),
    (member(desgaste_llantas, Sintomas); 
    (member(vibracion_alta_velocidad, Sintomas), member(desvio_en_recta, Sintomas))).

diagnostico(Sintomas, desgaste_embrague_clutch, 'Se infiere desgaste en el disco de embrague (clutch) o sistema de transmisión porque el motor se revoluciona sin ganar velocidad o las marchas raspan con olor a pasta quemada.') :-
    (
        (member(motor_revoluciona_no_avanza, Sintomas), (member(olor_pasta_quemada, Sintomas) ; member(perdida_potencia_subida, Sintomas)));
        (member(velocidad_raspa, Sintomas), (member(pedal_clutch_sin_presion, Sintomas) ; member(golpe_en_cambio, Sintomas)))
    ).

diagnostico(Sintomas, direccion_hidraulica_bomba, 'Se infiere falla en el sistema de asistencia de dirección hidráulica (fuga de fluido o bomba deficiente) porque el volante se siente excesivamente pesado a baja velocidad y el nivel de líquido de dirección está bajo.') :-
    member(volante_duro, Sintomas),
    member(liquido_direccion_bajo, Sintomas).

% 5. FUNCIÓN PRINCIPAL DE DIAGNÓSTICO
% diagnosticar_vehiculo(Sintomas[], DiagnosticoFalla, NombreSistema, Riesgo, Explicacion, Recomendacion).
diagnosticar_vehiculo(Sintomas, DiagnosticoFalla, NombreSistema, Riesgo, Explicacion, Recomendacion) :-
    Sintomas \= [],
    (
        diagnostico(Sintomas, IdFalla, Explicacion), !,
        menu_falla(IdFalla, IdSistema, DiagnosticoFalla, _, Recomendacion),
        sistema_carro(IdSistema, NombreSistema, _),
        evaluar_riesgo(Sintomas, IdFalla, Riesgo)
        ;
        calcular_causas_probables(Sintomas, IdFallaMax, DetalleMax, IdSistemaMax, PuntajeMax, DiagnosticoFalla),
        sistema_carro(IdSistemaMax, NombreSistemaBase, _),
        format(atom(NombreSistema), 'Sistema más probable: ~w', [NombreSistemaBase]), evaluar_riesgo(Sintomas, IdFallaMax, Riesgo),
        format(atom(Explicacion), 'Los síntomas ingresados no determinan un diagnóstico único definitivo. Evaluando la suma de ponderaciones por sistema mecánico, la causa más probable es "~w" con ~w% de coincidencia.', [DetalleMax, PuntajeMax]),
        Recomendacion = [
            '1. Se recomienda realizar un análisis mecánico más profundo y profesional en un taller especializado para confirmar cual es la posible causa del problema.',
            '2. Solicite pruebas físicas específicas sobre el sistema mecánico más probable antes de reemplazar componentes.',
            '3. Verifique si se presenta algún otro síntoma estático o dinámico en el vehículo para aproximar el diagnóstico.'
        ]
    ).