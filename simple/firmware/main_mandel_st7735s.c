/*
 Computes and displays the Mandelbrot set on the OLED display.
 (needs an SSD1351 128x128 OLED display plugged on the IceStick).
 This version uses floating-point numbers (much slower than mandelbrot_OLED.c
 that uses integer arithmetic).
*/

/* adapted for kianv riscv soc 2021, st7735s Hirosh Dabui */
#include "kianv_st7735s.h"

#define delay wait_cycles

#define HRES 160
#define VRES 128 

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

void mandel(short shift) {
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
      if(indexed) {
        //   GL_WRITE_DATA_UINT16(iter==0?0:(iter%15)+1);
   //     setpixel(framebuffer, X, Y, iter==0?0:(iter%15)+1);
      } else {
        //   GL_WRITE_DATA_UINT16((iter << 19)|(iter << 2));
    //    setpixel(framebuffer, X, Y, (iter << shift)|!(iter << shift)|(iter << shift));
        setpixel_st7735s(X, Y, (iter << shift), !(iter << shift), (iter << shift));

      }

      Cr += dx;
    }
    Ci += dy;
  }
}


//void main() RV32_FASTCODE;
void main() {

  short shift = 1;
  setup();
  for (;;) {

//    setpixel_st7735s(0, 0, 0x0000f);

  mandel(shift);

  shift = shift >= 16 ? 1 : shift + 1;

//  wait_cycles(45000000*1);
  }
}

