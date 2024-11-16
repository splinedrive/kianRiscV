#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

void print_memory_info(uint32 free_mem, char *unit) {
    uint32 free;
    char *unit_str;

    if (strcmp(unit, "k") == 0) {
        free = free_mem / 1024;
        unit_str = "KiB";
    } else if (strcmp(unit, "m") == 0) {
        free = free_mem / (1024 * 1024);
        unit_str = "MiB";
    } else {
        free = free_mem;
        unit_str = "bytes";
    }

    printf("Free memory: %d %s\n", free, unit_str);
}

int main(int argc, char *argv[]) {
    uint32 free_mem;
    char *unit = "b";

    if (argc > 1) {
        if (strcmp(argv[1], "-k") == 0) {
            unit = "k";
        } else if (strcmp(argv[1], "-m") == 0) {
            unit = "m";
        } else {
            fprintf(2, "Usage: freemem [-k | -m]\n");
            exit(1);
        }
    }

    free_mem = freemem();

    print_memory_info(free_mem, unit);
    exit(0);
}

