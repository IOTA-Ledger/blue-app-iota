#ifndef KERL_H
#define KERL_H

#include "common.h"
#include "iota_types.h"

int kerl_initialize(cx_sha3_t *sha3);

int kerl_absorb_bigints(cx_sha3_t *sha3, const uint32_t* bigint_in, uint16_t len);
int kerl_squeeze_bigints(cx_sha3_t *sha3, uint32_t* bigint_out, uint16_t len);

#endif // KERL_H
