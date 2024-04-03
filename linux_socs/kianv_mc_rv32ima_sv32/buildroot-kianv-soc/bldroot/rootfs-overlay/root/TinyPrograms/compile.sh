for file in *.c; do
   riscv32-unknown-linux-gnu-gcc -lm "$file" -o "${file%.c}"
done

