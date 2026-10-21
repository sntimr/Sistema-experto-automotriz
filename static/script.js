document.addEventListener('DOMContentLoaded', () =>{
    const cargarSintomas = document.getElementById('form-diagnostico');
    const contenedorSintomas = document.getElementById('contenedor-sintomas');
    const seccionResultados = document.getElementById('seccion-resultados');
    const listaResultados = document.getElementById('lista-resultados');
    const mensajeExcepcion = document.getElementById('mensaje-excepcion');
    const btnLimpiar = document.getElementById('btn-limpiar'); 

    btnLimpiar.addEventListener('click', () => {
        const checkboxes = document.querySelectorAll('input[name="sintomas"]');
        checkboxes.forEach(cb => cb.checked = false);
        seccionResultados.style.display = 'none';
        listaResultados.innerHTML = '';
        mensajeExcepcion.style.display = 'none';
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });
});