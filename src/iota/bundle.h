#ifndef BUNDLE_H
#define BUNDLE_H

#include "iota_types.h"

#define SEC_LVL 2

#define MAX_BUNDLE_INDEX_SZ 8
#define MAX_BUNDLE_NUM_INPUTS ((MAX_BUNDLE_INDEX_SZ)-2) / (SEC_LVL)

typedef struct BUNDLE_CTX {
        // bundle_bytes holds all of the bundle information in byte format
        unsigned char bytes[MAX_BUNDLE_INDEX_SZ * 96];

        uint32_t current_index;
        uint32_t last_index;
} BUNDLE_CTX;

void bundle_initialize(BUNDLE_CTX *ctx, uint32_t last_index);

void bundle_set_address_chars(BUNDLE_CTX *ctx, const char *address);

void bundle_set_address_bytes(BUNDLE_CTX *ctx, const unsigned char *addresses);

uint32_t bundle_add_tx(BUNDLE_CTX *ctx, int64_t value, const char *tag,
                       uint32_t timestamp);

/** @brief Computes the valid bundle hash.
 *  @return tag increment of the first transaction that was necessary to
 *          generate a valid bundle
 */
unsigned int bundle_finalize(BUNDLE_CTX *ctx, unsigned char *hash_bytes);

/** @brief Returns a pointer to the address of the given transaction in
 *         48-byte representation.
 */
const unsigned char *bundle_get_address_bytes(const BUNDLE_CTX *ctx,
                                              uint32_t tx_index);

uint32_t bundle_get_current_index(const BUNDLE_CTX *ctx);

/** @brief Computes the normalized hash.
 *  @param hash_bytes input hash in 48-byte representation.
 *  @param normalized_hash_trytes target 81-tryte array for the normalized hash.
 */
void normalize_hash_bytes(const unsigned char *hash_bytes,
                          tryte_t *normalized_hash_trytes);

#endif // BUNDLE_H
