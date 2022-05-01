/*
 Computes and displays the Mandelbrot set on the OLED display.
 (needs an SSD1351 128x128 OLED display plugged on the IceStick).
 This version uses floating-point numbers (much slower than mandelbrot_OLED.c
 that uses integer arithmetic).
*/

/* taken and adjusted for kianRiscV from https://github.com/BrunoLevy/learn-fpga */
/* adapted for kianv riscv soc 2021, st7735s Hirosh Dabui */
#include <stdint.h>
#include "kianv_st7735s.h"

const int HRES = 160;
const int VRES = 128;
int indexed = 0;

#define W HRES
#define H VRES

#define xmin -2.0
#define ymax  2.0
#define ymin -2.0
#define xmax  2.0
#define dx (xmax-xmin)/(float)W
#define dy (ymax-ymin)/(float)H

void mandel(short shift) {
  uint32_t total_ticks = 0;
  //   GL_write_window(0,0,W-1,H-1);
  float Ci = ymin;
  for(int Y=0; Y<H; ++Y) {
    float Cr = xmin;
    for(int X=0; X<W; ++X) {
      float Zr = Cr;
      float Zi = Ci;
      int iter = 15;
      while(iter > 0) {
        float Zrr = (Zr * Zr);
        float Zii = (Zi * Zi);
        float Zri = 2.0 * (Zr * Zi);
        Zr = Zrr - Zii + Cr;
        Zi = Zri + Ci;
        if(Zrr + Zii > 4.0) {
          break;
        }
        --iter;
      }
        setpixel_st7735s(X, Y, (iter << shift), !(iter << shift), (iter << shift));
      Cr += dx;
    }
    Ci += dy;
  }
}


void main() {

  short shift = 1;
  setup();
  for (;;) {

    mandel(shift);

    shift = shift >= 16 ? 1 : shift + 1;

  }
}

