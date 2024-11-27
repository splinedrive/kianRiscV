// kian riscv house rotation demo, author Hirosh Dabui
/* fast sin/cosine by https://www.atwillys.de/content/cc/sine-lookup-for-embedded-in-c/ */

#define DMA
#include <stdint.h>
#include "16X16-F7.c"
#include <math.h>
#include "stdlib.c"

#define HRES 80
#define VRES 60

#define SIZEOF(arr) sizeof(arr) / sizeof(*arr)

#define FRAMEBUFFER (volatile uint32_t *) 0x10000000
#define FB_CTRL     (volatile uint32_t *) 0x30000024

#define FB0_MEM (volatile uint32_t *) (0x10000000)
#define FB1_MEM (volatile uint32_t *) (0x10000000 + (8192*4))
int sin_offset[79] = {

2240,
2240,
2240,
2240,
2240,
2240,
2240,
2240,
2160,
2160,
2160,
2080,
2080,
2000,
2000,
1920,
1920,
1840,
1840,
1760,
1760,
1680,
1680,
1600,
1600,
1520,
1520,
1440,
1440,
1360,
1360,
1280,
1280,
1200,
1200,
1120,
1120,
1120,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1040,
1120,
1120,
1120,
1200,
1200,
1280,
1280,
1360,
1360,
1440,
1440,
1520,
1520,
1600,
1600,
1680,
1680,
1760,
1760,
1840,
1840,
1920,
1920,
2000,
2000,
2080,
};

void set_fb0(int fb) {
  *(FB_CTRL) = fb & 0x01;
}
void activefb(int fb) {
  set_fb0((fb & 0x01));
}

uint32_t getbmpLine(int x, int y) {
  uint8_t p0 = gimp_image.pixel_data[(((x<<2) + 0)) + y*(320<<2)];
  uint8_t p1 = gimp_image.pixel_data[(((x<<2) + 1)) + y*(320<<2)];
  uint8_t p2 = gimp_image.pixel_data[(((x<<2) + 2)) + y*(320<<2)];
  uint8_t p3 = gimp_image.pixel_data[(((x<<2) + 3)) + y*(320<<2)];

  return (p3<<24 | p0 << 16 | p1 << 8 | p2);
}

void render_glyph(char a, uint32_t *fb) {
  a -= 32;
  for (int y = 0; y < 16; y++) {
    for (int x = 0; x < 16; x++) {
      int yoff = (a / 20) <<4;
      int xoff = (a % 20) <<4;
      *(fb + x +y*80) = getbmpLine(x + xoff, y + yoff);
    }
  }
}

void render_glyph_col(char a, int col, uint32_t *fb) {
  a -= 32;
  for (int y = 0; y < 16; y++) {
    int yoff = (a / 20) <<4;
    int xoff = (a % 20) <<4;
    *(fb + y*HRES) = getbmpLine(col + xoff, y + yoff);
  }
}

uint32_t getFbAddrOffset(int x, int y) {
  return x + y*HRES;
}

uint32_t scroll_buf[16*80];

static char msg[] = "KIANV RISC-V RV32IM HDMI MULTICYCLE SOC: "
             "DMA, HDMI, VIDEO DOUBLE-BUFFER, GPIO, FLASH SPI, "
             "PSRAM, ...";
void main() {
  int fb = 0;
  char *p = msg;
  uint32_t offset_scbuff = getFbAddrOffset(79, 0);
  int i = 0;
  int j = 0;
  while (1) {
    // get slice
    for (int col = 0; col < 16; col++) {
      render_glyph_col(*p, col, scroll_buf + offset_scbuff);
      uint32_t *dst = !(fb & 1) ? (FB0_MEM) : (FB1_MEM);
      uint32_t *src = (fb & 1) ? (FB0_MEM) : (FB1_MEM);
      dma_action(dst, 0x0, VRES*HRES, DMA_MEMSET);
      uint32_t offset;
      
      /* copy scrollbuf into framebuffer */
      for (int y = 0; y < 16; y++) {
        for (int x = 0; x < 79; x++) {
          offset = sin_offset[(x+j) % 79];
          *(dst + y*80 + x + offset) = *(scroll_buf + y*80 + (x+1));
        }
      }
    j += 2;

    msleep(10);
      activefb(fb);
      /* shift scroll buf */
      for (int y = 0; y < 16; y++) {
        for (int x = 0; x < 79; x++) {
          *(scroll_buf + y*80 + x) = *(scroll_buf + y*80 + (x+1));
        }
      }
      fb ^= 1;
    }
    p = *p ? p + 1 : msg;
//  if ((i % 80 )) p++; else p = msg;
 //     i++;
  }
}

