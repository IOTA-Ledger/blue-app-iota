#include "kerl.h"
#include "conversion.h"
#include "common.h"

void kerl_initialize(cx_sha3_t *sha3) { cx_keccak_init(sha3, 384); }

void kerl_absorb_bytes(cx_sha3_t *sha3, const unsigned char *bytes,
                       unsigned int len)
{
    cx_hash((cx_hash_t *)sha3, 0, (unsigned char *)bytes, len, NULL);
}

void kerl_absorb_chunk(cx_sha3_t *sha3, const unsigned char *bytes)
{
    kerl_absorb_bytes(sha3, bytes, 48);
}

static inline void flip_hash_bytes(unsigned char *bytes)
{
    for (int i = 0; i < 48; i++) {
        bytes[i] = ~bytes[i];
    }
}

void kerl_squeeze_chunk(cx_sha3_t *sha3, unsigned char *bytes_out)
{
    unsigned char hash[48];

    cx_hash((cx_hash_t *)sha3, CX_LAST, hash, 0, hash);

    os_memcpy(bytes_out, hash, sizeof(hash));
    bytes_set_last_trit_zero(bytes_out);

    // flip bytes for multiple squeeze
    flip_hash_bytes(hash);

    kerl_initialize(sha3);
    kerl_absorb_chunk(sha3, hash);
}

void kerl_squeeze_bytes(cx_sha3_t *sha3, unsigned char *bytes, unsigned int len)
{
    unsigned char *chunk = bytes;

    // absorbing happens in 48 word bigint chunks
    for (unsigned int i = 0; i < (len / 48); i++) {
        kerl_squeeze_chunk(sha3, chunk);
        chunk += 48;
    }
}
