#ifndef TEST_COMMON_H
#define TEST_COMMON_H

#include <stdarg.h>
#include <stddef.h>
#include <setjmp.h>
#include <cmocka.h>
// include for safe redefines
#include <assert.h>
#include "common.h"

#include "hash_file.h"

#ifndef TEST_FOLDER
#define TEST_FOLDER "kerl-spec/test_vectors"
#endif

#define MAX_NUM_HASHES 5
#define NUM_HASH_TRITS 243
#define NUM_HASH_TRYTES 81
#define NUM_HASH_CHARS ((NUM_HASH_TRYTES) +1)
#define NUM_HASH_BYTES 48

#define NUM_TRINTS(X) (((X) / NUM_HASH_TRITS) * NUM_HASH_TRINTS)
#define NUM_BYTES(X) (((X) / NUM_HASH_TRITS) * NUM_HASH_BYTES)

#define MAX_NUM_TRITS (NUM_HASH_TRITS * MAX_NUM_HASHES)
#define MAX_NUM_BYTES NUM_BYTES(MAX_NUM_TRITS)
#define TRITS_PER_TRYTE 3
#define MAX_NUM_TRYTES (MAX_NUM_TRITS / TRITS_PER_TRYTE)

#undef assert
#define assert(X) mock_assert((int)(X), #X, __FILE__, __LINE__)

#undef THROW
#define THROW(X) mock_assert(false, #X, __FILE__, __LINE__)

#endif // TEST_COMMON_H
