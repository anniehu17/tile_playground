# Start with CUDA 12.1 for H100 support
FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

# Set up a working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    cmake \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch with CUDA support
RUN pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Install TileLang
RUN pip3 install --no-cache-dir tilelang

# Copy your Python script into the container
COPY gemm.py /app/

# Command to run when the container starts
CMD ["python3", "gemm.py"]
