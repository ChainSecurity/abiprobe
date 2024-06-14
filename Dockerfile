# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

WORKDIR /root

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Rust using rustup (the Rust installer)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Set environment variables for Rust
ENV PATH="/root/.cargo/bin:${PATH}"

# Verify the installation
RUN rustc --version

# # Install fuelup
RUN curl https://install.fuel.network | sh

ENV PATH="/root/.fuelup/bin:${PATH}"

# Install NVM (Node Version Manager)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Set environment variables for NVM and install Node.js v18.19.0
ENV NVM_DIR="/root/.nvm"
ENV NODE_VERSION="v20.14.0"
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION && \
    nvm alias default $NODE_VERSION

# Set PATH for Node.js and NPM
ENV PATH="$NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH"

# Verify the Node.js installation
RUN node -v

# Set the working directory
WORKDIR /usr/src/abiprobe

# Copy the current directory contents into the container at /usr/src/abiprobe
COPY . .


# Go to WORKDIR/ts-sdk and run npm install
WORKDIR /usr/src/abiprobe/ts-sdk
# Setup Ts SDK 
RUN npm install

# Go to WORKDIR/forc_project and run forc build
WORKDIR /usr/src/abiprobe/forc_project
# Build project
RUN forc build

# Set the working directory
WORKDIR /usr/src/abiprobe
# Build the Rust application
RUN cargo build

# Start a bash shell
ENTRYPOINT ["target/debug/abiprobe"]
