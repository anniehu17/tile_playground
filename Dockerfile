# Use a minimal base image with CUDA support
FROM --platform=linux/amd64 nvidia/cuda:12.1.0-base-ubuntu22.04

# Set up a working directory
WORKDIR /app

# Copy your Python script and entrypoint into the container
COPY gemm.py entrypoint.sh /app/

# Make entrypoint executable
RUN chmod +x /app/entrypoint.sh

# Command to run when the container starts
ENTRYPOINT ["/app/entrypoint.sh"]
