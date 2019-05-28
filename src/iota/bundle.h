#ifndef BUNDLE_H
#define BUNDLE_H

#include <stdbool.h>
#include <stdint.h>
#include "iota/iota_types.h"

// the largest bundle size due to memory limitations per device
#ifdef TARGET_NANOS
#define MAX_BUNDLE_SIZE 10
#elif defined TARGET_NANOX
#define MAX_BUNDLE_SIZE 10
#else // BLUE
#define MAX_BUNDLE_SIZE 20
#endif // TARGET_NANOS/X/BLUE

typedef struct BUNDLE_INFO {
    /// transaction values
    int64_t values[MAX_BUNDLE_SIZE];
    /// trasaction address indices
    uint32_t indices[MAX_BUNDLE_SIZE];

    uint8_t current_tx_index;
    uint8_t last_tx_index;
} BUNDLE_INFO;

typedef struct BUNDLE_CTX {
    /// shared bundle information
    BUNDLE_INFO bundle;

    /// bundle_bytes holds all of the bundle information in byte encoding
    unsigned char bytes[MAX_BUNDLE_SIZE * 2 * NUM_HASH_BYTES];

    /// bundle hash, when finalized
    unsigned char hash[NUM_HASH_BYTES];
} BUNDLE_CTX;

enum BundleRetCode {
    OK,
    UNSECURE_HASH,
    NONZERO_BALANCE,
    INVALID_META_TX,
    INVALID_ADDRESS_INDEX,
    ADDRESS_REUSED,
    CHANGE_IDX_LOW,
    CHANGE_ADDR_NOT_OURS
};

/** @brief Initializes the bundle context for a fixed number of transactions.
 *  @param ctx the bundle context used
 *  @param last_index index of the last transaction in the bundle. Must be at
 *         least 1 as at least an output and an input transaction is required
 */
void bundle_initialize(BUNDLE_CTX *ctx, uint8_t last_tx_index);

/** @brief Sets the address for the current output transaction.
 *  The address must be set befor calling bundle_add_tx().
 *  @param ctx the bundle context used
 *  @param address address in base-27 encoding
 */
void bundle_set_external_address(BUNDLE_CTX *ctx, const char *address);

/** @brief Sets the address for the current input transaction.
 *  The address must be set befor calling bundle_add_tx(). The index must match
 *  the address, this is verified in bundle_validating_finalize().
 *  @param ctx the bundle context used
 *  @param address address in base-27 encoding
 *  @param index address index
 */
void bundle_set_internal_address(BUNDLE_CTX *ctx, const char *address,
                                 uint32_t index);

/** @brief Sets the content for the current transaction, finalizing it.
 *  This will increment the current transaction, so that
 *  bundle_set_address_chars(), bundle_set_address_bytes() can be called for
 *  the next transaction.
 *  @param ctx the bundle context used
 *  @param value transaction signed value
 *  @param tag transaction tag in base-27 encoding must be exactly 27 char long
 *  @param timestamp transaction timestamp
 *  @return index of the just added transaction.
 */
uint8_t bundle_add_tx(BUNDLE_CTX *ctx, int64_t value, const char *tag,
                      uint32_t timestamp);

/** @brief Finalizes the bundle, if it has a valid bundle hash.
 *  A bundle is valid, if a) values sum up to 0 b) the index of each input
 *  transaction matches the provided address c) the normalized bundle hash does
 *  not contain 'M'.
 *  @param ctx the bundle context used.
 *  @param change_tx_index the index of the change transaction
 *  @param seed_bytes seed used for the addresses
 *  @param security security level used for the addresses
 *  @return 0 if the bundle is valid
 */
int bundle_validating_finalize(BUNDLE_CTX *ctx, uint8_t change_tx_index,
                               const unsigned char *seed_bytes,
                               uint8_t security);

/** @brief Returns the (not normalized) hash of the finalized bundle.
 *  @param ctx the bundle context used
 */
const unsigned char *bundle_get_hash(const BUNDLE_CTX *ctx);

/** @brief Returns a pointer to the address of the given transaction in
 *         48-byte representation.
 *         This can only be called for an already finalized transaction index.
 *  @param ctx the bundle context used
 *  @param tx_index transaction index
 */
const unsigned char *bundle_get_address_bytes(const BUNDLE_CTX *ctx,
                                              uint8_t tx_index);

/** @brief Computes the normalized hash.
 *  @param ctx the bundle context used
 *  @param hash_trytes target 81-tryte array for the normalized hash
 */
void bundle_get_normalized_hash(const BUNDLE_CTX *ctx, tryte_t *hash_trytes);

/** @brief Returns whether the given transaction is an input transaction
 *  @param ctx the bundle context used
 *  @param tx_index transaction index
 *  @return true, if transaction is an input, false otherwise
 */
bool bundle_is_input_tx(const BUNDLE_CTX *ctx, uint8_t tx_index);

/** @brief Returns the number of value transactions in the bundle.
 *  @param ctx the bundle context used
 */
uint8_t bundle_get_num_value_txs(const BUNDLE_CTX *ctx);

/** @brief Returns whether there are still transactions missing in the bundle.
 *  @param ctx the bundle context used
 *  @return true, if transactions are missing, false if the bundle is complete
 */
static inline bool bundle_has_open_txs(const BUNDLE_CTX *ctx)
{
    return ctx->bundle.current_tx_index <= ctx->bundle.last_tx_index;
}

#endif // BUNDLE_H
