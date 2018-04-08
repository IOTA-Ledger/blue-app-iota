#include "test_common.h"
#include <string.h>
#include "api_tests.h"
#include "api.h"
#include "transaction_file.h"
#include "iota/conversion.h"
#include "iota/signing.h"

void derive_seed_bip32(const unsigned int *path, unsigned int pathLength,
                       unsigned char *seed_bytes)
{
    UNUSED(path);
    UNUSED(pathLength);

    chars_to_bytes(mock_ptr_type(char *), seed_bytes, NUM_HASH_TRYTES);
}

void io_send(const void *ptr, unsigned int length, unsigned short sw)
{
    check_expected(ptr);
    check_expected(length);
    check_expected(sw);
}

static void input_valid_bundle(int security, const TX_INPUT *tx, int last_index,
                               const char *bundle_hash)
{
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    for (int i = 0; i < last_index; i++) {
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, tx[i], output);
    }
    {
        TX_OUTPUT output = {0};
        output.finalized = true;
        strncpy(output.bundle_hash, bundle_hash, 81);

        EXPECT_API_DATA_OK(tx, tx[last_index], output);
    }
}

static void test_valid_signatures(const char *seed, int security,
                                  const TX_INPUT *tx, int last_index,
                                  const char *bundle_hash,
                                  const char signature[][SIGNATURE_LENGTH])
{
    const int num_fragments = NUM_SIGNATURE_FRAGMENTS(security);

    SEED_INIT(seed);
    api_initialize();
    input_valid_bundle(security, tx, last_index, bundle_hash);

    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < num_fragments; j++) {
            SIGN_INPUT input;
            input.transaction_idx = 1 + i * security;

            SIGN_OUTPUT output;
            output.fragments_remaining = (j + 1) != num_fragments;
            memcpy(output.signature_fragment, signature[i] + j * 243, 243);

            EXPECT_API_DATA_OK(sign, input, output);
        }
    }
}

static void test_signatures_for_seed_from_file(void **state)
{
    UNUSED(state);

    void test(char *seed, TX_INPUT *tx, char *bundle_hash,
              char signature[][SIGNATURE_LENGTH])
    {
        test_valid_signatures(seed, 2, tx, 5, bundle_hash, signature);
    }

    test_for_each_bundle("generateBundlesForSeed", test);
}

static void test_unfinalized_bundle(void **state)
{
    UNUSED(state);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, 2};
        EXPECT_API_OK(set_seed, input);
    }
    {
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    {
        SIGN_INPUT input;
        input.transaction_idx = 0;

        EXPECT_API_EXCEPTION(sign, input);
    }
}

static void test_output_index(void **state)
{
    UNUSED(state);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    input_valid_bundle(2, PETER_VECTOR.bundle, 2, PETER_VECTOR.bundle_hash);
    {
        SIGN_INPUT input;
        input.transaction_idx = 0;

        EXPECT_API_EXCEPTION(sign, input);
    }
}

static void test_meta_index(void **state)
{
    UNUSED(state);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    input_valid_bundle(2, PETER_VECTOR.bundle, 2, PETER_VECTOR.bundle_hash);
    {
        SIGN_INPUT input;
        input.transaction_idx = 2;

        EXPECT_API_EXCEPTION(sign, input);
    }
}

static void test_changing_index(void **state)
{
    UNUSED(state);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    input_valid_bundle(2, PETER_VECTOR.bundle, 2, PETER_VECTOR.bundle_hash);
    {
        SIGN_INPUT input;
        input.transaction_idx = 1;

        SIGN_OUTPUT output;
        output.fragments_remaining = true;
        memcpy(output.signature_fragment, PETER_VECTOR.signature[0], 243);

        EXPECT_API_DATA_OK(sign, input, output);
    }
    {
        SIGN_INPUT input;
        input.transaction_idx = 2;

        EXPECT_API_EXCEPTION(sign, input);
    }
}

static void test_not_set_seed(void **state)
{
    UNUSED(state);

    api_initialize();
    {
        SIGN_INPUT input;
        input.transaction_idx = 0;

        EXPECT_API_EXCEPTION(sign, input);
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
        cmocka_unit_test(test_not_set_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
