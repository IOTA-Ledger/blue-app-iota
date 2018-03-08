#ifndef BUNDLE_H
#define BUNDLE_H

#include "iota_types.h"

#define SEC_LVL 2

#define MAX_BUNDLE_INDEX_SZ 8
#define MAX_BUNDLE_NUM_INPUTS ((MAX_BUNDLE_INDEX_SZ)-2) / (SEC_LVL)

typedef struct BUNDLE_CTX {
        // bundle_bytes holds all of the bundle information in byte encoding
        unsigned char bytes[MAX_BUNDLE_INDEX_SZ * 96];

        uint32_t current_index;
        uint32_t last_index;

        unsigned char hash[48]; // bundle hash, when finalized
} BUNDLE_CTX;

/** @brief Initializes the bundle context for a fixed number of transactions.
 *  @param ctx the bundle context used
 *  @param last_index index of the last transaction in the bundle. Must be at
 *         least 1 as at least an output and an input transaction is required
 */
void bundle_initialize(BUNDLE_CTX *ctx, uint32_t last_index);

/** @brief Sets the address for the current transaction.
 *  The address must be set befor calling bundle_add_tx().
 *  @param ctx the bundle context used
 *  @param address address in base-27 encoding
 */
void bundle_set_address_chars(BUNDLE_CTX *ctx, const char *address);

/** @brief Sets the address for the current transaction.
 *  The address must be set befor calling bundle_add_tx().
 *  @param ctx the bundle context used
 *  @param address address in 48-byte big endian encoding
 */
void bundle_set_address_bytes(BUNDLE_CTX *ctx, const unsigned char *addresses);

/** @brief Sets the content for the current transaction, finalizing it.
 *  This will increment the current transaction, so that
 *  bundle_set_address_chars(), bundle_set_address_bytes() can be called for
 *  the next transaction.
 *  @param ctx the bundle context used
 *  @param value transaction signed value
 *  @param tag transaction tag in base-27 encoding must be exactly 27 char long
 *  @param timestamp transaction timestamp
 *  @return index of the just finalized transaction.
 */
uint32_t bundle_add_tx(BUNDLE_CTX *ctx, int64_t value, const char *tag,
                       uint32_t timestamp);

/** @brief Finalizes the bundle by computing the valid bundle hash.
 *  @param ctx the bundle context used.
 *  @return tag increment of the first transaction that was necessary to
 *          generate a valid bundle
 */
unsigned int bundle_finalize(BUNDLE_CTX *ctx);

/** @brief Returns the (not normalized) hash of the finalized bundle.
 *  @param ctx the bundle context used
 */
const unsigned char* bundle_get_hash(const BUNDLE_CTX *ctx);

/** @brief Returns a pointer to the address of the given transaction in
 *         48-byte representation.
 *         This can only be called for an already finalized transaction index.
 *  @param ctx the bundle context used
 *  @param tx_index transaction index
 */
const unsigned char *bundle_get_address_bytes(const BUNDLE_CTX *ctx,
                                              uint32_t tx_index);

/** @brief Computes the normalized hash.
 *  @param hash_bytes input hash in 48-byte representation.
 *  @param normalized_hash_trytes target 81-tryte array for the normalized hash
 */
void normalize_hash_bytes(const unsigned char *hash_bytes,
                          tryte_t *normalized_hash_trytes);

#endif // BUNDLE_H
