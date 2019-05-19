#include "os.h"
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include "test_common.h"
#include "keccak/sha3.h"

void os_throw_exception(const char *expression, const char *file, int line)
{
    mock_assert(false, expression, file, line);
    abort(); // avoid compiler warning
}

void os_perso_derive_node_bip32(int curve, const unsigned int *path,
                                unsigned int pathLength,
                                unsigned char *privateKey, unsigned char *chain)
{
    UNUSED(curve);
    UNUSED(path);
    UNUSED(pathLength);

    THROW(NOT_IMPLEMENTED);

    // avoid linter warnings
    privateKey[0] = 0;
    chain[0] = 0;
}

void cx_keccak_init(SHA3_CTX *hash, int size)
{
    assert_int_equal(size, 384);

    keccak_384_Init(hash);
}

void cx_hash(cx_hash_t *hash, int mode, const unsigned char *in,
             unsigned int len, unsigned char *out, unsigned int out_len)
{
    if (mode != CX_LAST) {
        // if CX_LAST is not set, add input data to add to current hash
        keccak_Update(hash, in, len);
    }
    else if (len == 0) {
        // if no input data given, compute and copy the hash
        unsigned char hash_bytes[sha3_384_hash_size];
        keccak_Final(hash, hash_bytes);
        memcpy(out, hash_bytes, MAX(out_len, sha3_384_hash_size));
    }
    else {
        // if CX_LAST is set, compute hash for input
        keccak_Update(hash, in, len);
        unsigned char hash_bytes[sha3_384_hash_size];
        keccak_Final(hash, hash_bytes);
        memcpy(out, hash_bytes, MAX(out_len, sha3_384_hash_size));
    }
}