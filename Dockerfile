FROM python:3.10-slim

WORKDIR /app
COPY . /app

RUN apt-get update && \
    apt-get install -y git python3-dev python3-venv \
    gcc libgomp1 libgl1-mesa-glx libglib2.0-0 pkg-config libcairo2-dev libgirepository1.0-dev default-jdk nginx vim && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install gunicorn && \
    pip install torch --index-url https://download.pytorch.org/whl/cpu

CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]