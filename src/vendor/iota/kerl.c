#include "kerl.h"
#include <assert.h>
#include "conversion.h"
#include "common.h"

int kerl_initialize(cx_sha3_t *sha3)
{
    cx_keccak_init(sha3, 384);
    return 0;
}

static void kerl_hash_bytes(unsigned char *bytes_in, uint16_t in_len,
                            unsigned char *bytes_out)
{
    cx_sha3_t sha3;

    cx_keccak_init(&sha3, 384);
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, in_len, bytes_out);
}

static int kerl_absorb_bytes(cx_sha3_t *sha3, unsigned char *bytes_in,
                              uint16_t len)
{
    cx_hash((cx_hash_t *)sha3, 0, bytes_in, len, NULL);
    return 0;
}

static void flip_hash_bytes(unsigned char *bytes)
{
    for (uint8_t i = 0; i < 48; i++) {
        bytes[i] = ~bytes[i];
    }
}

// only 48 bytes can be squeezed at a time
int kerl_squeeze_bytes(cx_sha3_t *sha3, unsigned char *bytes_out)
{
    unsigned char md_value[48];

    cx_hash((cx_hash_t *)sha3, CX_LAST, md_value, 0, md_value);
    os_memcpy(bytes_out, md_value, 48);

    // flip bytes for multiple squeeze
    flip_hash_bytes(md_value);

    kerl_initialize(sha3);
    kerl_absorb_bytes(sha3, md_value, 48);

    return 0;
}

int kerl_absorb_bigints(cx_sha3_t *sha3, const uint32_t *bigint_in,
                        uint16_t len)
{
    // absorbing happens in 12 word bigint chunks
    for (uint16_t i = 0; i < (len / 12); i++) {
        unsigned char bytes[12 * 4];
        bigint_to_bytes(bigint_in + i * 12, bytes);

        kerl_absorb_bytes(sha3, bytes, 48);
    }

    return 0;
}

int kerl_squeeze_bigints(cx_sha3_t *sha3, uint32_t *bigint_out, uint16_t len)
{
    uint32_t *chunk = bigint_out;

    // absorbing happens in 12 word bigint chunks
    for (uint16_t i = 0; i < (len / 12); i++) {
        unsigned char bytes[12 * 4];
        kerl_squeeze_bytes(sha3, bytes);
        bytes_to_bigint(bytes, chunk);

        bigint_set_last_trit_zero(chunk);

        chunk += 12;
    }

    return 0;
}

int kerl_absorb_trits_single(cx_sha3_t *sha3,const trit_t *trits_in)
{
    unsigned char bytes[12 * 4];
    uint32_t bigint[12];

    // the last trit will be ignored
    trits_to_bigint(trits_in, bigint);
    bigint_to_bytes(bigint, bytes);

    return kerl_absorb_bytes(sha3, bytes, 12 * 4);
}

int kerl_absorb_trits(cx_sha3_t *sha3,const trit_t *trits_in, uint16_t len)
{
    // absorbing trits happens in 243 trit chunks
    for (uint8_t i = 0; i < (len / 243); i++) {
        kerl_absorb_trits_single(sha3, trits_in + i * 243);
    }

    return 0;
}

int kerl_squeeze_trits_single(cx_sha3_t *sha3, trit_t *trits_out)
{
    unsigned char bytes[12 * 4];
    uint32_t bigint[12];

    kerl_squeeze_bytes(sha3, bytes);
    bytes_to_bigint(bytes, bigint);

    bigint_to_trits(bigint, trits_out);

    // always set last trit to zero, as it cannot be represented in 48bytes
    trits_out[242] = 0;

    return 0;
}

int kerl_squeeze_trits(cx_sha3_t *sha3, trit_t *trits_out, uint16_t len)
{
    for (uint8_t i = 0; i < (len / 243); i++) {
        kerl_squeeze_trits_single(sha3, trits_out + i * 243);
    }

    return 0;
}

int kerl_absorb_trints_single(cx_sha3_t *sha3, const trint_t *trints_in)
{
    unsigned char bytes[12 * 4];
    uint32_t bigint[12];

    // the last trit will be ignored
    trints_to_bigint_mem(trints_in, bigint);
    bigint_to_bytes(bigint, bytes);

    return kerl_absorb_bytes(sha3, bytes, 12 * 4);
}

int kerl_absorb_trints(cx_sha3_t *sha3, const trint_t *trints_in, uint16_t len)
{
    for (uint8_t i = 0; i < (len / 49); i++) {
        kerl_absorb_trints_single(sha3, trints_in + i * 49);
    }

    return 0;
}

int kerl_squeeze_trints_single(cx_sha3_t *sha3, trint_t *trints_out)
{
    unsigned char bytes[12 * 4];
    uint32_t bigint[12];

    kerl_squeeze_bytes(sha3, bytes);
    bytes_to_bigint(bytes, bigint);

    bigint_to_trints_mem(bigint, trints_out);

    // always set last trit to zero, as it cannot be represented in 48bytes
    trit_t trits[3];
    // grab and store last clump of 3 trits
    trint_to_trits(trints_out[48], &trits[0], 3);
    trits[2] = 0;  // set last trit to 0
    // convert new trit set back to trint and store
    trints_out[48] = trits_to_trint(&trits[0], 3);

    return 0;
}

int kerl_squeeze_trints(cx_sha3_t *sha3, trint_t *trints_out, uint16_t len)
{
    for (uint8_t i = 0; i < (len / 49); i++) {
        kerl_squeeze_trints_single(sha3, trints_out + i * 49);
    }

    return 0;
}
