#ifndef COMMON_H
#define COMMON_H

#ifdef NO_BOLOS

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sha3.h"

/* ----------------------------------------------------------------------- */
/* -                      DEFINES AND MACROS                             - */
/* ----------------------------------------------------------------------- */

// no catching supported, just abort while printing the code name to stderr
#define THROW(x) \
        ({ fprintf(stderr, "EXCEPTION: " #x "\n"); \
           abort(); })

#define UNUSED(x) (void)(x)

#define MIN(a,b) \
        ({ __typeof__ (a)_a = (a); \
           __typeof__ (b)_b = (b); \
           _a < _b ? _a : _b; })
#define MAX(a,b) \
        ({ __typeof__ (a)_a = (a); \
           __typeof__ (b)_b = (b); \
           _a > _b ? _a : _b; })

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
        UNUSED(size);

        keccak_384_Init(hash);
}

static inline void cx_hash(SHA3_CTX* hash, int mode, const unsigned char *in,
                           unsigned int len, unsigned char *out) {

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

#define CEILING(x,y) (((x) + (y) - 1) / (y))

#define ASSIGN(dest,src) ({ \
                typeof(src)__x=(src); \
                typeof(dest)__y=__x; \
                (__x==__y && ((__x<1) == (__y<1)) ? (void)((dest)=__y),1 : 0); \
        })

#endif // COMMON_H
