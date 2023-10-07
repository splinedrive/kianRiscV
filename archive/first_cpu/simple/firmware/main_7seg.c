/* 2021 author Hirosh Dabui, kianRiscV example soc code */
#include <stdint.h>
#include "stdlib.c"
unsigned char reverse_bits3(unsigned char b)
{
    return (b * 0x0202020202ULL & 0x010884422010ULL) % 0x3ff;
}
char seven_seg(int bcd) {
  char segments;
  switch (bcd) {
    case 0b0000: segments = 0b0111111; break; // 0 ABCDEF
    case 0b0001: segments = 0b0000110; break; // 1 BC
    case 0b0010: segments = 0b1011011; break; // 2 ABDEG
    case 0b0011: segments = 0b1001111; break; // 3 ABCDG
    case 0b0100: segments = 0b1100110; break; // 4 BCFG
    case 0b0101: segments = 0b1101101; break; // 5 ACDFG
    case 0b0110: segments = 0b1111101; break; // 6 ACDEFG
    case 0b0111: segments = 0b0000111; break; // 7 ABC
    case 0b1000: segments = 0b1111111; break; // 8 ABCDEFG
    case 0b1001: segments = 0b1101111; break; // 9 ABCDFG
    case 0b1010: segments = 0b1110111; break; // A ABCEFG
    case 0b1011: segments = 0b1111100; break; // B CDEFG
    case 0b1100: segments = 0b1011000; break; // C DEG
    case 0b1101: segments = 0b1011110; break; // D BCDEG
    case 0b1110: segments = 0b1111001; break; // E ADEFG
    case 0b1111: segments = 0b1110001; break; // F AEFG
    default: segments <= ~0;
  }

  return segments;
}

void main() {
  IO_OUT(GPIO_OUTPUT, 0);
  IO_OUT(GPIO_DIR, 0xff);
  char i = 0;
  uint32_t start = (uint32_t) milliseconds();

  for (;;) {
    
    IO_OUT(GPIO_OUTPUT, ~(seven_seg(i & 0x0f) | 0x00));
    msleep(01);
    IO_OUT(GPIO_OUTPUT, ~(seven_seg((i & 0xf0)>>4) | 0x80));
    msleep(01);

    uint32_t time_diff =  (uint32_t) milliseconds() - start;
    if (time_diff >= 50) {
      start = milliseconds();
      i++;
    }
  }
}
