/*
 *  kianv harris multicycle RISC-V rv32im rle_encode.c
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
#include <stdio.h>
#include <stdlib.h>

void rle_encode(FILE* inputFile, FILE* outputFile) {
    int count;
    unsigned char value, lastValue;

    if (fread(&lastValue, 1, 1, inputFile) != 1) return; // Read first byte
    count = 1;

    while (fread(&value, 1, 1, inputFile) == 1) {
        if (value == lastValue && count < 255) {
            count++;
        } else {
            fwrite(&lastValue, 1, 1, outputFile);
            fputc(count, outputFile);
            lastValue = value;
            count = 1;
        }
    }

    // Write the last set of data
    fwrite(&lastValue, 1, 1, outputFile);
    fputc(count, outputFile);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <input file> <output file>\n", argv[0]);
        return 1;
    }

    FILE *inputFile = fopen(argv[1], "rb");
    FILE *outputFile = fopen(argv[2], "wb");

    if (inputFile == NULL || outputFile == NULL) {
        perror("Error opening file");
        return 1;
    }

    rle_encode(inputFile, outputFile);

    fclose(inputFile);
    fclose(outputFile);
    return 0;
}

