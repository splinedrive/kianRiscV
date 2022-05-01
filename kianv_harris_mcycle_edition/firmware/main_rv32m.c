#include <stdint.h>
#include "kianv_stdlib.h"

void main() {
  for (;;) {
    /*
    asm volatile("addi x1,x0,5");
    asm volatile("addi x2,x0,3");
    asm volatile("mul  x3,x1,x2");
    asm volatile("div  x4,x3,x2");
    */
    for (unsigned int i = 1; i < 1<<16; i++) {
      unsigned int square = i*i;
      print_str("Multiplication and Division:");
      print_dec(i);
      print_chr('*');
      print_dec(i);
      print_chr('=');
      print_dec(square);
      print_chr('/');
      print_dec(i);
      print_chr('=');
      print_dec(square/i);
      print_chr(10);
    }

    for (unsigned int i = 1<<16; i >= 1; i--) {
      unsigned int square = i*i;
      print_str("Multiplication and Division:");
      print_dec(i);
      print_chr('*');
      print_dec(i);
      print_chr('=');
      print_dec(square);
      print_chr('/');
      print_dec(i);
      print_chr('=');
      print_dec(square/i);
      print_chr(10);
    }
  }
}
