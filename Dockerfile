# Start with CUDA 12.1 for H100 support
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Set up a working directory
WORKDIR /app

# Install base dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch with CUDA support
RUN pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Copy your Python script into the container
COPY gemm.py /app/

# Set up entrypoint script
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Command to run when the container starts
ENTRYPOINT ["/app/entrypoint.sh"]
