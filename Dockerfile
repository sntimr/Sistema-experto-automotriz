FROM python:3.10-bullseye

RUN apt-get update && apt-get install -y \
    swi-prolog \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

EXPOSE 5000

CMD sh -c "gunicorn --bind 0.0.0.0:\${PORT:-5000} app:app --workers 1 --timeout 120"