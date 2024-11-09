// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
#include "custom_stdlib.h"
#include <stdarg.h>
#include <stdint.h>

char heap_memory[1024];
int heap_memory_used = 0;

static void printf_c(char c) { uart_print_char(c); }

static void printf_s(char *p) {
  while (*p)
    uart_print_char(*(p++));
}

void printf_d(int val, int width) {
  char buffer[32];
  char *p = buffer;
  int num_digits = 0;

  if (val < 0) {
    printf_c('-');
    val = -val;
  }

  // Store each digit in buffer
  while (val || p == buffer) {
    *(p++) = '0' + val % 10;
    val = val / 10;
    num_digits++;
  }

  // Calculate the number of leading zeros needed
  int padding = (width > num_digits) ? (width - num_digits) : 0;

  // Print leading zeros
  for (int i = 0; i < padding; i++) {
    printf_c('0');
  }

  // Print the number in the buffer
  while (p != buffer) {
    printf_c(*(--p));
  }
}

static void printf_u(int val) {
  char buffer[32];
  char *p = buffer;

  val = val >= 0 ? val : -val;
  while (val || p == buffer) {
    *(p++) = '0' + val % 10;
    val = val / 10;
  }
  while (p != buffer)
    printf_c(*(--p));
}

void printf_x(unsigned int n, int width) {
  const char *hex_digits = "0123456789abcdef";
  char buffer[8] = {0}; // Temporary buffer to hold hex digits
  int i = 0;

  // Convert number to hex in reverse order
  do {
    buffer[i++] = hex_digits[n % 16];
    n /= 16;
  } while (n > 0);

  // Print leading zeros if width is specified and larger than the number length
  for (; i < width; i++) {
    uart_print_char('0');
  }

  // Print the hex number in the correct order
  while (i > 0) {
    uart_print_char(buffer[--i]);
  }
}

int printf(const char *format, ...) {
  int i;
  va_list ap;

  va_start(ap, format);

  for (i = 0; format[i]; i++) {
    if (format[i] == '%') {
      int width = 0;

      // Check for '0' padding and width specification
      if (format[i + 1] == '0') {
        i++;
        if (format[i + 1] >= '1' && format[i + 1] <= '9') {
          width = format[i + 1] - '0';
          i++;
        }
      }

      while (format[++i]) {
        if (format[i] == 'c') {
          printf_c(va_arg(ap, int));
          break;
        }
        if (format[i] == 's') {
          printf_s(va_arg(ap, char *));
          break;
        }
        if (format[i] == 'd') {
          unsigned int num = va_arg(ap, unsigned int);
          printf_d(num, width ? width : 0); // Pass width to printf_x
          break;
        }
        if (format[i] == 'u') {
          printf_u(va_arg(ap, unsigned int));
          break;
        }
        if (format[i] == 'x') {
          unsigned int num = va_arg(ap, unsigned int);
          printf_x(num, width ? width : 0); // Pass width to printf_x
          break;
        }
      }
    } else {
      printf_c(format[i]);
    }
  }

  va_end(ap);
  return 0;
}

char *malloc(int size) {
  char *p = heap_memory + heap_memory_used;
  // printf("[malloc(%d) -> %d (%d..%d)]", size, (int)p, heap_memory_used,
  // heap_memory_used + size);
  heap_memory_used += size;
  if (heap_memory_used > ARRAY_SIZE(heap_memory))
    asm volatile("ebreak");
  return p;
}

void *memcpy(void *aa, const void *bb, long n) {
  // printf("**MEMCPY**\n");
  char *a = (char *)aa;
  const char *b = (const char *)bb;
  while (n--)
    *(a++) = *(b++);
  return aa;
}

char *strcpy(char *dst, const char *src) {
  char *r = dst;

  while ((((uint32_t)dst | (uint32_t)src) & 3) != 0) {
    char c = *(src++);
    *(dst++) = c;
    if (!c)
      return r;
  }

  while (1) {
    uint32_t v = *(uint32_t *)src;

    if (__builtin_expect((((v)-0x01010101UL) & ~(v) & 0x80808080UL), 0)) {
      dst[0] = v & 0xff;
      if ((v & 0xff) == 0)
        return r;
      v = v >> 8;

      dst[1] = v & 0xff;
      if ((v & 0xff) == 0)
        return r;
      v = v >> 8;

      dst[2] = v & 0xff;
      if ((v & 0xff) == 0)
        return r;
      v = v >> 8;

      dst[3] = v & 0xff;
      return r;
    }

    *(uint32_t *)dst = v;
    src += 4;
    dst += 4;
  }
}

int strcmp(const char *s1, const char *s2) {
  while ((((uint32_t)s1 | (uint32_t)s2) & 3) != 0) {
    char c1 = *(s1++);
    char c2 = *(s2++);

    if (c1 != c2)
      return c1 < c2 ? -1 : +1;
    else if (!c1)
      return 0;
  }

  while (1) {
    uint32_t v1 = *(uint32_t *)s1;
    uint32_t v2 = *(uint32_t *)s2;

    if (__builtin_expect(v1 != v2, 0)) {
      char c1, c2;

      c1 = v1 & 0xff, c2 = v2 & 0xff;
      if (c1 != c2)
        return c1 < c2 ? -1 : +1;
      if (!c1)
        return 0;
      v1 = v1 >> 8, v2 = v2 >> 8;

      c1 = v1 & 0xff, c2 = v2 & 0xff;
      if (c1 != c2)
        return c1 < c2 ? -1 : +1;
      if (!c1)
        return 0;
      v1 = v1 >> 8, v2 = v2 >> 8;

      c1 = v1 & 0xff, c2 = v2 & 0xff;
      if (c1 != c2)
        return c1 < c2 ? -1 : +1;
      if (!c1)
        return 0;
      v1 = v1 >> 8, v2 = v2 >> 8;

      c1 = v1 & 0xff, c2 = v2 & 0xff;
      if (c1 != c2)
        return c1 < c2 ? -1 : +1;
      return 0;
    }

    if (__builtin_expect((((v1)-0x01010101UL) & ~(v1) & 0x80808080UL), 0))
      return 0;

    s1 += 4;
    s2 += 4;
  }
}
