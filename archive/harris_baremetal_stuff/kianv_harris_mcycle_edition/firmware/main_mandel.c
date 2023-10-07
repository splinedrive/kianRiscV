/*
 Computes and displays the Mandelbrot set on the OLED display.
 (needs an SSD1351 128x128 OLED display plugged on the IceStick).
 This version uses floating-point numbers (much slower than mandelbrot_OLED.c
 that uses integer arithmetic).
*/

/* taken and adjusted for kianRiscV from https://github.com/BrunoLevy/learn-fpga */
#include <stdint.h>
#include "kianv_stdlib.h"

#define HRES 96
#define VRES 64

#define mandel_shift 10
#define mandel_mul (1 << mandel_shift)
#define xmin -2*mandel_mul
#define ymax  2*mandel_mul
#define ymin -2*mandel_mul
#define xmax  2*mandel_mul
#define dx (xmax-xmin)/HRES
#define dy (ymax-ymin)/VRES
#define norm_max (4 << mandel_shift)

int indexed = 0;

void mandel(volatile Pixel *framebuffer, short shift) {
  //  GL_write_window(0,0,W-1,H-1);
  int Ci = ymin;
  for(int Y = 0; Y < VRES; ++Y) {
    int Cr = xmin;
    for(int X = 0; X< HRES; ++X) {
      int Zr = Cr;
      int Zi = Ci;
      int iter = 15;
      while(iter > 0) {
        int Zrr = (Zr * Zr) >> mandel_shift;
        int Zii = (Zi * Zi) >> mandel_shift;
        int Zri = (Zr * Zi) >> (mandel_shift - 1);
        Zr = Zrr - Zii + Cr;
        Zi = Zri + Ci;
        if(Zrr + Zii > norm_max) {
          break;
        }
        --iter;
      }
      if(1) {
        //   GL_WRITE_DATA_UINT16(iter==0?0:(iter%15)+1);
          setpixel(framebuffer, X, Y, (iter==0?0:(iter%15)+1)<<shift);
      } else {
        //   GL_WRITE_DATA_UINT16((iter << 19)|(iter << 2));
          setpixel(framebuffer, X, Y, (iter << shift)|!(iter << shift)|(iter << shift));

      }

      Cr += dx;
    }
    Ci += dy;
  }
}


//void main() RV32_FASTCODE;
void main() {

  short shift = 1;
  int iter = 1;
  init_oled1331();
  for (int y = 0; y < VRES; y++)
    for (int x = 0; x < HRES; x++)
      setpixel(0, x, y, 0);
  for (;;) {


  mandel(0, shift);

  shift = shift >= 16 ? 1 : shift + 1;

  }
}

