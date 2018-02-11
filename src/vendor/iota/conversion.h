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


//bytes > bigints
// Converts bigint consisting of 12 words into an array of bytes.
void bigint_to_bytes(const uint32_t *bigint, unsigned char *bytes);
// Converts an array of 48 bytes into a bigint consisting of 12 words.
void bytes_to_bigint(const unsigned char *bytes, uint32_t *bigint);

//chars > bigints
void chars_to_bigints(const char *chars, uint32_t *bigints, uint16_t chars_len);
void bigints_to_chars(const uint32_t *bigints, char *chars, uint16_t bigint_len);

//trytes > trits
int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len);
int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len);

//chars > trytes
int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len);
int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len);

//trits > bigint
int trits_to_bigint(const trit_t *trits_in, uint32_t *bigint);
int bigint_to_trits(const uint32_t *bigint, trit_t *trits_out);

//misc
// sets the 242th trit of the balanced trinary representation to 0
void bigint_set_last_trit_zero(uint32_t *bigint);

#endif // CONVERSION_H
