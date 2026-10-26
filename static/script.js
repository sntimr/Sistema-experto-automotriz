document.addEventListener('DOMContentLoaded', () => {
    const contenedorSintomas = document.getElementById('contenedor-sintomas');
    const listaSeleccionados = document.getElementById('lista-seleccionados');
    const contadorSeleccionados = document.getElementById('contador-seleccionados');
    const formDiagnostico = document.getElementById('form-diagnostico');
    const seccionResultadosContainer = document.getElementById('resultados');
    const listaResultados = document.getElementById('lista-resultados');
    const mensajeExcepcion = document.getElementById('mensaje-excepcion');
    const btnLimpiar = document.getElementById('btn-limpiar');

    let mapaDetalles = {};

    // 1. Cargar sistemas y síntomas desde Flask
    async function cargarSintomas() {
        try {
            const response = await fetch('/api/sintomas');
            const data = await response.json();

            if (data.exito && data.sistemas) {
                contenedorSintomas.innerHTML = '';
                mapaDetalles = {};

                data.sistemas.forEach((sistema, index) => {
                    if (!sistema.elementos || sistema.elementos.length === 0) return;

                    const collapseId = `collapse_${sistema.id}`;
                    const headingId = `heading_${sistema.id}`;
                    const isFirst = '';
                    const isExpanded = index === 0 ? 'true' : 'false';

                    let checkboxesHTML = '';
                    sistema.elementos.forEach(el => { mapaDetalles[el.id] = el.detalle;
                        checkboxesHTML += `
                            <div class="col-12 col-md-6 mb-2">
                                <div class="form-check p-2 border rounded bg-white h-100 d-flex align-items-center">
                                    <input class="form-check-input mt-0 me-2 checkbox-sintoma" type="checkbox" value="${el.id}" id="s_${el.id}" name="sintomas">
                                    <label class="form-check-label text-dark" for="s_${el.id}" style="cursor: pointer; font-size: 0.9rem;">
                                        ${el.detalle}
                                    </label>
                                </div>
                            </div>
                        `;
                    });

                    const accordionItem = document.createElement('div');
                    accordionItem.className = 'accordion-item mb-2 border rounded';
                    accordionItem.innerHTML = `
                        <h2 class="accordion-header" id="${headingId}">
                            <button class="accordion-button ${index !== 0 ? 'collapsed' : ''} fw-semibold collapsed shadow-none text-primary" type="button" data-bs-toggle="collapse" data-bs-target="#${collapseId}" aria-expanded="${isExpanded}" aria-controls="${collapseId}">
                                ${sistema.nombre}
                            </button>
                        </h2>
                        <div id="${collapseId}" class="accordion-collapse collapse ${isFirst}" aria-labelledby="${headingId}" data-bs-parent="#contenedor-sintomas">
                            <div class="accordion-body bg-white">
                                <div class="row">
                                    ${checkboxesHTML}
                                </div>
                            </div>
                        </div>
                    `;
                    contenedorSintomas.appendChild(accordionItem);
                });
                activarEventosSeleccion();
            } else {
                contenedorSintomas.innerHTML = '<div class="alert alert-warning text-center">No se encontraron síntomas en la base de conocimiento.</div>';
            }
        } catch (error) {
            console.error('Error al conectar con la API:', error);
            contenedorSintomas.innerHTML = '<div class="alert alert-danger text-center">Error de conexión al cargar los síntomas del servidor.</div>';
        }
    }

    // 2. Control de la lista inferior en tiempo real
    function activarEventosSeleccion() {
        const checkboxes = document.querySelectorAll('.checkbox-sintoma');
        checkboxes.forEach(cb => {
            cb.addEventListener('change', actualizarListaSeleccionada);
        });
    }

    function actualizarListaSeleccionada() {
        const seleccionados = document.querySelectorAll('.checkbox-sintoma:checked');
        contadorSeleccionados.textContent = seleccionados.length;

        if (seleccionados.length === 0) {
            listaSeleccionados.innerHTML = '<em class="text-muted">Ningún síntoma seleccionado.</em>';
            return;
        }

        listaSeleccionados.innerHTML = '';
        seleccionados.forEach(cb => {
            const id = cb.value;
            const detalleText = mapaDetalles[id] || id;
            const li = document.createElement('li');
            li.className = 'text-dark small mb-1';
            li.innerHTML = `${detalleText}`;
            listaSeleccionados.append(li);
        });
    }

    // 3. Envío al Backend para Diagnóstico
    formDiagnostico.addEventListener('submit', async (e) => {
        e.preventDefault();
        const seleccionados = document.querySelectorAll('.checkbox-sintoma:checked');
        const idsSintomas = Array.from(seleccionados).map(cb => cb.value);

        if (idsSintomas.length === 0) {
            alert('Por favor, seleccione al menos un síntoma para realizar el diagnóstico.');
            return;
        }

        try {
            const response = await fetch('/api/diagnosticar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ sintomas: idsSintomas })
            });

            const resultado = await response.json();
            renderizarResultados(resultado);

        } catch (error) {
            console.error('Error al realizar el diagnóstico:', error);
            alert('Ocurrió un error al comunicarse con el servidor backend.');
        }
    });

    // 4. Renderizado de Resultados
    function renderizarResultados(resultado) {
        seccionResultadosContainer.style.display = 'block';
        listaResultados.innerHTML = '';

        if (!resultado.exito) {
            mensajeExcepcion.style.display = 'block';
            return;
        }

        const diagnosticos = resultado.diagnosticos || [resultado];

        if (diagnosticos.length === 0) {
            mensajeExcepcion.style.display = 'block';
            return;
        }

        mensajeExcepcion.style.display = 'none';

        diagnosticos.forEach((diag, index) => {
            const cardDiv = document.createElement('div');
            cardDiv.className = 'card';

            let contenidoFallaHTML = '';
            if (diag.causas_probables && diag.causas_probables.length > 0) {
                contenidoFallaHTML = `
                    <div class="mb-3">
                        <strong class="text-dark d-block mb-1">Causas Probables Evaluadas:</strong>
                        <ul class="list-group">
                            ${diag.causas_probables.map(c => `<li class="list-group-item bg-light small py-2 ">${c}</li>`).join('')}
                        </ul>
                    </div>
                `;
            } else {contenidoFallaHTML = `<h5 class="card-title text-primary fw-bold mb-3">${diag.falla}</h5>`;}

            let recomendacionesHTML = '';
            if (diag.recomendaciones && diag.recomendaciones.length > 0) {
                recomendacionesHTML = `
                    <div class="mt-3">
                        <strong class="card-text text-muted mb-2">Recomendaciones a seguir:</strong>
                        <ul class="list-group">
                            ${diag.recomendaciones.map(r => `<li class="list-group-item bg-light small py-2"> ${r}</li>`).join('')}
                        </ul>
                    </div>
                `;
            }

            cardDiv.innerHTML = `
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <span class="fw-bold">Diagnóstico</span>
                    <span class="badge bg-light text-primary">${diag.sistema || 'Sistema Automotriz'}</span>
                </div>
                <div class="card-body">
                    ${contenidoFallaHTML}
                    <p class="card-text text-danger mb-2"> ${diag.riesgo || 'No especificado'}</p>
                    <p class="card-text text-muted mb-2"><strong>Explicación:</strong> ${diag.explicacion || 'Sin detalles'}</p>
                    ${recomendacionesHTML}
                </div>
            `;
            listaResultados.appendChild(cardDiv);
        });

        seccionResultadosContainer.scrollIntoView({ behavior: 'smooth' });
    }

    // 5. Botón Limpiar Selección
    btnLimpiar.addEventListener('click', () => {
        document.querySelectorAll('.checkbox-sintoma').forEach(cb => cb.checked = false);
        actualizarListaSeleccionada();
        seccionResultadosContainer.style.display = 'none';
        listaResultados.innerHTML = '';
        mensajeExcepcion.style.display = 'none';
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    cargarSintomas();
});