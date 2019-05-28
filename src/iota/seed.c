#include "iota/seed.h"
#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "os.h"

#define NUM_KEY_BYTES 32
#define NUM_CHAIN_BYTES 32

/** @brief Computes a valid IOTA seed based on the provided entropy.
 *  @param n number of entropy bytes
 *  @param seed_bytes target array to store the seed in 48 byte encoding
 */
static void derive_seed_entropy(const unsigned char *entropy, unsigned int n,
                                unsigned char *seed_bytes)
{
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
}

void seed_derive_from_bip32(const unsigned int *path, unsigned int pathLength,
                            unsigned char *seed_bytes)
{
    // we only care about privateKey and chain to use as entropy for the seed
    unsigned char entropy[NUM_KEY_BYTES + NUM_CHAIN_BYTES];
    os_perso_derive_node_bip32(CX_CURVE_256K1, (unsigned int *)path, pathLength,
                               entropy, entropy + NUM_KEY_BYTES);

    derive_seed_entropy(entropy, sizeof(entropy), seed_bytes);
}
