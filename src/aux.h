#ifndef AUX_H
#define AUX_H

#include "vendor/iota/iota_types.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define TYPE_INT 1
#define TYPE_UINT 2
#define TYPE_STR 3
#define TOP 1
#define BOT 2

void uint_to_str(uint32_t i, char *str, uint8_t len);
void int_to_str(int i, char *str, uint8_t len);
uint32_t str_to_int(char *str, uint8_t len);

void any_trits_to_trints(trit_t *trits, trint_t *trints, size_t num_trits);
void any_trints_to_trits(trint_t *trints, trit_t *trits, size_t num_trints);

void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r);
void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r);
void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz);
int8_t trits_to_trint(int8_t *trits, int8_t sz);

void get_seed(unsigned char *privateKey, uint8_t sz, uint32_t *seed_bigint);
void get_private_key(trit_t *seed_trits, uint32_t idx, char* msg);

void test_kerl(char *msg);

#endif // AUX_H

