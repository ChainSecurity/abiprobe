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
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Rust using rustup (the Rust installer)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Set environment variables for Rust
ENV PATH="/root/.cargo/bin:${PATH}"

# Verify the installation
RUN rustc --version

# Install fuelup
RUN curl https://install.fuel.network | sh

ENV PATH="/root/.fuelup/bin:${PATH}"

# Install Node.js v20.x directly (no NVM — NVM is designed for interactive shells)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Verify the Node.js installation
RUN node -v

# Install fuel toolchain
RUN fuelup toolchain install nightly-2024-05-28

# Set the default toolchain
RUN fuelup default nightly-2024-05-28-x86_64-unknown-linux-gnu

# Set the working directory
WORKDIR /usr/src/abiprobe

# --- Layer ordering: dependencies first, source code last ---

# Copy dependency manifests first for better cache utilization
COPY Cargo.toml Cargo.lock ./

# Create a dummy main.rs to build dependencies (cache Rust deps separately)
RUN mkdir src && echo 'fn main() { println!("dummy"); }' > src/main.rs

# Build dependencies only (this layer is cached until Cargo.toml/Cargo.lock change)
RUN cargo build --release && rm -rf src

# Copy ts-sdk package.json and install npm dependencies
COPY ts-sdk/package.json ts-sdk/package-lock.json* ts-sdk/
WORKDIR /usr/src/abiprobe/ts-sdk
RUN npm install

# Copy forc_project and build it
WORKDIR /usr/src/abiprobe
COPY forc_project/ forc_project/
WORKDIR /usr/src/abiprobe/forc_project
RUN forc build

# Now copy the rest of the source code (this is the layer that changes most often)
WORKDIR /usr/src/abiprobe
COPY . .

# Build the Rust application in release mode
RUN cargo build --release

# Start the fuzzer
ENTRYPOINT ["target/release/abiprobe"]
