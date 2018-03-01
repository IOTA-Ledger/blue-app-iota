#ifndef SIGNING_H
#define SIGNING_H

#include "iota_types.h"

// the number of chunks in one signature fragment
// this can be changed to any multiple of 3 up to 27
#define SIGNATURE_FRAGMENT_SIZE 27
// #define SIGNATURE_FRAGMENT_SIZE 9

// the maximum number of chunks is SEC_LVL*27
#define NUM_SIGNATURE_FRAGMENTS(s) (CEILING(s*27, SIGNATURE_FRAGMENT_SIZE))

/** @brief Computes the first fragment of the signature.
 * @param state 48-byte Kerl state that can be used to generate next fragment
 * @param hash_fragment part of normalized hash of size #SIGNATURE_FRAGMENT_SIZE
 * @param signature_bytes target array for the signature in 48byte chunks
 */
void signing_first_fragment(const unsigned char *seed_bytes, uint32_t idx,
                            unsigned char *state, const tryte_t *hash_fragment,
                            unsigned char *signature_bytes);

/** @brief Computes a subsequent fragment of the signature.
 * @param state 48-byte Kerl state that is used to reinitialize the hashing for
 *        the new fragment. Contains updated Kerl state for further fragments.
 * @param hash_fragment part of normalized hash of size #SIGNATURE_FRAGMENT_SIZE
 * @param signature_bytes target array for the signature in 48byte chunks
 */
void signing_next_fragment(unsigned char *state, const tryte_t *hash_fragment,
                           unsigned char *signature_bytes);

#endif // SIGNING_H
