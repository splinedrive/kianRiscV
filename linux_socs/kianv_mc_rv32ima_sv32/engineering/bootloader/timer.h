/*
 * Code adapted from https://github.com/ultraembedded/fat_io_lib
 * and customized for the Kianv bootloader.
 *
 * Original library provides functionality for handling FAT file systems,
 * and this version includes modifications specific to the Kianv SoC
 * environment.
 *
 * Adjustments include compatibility with Kianv hardware registers,
 * integration with bootloader routines, and optimizations for
 * the resource constraints of the Kianv platform.
 */
#pragma once
//-----------------------------------------------------------------
// Types
//-----------------------------------------------------------------
typedef unsigned long t_time;

//-----------------------------------------------------------------
// Prototypes:
//-----------------------------------------------------------------

// General timer
void timer_init(void);
t_time timer_now(void);
static long timer_diff(t_time a, t_time b) { return (long)(a - b); }
void timer_sleep(int timeMs);
