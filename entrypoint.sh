#!/bin/bash
set -e

echo "Installing minimal build dependencies..."
apt-get update && apt-get install -y --no-install-recommends \
  cmake \
  build-essential \
  git \
  && rm -rf /var/lib/apt/lists/*

echo "Installing TileLang..."
# Install with minimal parallelism and minimal dependencies
MAKEFLAGS="-j1" CMAKE_BUILD_PARALLEL_LEVEL=1 pip3 install --no-cache-dir git+https://github.com/tile-ai/tilelang.git

echo "Cleaning up build dependencies..."
apt-get purge -y cmake build-essential git
apt-get autoremove -y
apt-get clean

echo "Running application..."
python3 /app/gemm.py
