sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev 
git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
cd riscv-gnu-toolchain
./configure --with-arch=rv32im --prefix=/opt/riscv32im
sudo make -j $(nproc)
sudo ln -s `ls -1 /opt/riscv32im/lib/gcc/riscv32-unknown-elf/` /opt/riscv32im/lib/gcc/riscv32-unknown-elf/last
