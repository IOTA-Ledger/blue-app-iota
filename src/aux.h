#ifndef AUX_H
#define AUX_H

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "iota/iota_types.h"

#define TYPE_INT 1
#define TYPE_UINT 2
#define TYPE_STR 3
#define TOP 1
#define MID 2
#define BOT 3

void int_to_str(int64_t i, char *str, uint8_t len);
int64_t str_to_int(char *str, uint8_t len);

void get_seed(const unsigned char *privateKey, uint8_t sz, unsigned char *seed_bytes);

#endif // AUX_H
