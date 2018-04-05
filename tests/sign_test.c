#include "test_common.h"
#include <string.h>
#include "api_tests.h"
#include "api.h"
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

static void input_valid_bundle(uint8_t security)
{
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
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
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[1], sizeof(input));

        TX_OUTPUT output;
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    {
        // Meta TX
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[2], sizeof(input));

        TX_OUTPUT output;
        output.finalized = true;
        strncpy(output.bundle_hash, PETER_VECTOR.bundle_hash, 81);

        EXPECT_API_DATA_OK(tx, input, output);
    }
}

static void test_valid_signature_level_two(void **state)
{
    UNUSED(state);
    const int security = 2;
    const int num_fragments = NUM_SIGNATURE_FRAGMENTS(security) - 1;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    input_valid_bundle(security);

    for (int i = 0; i < num_fragments; i++) {
        SIGN_INPUT input;
        input.transaction_idx = 1;

        SIGN_OUTPUT output;
        output.fragments_remaining = true;
        memcpy(output.signature_fragment, PETER_VECTOR.signature[1] + i * 243,
               243);

        EXPECT_API_DATA_OK(sign, input, output);
    }
    {
        SIGN_INPUT input;
        input.transaction_idx = 1;

        SIGN_OUTPUT output;
        output.fragments_remaining = false;
        memcpy(output.signature_fragment,
               PETER_VECTOR.signature[1] + num_fragments * 243, 243);

        EXPECT_API_DATA_OK(sign, input, output);
    }
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
    input_valid_bundle(2);
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
    input_valid_bundle(2);
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
    input_valid_bundle(2);
    {
        SIGN_INPUT input;
        input.transaction_idx = 1;

        SIGN_OUTPUT output;
        output.fragments_remaining = true;
        memcpy(output.signature_fragment, PETER_VECTOR.signature[1], 243);

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

        EXPECT_API_EXCEPTION(tx, input);
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_valid_signature_level_two),
        cmocka_unit_test(test_unfinalized_bundle),
        cmocka_unit_test(test_output_index),
        cmocka_unit_test(test_meta_index),
        cmocka_unit_test(test_changing_index),
        cmocka_unit_test(test_not_set_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
