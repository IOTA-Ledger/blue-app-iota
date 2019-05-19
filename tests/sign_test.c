#include <stddef.h>
#include <string.h>
#include "api_tests.h"
#include "test_common.h"
#include "test_vectors.h"
#include "transaction_file.h"
#include "os.h"
#include "api.h"
#include "iota/conversion.h"
#include "iota/iota_types.h"

void seed_derive_from_bip32(const unsigned int *path, unsigned int pathLength,
                            unsigned char *seed_bytes)
{
    check_expected(path);
    check_expected(pathLength);

    chars_to_bytes(mock_ptr_type(char *), seed_bytes, NUM_HASH_TRYTES);
}

void io_send(const void *ptr, unsigned int length, unsigned short sw)
{
    check_expected(ptr);
    check_expected(length);
    check_expected(sw);
}

static void test_valid_signatures(const char *seed, int security,
                                  const TX_INPUT *tx, int last_index,
                                  const char *bundle_hash,
                                  const char signature[][SIGNATURE_LENGTH])
{
    const int num_fragments = NUM_SIGNATURE_FRAGMENTS(security);

    api_initialize();
    EXPECT_API_SET_BUNDLE_OK(seed, security, tx, last_index, bundle_hash);

    const int num_inputs = (last_index - 1) / security;
    for (int i = 0; i < num_inputs; i++) {
        for (int j = 0; j < num_fragments; j++) {
            SIGN_INPUT input;
            input.transaction_idx = 1 + i * security;

            SIGN_OUTPUT output;
            output.fragments_remaining = (j + 1) != num_fragments;
            memcpy(output.signature_fragment, signature[i] + j * 243, 243);

            EXPECT_API_DATA_OK(sign, 0, input, output);
        }
    }
}

static void test_seed(char *seed, int security, TX_INPUT *tx, int last_index,
                      char *bundle_hash, char signature[][SIGNATURE_LENGTH])
{
    test_valid_signatures(seed, security, tx, last_index, bundle_hash,
                          signature);
}

static void test_signatures_for_seed_from_file(void **state)
{
    UNUSED(state);

    test_for_each_bundle("generateBundlesForSeed", test_seed);
}

static void test_unfinalized_bundle(void **state)
{
    UNUSED(state);

    api_initialize();
    {
        SET_SEED_TX_INPUT input;
        SET_SEED_IN_INPUT(PETER_VECTOR.seed, 2, &input);
        memcpy(&input.tx, &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));

        TX_OUTPUT output = {};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, P1_FIRST, input, output);
    }
    {
        SIGN_INPUT input;
        input.transaction_idx = 0;

        EXPECT_API_EXCEPTION(sign, P1_MORE, input);
    }
}

static void test_output_index(void **state)
{
    UNUSED(state);

    api_initialize();
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.seed, 2, PETER_VECTOR.bundle, 2,
                             PETER_VECTOR.bundle_hash);
    {
        SIGN_INPUT input;
        input.transaction_idx = 0;

        EXPECT_API_EXCEPTION(sign, 0, input);
    }
}

static void test_meta_index(void **state)
{
    UNUSED(state);

    api_initialize();
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.seed, 2, PETER_VECTOR.bundle, 2,
                             PETER_VECTOR.bundle_hash);
    {
        SIGN_INPUT input;
        input.transaction_idx = 2;

        EXPECT_API_EXCEPTION(sign, 0, input);
    }
}

static void test_changing_index(void **state)
{
    UNUSED(state);

    api_initialize();
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.seed, 2, PETER_VECTOR.bundle, 2,
                             PETER_VECTOR.bundle_hash);
    {
        SIGN_INPUT input;
        input.transaction_idx = 1;

        SIGN_OUTPUT output;
        output.fragments_remaining = true;
        memcpy(output.signature_fragment, PETER_VECTOR.signature[0], 243);

        EXPECT_API_DATA_OK(sign, 0, input, output);
    }
    {
        SIGN_INPUT input;
        input.transaction_idx = 2;

        EXPECT_API_EXCEPTION(sign, 0, input);
    }
}

static void test_no_bundle(void **state)
{
    UNUSED(state);

    api_initialize();
    {
        SIGN_INPUT input;
        input.transaction_idx = 0;

        EXPECT_API_EXCEPTION(sign, 0, input);
    }
}

static void test_overflow_index(void **state)
{
    UNUSED(state);

    api_initialize();
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.seed, 2, PETER_VECTOR.bundle, 2,
                             PETER_VECTOR.bundle_hash);
    {
        SIGN_INPUT input;
        input.transaction_idx = UINT8_MAX + 1;

        EXPECT_API_EXCEPTION(sign, 0, input);
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_signatures_for_seed_from_file),
        cmocka_unit_test(test_unfinalized_bundle),
        cmocka_unit_test(test_output_index),
        cmocka_unit_test(test_meta_index),
        cmocka_unit_test(test_changing_index),
        cmocka_unit_test(test_no_bundle),
        cmocka_unit_test(test_overflow_index)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
