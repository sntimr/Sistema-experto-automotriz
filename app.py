# Servidor Flask y API REST
from flask import Flask, request, jsonify, render_template, send_from_directory
from pyswip import Prolog
import os

app = Flask(__name__, static_folder='static', static_url_path='')

# Inicializar y cargar la base de conocimiento de Prolog
prolog = Prolog()
PROLOG_FILE = "prueba.pl"

if os.path.exists(PROLOG_FILE):
    prolog.consult(PROLOG_FILE)
else:
    print(f"Advertencia: No se encontró el archivo {PROLOG_FILE}")

@app.route('/')
def index():
    return send_from_directory('static', 'index.html')

if __name__ == '__main__':
    print("Iniciando Servidor del Sistema Experto...")
    app.run(host='0.0.0.0', port=5000, debug=True)