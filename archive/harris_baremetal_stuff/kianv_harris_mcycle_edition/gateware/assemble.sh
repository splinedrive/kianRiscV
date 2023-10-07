#.word
(echo .org 0; echo $1) | riscv32-unknown-elf-as;riscv32-unknown-elf-objdump  -d -S -l -F  -Mnumeric,no-aliases ./a.out

