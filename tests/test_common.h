#ifndef TEST_COMMON_H
#define TEST_COMMON_H

#include <stdbool.h>
#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <cmocka.h>
// include for safe redefines
#include <assert.h>
#include "common.h"
#include "test_vectors.h"

#include "iota_types.h"

#ifndef KERL_TEST_FOLDER
#define KERL_TEST_FOLDER "kerl-spec/test_vectors"
#endif

#ifndef TEST_FOLDER
#define TEST_FOLDER "test_vectors"
#endif

#define MAX_NUM_HASHES 5

#define NUM_TRYTES(X) (((X) / NUM_HASH_TRITS) * NUM_HASH_TRYTES)
#define NUM_BYTES(X) (((X) / NUM_HASH_TRITS) * NUM_HASH_BYTES)

#define MAX_NUM_TRITS (NUM_HASH_TRITS * MAX_NUM_HASHES)
#define MAX_NUM_BYTES NUM_BYTES(MAX_NUM_TRITS)
#define TRITS_PER_TRYTE 3
#define MAX_NUM_TRYTES (MAX_NUM_TRITS / TRITS_PER_TRYTE)

#undef assert
#define assert(X) mock_assert((int)(X), #X, __FILE__, __LINE__)

static inline void assert_all_zero(const void *a, size_t size)
{
    if (size > 0) {
        assert_int_equal(((char *)a)[0], 0);
        assert_memory_equal(a, a + 1, size - 1);
    }
}

#endif // TEST_COMMON_H
