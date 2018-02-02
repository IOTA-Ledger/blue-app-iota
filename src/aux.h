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

extern char debug_str[];

void trits_to_trints(const trit_t *trits, trint_t *trints, size_t num_trits);
void trints_to_trits(const trint_t *trints, trit_t *trits, size_t num_trits);
void specific_243trits_to_49trints(int8_t *trits, int8_t *trints_r);
void specific_49trints_to_243trits(int8_t *trints, int8_t *trits_r);
void trint_to_trits(int8_t integ, int8_t *trits_r, int8_t sz);
int8_t trits_to_trint(int8_t *trits, int8_t sz);

int myadd_index_to_seed(trint_t trits[], uint32_t index);
int mygenerate_private_key(trint_t *seed_trits, uint32_t index, trint_t *private_key);
int mygenerate_public_address(const trit_t private_key[], trit_t address_out[]);

int trints_to_words(trint_t *trints_in, int32_t words_out[]);

void do_nothing(void);
void get_seed(unsigned char *privateKey, uint8_t sz, uint32_t *seed_bigint);
void write_debug(void* o, unsigned int sz, uint8_t t);


#endif // AUX_H
