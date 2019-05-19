#ifndef OS_H
#define OS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "keccak/sha3.h"

/* ----------------------------------------------------------------------- */
/* -                      DEFINES AND MACROS                             - */
/* ----------------------------------------------------------------------- */

#define APPVERSION_MAJOR 0xFF
#define APPVERSION_MINOR 0xFF
#define APPVERSION_PATCH 0xFF

#define THROW(x) os_throw_exception(#x, __FILE__, __LINE__)

#define PRINTF printf

#define UNUSED(x) (void)(x)

#define MIN(x, y) ((x) < (y) ? (x) : (y))
#define MAX(x, y) ((x) > (y) ? (x) : (y))

void os_throw_exception(const char *expression, const char *file, int line)
    __attribute__((noreturn));

/* ----------------------------------------------------------------------- */
/* -                         OS ALTERNATIVES                             - */
/* ----------------------------------------------------------------------- */

#define os_swap_u32 __builtin_bswap32

#define os_memmove memmove
#define os_memcpy memcpy
#define os_memcmp memcmp
#define os_memset memset

void os_perso_derive_node_bip32(int curve, const unsigned int *path,
                                unsigned int pathLength,
                                unsigned char *privateKey,
                                unsigned char *chain);

/* ----------------------------------------------------------------------- */
/* -                          CRYPTO FUNCTIONS                           - */
/* ----------------------------------------------------------------------- */

#define CX_CURVE_256K1 33
#define CX_LAST (1 << 0)
#define CX_SHA384_SIZE 48

typedef SHA3_CTX cx_sha3_t;
typedef SHA3_CTX cx_hash_t;

void cx_keccak_init(cx_sha3_t *hash, int size);
void cx_hash(cx_hash_t *hash, int mode, const unsigned char *in,
             unsigned int len, unsigned char *out, unsigned int out_len);

/* ----------------------------------------------------------------------- */
/* -                                 IO                                  - */
/* ----------------------------------------------------------------------- */

#define IO_ASYNCH_REPLY 1

#endif
