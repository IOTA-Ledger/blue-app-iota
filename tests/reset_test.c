#include "test_common.h"
#include "api_tests.h"
#include "iota/conversion.h"
// include the c-file to be able to test static functions
#include "api.c"

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

static void test_reset_initialized(void **state)
{
    UNUSED(state);

    api_initialize();

    unsigned char input[0]; // no input
    EXPECT_API_OK(reset, 0, input);

    assert_all_zero(&api, sizeof(api));
}

static void test_reset_pubkey(void **state)
{
    UNUSED(state);
    static const int security = 2;

    api_initialize();
    {
        SET_SEED_PUBKEY_INPUT input;
        SET_SEED_IN_INPUT(PETER_VECTOR.seed, security, &input);
        input.pubkey.address_idx = 0;

        PUBKEY_OUTPUT output;
        strncpy(output.address, PETER_VECTOR.addresses[security][0],
                NUM_HASH_TRYTES);

        EXPECT_API_DATA_OK(pubkey, 0, input, output);
    }
    {
        unsigned char input[0]; // no input
        EXPECT_API_OK(reset, 0, input);
    }

    assert_all_zero(&api, sizeof(api));

    {
        SET_SEED_PUBKEY_INPUT input;
        SET_SEED_IN_INPUT(PETER_VECTOR.seed, security, &input);
        input.pubkey.address_idx = 0;

        PUBKEY_OUTPUT output;
        strncpy(output.address, PETER_VECTOR.addresses[security][0],
                NUM_HASH_TRYTES);

        EXPECT_API_DATA_OK(pubkey, 0, input, output);
    }
}

static void test_reset_bundle(void **state)
{
    UNUSED(state);
    static const int security = 2;

    api_initialize();
    { // set first tx of bundle
        SET_SEED_TX_INPUT input;
        SET_SEED_IN_INPUT(PETER_VECTOR.seed, security, &input);
        memcpy(&input.tx, &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));

        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, P1_FIRST, input, output);
    }
    {
        unsigned char input[0]; // no input
        EXPECT_API_OK(reset, 0, input);
    }

    assert_all_zero(&api, sizeof(api));

    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.seed, security, PETER_VECTOR.bundle,
                             2, PETER_VECTOR.bundle_hash);
}

int main(void)
{
    const struct CMUnitTest tests[] = {cmocka_unit_test(test_reset_initialized),
                                       cmocka_unit_test(test_reset_pubkey),
                                       cmocka_unit_test(test_reset_bundle)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
