FROM nvidia/cuda:12.1.0-base-ubuntu22.04

# Set up a working directory
WORKDIR /app

# Install Python and pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Copy your Python script into the container
COPY gemm.py /app/

# Install TileLang - add appropriate permissions for compilation
RUN pip install tilelang -f https://tile-ai.github.io/whl/nightly/cu121/

# Command to run when the container starts
CMD ["python3", "/app/gemm.py"]
