#include <setjmp.h>
#include <stdarg.h>
#include <stddef.h>

#include <cmocka.h>

#include "hash_file.h"
#include "test_constants.h"
#include "vendor/iota/conversion.h"
#include "vendor/iota/kerl.h"

static void trit_kerl(const char *input, const size_t squeeze_num_trits,
                      char *output)
{
    const size_t num_trytes = strlen(input);
    const size_t num_trits = num_trytes * TRITS_PER_TRYTE;

    tryte_t input_trytes[MAX_NUM_TRYTES];
    chars_to_trytes(input, input_trytes, num_trytes);

    trit_t input_trits[MAX_NUM_TRITS];
    trytes_to_trits(input_trytes, input_trits, num_trytes);

    cx_sha3_t sha3;
    trit_t output_trits[MAX_NUM_TRITS];

    assert_return_code(kerl_initialize(&sha3), 0);
    assert_return_code(kerl_absorb_trits(&sha3, input_trits, num_trits), 0);
    assert_return_code(
        kerl_squeeze_trits(&sha3, output_trits, squeeze_num_trits), 0);

    tryte_t output_trytes[MAX_NUM_TRYTES];
    trits_to_trytes(output_trits, output_trytes, squeeze_num_trits);

    const size_t squeeze_num_trytes = squeeze_num_trits / TRITS_PER_TRYTE;
    trytes_to_chars(output_trytes, output, squeeze_num_trytes);
    output[squeeze_num_trytes] = 0;
}

static void bigint_kerl(const char *input, const size_t squeeze_num_trits,
                        char *output)
{
    const size_t num_trytes = strlen(input);
    const size_t num_trits = num_trytes * TRITS_PER_TRYTE;

    tryte_t input_trytes[MAX_NUM_TRYTES];
    chars_to_trytes(input, input_trytes, num_trytes);

    trit_t input_trits[MAX_NUM_TRITS];
    trytes_to_trits(input_trytes, input_trits, num_trytes);

    uint32_t bigint[MAX_NUM_BIGINTS];

    for (uint i = 0; i < NUM_BIGINTS(num_trits) / 12; i++) {
        trits_to_bigint(input_trits + i * NUM_HASH_TRITS, bigint + i * 12);
    }

    cx_sha3_t sha3;

    assert_return_code(kerl_initialize(&sha3), 0);
    assert_return_code(
        kerl_absorb_bigints(&sha3, bigint, NUM_BIGINTS(num_trits)), 0);
    assert_return_code(
        kerl_squeeze_bigints(&sha3, bigint, NUM_BIGINTS(squeeze_num_trits)), 0);

    trit_t output_trits[MAX_NUM_TRITS] = {0};

    for (uint i = 0; i < NUM_BIGINTS(squeeze_num_trits) / 12; i++) {
        bigint_to_trits(bigint + i * 12, output_trits + i * NUM_HASH_TRITS);
    }

    tryte_t output_trytes[MAX_NUM_TRYTES] = {0};
    trits_to_trytes(output_trits, output_trytes, squeeze_num_trits);

    const size_t squeeze_num_trytes = squeeze_num_trits / TRITS_PER_TRYTE;
    trytes_to_chars(output_trytes, output, squeeze_num_trytes);
    output[squeeze_num_trytes] = 0;
}

static void test_kerl(const char *input, const size_t length,
                      const char *expected,
                      void (*kerl)(const char *, size_t, const char *))
{
    char output[MAX_NUM_TRYTES + 1];

    assert_non_null(kerl);
    kerl(input, length, output);

    assert_string_equal(output, expected);
}

static void test_peter_seed(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;

    test_kerl(
        "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETER"
        "PETERPETERR",
        243,
        "JPXGSMTSWTIOVEMLNVWNUPDLZPCF9AARZTSBT9SUNTRHIHWNVB9SPXFHWLY9OCSPLBELQG"
        "IFYDXG9OHOC",
        kerl);
}

static void test_243_neg_one(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;

    test_kerl(
        "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
        "NNNNNNNNNNN",
        243,
        "NXOQOASTBGO9BF9YZRFHTALRUVRLRYPKDUIZJJLKLVTSMERZQBAQOSMGUE9LIDPXJJWAAB"
        "TIYNTURURTD",
        kerl);
}

static void test_242_neg_one(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;

    test_kerl(
        "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
        "NNNNNNNNNNW",
        243,
        "NXOQOASTBGO9BF9YZRFHTALRUVRLRYPKDUIZJJLKLVTSMERZQBAQOSMGUE9LIDPXJJWAAB"
        "TIYNTURURTD",
        kerl);
}

static void test_input_with_243trits(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;

    test_kerl(
        "EMIDYNHBWMBCXVDEFOFWINXTERALUKYYPPHKP9JJFGJEIUY9MUDVNFZHMMWZUYUSWAIOWE"
        "VTHNWMHANBH",
        243,
        "EJEAOOZYSAWFPZQESYDHZCGYNSTWXUMVJOVDWUNZJXDGWCLUFGIMZRMGCAZGKNPLBRLGUN"
        "YWKLJTYEAQX",
        kerl);
}

static void test_output_with_more_than_243trits(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;

    test_kerl(
        "9MIDYNHBWMBCXVDEFOFWINXTERALUKYYPPHKP9JJFGJEIUY9MUDVNFZHMMWZUYUSWAIOWE"
        "VTHNWMHANBH",
        486,
        "G9JYBOMPUXHYHKSNRNMMSSZCSHOFYOYNZRSZMAAYWDYEIMVVOGKPJBVBM9TDPULSFUNMTV"
        "XRKFIDOHUXXVYDLFSZYZTWQYTE9SPYYWYTXJYQ9IFGYOLZXWZBKWZN9QOOTBQMWMUBLEWU"
        "EEASRHRTNIQWJQNDWRYLCA",
        kerl);
}

static void test_input_output_with_more_than_243trits(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;

    test_kerl(
        "G9JYBOMPUXHYHKSNRNMMSSZCSHOFYOYNZRSZMAAYWDYEIMVVOGKPJBVBM9TDPULSFUNMTV"
        "XRKFIDOHUXXVYDLFSZYZTWQYTE9SPYYWYTXJYQ9IFGYOLZXWZBKWZN9QOOTBQMWMUBLEWU"
        "EEASRHRTNIQWJQNDWRYLCA",
        486,
        "LUCKQVACOGBFYSPPVSSOXJEKNSQQRQKPZC9NXFSMQNRQCGGUL9OHVVKBDSKEQEBKXRNUJS"
        "RXYVHJTXBPDWQGNSCDCBAIRHAQCOWZEBSNHIJIGPZQITIBJQ9LNTDIBTCQ9EUWKHFLGFUV"
        "GGUWJONK9GBCDUIMAYMMQX",
        kerl);
}

static void test_generate_trytes_and_hashes(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;
    void test(char *hashes[])
    {
        test_kerl(hashes[0], NUM_HASH_TRITS, hashes[1], kerl);
    }

    test_for_each_line("generateTrytesAndHashes", test);
}

static void test_generate_multi_trytes_and_hash(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;
    void test(char *hashes[])
    {
        test_kerl(hashes[0], NUM_HASH_TRITS, hashes[1], kerl);
    }

    test_for_each_line("generateMultiTrytesAndHash", test);
}

static void test_generate_trytes_and_multi_squeeze(void **state)
{
    void (*kerl)(const char *, size_t, const char *) = *state;
    void test(char *hashes[])
    {
        char str[1024];
        snprintf(str, sizeof(str), "%s%s%s", hashes[1], hashes[2], hashes[3]);

        test_kerl(hashes[0], 3 * NUM_HASH_TRITS, str, kerl);
    }

    test_for_each_line("generateTrytesAndMultiSqueeze", test);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test_prestate(test_peter_seed, trit_kerl),
        cmocka_unit_test_prestate(test_peter_seed, bigint_kerl),
        cmocka_unit_test_prestate(test_243_neg_one, trit_kerl),
        cmocka_unit_test_prestate(test_243_neg_one, bigint_kerl),
        cmocka_unit_test_prestate(test_242_neg_one, trit_kerl),
        cmocka_unit_test_prestate(test_242_neg_one, bigint_kerl),
        cmocka_unit_test_prestate(test_input_with_243trits, trit_kerl),
        cmocka_unit_test_prestate(test_input_with_243trits, bigint_kerl),
        cmocka_unit_test_prestate(test_output_with_more_than_243trits,
                                  trit_kerl),
        cmocka_unit_test_prestate(test_output_with_more_than_243trits,
                                  bigint_kerl),
        cmocka_unit_test_prestate(test_input_output_with_more_than_243trits,
                                  trit_kerl),
        cmocka_unit_test_prestate(test_input_output_with_more_than_243trits,
                                  bigint_kerl),
        cmocka_unit_test_prestate(test_generate_trytes_and_hashes, trit_kerl),
        cmocka_unit_test_prestate(test_generate_trytes_and_hashes, bigint_kerl),
        cmocka_unit_test_prestate(test_generate_multi_trytes_and_hash,
                                  trit_kerl),
        cmocka_unit_test_prestate(test_generate_multi_trytes_and_hash,
                                  bigint_kerl),
        cmocka_unit_test_prestate(test_generate_trytes_and_multi_squeeze,
                                  trit_kerl),
        cmocka_unit_test_prestate(test_generate_trytes_and_multi_squeeze,
                                  bigint_kerl)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
