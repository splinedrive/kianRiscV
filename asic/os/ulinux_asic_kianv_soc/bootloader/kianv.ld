/* Linker script for programs stored in SPI flash
 * Inspired from picorv32/picosoc/sections.lds
 *
 * Sections:
 * - text and rodata are sent to FLASH.
 * - bss and data sections are sent to PSRAM.
 * - Data sections have initialization data in flash.
 * - AT keyword specifies LMA (Load Memory Address).
 *
 * Usage:
 * - If you got a lot of code that does not fit in RAM,
 *   you may keep text sections in flash using spiflash_icebreaker_run_from_flash.ld.
 */

MEMORY {
  FLASH (rx)  : ORIGIN = 0x020100000, LENGTH = 0x10000000
  PSRAM  (rwx) : ORIGIN = 0x080000000 + (8*1024*1024 - (32*1024)), LENGTH = 0x00002000
}

__stacktop = ORIGIN(PSRAM) + LENGTH(PSRAM);

SECTIONS {
    /* C runtime initialization code and readonly data goes to FLASH */
    .text : {
        . = ALIGN(4);
        crt0.o(.text)        /* c runtime initialization (code) */
        *(.text)             /* .text sections (code) */
        *(.text*)            /* .text* sections (code) */
        *(.rodata)           /* .rodata sections (constants, strings, etc.) */
        *(.rodata*)          /* .rodata* sections (constants, strings, etc.) */
        _etext = .;          /* define a global symbol at end of code */
        _sidata = _etext;    /* This is used by the startup to initialize the .data section */
    } >FLASH

    /* Initialized data section (data in RAM but initial values in FLASH) */
    .data : AT( _sidata ) {
        . = ALIGN(4);
        _sdata = .;          /* create a global symbol at data start */
        _ram_start = .;      /* global symbol at RAM start (e.g., for GC) */

        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;          /* define a global symbol at data end */
    } > FLASH

    /* Uninitialized data section */
    .bss : {
        . = ALIGN(4);
        _sbss = .;           /* define a global symbol at bss start */
        *(.bss)
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;           /* define a global symbol at bss end */
    } >PSRAM

    /* Stack and heap definitions */
    .heap : {
        . = ALIGN(4);
        _heap_start = .;     /* define a global symbol at heap start */
        _end = .;            /* define end of heap as expected by syscalls.c */
    } >PSRAM

    /* Miscellaneous sections that need to be included */
    .misc : {
        . = ALIGN(4);
        *(.eh_frame)
        *(.eh_frame_hdr)
        *(.init_array)
        *(.gcc_except_table*)
    } >FLASH
}

