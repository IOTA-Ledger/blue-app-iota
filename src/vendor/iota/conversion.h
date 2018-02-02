#ifndef CONVERSION_H
#define CONVERSION_H

#include "iota_types.h"
#include "aux.h"

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

void chars_to_bigints(const char *chars, uint32_t *bigint, uint16_t chars_len);
void bigints_to_chars(const uint32_t *bigint, char *chars, uint16_t bigint_len);

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len);
int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len);
int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len);
int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len);
int words_to_trits(const int32_t words_in[], trit_t trits_out[]);

// sets the 242th trit of the balanced trinary representation to 0
void bigint_set_last_trit_zero(uint32_t *bigint);

// Converts bigint consisting of 12 words into an array of bytes.
void bigint_to_bytes(const uint32_t *bigint, unsigned char *bytes);
// Converts an array of 48 bytes into a bigint consisting of 12 words.
void bytes_to_bigint(const unsigned char *bytes, uint32_t *bigint);

int trits_to_bigint(const trit_t *trits, uint32_t *bigint);
int bigint_to_trits(const uint32_t *bigint, trit_t *trits);

int trints_to_words(trint_t *trints_in, int32_t words_out[]);
int words_to_trints(const int32_t words_in[], trint_t *trints_out);

int words_to_trints_u(const uint32_t *words_in, trint_t *trints_out);
int trints_to_words_u(const trint_t trints_in[], uint32_t words_out[]);
int trints_to_bigint_mem(const trint_t *trints_in, uint32_t *words_out);
int bigint_to_trints_mem(uint32_t *bigint_in, trint_t *trints_out);

void print_words(uint32_t *words, int len);

#endif // CONVERSION_H
