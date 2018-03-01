#include "common.h"
#include "conversion.h"
#include "kerl.h"
#include "bundle.h"

// pointer to the first byte of the current transaction
#define TX_BYTES(C) ((C)->bytes + (C)->current_index * 96)

void bundle_initialize(BUNDLE_CTX *ctx, uint32_t last_index)
{
    if (last_index < 1 || last_index >= MAX_BUNDLE_INDEX_SZ) {
        THROW(INVALID_PARAMETER);
    }

    os_memset(ctx, 0, sizeof(BUNDLE_CTX));
    ctx->last_index = last_index;
}

void bundle_set_address_chars(BUNDLE_CTX *ctx, const char *address)
{
    if (ctx->current_index > ctx->last_index) {
        THROW(INVALID_STATE);
    }

    unsigned char *bytes_ptr = TX_BYTES(ctx);
    chars_to_bytes(address, bytes_ptr, 81);
}

void bundle_set_address_bytes(BUNDLE_CTX *ctx, const unsigned char *addresses)
{
    if (ctx->current_index > ctx->last_index) {
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
    if (ctx->current_index > ctx->last_index) {
        THROW(INVALID_STATE);
    }

    unsigned char *bytes_ptr = TX_BYTES(ctx);

    // the combined trits make up the second part
    create_bundle_bytes(value, tag, timestamp, ctx->current_index,
                        ctx->last_index, bytes_ptr + 48);

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

static void normalize_hash(tryte_t *hash_trytes)
{
    for (unsigned int i = 0; i < 3; i++) {
        normalize_hash_fragment(hash_trytes + i * 27);
    }
}

static inline void compute_hash(const BUNDLE_CTX *ctx,
                                unsigned char *hash_bytes)
{
    cx_sha3_t sha;

    kerl_initialize(&sha);
    kerl_absorb_bytes(&sha, ctx->bytes, TX_BYTES(ctx) - ctx->bytes);
    kerl_squeeze_final_chunk(&sha, hash_bytes);
}

unsigned int bundle_finalize(BUNDLE_CTX *ctx, unsigned char *hash_bytes)
{
    unsigned int tag_increment = 0;

    if (ctx->current_index <= ctx->last_index) {
        THROW(INVALID_STATE);
    }

    while (true) {
        tryte_t hash_trytes[81];
        compute_hash(ctx, hash_bytes);
        bytes_to_trytes(hash_bytes, hash_trytes);

        normalize_hash(hash_trytes);
        if (memchr(hash_trytes, MAX_TRYTE_VALUE, 81) != NULL) {
            // increment the tag of the first transaction
            bytes_increment_trit_area_81(ctx->bytes + 48);
            tag_increment++;
        }
        else {
            // we found a valid bundle hash
            break;
        }
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

uint32_t bundle_get_current_index(const BUNDLE_CTX *ctx)
{
    return ctx->current_index;
}
