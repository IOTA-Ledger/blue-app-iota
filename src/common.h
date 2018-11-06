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
#define APPVERSION_MAJOR 0xFF
#define APPVERSION_MINOR 0xFF
#define APPVERSION_PATCH 0xFF

void throw_exception(const char *expression, const char *file, int line);

#define THROW(x) throw_exception(#x, __FILE__, __LINE__)

#define UNUSED(x) (void)(x)

#define MIN(a, b)                                                              \
    ({                                                                         \
        __typeof__(a) _a = (a);                                                \
        __typeof__(b) _b = (b);                                                \
        _a < _b ? _a : _b;                                                     \
    })
#define MAX(a, b)                                                              \
    ({                                                                         \
        __typeof__(a) _a = (a);                                                \
        __typeof__(b) _b = (b);                                                \
        _a > _b ? _a : _b;                                                     \
    })

/* ----------------------------------------------------------------------- */
/* -                         OS ALTERNATIVES                             - */
/* ----------------------------------------------------------------------- */

#define os_swap_u32 __builtin_bswap32

#define os_memmove memmove
#define os_memcpy memcpy
#define os_memcmp memcmp
#define os_memset memset

/* ----------------------------------------------------------------------- */
/* -                          CRYPTO FUNCTIONS                           - */
/* ----------------------------------------------------------------------- */

#define CX_LAST (1 << 0)

typedef SHA3_CTX cx_sha3_t;
typedef SHA3_CTX cx_hash_t;

static inline void cx_keccak_init(SHA3_CTX *hash, int size)
{
    UNUSED(size);

    keccak_384_Init(hash);
}

static inline void cx_hash(cx_hash_t *hash, int mode, const unsigned char *in,
                           unsigned int len, unsigned char *out,
                           unsigned int out_len)
{
    if (mode != CX_LAST) {
        // if CX_LAST is not set, add input data to add to current hash
        keccak_Update(hash, in, len);
    }
    else if (len == 0) {
        // if no input data given, compute and copy the hash
        unsigned char hash_bytes[48];
        keccak_Final(hash, hash_bytes);
        memcpy(out, hash_bytes, MAX(out_len, 48u));
    }
    else {
        // if CX_LAST is set, compute hash for input
        keccak_Update(hash, in, len);
        unsigned char hash_bytes[48];
        keccak_Final(hash, hash_bytes);
        memcpy(out, hash_bytes, MAX(out_len, 48u));
    }
}

/* ----------------------------------------------------------------------- */
/* -                                 IO                                  - */
/* ----------------------------------------------------------------------- */

#define IO_ASYNCH_REPLY 1

#else // ifdef NO_BOLOS

/* ----------------------------------------------------------------------- */
/* -                          USE BOLOS                                  - */
/* ----------------------------------------------------------------------- */

#include "os.h"
#endif // ifdef NO_BOLOS

/* ----------------------------------------------------------------------- */
/* -                            COMMON                                   - */
/* ----------------------------------------------------------------------- */

#define NO_INLINE __attribute__((noinline))

#define CX_KECCAK384_SIZE 48

// additional supported features
#define APP_FLAGS 0

#define CEILING(x, y)                                                          \
    ({                                                                         \
        typeof(y) _y = (y);                                                    \
        (((x) + _y - 1) / _y);                                                 \
    })

#define ABS(a)                                                                 \
    ({                                                                         \
        typeof(a) _a = (a);                                                    \
        _a < 0 ? -_a : _a;                                                     \
    })

#define ASSIGN(dest, src)                                                      \
    ({                                                                         \
        typeof(src) _x = (src);                                                \
        typeof(dest) _y = _x;                                                  \
        (_x == _y && ((_x < 1) == (_y < 1)) ? (void)((dest) = _y), 1 : 0);     \
    })

#define IN_RANGE(x, min, max)                                                  \
    ({                                                                         \
        typeof(x) _x = (x);                                                    \
        (_x >= (min) && _x <= (max));                                          \
    })

#define MEMCLEAR(x) os_memset(&x, 0, sizeof(x))

#endif // COMMON_H
