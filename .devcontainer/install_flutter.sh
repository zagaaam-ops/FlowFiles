#!/bin/bash
set -e

echo "=== FlowFiles Development Environment Setup ==="

export DEBIAN_FRONTEND=noninteractive

echo "=== Installing Linux build dependencies ==="
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  cmake \
  ninja-build \
  pkg-config \
  libgtk-3-dev \
  clang

echo "=== Installing Flutter ==="

if [ ! -d "$HOME/flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable "$HOME/flutter"
else
  echo "Flutter already exists - skipping clone."
fi

export PATH="$HOME/flutter/bin:$PATH"

if ! grep -q 'HOME/flutter/bin' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/flutter/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "=== Flutter version ==="
flutter --version

echo "=== Compilers ==="
gcc --version | head -1
g++ --version | head -1

echo "=== CMake ==="
cmake --version | head -1

echo "=== Ninja ==="
ninja --version

echo "=== GTK ==="
pkg-config --modversion gtk+-3.0

echo "=== Flutter Linux ==="
flutter config --enable-linux-desktop

echo ""
echo "=== FlowFiles development environment ready ==="
