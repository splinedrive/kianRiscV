#include <stdint.h>
#include <math.h>
#define UART_TX    (volatile uint32_t *) 0x30000000
#define UART_READY (volatile uint32_t *) 0x30000000
#define VIDEO      (volatile uint32_t *) 0x30000008
#define VIDEO_RAW  (volatile uint32_t *) 0x3000000C

void putchar(char c) {
  while (!*(UART_READY))
    ;
  *(UART_TX) = c;
}

void print_chr(char ch)
{
  while (!*(UART_READY))
    ;
  *(UART_TX) = ch;
}

void print_str(char *p)
{
  while (*p != 0) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = *(p++);
  }
}

void print_dec(unsigned int val)
{
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

void print_hex(unsigned int val, int digits)
{
  for (int i = (4*digits)-4; i >= 0; i -= 4) {
    while (!*(UART_READY))
      ;
    *(UART_TX) = "0123456789ABCDEF"[(val >> i) % 16];
  }
}

void print_dec64(uint64_t val) {
  char buffer[20];
  char *p = buffer;
  while (val || p == buffer) {
    *(p++) = val % 10;
    val = val / 10;
  }

  while (p != buffer) {
    while (!*((volatile uint32_t*) UART_READY))
      ;
    *((volatile uint32_t*) UART_TX) = '0' + *(--p);
  }
}

inline uint64_t get_cycles() {
  volatile uint32_t tmph0;
  volatile uint32_t tmpl0;

  asm volatile ("rdcycleh %0" : "=r"(tmph0));
  asm volatile ("rdcycle  %0" : "=r"(tmpl0));

  return ((uint64_t)(tmph0)<<32) + tmpl0;
  //  uint64_t rdinstret = ((uint64_t)(tmph1)<<32) + tmpl1;

}

inline void wait_cycles(uint64_t wait) {
  uint64_t lim = get_cycles() + wait;
  while (get_cycles() < lim)
    ;
}


//void setpixel(volatile Pixel *fb, int x, int y, short color) RV32_FASTCODE;
void setpixel(int x, int y, short color) {
  /*
     const int x_offset = x;
     const int y_offset = y*HRES;

     fb[x_offset + y_offset] = color;
     */
  *((volatile uint32_t*) VIDEO) = (((uint32_t) color & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
//      wait_cycles(40000);
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
}

void fill_oled(int rgb) {
  for (int y = 0; y < 64; y++) {
    for (int x = 0; x < 96; x++) {
      *((volatile uint32_t*) VIDEO) = (((uint32_t) rgb & 0xffff) << 16Ul) | ((x & 0xff) << 8) | (y & 0xff);
    }
  }
}


void main() {
  int i = 0;
  //fill_oled(0);
  for (;;) {

    /*
    for (int i = 0; i < 96/2; i = i + 5) {
      draw_bresenham(0, i, i, 63, 0x0fff);
      draw_bresenham(i, 0, 96, i, 0x0fff);
    }

    for (int i = 0; i < 96/2; i = i + 5) {
      draw_bresenham(0, i, i, 63, 0x0000);
      draw_bresenham(i, 0, 96, i, 0x0000);
    }
*/

 //  *((volatile uint32_t*) VIDEO) = 0xffff0000;
  // *((volatile uint32_t*) VIDEO) = 0xffff0101;
    //fill_oled(0);
    //i = i + 64;
    //print_dec(i);
    //putchar(13);
    //fill_oled(0xff);

    /* fill rect
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x26);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x01);

   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x22);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x00);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x00);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x5f);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x3f);

   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x00);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x00);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x00);

   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (40);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x00);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x00);
  */
    //fill_oled(0xff);

    /*
       set pixel
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x15);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x0);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (96-1);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x75);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (0x0);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x00) << 8) | (64-1);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x01) << 8) | (0xff);
   *((volatile uint32_t*) VIDEO_RAW) = ((0x01) << 8) | (0xff);
   */
   for (;;);


  }
}
