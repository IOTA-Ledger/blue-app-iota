#ifndef CONVERSION_H
#define CONVERSION_H

#include "iota_types.h"
#include "../../aux.h"

static const trit_t trits_mapping[27][3] =
{{-1, -1, -1}, { 0, -1, -1}, {1, -1, -1},
    {-1,  0, -1}, { 0,  0, -1}, {1,  0, -1},
    {-1,  1, -1}, { 0,  1, -1}, {1,  1, -1},
    {-1, -1,  0}, { 0, -1,  0}, {1, -1,  0},
    {-1,  0,  0}, { 0,  0,  0}, {1,  0,  0},
    {-1,  1,  0}, { 0,  1,  0}, {1,  1,  0},
    {-1, -1,  1}, { 0, -1,  1}, {1, -1,  1},
    {-1,  0,  1}, { 0,  0,  1}, {1,  0,  1},
    {-1,  1,  1}, { 0,  1,  1}, {1,  1,  1}};

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len);
int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len);
int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len);
int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len);
int words_to_trits(const int32_t words_in[], trit_t trits_out[]);

int trits_to_words_u(const trit_t trits_in[], uint32_t words_out[]);
int words_to_trits_u(const uint32_t words_in[], trit_t trits_out[]);

int bytes_to_words(const unsigned char bytes_in[], uint32_t words_out[], uint8_t word_len);
int words_to_bytes(const uint32_t words_in[], unsigned char bytes_out[], uint8_t word_len);

int trints_to_words(trint_t *trints_in, int32_t words_out[]);
int words_to_trints(const int32_t words_in[], trint_t *trints_out);

int words_to_trints_u(const uint32_t *words_in, trint_t *trints_out);
int trints_to_words_u(const trint_t trints_in[], uint32_t words_out[]);
int trints_to_words_u_mem(const trint_t *trints_in, uint32_t *words_out);
int words_to_trints_u_mem(uint32_t *words_in, trint_t *trints_out);


int kerl_absorb_trints(trint_t *trints_in, uint16_t len);
int kerl_squeeze_trints(trint_t *trints_out, uint16_t len);

void print_words(uint32_t *words, int len);

#endif // CONVERSION_H
