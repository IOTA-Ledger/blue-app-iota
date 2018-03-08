#include "signing.h"
#include "common.h"
#include "conversion.h"
#include "kerl.h"

static void initialize_state(const unsigned char *seed_bytes,
                             uint32_t address_idx, unsigned char *state)
{
    os_memcpy(state, seed_bytes, 48);
    bytes_add_u32_mem(state, address_idx);

    cx_sha3_t sha;
    kerl_initialize(&sha);
    kerl_absorb_chunk(&sha, state);
    kerl_squeeze_final_chunk(&sha, state);
}

void signing_initialize(SIGNING_CTX *ctx, const unsigned char *seed_bytes,
                        uint32_t address_idx, uint8_t security,
                        const tryte_t *normalized_hash)
{
    // TODO: check parameters
    os_memset(ctx, 0, sizeof(SIGNING_CTX));

    initialize_state(seed_bytes, address_idx, ctx->state);
    ctx->last_fragment = NUM_SIGNATURE_FRAGMENTS(security) - 1;

    os_memcpy(ctx->hash, normalized_hash, 81);
}

static void generate_signature_fragment(unsigned char *state,
                                        const tryte_t *hash_fragment,
                                        unsigned char *signature_bytes)
{
    cx_sha3_t sha;
    kerl_reinitialize(&sha, state);

    for (unsigned int j = 0; j < SIGNATURE_FRAGMENT_SIZE; j++) {
        unsigned char *signature_f = signature_bytes + j * KERL_HASH_NUM_BYTES;

        // the output of the squeeze is exactly the private key
        kerl_state_squeeze_chunk(&sha, state, signature_f);

        for (unsigned int k = MAX_TRYTE_VALUE - hash_fragment[j]; k-- > 0;) {
            kerl_initialize(&sha);
            kerl_absorb_chunk(&sha, signature_f);
            kerl_squeeze_final_chunk(&sha, signature_f);
        }

        // if we are not the the final iteration reinitialize to get next key_f
        if (j < SIGNATURE_FRAGMENT_SIZE - 1) {
            kerl_reinitialize(&sha, state);
        }
    }
}

unsigned int signing_next_fragment(SIGNING_CTX *ctx,
                                   unsigned char *signature_bytes)
{
    if (ctx->fragment_index > ctx->last_fragment) {
        THROW(INVALID_STATE);
    }

    generate_signature_fragment(
        ctx->state, ctx->hash + ctx->fragment_index * SIGNATURE_FRAGMENT_SIZE,
        signature_bytes);

    return ctx->fragment_index++;
}
