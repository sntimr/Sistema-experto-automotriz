# Usar una imagen oficial de Python ligera basada en Debian/Ubuntu
FROM python:3.10-slim

# Instalar SWI-Prolog y dependencias del sistema operativo necesarias
RUN apt-get update && apt-get install -y \ 
    swi-prolog \
    && rm -rf /var/lib/apt/lists/*

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar e instalar las dependencias de Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar todo el código fuente del proyecto al contenedor
COPY . .

# Exponer el puerto estándar de la aplicación
EXPOSE 5000

# Comando para ejecutar la aplicación usando Gunicorn en producción
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]