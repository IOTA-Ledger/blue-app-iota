#include "addresses.h"
#include "common.h"
#include "bigint.h"
#include "conversion.h"
#include "kerl.h"

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
    
    //one final squeeze for address
    kerl_squeeze_bigints(&addr_sha, address, 12);
}
