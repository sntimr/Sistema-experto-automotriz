# Contexto Integral del Proyecto, Guía de Archivos y Prompts de Video — AutoCheck-Prolog (ESCOM - IPN)

**Institución:** Instituto Politécnico Nacional (IPN) — Escuela Superior de Cómputo (ESCOM)  
**Unidad de Aprendizaje:** Paradigmas de Programación (1er Parcial)  
**Proyecto:** *AutoCheck-Prolog* — Sistema Experto de Pre-Diagnóstico Automotriz mediante Sensaciones de Conducción e Inspección Física (Sin Escáner OBD-II)  
**Fechas de Entrega Oficiales:** Miércoles 21 de octubre de 2026 y Viernes 23 de octubre de 2026  

## 1. Contexto General de lo Realizado en la Tarea

El objetivo de la Práctica Integradora del 1er Parcial es diseñar, construir, validar y desplegar un **Sistema Experto basado en Programación Lógica (SWI-Prolog)** capaz de resolver un problema real mediante una base de conocimientos (hechos y reglas) y su posterior integración con una arquitectura web.

### 1.1 Problemática Elegida y Enfoque Diferenciador
En lugar de depender de un escáner electrónico OBD-II que solo arroja códigos alfanuméricos, propusiste desarrollar **AutoCheck-Prolog**, un sistema experto que diagnostica fallas mecánicas a partir de **tres fuentes reales de información humana**:

1. **Inspección física y visual sin escáner (`observacion_fisica/3`):** Lo que cualquier persona puede observar con el auto detenido: color del humo del escape (blanco espeso, azul o negro), comportamiento del motor en neutral/ralentí (temblores, revoluciones inestables, cascabeleo metálico, chasquido al dar marcha), testigos encendidos en el tablero (Check Engine, temperatura roja, aceitera roja, batería, frenos/ABS, luces tenues), estado de niveles de líquidos (anticongelante lechoso o bajo, nivel de aceite, líquido de frenos, líquido de dirección) y olores o desgastes visibles (olor a gasolina cruda, vapor dulce, pasta de clutch quemada, aceite quemado, llantas gastadas de un borde, bornes sulfatados).
2. **Sensaciones dinámicas del conductor al manejar (`sensacion_manejo/3`):** Lo que el usuario siente físicamente mientras conduce el vehículo en cinco momentos clave:
   - **Al acelerar (`al_acelerar`):** Jaloneos o tirones, pérdida de potencia en subidas, motor que se revoluciona sin ganar velocidad (patina), o respuesta lenta/ahogamiento.
   - **Al frenar (`al_frenar`):** Pedal esponjoso que se va al fondo, pedal excesivamente duro, vibración en el volante al frenar, desvío brusco hacia un lado o chillido metálico agudo.
   - **En la dirección (`en_direccion`):** Volante duro o pesado a baja velocidad, auto que se va chueco en calle plana o vibración constante a más de 80 km/h.
   - **En baches y curvas (`en_baches_curvas`):** Golpeteo seco (*clonk*) al pasar topes, rebote excesivo de la carrocería o zumbido que crece con la velocidad.
   - **Al hacer cambios (`en_cambios`):** Velocidades que raspan al entrar, pateo o golpe brusco al cambiar de marcha, o pedal de clutch sin presión.
3. **Relato coloquial del conductor (`palabra_clave_sintoma/2`):** Un diccionario léxico de 51 términos cotidianos (como `jalonea`, `tirones`, `sin_fuerza`, `patina`, `esponjoso`, `se_va_chueco`, `tiembla`, `calienta`, `huele_gasolina`) que traduce recursivamente lo que el conductor expresa con sus propias palabras hacia los átomos técnicos formales del motor de inferencia.

### 1.2 Arquitectura Lógica Implementada en Prolog (Tu Responsabilidad Directa)
Como encargado del módulo de **SWI-Prolog** dentro de tu equipo, construimos y auditamos un programa completo de **235 cláusulas** que supera ampliamente todos los requisitos de la rúbrica (35 puntos del módulo lógico):

| Requisito Oficial del PDF | Mínimo Exigido | Implementado en AutoCheck-Prolog | Predicados Clave en el Código |
|---|---|---|---|
| **Hechos significativos** | 20 hechos | **166 hechos** organizados en 6 predicados de dominio + 10 casos de prueba | `sistema_auto/3` (7), `sensacion_manejo/3` (18), `observacion_fisica/3` (25), `catalogo_falla/5` (15), `evidencia_falla/4` (63), `palabra_clave_sintoma/2` (51) |
| **Reglas no triviales** | 10 reglas | **21 reglas lógicas** con conjunción (`,`), disyunción (`;`), negación por fallo (`\+`), corte (`!`) y condicional (`-> ;`) | 15 reglas en `regla_diagnostico/4`, `diagnosticar_por_evidencia/5`, `evaluar_seguridad_conduccion/4`, `validar_consulta/3`, `diagnosticar_vehiculo/10` |
| **Predicados propios diferenciados** | 5 predicados | **13 predicados propios** (6 de hechos y 7 de reglas, listas y recursividad) | `pertenece/2`, `agregar_sin_duplicados/2`, `longitud_lista/2`, `sintoma_reconocido/4`, `evaluar_evidencias_falla/6`, `traducir_relato_usuario/2`, `detectar_sintomas_invalidos/2` |
| **Conclusiones distintas** | 3 conclusiones | **15 diagnósticos mecánicos completos** (con 4 pasos de solución cada uno) y **3 niveles de seguridad vial** | `peligro_inmediato_detenerse`, `precaucion_acudir_taller`, `mantenimiento_programado` |
| **Variables, unificación y recursividad** | Obligatorio | Descomposición recursiva `[Cabeza\|Cola]`, acumuladores aritméticos con `is` y unificación multimodal | `pertenece/2`, `agregar_sin_duplicados/2`, `longitud_lista/2`, `evaluar_evidencias_falla/6`, `traducir_relato_interna/2` |
| **Backtracking (múltiples soluciones)** | Obligatorio | Doble vía de inferencia (Vía 1: Reglas exactas; Vía 2: Motor ponderado por puntos) | Al presionar `;` en consola o usar `findall/3`, entrega todos los diagnósticos compatibles sin repetir la misma falla |
| **Casos de prueba documentados** | 10 casos | **10 casos de prueba integrados** en el código y automatizados | `caso_prueba/3` (1 al 10) y `ejecutar_pruebas/0` |

### 1.3 Resumen de la Auditoría de Calidad Realizada al Código Prolog
Se ejecutó una auditoría estática y dinámica sobre las 235 cláusulas del programa, verificando **0 errores de sintaxis**, **0 advertencias de variables solitarias (*singleton variables*)** y aplicando **6 mejoras clave**:
1. **Corrección de átomo de riesgo vial:** Se corrigió `peligo_inmediato_detenerse` a `peligro_inmediato_detenerse` en `evaluar_seguridad_conduccion/4`.
2. **Cobertura del 100% de síntomas (0 hechos huérfanos):** Se incorporó la falla #15 (`falla_direccion_hidraulica_bomba`) y la Regla 15 (`regla_direccion_hidraulica_15`) para conectar los síntomas `volante_duro_pesado` y `liquido_direccion_bajo`.
3. **Eliminación de puntos de elección duplicados en disyunciones (`;`):** Se encapsuló la condición de cada `regla_diagnostico/4` dentro de `once(( ... ))` para que cada regla tenga éxito a lo sumo una vez por falla y el backtracking con `;` solo arroje diagnósticos distintos.
4. **Calibración del umbral de evidencia ponderada:** En `diagnosticar_por_evidencia/5`, cuando el usuario ingresa 2 o más síntomas se exige al menos un síntoma primario, mínimo 2 coincidencias y 50 puntos, evitando falsos positivos por síntomas secundarios aislados.
5. **Validación inteligente tras eliminar sinónimos/duplicados:** `validar_consulta/3` ahora verifica `traducir_relato_usuario(ListaEntrada, [_UnicoSintoma])`, detectando `datos_insuficientes` incluso si el usuario escribió dos sinónimos del mismo síntoma (ej. `[jalonea, tirones]`).
6. **Limpieza total de la versión sin comentarios:** Se eliminaron todos los comentarios de línea y de fin de línea en `diagnostico_automotriz_sin_comentarios.pl` y se completaron los alias en `palabra_clave_sintoma/2`.

## 2. Guía de Archivos Entregados y Para Qué Funciona Cada Uno

A continuación se detalla la función exacta de cada archivo generado para que sepas cuál usar al programar, cuál entregar en el repositorio y cuál leer para estudiar tu exposición:

| Nombre del Archivo | Formato | Para Qué Funciona y Cuándo Usarlo |
|---|---|---|
| **`diagnostico_automotriz_sin_comentarios.pl`** | Código fuente SWI-Prolog (`.pl`) | **Versión limpia de producción (685 líneas, 235 cláusulas puras sin `%`).** Úsala para cargar el programa en SWI-Prolog (`File -> Consult...`), correr `ejecutar_pruebas.` y conectarla al backend web si tu equipo prefiere un archivo compacto sin bloques de texto explicativo. |
| **`diagnostico_automotriz_comentado.pl`** | Código fuente SWI-Prolog (`.pl`) | **Versión documentada académicamente (852 líneas).** Contiene exactamente la misma lógica auditada que la versión limpia, pero incluye encabezados institucionales (ESCOM-IPN), explicación de argumentos (`+Entrada`, `-Salida`) y comentarios en cada sección. Es ideal para subir al repositorio de GitHub como entregable documentado. |
| **`Manual_Estudio_y_Exposicion_Prolog_ESCOM.pdf`** | Documento PDF (7 páginas) | **Tu manual personal de estudio para la defensa oral.** Explica el código bloque por bloque y línea por línea (qué significan `:-`, `,`, `;`, `\+`, `!`, `[H\|T]`, `is`, `findall`), cómo funciona cada una de las reglas y predicados recursivos, e incluye un **Guion de Preguntas y Respuestas de Defensa** para responderle al profesor el día de la evaluación. |
| **`Guia_Consultas_y_10_Casos_Prueba_Prolog.pdf`** | Documento PDF (3 páginas) | **Tu acordeón práctico de pruebas en consola y entregable de reporte.** Contiene todas las consultas (`?- ...`) listas para copiar y pegar en SWI-Prolog divididas por categoría (hechos, recursividad, reglas exactas, backtracking con `;`, palabras coloquiales y validación), además de la **Tabla Oficial de los 10 Casos de Prueba** lista para integrar en el Entregable #6 del reporte técnico. |
| **`Contexto_Proyecto_y_Guia_de_Archivos_AutoCheck_Prolog.md`** | Documento Markdown (`.md`) | **Este documento maestro de referencia.** Reúne todo el contexto del proyecto, el resumen de cumplimiento de la rúbrica, el inventario de archivos entregados y los **prompts especializados de generación de video** para presentar tu proyecto. |

## 3. Cómo Cargar Tus Archivos `.pl` en SWI-Prolog (Recordatorio Rápido)

Para evitar el error `source_sink does not exist` en Windows:
1. Abre **SWI-Prolog**.
2. En la barra superior haz clic en **`File` -> `Consult...`**.
3. Busca en tu carpeta de **Descargas (`Downloads`)** el archivo `diagnostico_automotriz_sin_comentarios.pl` (o `diagnostico_automotriz_comentado.pl`) y ábrelo.
4. En la consola escribe `ejecutar_pruebas.` (con el punto final) y presiona **Enter** para ver correr los 10 casos de prueba automáticamente.

## 4. Prompts para Generar un Video con el Modelo de Video de Google (Argon / Veo)

A continuación tienes dos modalidades de prompt diseñadas específicamente para el modelo de generación de video de Google (**Argon / Google Veo**):
- **Opción A:** Un **Prompt Maestro Único** (en español y en inglés, ya que los modelos de video de Google suelen lograr aún mayor fidelidad visual y cinematográfica cuando el prompt técnico se ingresa en inglés).
- **Opción B:** Una **Secuencia de 3 Prompts por Escenas (Storyboard de 3 clips)** por si deseas generar 3 videos cortos (1. El problema al conducir y síntomas físicos sin escáner; 2. El motor lógico en Prolog unificando reglas y backtracking; 3. El diagnóstico de seguridad vial y pasos de solución) para unirlos en la introducción de tu presentación o interfaz web.

### Opción A: Prompt Maestro Único (Video Demostrativo Cinematográfico)

#### Versión en Español (Lista para copiar y pegar)
> **Prompt (Español):**  
> Video tecnológico y cinematográfico en resolución 4K, iluminación realista estilo ingeniería automotriz moderna. La escena inicia desde el punto de vista de un conductor dentro de un automóvil sintiendo vibraciones en el volante al frenar, observando el testigo de temperatura encendido en el tablero y humo blanco saliendo del escape con el auto detenido, sin ningún escáner electrónico conectado. De forma fluida, la cámara hace una transición holográfica translúcida sobre el motor del vehículo donde aparecen nodos lógicos luminosos y árboles de decisión de inteligencia artificial simbólica (estilo Prolog) conectando las sensaciones del conductor y las observaciones físicas (color de humo, niveles de líquidos, vibración del motor) mediante reglas lógicas y retroceso (backtracking). Finalmente, la visualización proyecta un panel de diagnóstico limpio en color ámbar y verde esmeralda que muestra la falla mecánica exacta detectada, una alerta de seguridad vial y cuatro pasos claros de reparación mecánica. Movimiento de cámara suave (dolly-in), profundidad de campo cinematográfica, estética limpia, sin texto borroso ni marcas de agua.

#### Versión en Inglés (Recomendada para máxima precisión visual en el modelo de Google)
> **Prompt (English):**  
> Cinematic 4K tech-automotive commercial, photorealistic lighting, shallow depth of field. The shot opens inside a modern car from the driver's perspective: the driver feels the steering wheel vibrating while braking, sees glowing dashboard warning lights, and steps out to inspect thick white exhaust smoke and fluid reservoirs under the open hood—performing a real-world pre-scanner inspection without any OBD-II cable. Smoothly, a futuristic amber and emerald-green holographic overlay materializes over the engine bay, visualizing a symbolic AI Expert System (Prolog logic tree): glowing nodes representing driving sensations and physical observations unify through logical inference rules and backtracking paths. The holographic tree resolves into a crisp diagnostic alert card showing critical driving safety status and step-by-step mechanical repair solutions. Smooth camera dolly movement, ultra-detailed automotive engineering aesthetic, clean composition, text-free, no watermarks.

### Opción B: Prompts Secuenciales por Escenas (Por si generas 3 clips para tu exposición)

| Escena | Qué muestra en tu exposición | Prompt para pegar en el generador de video de Google |
|---|---|---|
| **Clip 1: El Problema (Sensaciones al manejar + Inspección sin escáner)** | Cómo el usuario detecta fallas sintiendo el auto al conducir y observando humo, motor y líquidos sin escáner. | `Cinematic 4K shot of a driver experiencing car trouble on an urban road: close-up of hands feeling a vibrating steering wheel and a spongy brake pedal, cutting to the parked car with the hood open where the driver inspects engine vibrations, fluid levels, and white exhaust smoke without any electronic scanner. Realistic natural lighting, automotive documentary style, clean composition, text-free, no watermarks.` |
| **Clip 2: El Motor de Inferencia en Prolog (Unificación y Backtracking)** | Cómo tu programa en Prolog procesa los hechos, evalúa las 15 reglas lógicas y hace backtracking para encontrar las causas. | `Futuristic 3D data visualization over a translucent car engine in a dark studio with amber and cyan lighting: glowing symbolic logic nodes and decision trees branch out, illustrating Prolog unification and backtracking search across mechanical systems (cooling, brakes, ignition, clutch, suspension). Smooth orbital camera motion, high-tech engineering aesthetic, clean composition, text-free, no watermarks.` |
| **Clip 3: El Resultado (Seguridad Vial y Pasos de Solución)** | Cómo el sistema experto entrega el diagnóstico certero, el nivel de riesgo vial y los 4 pasos para solucionar la falla. | `Cinematic 4K shot in a modern automotive workshop: a hologram over a car engine highlights a repaired cylinder head gasket and brake system in glowing emerald green, showing a clear visual sequence of mechanical inspection and safe driving confirmation. Warm professional lighting, crisp focus, clean composition, text-free, no watermarks.` |
