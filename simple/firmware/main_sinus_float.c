// kian riscv sinus demo, author Hirosh Dabui
#include <stdint.h>
#include <math.h>
#include <fenv.h>
#include "kianv_stdlib.h"

#define HRES 96
#define VRES 64

void main() {
  int i = 0;
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

    //fill_oled(0);
  }


}
