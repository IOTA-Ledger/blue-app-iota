#ifndef SIGNING_H
#define SIGNING_H

#include "iota_types.h"

// the number of chunks in one signature fragment
// this can be changed to any multiple of 3 up to 27
#define SIGNATURE_FRAGMENT_SIZE 3

// the maximum number of chunks is SEC_LVL*27
#define NUM_SIGNATURE_FRAGMENTS(s) (CEILING(s*27, SIGNATURE_FRAGMENT_SIZE))

typedef struct SIGNING_CTX {
        unsigned char state[48];

        uint32_t fragment_index;
        uint32_t last_fragment;

        tryte_t hash[81];
} SIGNING_CTX;

void signing_initialize(SIGNING_CTX *ctx, const unsigned char *seed_bytes,
                        uint32_t address_idx, uint8_t security,
                        const tryte_t *normalized_hash);

unsigned int signing_next_fragment(SIGNING_CTX *ctx,
                                   unsigned char *signature_bytes);

#endif // SIGNING_H
