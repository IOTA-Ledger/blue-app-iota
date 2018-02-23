#ifndef COMMON_H
#define COMMON_H

#ifdef NO_BOLOS

#include <string.h>
#include <stdbool.h>
#include "sha3.h"

/* ----------------------------------------------------------------------- */
/* -                         OS ALTERNATIVES                             - */
/* ----------------------------------------------------------------------- */

#define os_swap_u32 __builtin_bswap32

#define os_memmove memmove
#define os_memcpy memcpy

#define os_memset memset

/* ----------------------------------------------------------------------- */
/* -                          CRYPTO FUNCTIONS                           - */
/* ----------------------------------------------------------------------- */

#define CX_LAST (1 << 0)

typedef SHA3_CTX cx_sha3_t;
typedef SHA3_CTX cx_hash_t;

static inline void cx_keccak_init(SHA3_CTX* hash, int size) {
        (void)size; // unused

        keccak_384_Init(hash);
}

static inline void cx_hash(SHA3_CTX* hash, int mode, const unsigned char *in,
                           unsigned int len,unsigned char *out) {

        if (mode != CX_LAST) {
                // if CX_LAST is not set, add input data to add to current hash
                keccak_Update(hash, in, len);
        } else if (len == 0) {
                // if no input data given, compute and copy the hash
                keccak_Final(hash, out);
        } else {
                // if CX_LAST is set, compute hash for input
                keccak_Update(hash, in, len);
                keccak_Final(hash, out);
        }
}

static inline int cx_math_cmp(const uint8_t *a, const uint8_t *b,
                              unsigned int len) {
        return memcmp(a, b, len);
}

static inline int cx_math_add(uint8_t *r, const uint8_t *a, const uint8_t *b,
                              unsigned int len) {
        bool carry = false;
        for(unsigned int i=len; i-- > 0;) {
                const uint16_t summand = carry ? b[i] + (uint16_t)1 : b[i];
                carry = __builtin_add_overflow(a[i], summand, &r[i]);
        }
        return carry;
}

static inline int cx_math_sub(uint8_t *r, const uint8_t *a, const uint8_t *b,
                              unsigned int len) {
        bool borrow = false;
        for(unsigned int i=len; i-- > 0;) {
                const uint16_t subtrahend = borrow ? b[i] + (uint16_t)1 : b[i];
                borrow = __builtin_sub_overflow(a[i], subtrahend, &r[i]);
        }
        return borrow;
}

#else // ifdef NO_BOLOS

/* ----------------------------------------------------------------------- */
/* -                          USE BOLOS                                  - */
/* ----------------------------------------------------------------------- */

#include "os.h"
#endif // ifdef NO_BOLOS

/* ----------------------------------------------------------------------- */
/* -                            COMMON                                   - */
/* ----------------------------------------------------------------------- */

#define CX_KECCAK384_SIZE 48

#endif // COMMON_H
