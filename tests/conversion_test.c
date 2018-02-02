#include <setjmp.h>
#include <stdarg.h>
#include <stddef.h>
#include <cmocka.h>
#include "test_constants.h"
#include "vendor/iota/conversion.h"

#define NUM_RANDOM_TESTS 10000

static uint32_t random_int()
{
    uint32_t init32;

    // rand() is only guaranteed to produce 15 random bits
    init32 = rand() & 0x7FFF;
    init32 <<= 15;
    init32 |= rand() & 0x7FFF;
    init32 <<= 2;
    init32 |= rand() & 0x3;

    return init32;
}

static void random_bigint(uint32_t *bigint)
{
    for (uint i = 0; i < NUM_HASH_BIGINTS; i++) {
        bigint[i] = random_int();
    }

    // last trit must be zero for compatibility
    bigint_set_last_trit_zero(bigint);
}

static void random_trits(trit_t *trits)
{
    for (uint i = 0; i < NUM_HASH_TRITS; i++) {
        trits[i] = (rand() % 3) - 1;
    }

    // last trit must be zero for compatibility
    trits[NUM_HASH_TRITS - 1] = 0;
}

static void test_single_byte_via_trits(void **state)
{
    (void)state;  // unused
    // test each single byte without the most relevant
    for (uint16_t idx = 1; idx < NUM_HASH_BYTES; idx++) {
        for (uint16_t v = 0; v < 256; v++) {
            unsigned char in_bytes[NUM_HASH_BYTES] = {0};
            in_bytes[idx] = v;

            uint32_t in_bigint[NUM_HASH_BIGINTS];
            bytes_to_bigint(in_bytes, in_bigint);

            trit_t trits[NUM_HASH_TRITS];
            bigint_to_trits(in_bigint, trits);

            uint32_t out_bigint[NUM_HASH_BIGINTS];
            trits_to_bigint(trits, out_bigint);

            unsigned char out_bytes[NUM_HASH_BYTES];
            bigint_to_bytes(out_bigint, out_bytes);

            assert_memory_equal(out_bytes, in_bytes, NUM_HASH_BYTES);
        }
    }
}

static void test_random_bigints_via_trits(void **state)
{
    (void)state;  // unused

    srand(2);
    for (uint i = 0; i < NUM_RANDOM_TESTS; i++) {
        uint32_t in_bigint[NUM_HASH_BIGINTS];
        random_bigint(in_bigint);

        trit_t trits[NUM_HASH_TRITS];
        bigint_to_trits(in_bigint, trits);

        uint32_t out_bigint[NUM_HASH_BIGINTS];
        trits_to_bigint(trits, out_bigint);

        assert_memory_equal(in_bigint, out_bigint, NUM_HASH_BIGINTS * 4);
    }
}

static void test_random_bigints_via_chars(void **state)
{
    (void)state;  // unused

    srand(2);
    for (uint i = 0; i < NUM_RANDOM_TESTS; i++) {
        uint32_t in_bigint[NUM_HASH_BIGINTS];
        random_bigint(in_bigint);

        char chars[82];
        bigints_to_chars(in_bigint, chars, NUM_HASH_BIGINTS);

        uint32_t out_bigint[NUM_HASH_BIGINTS];
        chars_to_bigints(chars, out_bigint, NUM_HASH_TRYTES);

        assert_memory_equal(in_bigint, out_bigint, NUM_HASH_BIGINTS * 4);
    }
}

static void test_random_trits(void **state)
{
    (void)state;  // unused

    srand(2);
    for (uint i = 0; i < NUM_RANDOM_TESTS; i++) {
        trit_t in_trits[NUM_HASH_TRITS];
        random_trits(in_trits);

        uint32_t in_bigint[NUM_HASH_BIGINTS];
        trits_to_bigint(in_trits, in_bigint);

        unsigned char bytes[NUM_HASH_BYTES];
        bigint_to_bytes(in_bigint, bytes);

        uint32_t out_bigint[NUM_HASH_BIGINTS];
        bytes_to_bigint(bytes, out_bigint);

        trit_t out_trits[NUM_HASH_TRITS];
        bigint_to_trits(out_bigint, out_trits);

        assert_memory_equal(in_trits, out_trits,
                            NUM_HASH_TRITS * sizeof(trit_t));
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_single_byte_via_trits),
        cmocka_unit_test(test_random_bigints_via_trits),
        cmocka_unit_test(test_random_bigints_via_chars),
        cmocka_unit_test(test_random_trits)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
