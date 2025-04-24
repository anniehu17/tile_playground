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
  && rm -rf /var/lib/apt/lists/*

# Install TileLang which will pull in PyTorch as needed
echo "Installing TileLang..."
MAKEFLAGS="-j1" CMAKE_BUILD_PARALLEL_LEVEL=1 pip3 install git+https://github.com/tile-ai/tilelang.git

# Run the application
echo "Running TileLang GEMM application..."
python3 /app/gemm.py
