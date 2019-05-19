#include <stdint.h>
#include "hash_file.h"
#include "test_common.h"
#include "test_vectors.h"
#include "os.h"
#include "iota/addresses.h"
#include "iota/conversion.h"

static void seed_address(const char *seed_chars, uint32_t idx, uint8_t security,
                         char *address_chars)
{
    unsigned char seed_bytes[NUM_HASH_BYTES];
    chars_to_bytes(seed_chars, seed_bytes, NUM_HASH_TRYTES);

    unsigned char address_bytes[NUM_HASH_BYTES];
    get_public_addr(seed_bytes, idx, security, address_bytes);

    get_address_with_checksum(address_bytes, address_chars);
}

static void test_address(const char *seed, uint32_t idx, uint8_t security,
                         bool has_checksum, const char *expected)
{
    char output[NUM_HASH_TRYTES + NUM_CHECKSUM_TRYTES];
    seed_address(seed, idx, security, output);

    int address_length = NUM_HASH_TRYTES;
    if (has_checksum) {
        address_length += NUM_CHECKSUM_TRYTES;
    }

    assert_memory_equal(output, expected, address_length);
}

static void test_vector(void **state, const TEST_VECTOR *vector,
                        uint8_t security)
{
    uint32_t idx = (uintptr_t)*state;
    assert_in_range(idx, 0, MAX_ADDRESS_INDEX);

    test_address(vector->seed, idx, security, true,
                 vector->addresses[security][idx]);
}

static void test_below_min_level(void **state)
{
    UNUSED(state);

    char output[NUM_HASH_TRYTES + NUM_CHECKSUM_TRYTES];
    expect_assert_failure(
        seed_address(PETER_VECTOR.seed, 0, MIN_SECURITY_LEVEL - 1, output));
}

static void test_above_max_level(void **state)
{
    UNUSED(state);

    char output[NUM_HASH_TRYTES + NUM_CHECKSUM_TRYTES];
    expect_assert_failure(
        seed_address(PETER_VECTOR.seed, 0, MAX_SECURITY_LEVEL + 1, output));
}

static void test_security_level_one(void **state)
{
    test_vector(state, &PETER_VECTOR, 1);
}

static void test_security_level_two(void **state)
{
    test_vector(state, &PETER_VECTOR, 2);
}

static void test_security_level_three(void **state)
{
    test_vector(state, &PETER_VECTOR, 3);
}

static void test_overflow_seed_level_one(void **state)
{
    test_vector(state, &OVERFLOW_VECTOR, 1);
}

static void test_overflow_seed_level_two(void **state)
{
    test_vector(state, &OVERFLOW_VECTOR, 2);
}

static void test_overflow_seed_level_three(void **state)
{
    test_vector(state, &OVERFLOW_VECTOR, 3);
}

static void test_word_overflow_seed_level_two(void **state)
{
    test_vector(state, &WORD_OVERFLOW_VECTOR, 2);
}

static void test(char *hashes[])
{
    for (uint32_t idx = 0; idx < 4; idx++) {
        test_address(hashes[0], idx, 2, false, hashes[idx + 1]);
    }
}

static void test_n_addresses_for_seed(void **state)
{
    UNUSED(state);

    test_for_each_line("generateNAddressesForSeed", test);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_below_min_level),
        cmocka_unit_test(test_above_max_level),
        cmocka_unit_test_prestate(test_security_level_one, (uint32_t *)0),
        cmocka_unit_test_prestate(test_security_level_one, (uint32_t *)1),
        cmocka_unit_test_prestate(test_security_level_one, (uint32_t *)2),
        cmocka_unit_test_prestate(test_security_level_one, (uint32_t *)3),
        cmocka_unit_test_prestate(test_security_level_one, (uint32_t *)4),
        cmocka_unit_test_prestate(test_security_level_two, (uint32_t *)0),
        cmocka_unit_test_prestate(test_security_level_two, (uint32_t *)1),
        cmocka_unit_test_prestate(test_security_level_two, (uint32_t *)2),
        cmocka_unit_test_prestate(test_security_level_two, (uint32_t *)3),
        cmocka_unit_test_prestate(test_security_level_two, (uint32_t *)4),
        cmocka_unit_test_prestate(test_security_level_three, (uint32_t *)0),
        cmocka_unit_test_prestate(test_security_level_three, (uint32_t *)1),
        cmocka_unit_test_prestate(test_security_level_three, (uint32_t *)2),
        cmocka_unit_test_prestate(test_security_level_three, (uint32_t *)3),
        cmocka_unit_test_prestate(test_security_level_three, (uint32_t *)4),
        cmocka_unit_test_prestate(test_overflow_seed_level_one, (uint32_t *)0),
        cmocka_unit_test_prestate(test_overflow_seed_level_one, (uint32_t *)1),
        cmocka_unit_test_prestate(test_overflow_seed_level_one, (uint32_t *)2),
        cmocka_unit_test_prestate(test_overflow_seed_level_one, (uint32_t *)3),
        cmocka_unit_test_prestate(test_overflow_seed_level_one, (uint32_t *)4),
        cmocka_unit_test_prestate(test_overflow_seed_level_two, (uint32_t *)0),
        cmocka_unit_test_prestate(test_overflow_seed_level_two, (uint32_t *)1),
        cmocka_unit_test_prestate(test_overflow_seed_level_two, (uint32_t *)2),
        cmocka_unit_test_prestate(test_overflow_seed_level_two, (uint32_t *)3),
        cmocka_unit_test_prestate(test_overflow_seed_level_two, (uint32_t *)4),
        cmocka_unit_test_prestate(test_overflow_seed_level_three,
                                  (uint32_t *)0),
        cmocka_unit_test_prestate(test_overflow_seed_level_three,
                                  (uint32_t *)1),
        cmocka_unit_test_prestate(test_overflow_seed_level_three,
                                  (uint32_t *)2),
        cmocka_unit_test_prestate(test_overflow_seed_level_three,
                                  (uint32_t *)3),
        cmocka_unit_test_prestate(test_overflow_seed_level_three,
                                  (uint32_t *)4),
        cmocka_unit_test_prestate(test_word_overflow_seed_level_two,
                                  (uint32_t *)0),
        cmocka_unit_test_prestate(test_word_overflow_seed_level_two,
                                  (uint32_t *)1),
        cmocka_unit_test_prestate(test_word_overflow_seed_level_two,
                                  (uint32_t *)2),
        cmocka_unit_test_prestate(test_word_overflow_seed_level_two,
                                  (uint32_t *)3),
        cmocka_unit_test_prestate(test_word_overflow_seed_level_two,
                                  (uint32_t *)4),
        cmocka_unit_test(test_n_addresses_for_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
