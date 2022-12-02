/*
 Computes and displays the Mandelbrot set on the OLED display.
 (needs an SSD1351 128x128 OLED display plugged on the IceStick).
 This version uses floating-point numbers (much slower than mandelbrot_OLED.c
 that uses integer arithmetic).
*/

/* taken and adjusted for kianRiscV from https://github.com/BrunoLevy/learn-fpga */
#include <stdint.h>
#include "stdlib.c"

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
      short rgb = !(iter << 8)|(iter << 5)|(iter << 0);
      printf("\033[48;2;%d;%d;%dm ", (rgb >> 8) & 0xff, (rgb >> 4) & 0xff, rgb & 0xff);
      if(X == HRES-1) {
        printf("\033[48;2;0;0;0m");
        printf("\n");
      }

      Cr += dx;
    }
    Ci += dy;
  }
}


typedef unsigned char datum;
#define SIZE 256*1024*4/sizeof(datum)
//#define SIZE 640*480*2/sizeof(datum)//256*1024*4/sizeof(datum)
#define BASE 0x10000000
volatile datum *p = (volatile datum*) BASE;
//void main() RV32_FASTCODE;
void main() {

  short shift = 1;
  volatile short *q = (volatile short*) BASE;
  int iter = 1;
  for (;;) {

  volatile short *q = (volatile short*) BASE;

 // *((volatile uint32_t*) VIDEOENABLE) = 0x0;
  mandel(q, shift);
 // *((volatile uint32_t*) VIDEOENABLE) = 0x1;

  shift = shift >= 16 ? 1 : shift + 1;

//  wait_cycles(45000000*1);
  continue;
#if 0
    q = (volatile short*) BASE;
    for (int i = 0; i < 640*480; i++) {
      *q = 0x0ff00ff0;
      q++;
    }
    q = (volatile short*) BASE;
    for (int i = 0; i < 640*480; i++) {
      *q = 0x0f000f00;
      q++;
    }


    q = (volatile short*) BASE;
    for (int i = 0; i < 640*480; i++) {
      *q = 0x000f000f;
      q++;
    }
#endif

    print_char(13);
    print_str(GRN);
    print_str(BLINK);
    print_str(BOLD);
    print_str("Memory test iteration: ");
    print_dec(iter);
    print_char(13);
    print_str(RESET);
    print_str(BLINK_OFF);
    print_str_ln("=========================================");
    print_str(MAG);
    print_str("Size of datum         : ");
    print_str(WHT);
    print_str("0x");
    print_hex((unsigned int) sizeof(datum), 8);
    print_char(13);
    print_str(GRN);
    print_str("Size of memory to test: ");
    print_str(WHT);
    print_str("0x");
    print_hex((unsigned int) SIZE, 8);
    print_char(13);
    print_char(13);

    datum pattern = 1;
    datum antipattern = ~1;
    p = (volatile datum*) BASE;
    for (int i = 0; i < SIZE; i++, pattern++) {
      *p = pattern;
      p++;
    }

    print_str(CYN);
    print_str_ln("pattern write                       done!");

    pattern = 1;
    p = (volatile datum*) BASE;
    for (int i = 0; i < SIZE; i++, pattern++) {
//      print_hex((unsigned int) p, 8);
 //     print_char(13);
      if (*p != pattern) {
        print_str(RED);
        print_str("Error pattern in:");
        print_char(13);
        print_hex((unsigned int) pattern, 8);
        print_char(13);
        print_hex((unsigned int) p, 8);
        print_char(13);
        print_hex((unsigned int) *p, 8);
        print_char(13);
      }
      antipattern = ~pattern;
      *p = antipattern;
      p++;
    }

    print_str(YEL);
    print_str_ln("check pattern and antipattern write done!");

    p = (volatile datum*) BASE;
    pattern = 1;
    for (int i = 0; i < SIZE; i++, pattern++) {
      antipattern = ~pattern;
      if (*p != antipattern) {
        print_str(RED);
        print_str("Error antipattern in:");
        print_char(13);
        print_hex((unsigned int) antipattern, 8);
        print_char(13);
        print_hex((unsigned int) p, 8);
        print_char(13);
        print_hex((unsigned int) *p, 8);
        print_char(13);
      }
      *p = 0x00;
      p++;
    }
    print_str(WHT);
    print_str_ln("check antipattern and test          done!");
    print_str("\xa\xa\xa");

    iter++;
  }

}

