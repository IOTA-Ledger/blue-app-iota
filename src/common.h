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

#define PRINTF printf

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

#if defined(TARGET_NANOS) || defined(TARGET_NANOX)
#define TARGET_NANO
#endif

#endif // ifdef NO_BOLOS

/* ----------------------------------------------------------------------- */
/* -                            COMMON                                   - */
/* ----------------------------------------------------------------------- */

#define NO_INLINE __attribute__((noinline))

#define CX_KECCAK384_SIZE 48

// additional supported features
#define APP_FLAGS 0

#define MEMCLEAR(x) os_memset(&x, 0, sizeof(x))

/// Devide x by y and round up.
#define CEILING(x, y)                                                          \
    ({                                                                         \
        typeof(y) _y = (y);                                                    \
        (((x) + _y - 1) / _y);                                                 \
    })

/// Absolute value of x.
#define ABS(x)                                                                 \
    ({                                                                         \
        typeof(x) _x = (x);                                                    \
        _x < 0 ? -_x : _x;                                                     \
    })

/// Assigns the value of src to dest and returns whether there was an overflow.
#define ASSIGN(dest, src)                                                      \
    ({                                                                         \
        typeof(src) _x = (src);                                                \
        typeof(dest) _y = _x;                                                  \
        (_x == _y && ((_x < 1) == (_y < 1)) ? (void)((dest) = _y), 1 : 0);     \
    })

/// Returns whether x is min <= x <= max.
#define IN_RANGE(x, min, max)                                                  \
    ({                                                                         \
        typeof(x) _x = (x);                                                    \
        (_x >= (min) && _x <= (max));                                          \
    })

/// Typesafe array size computation.
#define ARRAY_SIZE(arr)                                                        \
    (sizeof(arr) / sizeof((arr)[0]) +                                          \
     sizeof(typeof(int[1 - 2 * !!__builtin_types_compatible_p(                 \
                                   typeof(arr), typeof(&arr[0]))])) *          \
         0)

/// Throws an error together with a debug message
#define THROW_MSG(msg, error)                                                  \
    ({                                                                         \
        PRINTF(msg " in %s: %d\n", __FILE__, __LINE__);                        \
        THROW((error));                                                        \
    })

/// Throws INVALID_PARAMETER exception with addition debug info
#define THROW_PARAMETER(x) THROW_MSG("invalid " x, INVALID_PARAMETER)

/// Throws provided error, if condition does not apply
#define VALIDATE(cond, error)                                                  \
    ({                                                                         \
        if (!(cond)) {                                                         \
            THROW_MSG("validation error", error);                              \
        }                                                                      \
    })

#endif // COMMON_H
