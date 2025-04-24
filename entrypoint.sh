#!/bin/bash
set -e

# Install build dependencies
apt-get update && apt-get install -y cmake build-essential git

# Install TileLang with minimal parallelism
echo "Installing TileLang..."
MAKEFLAGS="-j1" pip3 install git+https://github.com/tile-ai/tilelang.git

# Run the application
echo "Running application..."
python3 /app/gemm.py
