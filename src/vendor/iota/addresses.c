#include "addresses.h"
#include "common.h"
#include "bigint.h"
#include "conversion.h"
#include "kerl.h"

static void key_digests(const uint32_t *key, uint8_t security,
                        uint32_t *digests)
{
    for (uint8_t l = 0; l < security; l++) {
        const uint32_t *p = key + (l * 12 * 27);
        cx_sha3_t digest_sha3;

        kerl_initialize(&digest_sha3);

        for (uint8_t i = 0; i < 27; i++) {
            cx_sha3_t round_sha3;
            uint32_t buffer[12];

            os_memcpy(buffer, p, 12 * 4);
            p += 12;

            for (int k = 0; k < 26; k++) {
                kerl_initialize(&round_sha3);
                kerl_absorb_bigints(&round_sha3, buffer, 12);
                kerl_squeeze_bigints(&round_sha3, buffer, 12);
            }

            // basorb buffer directly to avoid storing the digest fragment
            kerl_absorb_bigints(&digest_sha3, buffer, 12);
        }

        kerl_squeeze_bigints(&digest_sha3, digests, 12);
        digests += 12;
    }
}

static void digests_address(const uint32_t *digests, uint8_t security,
                            uint32_t *address)
{
    cx_sha3_t sha3;

    kerl_initialize(&sha3);
    kerl_absorb_bigints(&sha3, digests, 12 * security);
    kerl_squeeze_bigints(&sha3, address, 12);
}

void generate_private_key(const uint32_t *seed_bigint, uint32_t idx,
                          uint8_t security, uint32_t *key)
{
    cx_sha3_t sha3;
    // work on temporary bigint, so that seed_bigint is not destroyed
    uint32_t bigint[12];
    bigint_add_int_u(seed_bigint, idx, bigint, 12);
    bigint_set_last_trit_zero(bigint);

    kerl_initialize(&sha3);

    kerl_absorb_bigints(&sha3, bigint, 12);
    kerl_squeeze_bigints(&sha3, bigint, 12);

    kerl_initialize(&sha3);
    kerl_absorb_bigints(&sha3, bigint, 12);

    uint32_t *p = key;
    for (uint8_t l = 1; l <= security; l++) {
        for (uint8_t i = 0; i < 27; i++) {
            kerl_squeeze_bigints(&sha3, p, 12);
            p += 12;
        }
    }
}

void generate_public_address(const uint32_t *private_key, uint8_t security,
                             uint32_t *address)
{
    uint32_t digests[12 * security];

    key_digests(private_key, security, digests);
    digests_address(digests, security, address);
}


//------- ONLY USES FUNCTIONS FROM HERE DOWN

static void digest_addr(cx_sha3_t *digest_sha3, cx_sha3_t *addr_sha3) {
    uint32_t digest[12];
    kerl_squeeze_bigints(digest_sha3, digest, 12);
    
    //keep a running absorb on all digest chunks
    kerl_absorb_bigints(addr_sha3, digest, 12);
    
    //reset digest sha for next digest
    kerl_initialize(digest_sha3);
}

static void digest_single_chunk(const uint32_t *key, cx_sha3_t *digest_sha3)
{
    cx_sha3_t round_sha3;
    uint32_t buffer[12];
    
    os_memcpy(buffer, key, 12 * 4);
    
    for (int k = 0; k < 26; k++) {
        kerl_initialize(&round_sha3);
        kerl_absorb_bigints(&round_sha3, buffer, 12);
        kerl_squeeze_bigints(&round_sha3, buffer, 12);
    }
    
    // asorb buffer directly to avoid storing the digest fragment
    kerl_absorb_bigints(digest_sha3, buffer, 12);
}

//initialize the sha3 instance for generating private key
void init_shas(const uint32_t *seed_bigint, uint32_t idx, cx_sha3_t *key_sha,
                      cx_sha3_t *digest_sha, cx_sha3_t *addr_sha) {
    //use temp bigint so seed not destroyed
    uint32_t bigint[12];
    bigint_add_int_u(seed_bigint, idx, bigint, 12);
    bigint_set_last_trit_zero(bigint);
    
    kerl_initialize(key_sha);
    kerl_absorb_bigints(key_sha, bigint, 12);
    kerl_squeeze_bigints(key_sha, bigint, 12);
    
    kerl_initialize(key_sha);
    kerl_absorb_bigints(key_sha, bigint, 12);
    
    kerl_initialize(digest_sha);
    kerl_initialize(addr_sha);
}

//create a couple instances of sha3 and keep them running.
void get_public_addr(uint32_t *seed_bigint, uint32_t idx, uint8_t security,
                   uint32_t *address) {
    //sha size is 424 bytes
    cx_sha3_t key_sha, digest_sha, addr_sha;
    
    //init private key sha, digest sha and addr sha
    init_shas(seed_bigint, idx, &key_sha, &digest_sha, &addr_sha);
    
    
    //only store a single fragment of the private key at a time and use it to completion
    //before moving onto next fragment to store memory
    uint32_t key_f[12];
    
    for(uint8_t i=0; i<security; i++) {
        for(uint8_t j=0; j<27; j++) {
            //generate every private key frag, and absorb them
            kerl_squeeze_bigints(&key_sha, key_f, 12);
            digest_single_chunk(key_f, &digest_sha);
        }
        
        digest_addr(&digest_sha, &addr_sha);
    }
    
    //squeeze_key_frag(&key_sha, key);
    //digest_chunk(key, &digest_sha, &addr_sha);
    
    //one final squeeze for address
    kerl_squeeze_bigints(&addr_sha, address, 12);
}
