#.word
(echo .org 0; echo $1) | /opt/riscv32im/bin/riscv32-unknown-elf-as;/opt/riscv32im/bin/riscv32-unknown-elf-objdump  -d -S -l -F  -Mnumeric,no-aliases ./a.out

