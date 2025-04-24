#!/bin/sh
set -e

# Install only the dependencies we need
echo "Installing dependencies..."
apt-get update && apt-get install -y --no-install-recommends \
  python3 \
  python3-pip \
  cmake \
  build-essential \
  git \
  wget \
  gnupg \
  && rm -rf /var/lib/apt/lists/*

# Install minimal CUDA toolkit for nvcc
echo "Installing CUDA toolkit..."
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb
apt-get update && apt-get install -y cuda-nvcc-12-1
rm cuda-keyring_1.1-1_all.deb

# Set CUDA environment variables
export PATH=/usr/local/cuda-12.1/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64:$LD_LIBRARY_PATH

# Install TileLang which will pull in PyTorch as needed
echo "Installing TileLang..."
MAKEFLAGS="-j1" CMAKE_BUILD_PARALLEL_LEVEL=1 pip3 install git+https://github.com/tile-ai/tilelang.git

# Run the application
echo "Running TileLang GEMM application..."
python3 /app/gemm.py
