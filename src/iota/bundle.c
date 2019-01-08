#include "bundle.h"
#include <string.h>
#include "common.h"
#include "addresses.h"
#include "conversion.h"
#include "kerl.h"

// pointer to the first byte of the current transaction
#define TX_BYTES(C) ((C)->bytes + (C)->current_tx_index * (2 * NUM_HASH_BYTES))

void bundle_initialize(BUNDLE_CTX *ctx, uint8_t last_tx_index)
{
    if (last_tx_index < 1 || last_tx_index >= MAX_BUNDLE_SIZE) {
        THROW(INVALID_PARAMETER);
    }

    os_memset(ctx, 0, sizeof(BUNDLE_CTX));
    ctx->last_tx_index = last_tx_index;
}

void bundle_set_external_address(BUNDLE_CTX *ctx, const char *address)
{
    if (!bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }

    unsigned char *bytes_ptr = TX_BYTES(ctx);
    chars_to_bytes(address, bytes_ptr, 81);
}

void bundle_set_internal_address(BUNDLE_CTX *ctx, const char *address,
                                 uint32_t index)
{
    bundle_set_external_address(ctx, address);
    ctx->indices[ctx->current_tx_index] = index;
}

static void create_bundle_bytes(int64_t value, const char *tag,
                                uint32_t timestamp, uint8_t current_tx_index,
                                uint8_t last_tx_index, unsigned char *bytes)
{
    trit_t bundle_essence_trits[243] = {0};

    s64_to_trits(value, bundle_essence_trits, 81);
    chars_to_trits(tag, bundle_essence_trits + 81, 27);
    u32_to_trits(timestamp, bundle_essence_trits + 162, 27);
    u32_to_trits(current_tx_index, bundle_essence_trits + 189, 27);
    u32_to_trits(last_tx_index, bundle_essence_trits + 216, 27);

    // now we have exactly one chunk of 243 trits
    trits_to_bytes(bundle_essence_trits, bytes);
}

uint32_t bundle_add_tx(BUNDLE_CTX *ctx, int64_t value, const char *tag,
                       uint32_t timestamp)
{
    if (!bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }

    unsigned char *bytes_ptr = TX_BYTES(ctx);

    // the combined trits make up the second part
    create_bundle_bytes(value, tag, timestamp, ctx->current_tx_index,
                        ctx->last_tx_index, bytes_ptr + 48);

    // store the binary value
    ctx->values[ctx->current_tx_index] = value;

    return ctx->current_tx_index++;
}

static inline int decrement_tryte(int max, tryte_t *tryte)
{
    const int slack = *tryte - MIN_TRYTE_VALUE;
    if (slack <= 0) {
        return 0;
    }

    const int dec = MIN(max, slack);
    *tryte -= dec;

    return dec;
}

static inline int increment_tryte(int max, tryte_t *tryte)
{
    const int slack = MAX_TRYTE_VALUE - *tryte;
    if (slack <= 0) {
        return 0;
    }

    const int inc = MIN(max, slack);
    *tryte += inc;

    return inc;
}

static void normalize_hash_fragment(tryte_t *fragment_trytes)
{
    int sum = 0;
    for (unsigned int j = 0; j < 27; j++) {
        sum += fragment_trytes[j];
    }

    for (unsigned int j = 0; j < 27; j++) {
        if (sum > 0) {
            sum -= decrement_tryte(sum, &fragment_trytes[j]);
        }
        else if (sum < 0) {
            sum += increment_tryte(-sum, &fragment_trytes[j]);
        }
        if (sum == 0) {
            break;
        }
    }
}

static inline void normalize_hash(tryte_t *hash_trytes)
{
    for (unsigned int i = 0; i < 3; i++) {
        normalize_hash_fragment(hash_trytes + i * 27);
    }
}

static void normalize_hash_bytes(const unsigned char *hash_bytes,
                                 tryte_t *normalized_hash_trytes)
{
    bytes_to_trytes(hash_bytes, normalized_hash_trytes);
    normalize_hash(normalized_hash_trytes);
}

static bool validate_address(const unsigned char *addr_bytes,
                             const unsigned char *seed_bytes, uint32_t idx,
                             unsigned int security)
{
    unsigned char computed_addr[48];
    get_public_addr(seed_bytes, idx, security, computed_addr);

    return (os_memcmp(addr_bytes, computed_addr, 48) == 0);
}

/** @return Whether all values sum up to zero. */
static bool validate_balance(const BUNDLE_CTX *ctx)
{
    int64_t value = 0;

    for (uint8_t i = 0; i <= ctx->last_tx_index; i++) {
        value += ctx->values[i];
    }

    return value == 0;
}

/** @return Whether every input transaction has meta transactions. */
static bool validate_meta_txs(const BUNDLE_CTX *ctx, uint8_t security)
{
    for (uint8_t i = 0; i <= ctx->last_tx_index; i++) {
        // only input transactions have meta transactions
        if (bundle_is_input_tx(ctx, i)) {
            const unsigned char *input_addr_bytes =
                bundle_get_address_bytes(ctx, i);

            for (uint8_t j = 1; j < security; j++) {
                if (i + j > ctx->last_tx_index || ctx->values[i + j] != 0) {
                    return false;
                }
                if (os_memcmp(input_addr_bytes,
                              bundle_get_address_bytes(ctx, i + j),
                              NUM_HASH_BYTES) != 0) {
                    return false;
                }
            }
        }
    }

    return true;
}

/**
 * @return Whether the index of the change address is higher than all input
 * indices.
 */
static bool validate_change_index(const BUNDLE_CTX *ctx,
                                  uint8_t change_tx_index)
{
    // if there is no change transaction, this is always valid
    if (change_tx_index > ctx->last_tx_index) {
        return true;
    }

    for (uint8_t i = 0; i <= ctx->last_tx_index; i++) {
        if (ctx->values[i] < 0 &&
            ctx->indices[i] >= ctx->indices[change_tx_index]) {
            return false;
        }
    }

    return true;
}

/** @return Whether the provided seed indices match the addresses. */
static bool validate_address_indices(const BUNDLE_CTX *ctx,
                                     uint8_t change_tx_index,
                                     const unsigned char *seed_bytes,
                                     uint8_t security)
{
    for (uint8_t i = 0; i <= ctx->last_tx_index; i++) {
        // only check the change and input addresses
        if (i == change_tx_index || bundle_is_input_tx(ctx, i)) {
            const unsigned char *addr_bytes = bundle_get_address_bytes(ctx, i);

            if (!validate_address(addr_bytes, seed_bytes, ctx->indices[i],
                                  security)) {
                return false;
            }
        }
    }

    return true;
}

/** @return Whether each address occures only once in the bundle. */
static bool validate_address_reuse(const BUNDLE_CTX *ctx)
{
    for (uint8_t i = 0; i <= ctx->last_tx_index; i++) {

        if (ctx->values[i] == 0) {
            continue;
        }
        const unsigned char *addr_bytes = bundle_get_address_bytes(ctx, i);

        for (uint8_t j = i + 1; j <= ctx->last_tx_index; j++) {
            if (ctx->values[j] != 0 &&
                os_memcmp(addr_bytes, bundle_get_address_bytes(ctx, j),
                          NUM_HASH_BYTES) == 0) {
                return false;
            }
        }
    }

    return true;
}

static int validate_bundle(const BUNDLE_CTX *ctx, uint8_t change_tx_index,
                           const unsigned char *seed_bytes, uint8_t security)
{
    if (!validate_balance(ctx)) {
        return NONZERO_BALANCE;
    }
    if (!validate_meta_txs(ctx, security)) {
        return INVALID_META_TX;
    }
    if (!validate_change_index(ctx, change_tx_index)) {
        return CHANGE_IDX_LOW;
    }
    if (!validate_address_indices(ctx, change_tx_index, seed_bytes, security)) {
        return INVALID_ADDRESS_INDEX;
    }
    if (!validate_address_reuse(ctx)) {
        return ADDRESS_REUSED;
    }

    return OK;
}

NO_INLINE
static bool validate_hash(const BUNDLE_CTX *ctx)
{
    tryte_t hash_trytes[81];
    normalize_hash_bytes(ctx->hash, hash_trytes);

    if (memchr(hash_trytes, MAX_TRYTE_VALUE, 81) != NULL) {
        return false;
    }

    return true;
}

NO_INLINE
static void compute_hash(BUNDLE_CTX *ctx)
{
    cx_sha3_t sha;

    kerl_initialize(&sha);
    kerl_absorb_bytes(&sha, ctx->bytes, TX_BYTES(ctx) - ctx->bytes);
    kerl_squeeze_final_chunk(&sha, ctx->hash);
}

int bundle_validating_finalize(BUNDLE_CTX *ctx, uint8_t change_tx_index,
                               const unsigned char *seed_bytes,
                               uint8_t security)
{
    if (bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }

    int result = validate_bundle(ctx, change_tx_index, seed_bytes, security);
    if (result != OK) {
        return result;
    }

    compute_hash(ctx);
    if (!validate_hash(ctx)) {
        // if the hash is invalid, reset it to zero
        os_memset(ctx->hash, 0, 48);
        return UNSECURE_HASH;
    }

    return OK;
}

const unsigned char *bundle_get_address_bytes(const BUNDLE_CTX *ctx,
                                              uint8_t tx_index)
{
    if (tx_index >= ctx->current_tx_index) {
        THROW(INVALID_PARAMETER);
    }

    return ctx->bytes + tx_index * 96;
}

const unsigned char *bundle_get_hash(const BUNDLE_CTX *ctx)
{
    if (bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }
    // TODO check that the bundle has already been finalized

    return ctx->hash;
}

void bundle_get_normalized_hash(const BUNDLE_CTX *ctx, tryte_t *hash_trytes)
{
    bytes_to_trytes(bundle_get_hash(ctx), hash_trytes);
    normalize_hash(hash_trytes);
}

bool bundle_is_input_tx(const BUNDLE_CTX *ctx, uint8_t tx_index)
{
    if (tx_index > ctx->last_tx_index) {
        THROW(INVALID_PARAMETER);
    }

    return ctx->values[tx_index] < 0;
}
