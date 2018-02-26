#include <setjmp.h>
#include <stdarg.h>
#include <stddef.h>
#include <cmocka.h>
#include "test_constants.h"
#include "iota/conversion.h"
// include the c-file to be able to test static functions
#include "iota/bundle.c"

static void test_normalize_hash_zero(void **state)
{
    UNUSED(state);

    tryte_t hash_trytes[NUM_HASH_TRYTES] = {0};
    normalize_hash(hash_trytes);

    // all zero hash is already normalized
    static const tryte_t expected_trytes[NUM_HASH_TRYTES] = {0};
    assert_memory_equal(hash_trytes, expected_trytes, NUM_HASH_TRYTES);
}

static void test_normalize_hash_one(void **state)
{
    UNUSED(state);

    tryte_t hash_trytes[NUM_HASH_TRYTES] = {MAX_TRYTE_VALUE, MAX_TRYTE_VALUE};
    normalize_hash(hash_trytes);

    // in the normalized hash the first tryte will be reduced to lowest value
    static const tryte_t expected_trytes[NUM_HASH_TRYTES] = {MIN_TRYTE_VALUE,
                                                             MAX_TRYTE_VALUE};
    assert_memory_equal(hash_trytes, expected_trytes, NUM_HASH_TRYTES);
}

static void test_normalize_hash_neg_one(void **state)
{
    UNUSED(state);

    tryte_t hash_trytes[NUM_HASH_TRYTES] = {MIN_TRYTE_VALUE, MIN_TRYTE_VALUE};
    normalize_hash(hash_trytes);

    // in the normalized hash the first tryte will be reduced to highest value
    static const tryte_t expected_trytes[NUM_HASH_TRYTES] = {MAX_TRYTE_VALUE,
                                                             MIN_TRYTE_VALUE};
    assert_memory_equal(hash_trytes, expected_trytes, NUM_HASH_TRYTES);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_normalize_hash_zero),
        cmocka_unit_test(test_normalize_hash_one),
        cmocka_unit_test(test_normalize_hash_neg_one)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
