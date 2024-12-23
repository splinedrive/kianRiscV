# To use, run the following commands in this directory:
# 
# docker build -t linux_kianv_rv32_sv32_soc_builder .
# docker run -v `pwd`:`pwd` linux_kianv_rv32_sv32_soc_builder kian-build make -C `pwd` all

FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y build-essential device-tree-compiler cpio rsync file wget unzip bc
