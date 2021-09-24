/*
 Computes and displays the Mandelbrot set on the OLED display.
 (needs an SSD1351 128x128 OLED display plugged on the IceStick).
 This version uses floating-point numbers (much slower than mandelbrot_OLED.c
 that uses integer arithmetic).
*/

/* adapted for kianv riscv soc 2021, Hirosh Dabui */
#include <stdint.h>
#include <float.h>
#include "kianv_stdlib.h"

const int HRES = 96;
const int VRES = 64;
int indexed = 0;

#define W HRES
#define H VRES

#define xmin -2.0
#define ymax  2.0
#define ymin -2.0
#define xmax  2.0
#define dx (xmax-xmin)/(float)W
#define dy (ymax-ymin)/(float)H

void mandel(Pixel *framebuffer, short shift) {
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
       setpixel(framebuffer, X, Y, (iter << shift)|!(iter << shift)|(iter << shift));
      //setpixel(framebuffer, X, Y, (iter << 8)|!(iter << 5)|(iter << 0));
      Cr += dx;
    }
    Ci += dy;
  }
}


#define BASE 0x10000000
void main() {


  short shift = 1;
  short *q = (volatile short*) BASE;
  int iter = 1;
  volatile short *p = (volatile short *) BASE;

  /*
  for (int i = 0; i < 640*480; i++) { 
    *p = 0;
    p++;
  }
  */

  for (;;) {

    short *q = (volatile short*) BASE;

    mandel(q, shift);

    shift = shift >= 8 ? 1 : shift + 1;

  }
}

