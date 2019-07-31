#include "iota/addresses.h"
#include "iota/conversion.h"
#include "iota/iota_types.h"
#include "iota/kerl.h"
#include "macros.h"
#include "os.h"

static void digest_single_chunk(unsigned char *key_fragment,
                                cx_sha3_t *digest_sha3, cx_sha3_t *round_sha3)
{
    for (int k = 0; k < UTRYTE_MAX; k++) {
        kerl_initialize(round_sha3);
        kerl_absorb_chunk(round_sha3, key_fragment);
        kerl_squeeze_final_chunk(round_sha3, key_fragment);
    }

    // absorb buffer directly to avoid storing the digest fragment
    kerl_absorb_chunk(digest_sha3, key_fragment);
}

// initialize the sha3 instance for generating private key
static void init_shas(const unsigned char *seed_bytes, uint32_t idx,
                      cx_sha3_t *key_sha, cx_sha3_t *digest_sha,
                      unsigned char *buffer)
{
    // use temp bigint so seed not destroyed
    os_memcpy(buffer, seed_bytes, NUM_HASH_BYTES);

    bytes_add_u32_mem(buffer, idx);

    kerl_initialize(key_sha);
    kerl_absorb_chunk(key_sha, buffer);
    kerl_squeeze_final_chunk(key_sha, buffer);

    kerl_initialize(key_sha);
    kerl_absorb_chunk(key_sha, buffer);

    kerl_initialize(digest_sha);
}

// generate public address in byte format
void get_public_addr(const unsigned char *seed_bytes, uint32_t idx,
                     unsigned int security, unsigned char *address_bytes)
{
    if (!IN_RANGE(security, MIN_SECURITY_LEVEL, MAX_SECURITY_LEVEL)) {
        THROW_PARAMETER("security");
    }

    // sha size is 424 bytes
    cx_sha3_t key_sha;
    cx_sha3_t digest_sha;

    // buffer for the digests of each security level
    unsigned char digest[NUM_HASH_BYTES * security];

    // use last chunk of digest, as this is only used after the key is generated
    unsigned char *buffer = digest + NUM_HASH_BYTES * (security - 1);

    // init private key sha, digest sha
    init_shas(seed_bytes, idx, &key_sha, &digest_sha, buffer);

    for (unsigned int i = 0; i < security; i++) {
        for (unsigned int j = 0; j < NUM_HASH_FRAGMENT_TRYTES; j++) {
            // use address output array as a temp Kerl state storage
            unsigned char *state = address_bytes;

            // the state takes only 48bytes and allows us to reuse key_sha
            kerl_state_squeeze_chunk(&key_sha, state, buffer);
            // re-use key_sha as round_sha
            digest_single_chunk(buffer, &digest_sha, &key_sha);

            // as key_sha has been tainted, reinitialize with the saved state
            kerl_reinitialize(&key_sha, state);
        }
        kerl_squeeze_final_chunk(&digest_sha, digest + NUM_HASH_BYTES * i);

        // reset digest sha for next digest
        kerl_initialize(&digest_sha);
    }

    // absorb the digest for each security
    kerl_absorb_bytes(&digest_sha, digest, NUM_HASH_BYTES * security);

    // one final squeeze for address
    kerl_squeeze_final_chunk(&digest_sha, address_bytes);
}

// get 9 character checksum of NUM_HASH_TRYTES character address
void get_address_with_checksum(const unsigned char *address_bytes,
                               char *full_address)
{
    cx_sha3_t sha;
    kerl_initialize(&sha);

    unsigned char checksum_bytes[NUM_HASH_BYTES];
    kerl_absorb_chunk(&sha, address_bytes);
    kerl_squeeze_final_chunk(&sha, checksum_bytes);

    char full_checksum[NUM_HASH_TRYTES];
    bytes_to_chars(checksum_bytes, full_checksum, NUM_HASH_BYTES);

    bytes_to_chars(address_bytes, full_address, NUM_HASH_BYTES);

    os_memcpy(full_address + NUM_HASH_TRYTES,
              full_checksum + NUM_HASH_TRYTES - NUM_CHECKSUM_TRYTES,
              NUM_CHECKSUM_TRYTES);
}
