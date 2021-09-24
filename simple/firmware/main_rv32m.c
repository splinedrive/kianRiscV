#include <stdint.h>
#include "kianv_stdlib.h"

void main() {
  for (;;) {
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
