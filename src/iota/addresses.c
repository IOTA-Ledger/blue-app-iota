#include "addresses.h"
#include "common.h"
#include "conversion.h"
#include "kerl.h"

static void digest_single_chunk(const unsigned char *key,
                                cx_sha3_t *digest_sha3, cx_sha3_t *round_sha3)
{
    unsigned char buffer[48];

    os_memcpy(buffer, key, sizeof(buffer));
    // key will not have last trit set to 0, so set it to 0 in buffer
    bytes_set_last_trit_zero(buffer);

    for (int k = 0; k < 26; k++) {
        kerl_initialize(round_sha3);
        kerl_absorb_chunk(round_sha3, buffer);
        kerl_squeeze_final_chunk(round_sha3, buffer);
    }

    // absorb buffer directly to avoid storing the digest fragment
    kerl_absorb_chunk(digest_sha3, buffer);
}

// initialize the sha3 instance for generating private key
void init_shas(const unsigned char *seed_bytes, uint32_t idx,
               cx_sha3_t *key_sha, cx_sha3_t *digest_sha)
{
    // use temp bigint so seed not destroyed
    unsigned char bytes[48];
    os_memcpy(bytes, seed_bytes, sizeof(bytes));

    bytes_add_u32_mem(bytes, idx);

    kerl_initialize(key_sha);
    kerl_absorb_chunk(key_sha, bytes);
    kerl_squeeze_final_chunk(key_sha, bytes);

    kerl_initialize(key_sha);
    kerl_absorb_chunk(key_sha, bytes);

    kerl_initialize(digest_sha);
}

// generate public address in byte format
void get_public_addr(const unsigned char *seed_bytes, uint32_t idx,
                     uint8_t security, unsigned char *address_bytes)
{
    // sha size is 424 bytes
    cx_sha3_t key_sha, digest_sha;

    // init private key sha, digest sha
    init_shas(seed_bytes, idx, &key_sha, &digest_sha);

    // buffer for the digests of each security level
    unsigned char digest[48 * security];

    // only store a single fragment of the private key at a time
    // use last chunk of buffer, as this is only used after the key is generated
    unsigned char *key_f = digest + 48 * (security - 1);

    for (uint8_t i = 0; i < security; i++) {
        for (uint8_t j = 0; j < 27; j++) {
            // cheat the squeeze (last trit not set to 0, nor are bytes
            // flipped/reabsorbed)
            kerl_squeeze_cheat(&key_sha, key_f);
            // re-use key_sha as round_sha
            digest_single_chunk(key_f, &digest_sha, &key_sha);
            // now that we've reused the key_sha, we can reinitialize it with
            // our key_f
            kerl_absorb_cheat(&key_sha, key_f);
        }
        kerl_squeeze_final_chunk(&digest_sha, digest + 48 * i);

        // reset digest sha for next digest
        kerl_initialize(&digest_sha);
    }

    // absorb the digest for each security
    kerl_absorb_bytes(&digest_sha, digest, 48 * security);

    // one final squeeze for address
    kerl_squeeze_final_chunk(&digest_sha, address_bytes);
}
