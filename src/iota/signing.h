#ifndef SIGNING_H
#define SIGNING_H

#include "stdbool.h"
#include "iota_types.h"

// the number of chunks in one signature fragment
// this can be changed to any multiple of 3 up to 27
// prefer larger number when possible
#define SIGNATURE_FRAGMENT_SIZE 27

// the maximum number of chunks is SEC_LVL*27
#define NUM_SIGNATURE_FRAGMENTS(s) (CEILING(s*27, SIGNATURE_FRAGMENT_SIZE))

typedef struct SIGNING_CTX {
        unsigned char state[48]; // state of the last Kerl squeeze

        // bitfield storing all the indices
        uint32_t fragment_index; // index of the next fragment
        uint32_t last_fragment; // final fragment

        tryte_t hash[81]; // bundle hash used for signing
} SIGNING_CTX;

/** @brief Initializes the signing context for one complete signature.
 *  @param ctx the signing context used
 *  @param seed_bytes seed in 48 byte big endian encoding
 *  @param address_idx index of the address
 *  @param security security level, either 1,2 or 3
 *  @param normalized_hash bundle hash as a 81 elemet tryte array
 */
void signing_initialize(SIGNING_CTX *ctx, const unsigned char *seed_bytes,
                        uint32_t address_idx, uint8_t security,
                        const tryte_t *normalized_hash);

/** @brief Computes the next signature fragment.
 *  @param ctx the signing context used
 *  @param signature_bytes target array for the fragment in 48 byte encoding
 *  @return index of the just computed signature fragment
 */
unsigned int signing_next_fragment(SIGNING_CTX *ctx,
                                   unsigned char *signature_bytes);

/** @brief Return wether there are remaining signatrue fragments
 *  @param ctx the signing context used
 *  @return true, if there is another fragment, false otherwise
 */
static inline bool signing_has_next_fragment(const SIGNING_CTX *ctx)
{
        return ctx->fragment_index <= ctx->last_fragment;
}

#endif // SIGNING_H
