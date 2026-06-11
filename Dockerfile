FROM ubuntu:22.04

# 1. Set the working directory first
WORKDIR /app

# 2. Install system dependencies & clean up cache to keep the image slim
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# 3. Create the virtual environment in a reliable location
RUN python3 -m venv /opt/venv

# 4. Copy requirements and install dependencies using the venv's pip directly
COPY requirements.txt /app/
RUN /opt/venv/bin/pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of your project files
# Note: If 'test-django-pro' contains 'manage.py', we copy its CONTENTS to /app
COPY . /app/

# 6. Expose the Django port
EXPOSE 8000

# 7. Run the server using the virtual environment's absolute python path
CMD ["/opt/venv/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]
