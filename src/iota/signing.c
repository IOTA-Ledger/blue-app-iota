#include "iota/signing.h"
#include "iota/bundle.h"
#include "iota/conversion.h"
#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "macros.h"
#include "os.h"

void signing_initialize(SIGNING_CTX *ctx, const BUNDLE_INFO *bundle_info,
                        const tryte_t *normalized_hash)
{
    // source and destination can potentially overlap
    os_memmove(&ctx->bundle, bundle_info, sizeof(BUNDLE_INFO));
    os_memcpy(ctx->hash, normalized_hash, NUM_HASH_TRYTES);
}

/// Returns the total number of signature fragments.
static uint8_t num_fragments(const uint8_t security)
{
    // the maximum number of chunks is SEC_LVL*27
    return CEILING(security * NUM_HASH_FRAGMENT_TRYTES,
                   SIGNATURE_FRAGMENT_SIZE);
}

static void initialize_state(const unsigned char *seed_bytes,
                             uint32_t address_idx, unsigned char *state)
{
    os_memcpy(state, seed_bytes, NUM_HASH_BYTES);
    bytes_add_u32_mem(state, address_idx);

    cx_sha3_t sha;
    kerl_initialize(&sha);
    kerl_absorb_chunk(&sha, state);
    kerl_squeeze_final_chunk(&sha, state);
}

void signing_start(SIGNING_CTX *ctx, uint8_t tx_index,
                   const unsigned char *seed_bytes, uint8_t security)
{
    if (tx_index > ctx->bundle.last_tx_index) {
        THROW_PARAMETER("tx_idx");
    }
    if (!IN_RANGE(security, MIN_SECURITY_LEVEL, MAX_SECURITY_LEVEL)) {
        THROW_PARAMETER("security");
    }

    ctx->fragment_index = 0;
    ctx->last_fragment = num_fragments(security) - 1;
    ctx->tx_index = tx_index;

    const uint32_t address_idx = ctx->bundle.indices[tx_index];

    initialize_state(seed_bytes, address_idx, ctx->state);
}

static void generate_signature_fragment(unsigned char *state,
                                        const tryte_t *hash_fragment,
                                        unsigned char *signature_bytes)
{
    cx_sha3_t sha;

    for (unsigned int j = 0; j < SIGNATURE_FRAGMENT_SIZE; j++) {
        unsigned char *signature_f = signature_bytes + j * NUM_HASH_BYTES;

        kerl_reinitialize(&sha, state);
        // the output of the squeeze is exactly the private key
        kerl_state_squeeze_chunk(&sha, state, signature_f);

        for (unsigned int k = TRYTE_MAX - hash_fragment[j]; k-- > 0;) {
            kerl_initialize(&sha);
            kerl_absorb_chunk(&sha, signature_f);
            kerl_squeeze_final_chunk(&sha, signature_f);
        }
    }
}

unsigned int signing_next_fragment(SIGNING_CTX *ctx,
                                   unsigned char *signature_bytes)
{
    if (!signing_has_next_fragment(ctx)) {
        THROW(INVALID_STATE);
    }

    generate_signature_fragment(
        ctx->state, ctx->hash + ctx->fragment_index * SIGNATURE_FRAGMENT_SIZE,
        signature_bytes);

    return ctx->fragment_index++;
}
