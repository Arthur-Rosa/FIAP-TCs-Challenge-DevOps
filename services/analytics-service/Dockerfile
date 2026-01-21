FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends wget && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

ENV PORT=8005
EXPOSE 8005

CMD ["gunicorn", "--bind", "0.0.0.0:8005", "--workers", "2", "--timeout", "120", "app:app"]

