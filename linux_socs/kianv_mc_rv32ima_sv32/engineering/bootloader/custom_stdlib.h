#pragma once
#include "kianv_io_utils.h"

/* ANSI Color Codes */
#define COLOR_RED "\x1b[31m"
#define COLOR_GREEN "\x1b[32m"
#define COLOR_YELLOW "\x1b[33m"
#define COLOR_BLUE "\x1b[34m"
#define COLOR_PURPLE "\x1b[35m"
#define COLOR_RESET "\x1b[0m"
#define COLOR_BOLD "\033[1m"

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

char *malloc();
int printf(const char *format, ...);

void *memcpy(void *dest, const void *src, long n);
char *strcpy(char *dest, const char *src);
int strcmp(const char *s1, const char *s2);
