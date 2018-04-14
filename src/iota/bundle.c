#include "bundle.h"
#include <string.h>
#include "common.h"
#include "addresses.h"
#include "conversion.h"
#include "kerl.h"

// pointer to the first byte of the current transaction
#define TX_BYTES(C) ((C)->bytes + (C)->current_index * 96)

void bundle_initialize(BUNDLE_CTX *ctx, uint32_t last_index)
{
    if (last_index >= MAX_BUNDLE_INDEX_SZ) {
        THROW(INVALID_PARAMETER);
    }

    os_memset(ctx, 0, sizeof(BUNDLE_CTX));
    ctx->last_index = last_index;
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
    ctx->indices[ctx->current_index] = index;
}

void bundle_set_address_bytes(BUNDLE_CTX *ctx, const unsigned char *addresses)
{
    if (!bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }

    unsigned char *bytes_ptr = TX_BYTES(ctx);
    os_memcpy(bytes_ptr, addresses, 48);
}

static void create_bundle_bytes(int64_t value, const char *tag,
                                uint32_t timestamp, uint32_t current_index,
                                uint32_t last_index, unsigned char *bytes)
{
    trit_t bundle_essence_trits[243] = {0};

    int64_to_trits(value, bundle_essence_trits, 81);
    chars_to_trits(tag, bundle_essence_trits + 81, 27);
    int64_to_trits(timestamp, bundle_essence_trits + 162, 27);
    int64_to_trits(current_index, bundle_essence_trits + 189, 27);
    int64_to_trits(last_index, bundle_essence_trits + 216, 27);

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
    create_bundle_bytes(value, tag, timestamp, ctx->current_index,
                        ctx->last_index, bytes_ptr + 48);

    // store the binary value
    ctx->values[ctx->current_index] = value;

    return ctx->current_index++;
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

void normalize_hash_bytes(const unsigned char *hash_bytes,
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

    return (memcmp(addr_bytes, computed_addr, 48) == 0);
}

static bool validate_balance(const BUNDLE_CTX *ctx)
{
    int64_t balance = 0;
    for (unsigned int i = 0; i <= ctx->last_index; i++) {
        balance += ctx->values[i];
    }

    return balance == 0;
}

/** @brief Checks that every input transaction has meta transactions. */
static bool validate_meta_txs(const BUNDLE_CTX *ctx, unsigned int security)
{
    for (unsigned int i = 0; i <= ctx->last_index; i++) {
        if (ctx->values[i] < 0) {
            const unsigned char *input_addr_bytes =
                bundle_get_address_bytes(ctx, i);

            for (unsigned int j = 1; j < security; j++) {
                if (i + j > ctx->last_index || ctx->values[i + j] != 0) {
                    return false;
                }
                if (memcmp(input_addr_bytes,
                           bundle_get_address_bytes(ctx, i + j),
                           NUM_HASH_BYTES) != 0) {
                    return false;
                }
            }
        }
    }

    return true;
}

static bool validate_address_indices(const BUNDLE_CTX *ctx,
                                     unsigned int change_tx_index,
                                     const unsigned char *seed_bytes,
                                     unsigned int security)
{
    for (unsigned int i = 0; i <= ctx->last_index; i++) {
        // only check the change and input addresses
        if (i == change_tx_index || ctx->values[i] < 0) {
            const unsigned char *addr_bytes = bundle_get_address_bytes(ctx, i);

            if (!validate_address(addr_bytes, seed_bytes, ctx->indices[i],
                                  security)) {
                return false;
            }
        }
    }

    return true;
}

static bool validate_address_reuse(const BUNDLE_CTX *ctx)
{
    for (unsigned int i = 0; i <= ctx->last_index; i++) {

        if (ctx->values[i] == 0) {
            continue;
        }
        const unsigned char *addr_bytes = bundle_get_address_bytes(ctx, i);

        for (unsigned int j = i + 1; j <= ctx->last_index; j++) {
            if (ctx->values[j] != 0 &&
                memcmp(addr_bytes, bundle_get_address_bytes(ctx, j),
                       NUM_HASH_BYTES) == 0) {
                return false;
            }
        }
    }

    return true;
}

static bool validate_bundle(const BUNDLE_CTX *ctx, unsigned int change_tx_index,
                            const unsigned char *seed_bytes,
                            unsigned int security)
{
    if (!validate_balance(ctx)) {
        return false;
    }

    if (!validate_meta_txs(ctx, security)) {
        return false;
    }

    if (!validate_address_indices(ctx, change_tx_index, seed_bytes, security)) {
        return false;
    }

    if (!validate_address_reuse(ctx)) {
        return false;
    }

    return true;
}

static void compute_hash(BUNDLE_CTX *ctx)
{
    cx_sha3_t sha;

    kerl_initialize(&sha);
    kerl_absorb_bytes(&sha, ctx->bytes, TX_BYTES(ctx) - ctx->bytes);
    kerl_squeeze_final_chunk(&sha, ctx->hash);
}

static bool bundle_validate_hash(BUNDLE_CTX *ctx)
{
    tryte_t hash_trytes[81];
    compute_hash(ctx);
    normalize_hash_bytes(ctx->hash, hash_trytes);

    if (memchr(hash_trytes, MAX_TRYTE_VALUE, 81) != NULL) {
        // if the hash is invalid, reset it to zero
        os_memset(ctx->hash, 0, 48);
        return false;
    }

    return true;
}

bool bundle_validating_finalize(BUNDLE_CTX *ctx, uint32_t change_index,
                                const unsigned char *seed_bytes,
                                unsigned int security)
{
    if (bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }

    return validate_bundle(ctx, change_index, seed_bytes, security) &&
           bundle_validate_hash(ctx);
}

unsigned int bundle_finalize(BUNDLE_CTX *ctx)
{
    unsigned int tag_increment = 0;

    if (bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }

    while (!bundle_validate_hash(ctx)) {
        // increment the tag of the first transaction
        bytes_increment_trit_area_81(ctx->bytes + 48);
        tag_increment++;
    }

    // the not normalized hash is already in the result pointer
    return tag_increment;
}

const unsigned char *bundle_get_address_bytes(const BUNDLE_CTX *ctx,
                                              uint32_t tx_index)
{
    if (tx_index >= ctx->current_index) {
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
