#include "test_common.h"
#include <stdlib.h>
// include the c-file to be able to test static functions
#include "iota/conversion.c"

#define NUM_RANDOM_TESTS 10000

static void test_increment_trit_82(void **state)
{
    UNUSED(state);

    // all zero trits correspond to all zero bytes
    unsigned char bytes[NUM_HASH_BYTES] = {0};

    bytes_increment_trit_area_81(bytes);

    trit_t inc_trits[NUM_HASH_TRITS];
    bytes_to_trits(bytes, inc_trits);

    trit_t expected_trits[NUM_HASH_TRITS] = {0};
    // the 82nd trit is the trit at index 81
    expected_trits[81] = 1;

    assert_memory_equal(inc_trits, expected_trits, NUM_HASH_TRITS);
}

static void test_increment_trit_no_overflow(void **state)
{
    UNUSED(state);

    trit_t trits[NUM_HASH_TRITS] = {0};
    memset(trits + 81, 1, 81);

    unsigned char bytes[NUM_HASH_BYTES];
    trits_to_bytes(trits, bytes);

    bytes_increment_trit_area_81(bytes);

    trit_t inc_trits[NUM_HASH_TRITS];
    bytes_to_trits(bytes, inc_trits);

    trit_t expected_trits[NUM_HASH_TRITS] = {0};
    memset(expected_trits + 81, -1, 81);

    assert_memory_equal(inc_trits, expected_trits, NUM_HASH_TRITS);
}

static void test_int64_to_trits_zero(void **state)
{
    UNUSED(state);

    static const int64_t input_value = 0;
    static const trit_t expected_trits[42] = {0};

    trit_t trits_out[42];
    bool result = int64_to_trits(input_value, trits_out, 42);

    assert_false(result);
    assert_memory_equal(trits_out, expected_trits, 42);
}

static void test_int64_to_trits_one(void **state)
{
    UNUSED(state);

    static const int64_t input_value = 6078832729528464400;
    trit_t expected_trits[40];
    memset(expected_trits, 1, 40);

    trit_t trits_out[40];
    bool result = int64_to_trits(input_value, trits_out, 40);

    assert_false(result);
    assert_memory_equal(trits_out, expected_trits, 40);
}

static void test_int64_to_trits_neg_one(void **state)
{
    UNUSED(state);

    static const int64_t input_value = -6078832729528464400;
    trit_t expected_trits[40];
    memset(expected_trits, -1, 40);

    trit_t trits_out[40];
    bool result = int64_to_trits(input_value, trits_out, 40);

    assert_false(result);
    assert_memory_equal(trits_out, expected_trits, 40);
}

static void test_int64_to_trits_overflow(void **state)
{
    UNUSED(state);

    static const int64_t input_value = 6078832729528464401;

    trit_t trits_out[40];
    bool result = int64_to_trits(input_value, trits_out, 40);

    assert_true(result);
}

static void random_bytes(unsigned char *bytes)
{
    for (int i = 0; i < NUM_HASH_BYTES; i++) {
        bytes[i] = rand() & 0xFF;
    }
}

static void random_chars(char *chars)
{
    for (int i = 0; i < NUM_HASH_TRYTES; i++) {
        const int rn = rand() % 27;
        if (rn == 26) {
            chars[i] = '9';
        }
        else {
            chars[i] = 'A' + rn;
        }
    }
}

static void assert_bytes_equal(unsigned char *actual, unsigned char *expected)
{
    bytes_set_last_trit_zero(actual);
    bytes_set_last_trit_zero(expected);

    assert_memory_equal(actual, expected, NUM_HASH_BYTES);
}

static void test_random_bytes_via_chars(void **state)
{
    UNUSED(state);

    srand(2);
    for (uint i = 0; i < NUM_RANDOM_TESTS; i++) {
        unsigned char in_bytes[NUM_HASH_BYTES];
        random_bytes(in_bytes);

        char chars[82];
        bytes_to_chars(in_bytes, chars, NUM_HASH_BYTES);

        unsigned char out_bytes[NUM_HASH_BYTES];
        chars_to_bytes(chars, out_bytes, NUM_HASH_TRYTES);

        assert_bytes_equal(in_bytes, out_bytes);
    }
}

static void assert_chars_equal(const char *actual, const char *expected)
{
    trit_t actual_trits[NUM_HASH_TRITS];
    chars_to_trits(actual, actual_trits, NUM_HASH_TRYTES);

    trit_t expected_trits[NUM_HASH_TRITS];
    chars_to_trits(expected, expected_trits, NUM_HASH_TRYTES);

    // ignore 243th trit
    assert_memory_equal(actual_trits, expected_trits, 242);
}

static void test_chars_via_bytes(const char *input)
{
    unsigned char bytes[NUM_HASH_BYTES];
    chars_to_bytes(input, bytes, NUM_HASH_TRYTES);

    char chars[82];
    bytes_to_chars(bytes, chars, NUM_HASH_BYTES);

    assert_chars_equal(chars, input);
}

static void test_all_zero(void **state)
{
    UNUSED(state);

    static const char ZERO_CHARS[NUM_HASH_TRYTES] =
        "9999999999999999999999999999999999999999999999999999999999999999999999"
        "99999999999";
    static const unsigned char ZERO_BYTES[NUM_HASH_BYTES] = {0};

    unsigned char bytes[NUM_HASH_BYTES];
    chars_to_bytes(ZERO_CHARS, bytes, NUM_HASH_TRYTES);

    assert_memory_equal(bytes, ZERO_BYTES, NUM_HASH_BYTES);

    char chars[82];
    bytes_to_chars(bytes, chars, NUM_HASH_BYTES);

    assert_chars_equal(chars, ZERO_CHARS);
}

static void test_all_neg_one(void **state)
{
    UNUSED(state);

    static const char NEG_ONE_CHARS[NUM_HASH_TRYTES] =
        "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
        "NNNNNNNNNNN";

    test_chars_via_bytes(NEG_ONE_CHARS);
}

static void test_random_chars_via_bytes(void **state)
{
    (void)state; // unused

    srand(2);
    for (uint i = 0; i < NUM_RANDOM_TESTS; i++) {
        char in_chars[NUM_HASH_TRYTES];
        random_chars(in_chars);

        test_chars_via_bytes(in_chars);
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_increment_trit_82),
        cmocka_unit_test(test_increment_trit_no_overflow),
        cmocka_unit_test(test_int64_to_trits_zero),
        cmocka_unit_test(test_int64_to_trits_one),
        cmocka_unit_test(test_int64_to_trits_neg_one),
        cmocka_unit_test(test_int64_to_trits_overflow),
        cmocka_unit_test(test_all_zero),
        cmocka_unit_test(test_all_neg_one),
        cmocka_unit_test(test_random_bytes_via_chars),
        cmocka_unit_test(test_random_chars_via_bytes)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
