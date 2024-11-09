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
#pragma once
#include <stdint.h>

/* Base address for Kian hardware registers */
#define IO_BASE 0x10000000
#define UART_TX (volatile uint32_t *)(IO_BASE + 0x0000)
#define UART_LSR (volatile uint8_t *)(IO_BASE + 0x0005)
#define CPU_FREQ_REG (volatile uint32_t *)(IO_BASE + 0x0014)

/* Function declarations for I/O and timing utilities */

/**
 * Reads the current CPU frequency in Hz.
 */
uint32_t read_cpu_frequency();

/**
 * Reads the current CPU cycle count.
 */
uint64_t read_cpu_cycles();

/**
 * Returns the elapsed time in milliseconds since startup.
 */
uint64_t elapsed_milliseconds();

/**
 * Returns the elapsed time in nanoseconds since startup.
 */
uint64_t elapsed_nanoseconds();

/**
 * Returns the elapsed time in seconds since startup.
 */
uint64_t elapsed_seconds();

/**
 * Delays execution for a specified number of milliseconds.
 */
void delay_milliseconds(uint32_t ms);

/**
 * Delays execution for a specified number of seconds.
 */
void delay_seconds(uint32_t sec);

/**
 * Delays execution for a specified number of microseconds.
 */
void delay_microseconds(uint32_t us);

/**
 * Delays execution by waiting for a specified number of CPU cycles.
 */
void delay_cycles(uint64_t cycles);

/**
 * Sends a single character to the UART transmitter.
 */
void uart_putchar(char c);

/**
 * Prints a single character to UART.
 */
void uart_print_char(char ch);
