// kian riscv sinus demo, author Hirosh Dabui
#include <stdint.h>
#include <math.h>
#include <fenv.h>
#include "kianv_stdlib.h"

#define HRES 96
#define VRES 64

void fill_oled(int rgb) {
  for (int y = 0; y < 64; y++) {
    for (int x = 0; x < 96; x++) {
      *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
    }
  }
}

void main() {
  int i = 0;
  init_oled1331();
  fill_oled(0);

  float div = 1.0;
  int count = 0;
  float delta = 0.2;
  for (;;) {
    for (int x = 0; x < 96; x++) {
      setpixel(0, x, 32.0*sinf(x/(96.0/(2.0*div))) + 32, count++);
    }
    for (int x = 0; x < 96; x++) {
      setpixel(0, x, 32.0*sinf(x/(96.0/(2.0*div))) + 32, 0);
    }

    div = div + delta;

    if (div > 15.0) delta = -1, div = 15.0;
    if (div < 1.0)  delta =  1, div = 1.0;
  }


}
