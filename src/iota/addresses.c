#include "addresses.h"
#include "common.h"
#include "conversion.h"
#include "kerl.h"

static void digest_single_chunk(const unsigned char *key,
                                cx_sha3_t *digest_sha3)
{
    cx_sha3_t round_sha3;
    unsigned char buffer[48];

    os_memcpy(buffer, key, sizeof(buffer));

    for (int k = 0; k < 26; k++) {
        kerl_initialize(&round_sha3);
        kerl_absorb_chunk(&round_sha3, buffer);
        kerl_squeeze_final_chunk(&round_sha3, buffer);
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

    // init private key sha, digest sha and addr sha
    init_shas(seed_bytes, idx, &key_sha, &digest_sha);


    // only store a single fragment of the private key at a time and use it to
    // completion  before moving onto next fragment to store memory
    unsigned char key_f[48];
    
    // max security is 3, so digest can store first chunk, address_bytes can
    // store second, and key_f can store third
    unsigned char digest[48];

    for (uint8_t i = 0; i < security; i++) {
        for (uint8_t j = 0; j < 27; j++) {
            // generate every private key frag, and absorb them
            kerl_squeeze_chunk(&key_sha, key_f);
            digest_single_chunk(key_f, &digest_sha);
        }

        //save as much memory as humanly possible
        if(i == 0)
            kerl_squeeze_chunk(&digest_sha, digest);
        else if(i == 1) //temp store
            kerl_squeeze_chunk(&digest_sha, address_bytes);
        else //the last chunk can go into key_f (won't need key_f again)
            kerl_squeeze_chunk(&digest_sha, key_f);
        
        // reset digest sha for next digest
        kerl_initialize(&digest_sha);
    }
    
    //reuse digest_sha to produce the address
    kerl_initialize(&digest_sha);
    
    for(uint8_t i = 0; i < security; i++) {
        if(i == 0)
            kerl_absorb_chunk(&digest_sha, digest);
        else if(i == 1)
            kerl_absorb_chunk(&digest_sha, address_bytes);
        else
            kerl_absorb_chunk(&digest_sha, key_f);
    }

    // one final squeeze for address
    kerl_squeeze_final_chunk(&digest_sha, address_bytes);
}
