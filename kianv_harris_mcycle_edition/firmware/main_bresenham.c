#include <stdint.h>
#include <float.h>
#include <string.h>
#include <math.h>
#define UART_TX    (volatile uint32_t  *) 0x30000000
#define UART_READY (volatile uint32_t  *) 0x30000000
#define VIDEOENABLE (volatile uint32_t *) 0x30000008

#define FB 0x10000000
#define HRES 640
#define VRES 480
#define FBSIZE HRES*VRES
typedef short Pixel;


//const int HRES = 640;
//const int VRES = 480;


volatile short *fb = (volatile short*) FB;

#define RED   "\x1B[31m"
#define GRN   "\x1B[32m"
#define YEL   "\x1B[33m"
#define BLU   "\x1B[34m"
#define MAG   "\x1B[35m"
#define CYN   "\x1B[36m"
#define WHT   "\x1B[37m"
#define RESET "\x1B[0m"

#define CLS       "\x1B[2J"
#define BOLD      "\x1B[1m"
#define BLINK     "\x1B[5m"
#define BLINK_OFF "\x1B[25m"

void putchar(char c) {
  while (!*(UART_READY))
    ;
  *(UART_TX) = c;
}

void print_chr(char ch) {
  while (!*(UART_READY))
    ;
  *(UART_TX) = ch;
}

void print_str(char *p) {
  while (*p != 0) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = *(p++);
  }
}
void print_str_ln(char *p) {
  print_str(p);
  print_chr(10);
}

void print_dec(unsigned int val) {
  char buffer[10];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = '0' + *(--p);
  }
}

void print_hex(unsigned int val, int digits) {
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}

void setpixel(int x, int y, short color) {
  const int x_offset = x;
  const int y_offset = y*HRES;

  fb[x_offset + y_offset] = color;
}

void clear_fb() {
  memset((void *) fb, (short) 0, FBSIZE*sizeof(Pixel));
}


void draw_bresenham(int x0, int y0, int x1, int y1, short color)
{

   int dx =  abs(x1-x0), sx = x0<x1 ? 1 : -1;
   int dy = -abs(y1-y0), sy = y0<y1 ? 1 : -1;
   int err = dx+dy, e2; /* error value e_xy */

   for(;;){  /* loop */
      setpixel(x0,y0, color);
      if (x0==x1 && y0==y1) break;
      e2 = 2*err;
      if (e2 >= dy) { err += dy; x0 += sx; } /* e_xy+e_x > 0 */
      if (e2 <= dx) { err += dx; y0 += sy; } /* e_xy+e_y < 0 */
   }
  /*
  int dx = x1 - x0;
  int dy = y1 - y0;

  int xstep = 1;
  int ystep = 1;

  if (dx < 0) {
    dx = -dx;
    xstep = -1;
  }

  if (dy < 0) {
    dy = -dy;
    ystep = -1;
  }

  int x = x0;
  int y = y0;
  if (dy <= dx) {
    int eps = -dx;
    while (x != x1) {
      setpixel(x, y, color);
      eps = eps + (dy<<1);
      if (eps > 0) {
        y = y + ystep;
        eps = eps - (dx<<1);
      }
      x = x + xstep;
    }
  } else {
    int eps = -dy;
    while (y != y1) {
      setpixel(x, y, color);
      eps = eps + (dx<<1);
      if (eps > 0) {
        x = x + ystep;
        eps = eps - (dy<<1);
      }
      y = y + xstep;
    }
  }
  setpixel(x, y, color);
  */
}

//#define SIZE 256*1024*4/sizeof(datum)
#define SIZE 680*480*2///sizeof(datum)//640*480//256*1024*4/sizeof(datum)
void main() {
    clear_fb();
  for (;;) {

    for (int i = 0; i < 640/2; i = i + 5) {
      draw_bresenham(0, i, i, 439, 0x0fff);
      draw_bresenham(i, 0, 639, i, 0x0fff);
    }


    for (int i = 0; i < 640/2; i = i + 5) {
      draw_bresenham(0, i, i, 439, 0x0000);
      draw_bresenham(i, 0, 639, i, 0x0000);
    }

  }
}
