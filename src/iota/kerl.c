#include "kerl.h"
#include "conversion.h"
#include "common.h"

// number of bytes in one keccak hash
#define NUM_HASH_BYTES 48

void kerl_initialize(cx_sha3_t *sha3)
{
    cx_keccak_init(sha3, 384);
}

void kerl_reinitialize(cx_sha3_t *sha3, const unsigned char *state_bytes)
{
    kerl_initialize(sha3);
    kerl_absorb_chunk(sha3, state_bytes);
}

void kerl_absorb_bytes(cx_sha3_t *sha3, const unsigned char *bytes,
                       unsigned int len)
{
    cx_hash((cx_hash_t *)sha3, 0, (unsigned char *)bytes, len, NULL);
}

void kerl_absorb_chunk(cx_sha3_t *sha3, const unsigned char *bytes)
{
    kerl_absorb_bytes(sha3, bytes, NUM_HASH_BYTES);
}

void kerl_squeeze_final_chunk(cx_sha3_t *sha3, unsigned char *bytes_out)
{
    cx_hash((cx_hash_t *)sha3, CX_LAST, bytes_out, 0, bytes_out);
    bytes_set_last_trit_zero(bytes_out);
}

void kerl_squeeze_chunk(cx_sha3_t *sha3, unsigned char *bytes_out)
{
    unsigned char state_bytes[NUM_HASH_BYTES];

    kerl_state_squeeze_chunk(sha3, state_bytes, bytes_out);
    kerl_reinitialize(sha3, state_bytes);
}

void kerl_squeeze_bytes(cx_sha3_t *sha3, unsigned char *bytes, unsigned int len)
{
    // absorbing happens in 48 word bigint chunks
    for (unsigned int i = 0; i < (len / NUM_HASH_BYTES); i++) {
        kerl_squeeze_chunk(sha3, bytes + NUM_HASH_BYTES * i);
    }
}

static inline void flip_hash_bytes(unsigned char *bytes)
{
    for (unsigned int i = 0; i < NUM_HASH_BYTES; i++) {
        bytes[i] = ~bytes[i];
    }
}

void kerl_state_squeeze_chunk(cx_sha3_t *sha3, unsigned char *state_bytes,
                              unsigned char *bytes_out)
{
    cx_hash((cx_hash_t *)sha3, CX_LAST, state_bytes, 0, state_bytes);

    os_memcpy(bytes_out, state_bytes, NUM_HASH_BYTES);
    bytes_set_last_trit_zero(bytes_out);

    // flip bytes for multiple squeeze
    flip_hash_bytes(state_bytes);
}
