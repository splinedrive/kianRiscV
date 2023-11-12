/*
 *  kianv harris RISCV project
 *
 *  copyright (c) 2023 hirosh dabui <hirosh@dabui.de>
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

#include "stdlib.c"
#include <stddef.h>
#include <stdint.h>

#define SPI_ADDR_BASE 0x20000000
#define KERNEL_IMAGE (SPI_ADDR_BASE + 1024 * 1024 * 2)
#define DTB_IMAGE (SPI_ADDR_BASE + 1024 * 1024 / 2)
#define SDRAM_START (0x80000000)
#define SDRAM_END (SDRAM_START + 1024 * 1024 * 32 - (1024 * 8))
#define DTB_TARGET SDRAM_END
#define CHUNK_SIZE (512 * 1024)

typedef void (*func_ptr)(int, char *);

void *memcpy_verbose(void *d, const void *s, size_t count) {
    char symbols[] = {'|', '/', '-', '\\'};
    size_t symbol_idx = 0;

    for (size_t i = 0; i < count; i++, d++, s++) {
        if (i % CHUNK_SIZE == 0) {
            printf("%c\033[D", symbols[symbol_idx]);
            symbol_idx = (symbol_idx + 1) % 4;
        }
        *(char*)d = *(char*)s;
    }
    return d;
}

void main() {
    printf("\n   KianV RISC-V Bootloader v0.0.1\n   FPGA Linux RISC-V System\n   (C) 2023 KianV Tech Inc.\n\n");
    printf("- Initializing...\n- KianV RISC-V CPU ready.\n- Fetching Linux kernel from flash storage...");
    memcpy_verbose(SDRAM_START, KERNEL_IMAGE, 1024 * 1024 * 4);
    printf("\n- Handing control to Linux...\n\n\nstarting kernel at 0x80000000...\n");
    ((func_ptr)SDRAM_START)(0, (char *)DTB_IMAGE);
}

