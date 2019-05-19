#ifndef TEST_COMMON_H
#define TEST_COMMON_H

#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <stdint.h>
#include <cmocka.h>

#include <assert.h> // include for safe redefines
#include "macros.h"
#include "iota/iota_types.h"

#define MAX_NUM_HASHES 5

#define NUM_TRYTES(X) (((X) / NUM_HASH_TRITS) * NUM_HASH_TRYTES)
#define NUM_BYTES(X) (((X) / NUM_HASH_TRITS) * NUM_HASH_BYTES)

#define MAX_NUM_TRITS (NUM_HASH_TRITS * MAX_NUM_HASHES)
#define MAX_NUM_BYTES NUM_BYTES(MAX_NUM_TRITS)
#define TRITS_PER_TRYTE 3
#define MAX_NUM_TRYTES (MAX_NUM_TRITS / TRITS_PER_TRYTE)

#undef assert
#define assert(X) mock_assert((int)(X), #X, __FILE__, __LINE__)

static inline void assert_all_zero(const void *a, const size_t size)
{
    if (size > 0) {
        assert_int_equal(((char *)a)[0], 0);
        assert_memory_equal(a, a + 1, size - 1);
    }
}

#endif // TEST_COMMON_H
