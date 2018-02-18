#ifndef KERL_H
#define KERL_H

#include "common.h"

void kerl_initialize(cx_sha3_t *sha3);

void kerl_absorb_chunk(cx_sha3_t *sha3, const unsigned char* bytes);
void kerl_absorb_bytes(cx_sha3_t *sha3, const unsigned char* bytes, unsigned int len);

void kerl_squeeze_chunk(cx_sha3_t *sha3, unsigned char* bytes);
void kerl_squeeze_bytes(cx_sha3_t *sha3, unsigned char* bytes, unsigned int len);

#endif // KERL_H
