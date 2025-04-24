# Build stage
FROM nvidia/cuda:12.1.0-base-ubuntu22.04 AS builder

# Install minimal dependencies for the build
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-minimal \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install PyTorch with CUDA support - only needed components
RUN pip3 install --no-cache-dir --index-url https://download.pytorch.org/whl/cu121 \
    torch==2.0.1 \
    --extra-index-url https://pypi.org/simple

# Runtime stage - minimal image
FROM nvidia/cuda:12.1.0-base-ubuntu22.04

# Copy Python and PyTorch from builder
COPY --from=builder /usr/bin/python3* /usr/bin/
COPY --from=builder /usr/lib/python3* /usr/lib/python3*/
COPY --from=builder /usr/local/lib/python3*/dist-packages /usr/local/lib/python3*/dist-packages/

# Add pip
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /app

# Copy your Python script into the container
COPY gemm.py /app/

# Create optimized entrypoint script
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Command to run when the container starts
ENTRYPOINT ["/app/entrypoint.sh"]
