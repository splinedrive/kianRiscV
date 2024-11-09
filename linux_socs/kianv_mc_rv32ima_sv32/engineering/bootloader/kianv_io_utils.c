/*
 *  kianv.v - RISC-V rv32ima
 *
 *  copyright (c) 2024 hirosh dabui <hirosh@dabui.de>
 *
 *  permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  the software is provided "as is" and the author disclaims all warranties
 *  with regard to this software including all implied warranties of
 *  merchantability and fitness. in no event shall the author be liable for
 *  any special, direct, indirect, or consequential damages or any damages
 *  whatsoever resulting from loss of use, data or profits, whether in an
 *  action of contract, negligence or other tortious action, arising out of
 *  or in connection with the use or performance of this software.
 *
 */
#include "kianv_io_utils.h"
#include <math.h>
#include <stdint.h>

/* Kian hardware register base address */
#define IO_BASE 0x10000000
#define UART_TX (volatile uint32_t *)(IO_BASE + 0x0000)
#define UART_LSR (volatile uint8_t *)(IO_BASE + 0x0005)
#define CPU_FREQ_REG (volatile uint32_t *)(IO_BASE + 0x0014)

/* ANSI color codes */
#define COLOR_RED "\x1B[31m"
#define COLOR_GREEN "\x1B[32m"
#define COLOR_YELLOW "\x1B[33m"
#define COLOR_BLUE "\x1B[34m"
#define COLOR_MAGENTA "\x1B[35m"
#define COLOR_CYAN "\x1B[36m"
#define COLOR_WHITE "\x1B[37m"
#define COLOR_RESET "\x1B[0m"

/* ANSI display attributes */
#define DISPLAY_CLEAR "\x1B[2J"
#define DISPLAY_BOLD "\x1B[1m"
#define DISPLAY_BLINK "\x1B[5m"
#define DISPLAY_BLINK_OFF "\x1B[25m"

/* Retrieve CPU cycle count */
uint64_t read_cpu_cycles() {
  volatile uint32_t high, low;
  asm volatile("rdcycleh %0" : "=r"(high));
  asm volatile("rdcycle %0" : "=r"(low));
  return ((uint64_t)high << 32) | low;
}

/* Retrieve CPU frequency */
uint32_t read_cpu_frequency() { return *CPU_FREQ_REG; }

/* Wait for a specified number of CPU cycles */
void delay_cycles(uint64_t cycles) {
  uint64_t target = read_cpu_cycles() + cycles;
  while (read_cpu_cycles() < target)
    ;
}

/* Delay functions for various time units */
void delay_microseconds(uint32_t us) {
  if (us)
    delay_cycles(us * (read_cpu_frequency() / 1000000));
}

void delay_milliseconds(uint32_t ms) {
  if (ms)
    delay_cycles(ms * (read_cpu_frequency() / 1000));
}

void delay_seconds(uint32_t sec) {
  if (sec)
    delay_cycles(sec * read_cpu_frequency());
}

/* Time conversion functions */
uint64_t elapsed_nanoseconds() {
  return read_cpu_cycles() / (read_cpu_frequency() / 1000000);
}

uint64_t elapsed_milliseconds() {
  return read_cpu_cycles() / (read_cpu_frequency() / 1000);
}

uint64_t elapsed_seconds() { return read_cpu_cycles() / read_cpu_frequency(); }

/* UART output functions */
void uart_putchar(char c) {
  while (!(*UART_LSR & 0x60))
    ;
  *UART_TX = (c == '\r') ? '\n' : c;
}

void uart_print_char(char ch) { uart_putchar(ch); }
