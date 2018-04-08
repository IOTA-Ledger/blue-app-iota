#include "test_common.h"
#include <stdio.h>
#include <string.h>
#include "hash_file.h"
#include "iota/conversion.h"
#include "iota/kerl.h"

static void kerl(const char *input, const size_t squeeze_num_trits,
                 char *output)
{
    const size_t num_trytes = strlen(input);
    const size_t num_trits = num_trytes * TRITS_PER_TRYTE;

    unsigned char bytes[MAX_NUM_BYTES];
    chars_to_bytes(input, bytes, num_trytes);

    cx_sha3_t kerl;

    kerl_initialize(&kerl);
    kerl_absorb_bytes(&kerl, bytes, NUM_BYTES(num_trits));
    kerl_squeeze_bytes(&kerl, bytes, NUM_BYTES(squeeze_num_trits));

    bytes_to_chars(bytes, output, NUM_BYTES(squeeze_num_trits));
    // make null-terminated
    output[NUM_TRYTES(squeeze_num_trits)] = '\0';
}

static void test_kerl(const char *input, const size_t length,
                      const char *expected)
{
    char output[MAX_NUM_TRYTES + 1];

    assert_non_null(kerl);
    kerl(input, length, output);

    assert_string_equal(output, expected);
}

static void test_peter_seed(void **state)
{
    (void)state; // unused

    test_kerl(
        "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETER"
        "PETERPETERR",
        243,
        "JPXGSMTSWTIOVEMLNVWNUPDLZPCF9AARZTSBT9SUNTRHIHWNVB9SPXFHWLY9OCSPLBELQG"
        "IFYDXG9OHOC");
}

static void test_243_neg_one(void **state)
{
    (void)state; // unused

    test_kerl(
        "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
        "NNNNNNNNNNN",
        243,
        "NXOQOASTBGO9BF9YZRFHTALRUVRLRYPKDUIZJJLKLVTSMERZQBAQOSMGUE9LIDPXJJWAAB"
        "TIYNTURURTD");
}

static void test_242_neg_one(void **state)
{
    (void)state; // unused

    test_kerl(
        "NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN"
        "NNNNNNNNNNW",
        243,
        "NXOQOASTBGO9BF9YZRFHTALRUVRLRYPKDUIZJJLKLVTSMERZQBAQOSMGUE9LIDPXJJWAAB"
        "TIYNTURURTD");
}

static void test_input_with_243trits(void **state)
{
    (void)state; // unused

    test_kerl(
        "EMIDYNHBWMBCXVDEFOFWINXTERALUKYYPPHKP9JJFGJEIUY9MUDVNFZHMMWZUYUSWAIOWE"
        "VTHNWMHANBH",
        243,
        "EJEAOOZYSAWFPZQESYDHZCGYNSTWXUMVJOVDWUNZJXDGWCLUFGIMZRMGCAZGKNPLBRLGUN"
        "YWKLJTYEAQX");
}

static void test_output_with_more_than_243trits(void **state)
{
    (void)state; // unused

    test_kerl(
        "9MIDYNHBWMBCXVDEFOFWINXTERALUKYYPPHKP9JJFGJEIUY9MUDVNFZHMMWZUYUSWAIOWE"
        "VTHNWMHANBH",
        486,
        "G9JYBOMPUXHYHKSNRNMMSSZCSHOFYOYNZRSZMAAYWDYEIMVVOGKPJBVBM9TDPULSFUNMTV"
        "XRKFIDOHUXXVYDLFSZYZTWQYTE9SPYYWYTXJYQ9IFGYOLZXWZBKWZN9QOOTBQMWMUBLEWU"
        "EEASRHRTNIQWJQNDWRYLCA");
}

static void test_input_output_with_more_than_243trits(void **state)
{
    (void)state; // unused

    test_kerl(
        "G9JYBOMPUXHYHKSNRNMMSSZCSHOFYOYNZRSZMAAYWDYEIMVVOGKPJBVBM9TDPULSFUNMTV"
        "XRKFIDOHUXXVYDLFSZYZTWQYTE9SPYYWYTXJYQ9IFGYOLZXWZBKWZN9QOOTBQMWMUBLEWU"
        "EEASRHRTNIQWJQNDWRYLCA",
        486,
        "LUCKQVACOGBFYSPPVSSOXJEKNSQQRQKPZC9NXFSMQNRQCGGUL9OHVVKBDSKEQEBKXRNUJS"
        "RXYVHJTXBPDWQGNSCDCBAIRHAQCOWZEBSNHIJIGPZQITIBJQ9LNTDIBTCQ9EUWKHFLGFUV"
        "GGUWJONK9GBCDUIMAYMMQX");
}

static void test_generate_trytes_and_hashes(void **state)
{
    (void)state; // unused

    void test(char *hashes[])
    {
        test_kerl(hashes[0], NUM_HASH_TRITS, hashes[1]);
    }

    test_for_each_line("generateTrytesAndHashes", test);
}

static void test_generate_multi_trytes_and_hash(void **state)
{
    (void)state; // unused

    void test(char *hashes[])
    {
        test_kerl(hashes[0], NUM_HASH_TRITS, hashes[1]);
    }

    test_for_each_line("generateMultiTrytesAndHash", test);
}

static void test_generate_trytes_and_multi_squeeze(void **state)
{
    (void)state; // unused

    void test(char *hashes[])
    {
        char str[1024];
        snprintf(str, sizeof(str), "%s%s%s", hashes[1], hashes[2], hashes[3]);

        test_kerl(hashes[0], 3 * NUM_HASH_TRITS, str);
    }

    test_for_each_line("generateTrytesAndMultiSqueeze", test);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_peter_seed),
        cmocka_unit_test(test_243_neg_one),
        cmocka_unit_test(test_242_neg_one),
        cmocka_unit_test(test_input_with_243trits),
        cmocka_unit_test(test_output_with_more_than_243trits),
        cmocka_unit_test(test_input_output_with_more_than_243trits),
        cmocka_unit_test(test_generate_trytes_and_hashes),
        cmocka_unit_test(test_generate_multi_trytes_and_hash),
        cmocka_unit_test(test_generate_trytes_and_multi_squeeze)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
