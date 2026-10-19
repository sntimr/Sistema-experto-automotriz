% Hechos y reglas de prueba temporal
sintoma_prueba(bateria_descargada).
diagnosticar([bateria_descargada], 'Bateria descargada o alternador defectuoso', 'Se detecto que la bateria no retiene carga debido a un posible fallo en el alternador.').
% =========================================================
% diagnostico.pl - Archivo provisional de prueba
% =========================================================

% Regla de prueba 1
diagnostico_prueba([bateria_descargada], 'Fallo en la Batería / Alternador', 'El voltaje es insuficiente para encender el vehículo. Se requiere revisar el alternador.').
diagnostico_prueba([motor_no_arranca], 'Sistema de Ignición Defectuoso', 'Las bujías o bobinas de encendido están fallando.').
diagnostico_prueba([motor_no_arranca], 'Falta de Combustible o Bomba Dañada', 'No hay presión de gasolina llegando a los inyectores.').