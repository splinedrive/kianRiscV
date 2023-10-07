/*
   Computes and displays the Mandelbrot set on the OLED display.
   (needs an SSD1351 128x128 OLED display plugged on the IceStick).
   This version uses floating-point numbers (much slower than mandelbrot_OLED.c
   that uses integer arithmetic).
   */

/* taken and adjusted for kianRiscV from https://github.com/BrunoLevy/learn-fpga */
#include <stdint.h>
#include "kianv_stdlib_hdmi.h"

#define HRES 80
#define VRES 60

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

void mandel(volatile Pixel *framebuffer, uint32_t shift) {
  //  GL_write_window(0,0,W-1,H-1);
  int Ci = ymin;
  for(int Y = 0; Y < VRES; ++Y) {
    int Cr = xmin;
    for(int X = 0; X< HRES; ++X) {
      int Zr = Cr;
      int Zi = Ci;
      int iter = 255;
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
      if(indexed) {
        //   GL_WRITE_DATA_UINT16(iter==0?0:(iter%15)+1);
                  setpixel(framebuffer, X, Y, iter==0?0:(iter%15)+1);
      } else {
        //   GL_WRITE_DATA_UINT16((iter << 19)|(iter << 2));
        setpixel(framebuffer, X, Y, (iter << 8));
                 setpixel(framebuffer, X, Y, ((iter << 19) | (iter << 2)) << shift);

      }

      Cr += dx;
    }
    Ci += dy;
  }
}


#define FRAMEBUFFER (volatile short *) 0x10000000
volatile short *fb = FRAMEBUFFER;
void main() {

  int shift = 0;
  for (;;) {
    mandel(fb, shift++);

  }

}
