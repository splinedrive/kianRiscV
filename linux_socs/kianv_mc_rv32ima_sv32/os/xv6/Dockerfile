# To use, run the following commands in this directory:
# 
# docker build -t xv6_unix_kianv_rv32_sv32_soc_builder .
# docker run -v `pwd`:`pwd` xv6_unix_kianv_rv32_sv32_soc_builder make -C `pwd`  -f Makefile.build

FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y git build-essential device-tree-compiler cpio rsync file wget unzip bc gcc libgmp-dev libmpfr-dev gawk
