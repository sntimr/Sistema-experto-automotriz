from flask import Flask, jsonify, render_template, request
from pyswip import Prolog

# Inicializamos Flask apuntando a las carpetas estándar 'templates' y 'static'
app = Flask(__name__, template_folder='templates', static_folder='static')

# Inicializamos y cargamos Prolog
prolog = Prolog()
prolog.consult("logica.pl")

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/sintomas', methods=['GET'])
def obtener_sistemas():
    try:
        # Consultamos los sistemas del carro en Prolog
        sistemas_query = list(prolog.query("sistema_carro(ID, Nombre, _)"))
        list_sistemas = []

        for sys in sistemas_query:
            sys_id = str(sys['ID'])
            
            # Buscamos los síntomas que pertenecen a este sistema
            relaciones = list(prolog.query(f"pertenece_sistema(SintomaID, {sys_id})"))

            elementos_sistema = []
            for el in relaciones:
                sintoma_id = str(el['SintomaID'])
                
                # Buscamos en observaciones
                obs_res = list(prolog.query(f"observacion({sintoma_id}, _, Detalle)"))
                if obs_res:
                    elementos_sistema.append({
                        "id": sintoma_id,
                        "detalle": str(obs_res[0]['Detalle'])
                    })
                else:
                    # Buscamos en sensaciones si no está en observaciones
                    sens_res = list(prolog.query(f"sensacion({sintoma_id}, _, Detalle)"))
                    if sens_res:
                        elementos_sistema.append({
                            "id": sintoma_id,
                            "detalle": str(sens_res[0]['Detalle'])
                        })

            list_sistemas.append({
                "id": sys_id,
                "nombre": str(sys['Nombre']),
                "elementos": elementos_sistema
            })

        return jsonify({"exito": True, "sistemas": list_sistemas})

    except Exception as e:
        return jsonify({"exito": False, "error": str(e)}), 500

@app.route('/api/diagnosticar', methods=['POST'])
def diagnosticar():
    try:
        datos = request.get_json()
        sintomas_seleccionados = datos.get('sintomas', [])
        
        if not sintomas_seleccionados:
            return jsonify({"exito": False, "error": "No se seleccionaron síntomas."}), 400
            
        lista_prolog = "[" + ", ".join(f"'{s}'" for s in sintomas_seleccionados) + "]"
        
        query_str = f"diagnosticar_vehiculo({lista_prolog}, DiagnosticoFalla, NombreSistema, Riesgo, Explicacion, Recomendacion)"
        resultados_prolog = list(prolog.query(query_str))

        diagnosticos = []
        for res in resultados_prolog:

            falla = res.get('DiagnosticoFalla')
            if isinstance(falla, list):
                falla_str = " | ".join(str(item) for item in falla)
            else:
                falla_str = str(falla or 'Falla detectada')

            recomendaciones = res.get('Recomendacion', [])
            if isinstance(recomendaciones, list):
                lista_recs = [str(r) for r in recomendaciones]
            elif recomendaciones:
                lista_recs = [str(recomendaciones)]
            else:
                lista_recs = []

            diagnosticos.append({
                "falla": falla_str,
                "sistema": str(res.get('NombreSistema', 'Sistema Automotriz')),
                "riesgo": str(res.get('Riesgo', 'Por determinar')),
                "explicacion": str(res.get('Explicacion', 'Sin explicación detallada.')),
                "recomendaciones": lista_recs
            })

        if not diagnosticos:
            return jsonify({
                "exito": True,
                "diagnosticos": [{
                    "falla": "Sin diagnóstico concluyente",
                    "sistema": "General",
                    "riesgo": "Desconocido",
                    "explicacion": "Los síntomas seleccionados no generaron ninguna coincidencia en la base de conocimiento.",
                    "recomendaciones": ["Verifique los síntomas seleccionados e intente nuevamente."]
                }]
            })

        return jsonify({"exito": True, "diagnosticos": diagnosticos})

    except Exception as e:
        return jsonify({"exito": False, "error": str(e)}), 500



if __name__ == '__main__':
    app.run(debug=True, port=5000)