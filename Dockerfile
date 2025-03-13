# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies for Calibre-Web and its dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnss3 \
    libx11-6 \
    libjpeg-dev \
    libpng-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application code (optional if using PyPI package)
COPY . .

# Expose port (Railway အတွက် 8080)
EXPOSE 8080

# Set environment variables
ENV CALIBRE_PORT=8080
ENV CALIBRE_HOST=0.0.0.0

# Run Calibre-Web
CMD ["python", "cps.py"]
