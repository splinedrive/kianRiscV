# To use, run the following commands in this directory:
# 
# docker build -t xv6_unix_kianv_rv32_sv32_soc_builder .
# docker run -v `pwd`:`pwd` xv6_unix_kianv_rv32_sv32_soc_builder make -C `pwd`  -f Makefile.build
# Base image
FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    git build-essential device-tree-compiler cpio rsync file wget unzip bc \
    gcc libgmp-dev libmpfr-dev gawk \
    autoconf automake libtool pkg-config \
    texinfo flex bison gettext \
    python3 \
    libexpat1-dev zlib1g-dev libncurses5-dev libncursesw5-dev \
    qemu-system-misc && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /xv6

# Copy source into container
COPY . .

# Default command: build xv6 (calls Makefile.build)
CMD ["make", "-C", "/xv6", "-f", "Makefile.build"]
