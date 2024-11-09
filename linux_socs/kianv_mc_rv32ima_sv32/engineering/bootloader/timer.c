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

#include "timer.h"
#include "kianv_io_utils.h"

//--------------------------------------------------------------------------
// timer_init:
//--------------------------------------------------------------------------
void timer_init(void) {
  // #error "Fill in timer implementation"
}
//--------------------------------------------------------------------------
// timer_sleep:
//--------------------------------------------------------------------------
void timer_sleep(int timeMs) {
  t_time t = timer_now();

  while (timer_diff(timer_now(), t) < timeMs)
    ;
}
//--------------------------------------------------------------------------
// timer_now: Return time now in ms
//--------------------------------------------------------------------------
t_time timer_now(void) { return elapsed_milliseconds(); }
