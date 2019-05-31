#ifndef SIGNING_H
#define SIGNING_H

#include <stdbool.h>
#include <stdint.h>
#include "iota/bundle.h"
#include "iota/iota_types.h"

// the number of chunks in one signature fragment
// this can be changed to any multiple of 3 up to 27
// prefer larger number when possible
#define SIGNATURE_FRAGMENT_SIZE 3

typedef struct SIGNING_CTX {
    BUNDLE_INFO bundle;            ///< shared bundle info used for signing
    tryte_t hash[NUM_HASH_TRYTES]; ///< bundle hash used for signing

    unsigned char state[NUM_HASH_BYTES]; ///< state of the last Kerl squeeze

    uint8_t fragment_index; ///< index of the next fragment
    uint8_t last_fragment;  ///< final fragment
    uint8_t tx_index;       ///< index of the signed transaction
} SIGNING_CTX;

/** @brief Initializes the signing context based on the given bundle.
 *  @param ctx the signing context used
 *  @param bundle_info
 *  @param normalized_hash bundle hash as a 81 elemet tryte array
 */
void signing_initialize(SIGNING_CTX *ctx, const BUNDLE_INFO *bundle_info,
                        const tryte_t *normalized_hash);

/** @brief Starts the signing context for one complete signature.
 *  @param ctx the signing context used
 *  @param tx_index index of the transaciton to be signed
 *  @param seed_bytes seed in 48 byte big endian encoding
 *  @param security security level, either 1,2 or 3
 */
void signing_start(SIGNING_CTX *ctx, uint8_t tx_index,
                   const unsigned char *seed_bytes, uint8_t security);

/** @brief Computes the next signature fragment.
 *  @param ctx the signing context used
 *  @param signature_bytes target array for the fragment in 48 byte encoding
 *  @return index of the just computed signature fragment
 */
unsigned int signing_next_fragment(SIGNING_CTX *ctx,
                                   unsigned char *signature_bytes);

/** @brief Returns whether there are remaining signature fragments.
 *  @param ctx the signing context used
 *  @return true, if there is another fragment, false otherwise
 */
static inline bool signing_has_next_fragment(const SIGNING_CTX *ctx)
{
    return ctx->fragment_index <= ctx->last_fragment;
}

#endif // SIGNING_H
