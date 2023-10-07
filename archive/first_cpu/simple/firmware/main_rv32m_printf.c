#include <stdint.h>
#include "stdlib.c"

void main() {
  for (;;) {
    for (unsigned int i = 1; i < 1<<16; i++) {
      unsigned int square = i*i;
      printf("Multiplication and Division: %d*%d=%d/%d=%d\n", i, i, square, i, square / i);
    }

    for (unsigned int i = 1<<16; i >= 1; i--) {
      unsigned int square = i*i;
      printf("Multiplication and Division: %d*%d=%d/%d=%d\n", i, i, square, i, square / i);
    }
  }
}
