#include "seed.h"
#include "common.h"
#include "iota_types.h"
#include "conversion.h"
#include "kerl.h"

void derive_seed_entropy(const unsigned char *entropy, unsigned int n,
                         unsigned char *seed_bytes)
{
#ifndef DEBUG_SEED
    // at least one chunk of entropy required
    if (n < NUM_HASH_BYTES) {
        THROW(INVALID_PARAMETER);
    }

    cx_sha3_t sha;
    kerl_initialize(&sha);

    for (unsigned int i = 0; i < n / NUM_HASH_BYTES; i++) {
        kerl_absorb_chunk(&sha, entropy + i * NUM_HASH_BYTES);
    }
    if (n % NUM_HASH_BYTES != 0) {
        kerl_absorb_chunk(&sha, entropy + (n - NUM_HASH_BYTES));
    }

    kerl_squeeze_final_chunk(&sha, seed_bytes);
#else  // DEBUG_SEED
    UNUSED(entropy);
    UNUSED(n);

    chars_to_bytes(DEBUG_SEED, seed_bytes, NUM_HASH_TRYTES);
#endif // DEBUG_SEED
}

void derive_seed_bip32(const unsigned int *path, unsigned int pathLength,
                       unsigned char *seed_bytes)
{
    // we only care about privateKey and chain to use as entropy for the seed
    unsigned char entropy[64];
    os_perso_derive_node_bip32(CX_CURVE_256K1, path, pathLength, entropy,
                               entropy + 32);

    derive_seed_entropy(entropy, sizeof(entropy), seed_bytes);
}
