# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies for Calibre-Web
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnss3 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application code
COPY . .

# Expose port (Railway အတွက် 8080)
EXPOSE 8080

# Set environment variable for port
ENV PORT=8080

# Run Calibre-Web
CMD ["python", "-m", "calibreweb", "--port", "8080"]
