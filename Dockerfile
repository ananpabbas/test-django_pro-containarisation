FROM ubuntu:22.04

WORKDIR /app

# Install system deps + MySQL client dev libraries (required for mysqlclient)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    default-libmysqlclient-dev \
    gcc \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /opt/venv

COPY requirements.txt /app/
RUN /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8000

CMD ["/opt/venv/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]