#include "signing.h"
#include "common.h"
#include "conversion.h"
#include "kerl.h"

static void generate_signature_fragment(cx_sha3_t *sha, unsigned char *state,
                                        const tryte_t *hash_fragment,
                                        unsigned char *signature_bytes)
{
    for (unsigned int j = 0; j < SIGNATURE_FRAGMENT_SIZE; j++) {
        unsigned char *signature_f = signature_bytes + j * KERL_HASH_NUM_BYTES;

        // the output of the squeeze is exactly the private key
        kerl_state_squeeze_chunk(sha, state, signature_f);

        for (unsigned int k = MAX_TRYTE_VALUE - hash_fragment[j]; k-- > 0;) {
            kerl_initialize(sha);
            kerl_absorb_chunk(sha, signature_f);
            kerl_squeeze_final_chunk(sha, signature_f);
        }

        // if we are not the the final iteration reinitialize to get next key_f
        if (j < SIGNATURE_FRAGMENT_SIZE - 1) {
            kerl_reinitialize(sha, state);
        }
    }
}

void signing_first_fragment(const unsigned char *seed_bytes, uint32_t idx,
                            unsigned char *state, const tryte_t *hash_fragment,
                            unsigned char *signature_bytes)
{
    unsigned char bytes[KERL_HASH_NUM_BYTES];
    os_memcpy(bytes, seed_bytes, sizeof(bytes));
    bytes_add_u32_mem(bytes, idx);

    cx_sha3_t sha;
    kerl_initialize(&sha);
    kerl_absorb_chunk(&sha, bytes);
    kerl_squeeze_final_chunk(&sha, bytes);

    kerl_initialize(&sha);
    kerl_absorb_chunk(&sha, bytes);

    generate_signature_fragment(&sha, state, hash_fragment, signature_bytes);
}

void signing_next_fragment(unsigned char *state, const tryte_t *hash_fragment,
                           unsigned char *signature_bytes)
{
    cx_sha3_t sha;
    kerl_reinitialize(&sha, state);

    generate_signature_fragment(&sha, state, hash_fragment, signature_bytes);
}
