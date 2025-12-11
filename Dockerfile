FROM ubuntu:22.04

# Install dependencies strictly required for building the .deb package
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    dpkg \
    lintian \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
