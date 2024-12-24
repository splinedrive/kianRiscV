# To use, run the following commands in this directory:
# 
# docker build -t ulinux_asic_kianv_soc_builder .
# docker run -v `pwd`:`pwd` ulinux_asic_kianv_soc_builder make -C `pwd` all

FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y build-essential device-tree-compiler cpio rsync file wget unzip bc
