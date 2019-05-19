#include <stddef.h>
#include "api_tests.h"
#include "test_common.h"
#include "test_vectors.h"
#include "api.h"
#include "iota/conversion.h"
#include "iota/iota_types.h"
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

static void assert_bundle_reset(void)
{
    assert_all_zero(&api.ctx.bundle, sizeof(api.ctx.bundle));
    assert_all_zero(&api.ctx.signing, sizeof(api.ctx.signing));
    assert_int_equal(api.state_flags, 0);
}

static void test_reset_initialized(void **state)
{
    UNUSED(state);

    api_initialize();

    unsigned char input[0]; // no input
    EXPECT_API_OK(reset, 0, input);

    assert_bundle_reset();
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

    assert_bundle_reset();

    {
        const SET_SEED_PUBKEY_INPUT input = {
            {security, BIP32_PATH_LENGTH, BIP32_PATH}, {0}};

        // seed_derive_from_bip32 may are may not be called
        expect_memory_count(
            seed_derive_from_bip32, path, input.set_seed.bip32_path,
            sizeof(input.set_seed.bip32_path), WILL_RETURN_ONCE);
        expect_value_count(seed_derive_from_bip32, pathLength,
                           input.set_seed.bip32_path_length, WILL_RETURN_ONCE);
        will_return_maybe(seed_derive_from_bip32,
                          cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

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

    // only send first tx of a bundle
    {
        SET_SEED_TX_INPUT input;
        SET_SEED_IN_INPUT(PETER_VECTOR.seed, security, &input);
        memcpy(&input.tx, &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));

        TX_OUTPUT output = {};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, P1_FIRST, input, output);
    }
    // reset
    {
        unsigned char input[0]; // no input
        EXPECT_API_OK(reset, 0, input);
    }

    assert_bundle_reset();

    // send complete bundle
    {
        SET_SEED_TX_INPUT input = {{security, BIP32_PATH_LENGTH, BIP32_PATH},
                                   {}};
        memcpy(&input.tx, &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));

        // seed_derive_from_bip32 may are may not be called
        expect_memory_count(
            seed_derive_from_bip32, path, input.set_seed.bip32_path,
            sizeof(input.set_seed.bip32_path), WILL_RETURN_ONCE);
        expect_value_count(seed_derive_from_bip32, pathLength,
                           input.set_seed.bip32_path_length, WILL_RETURN_ONCE);
        will_return_maybe(seed_derive_from_bip32,
                          cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

        TX_OUTPUT output = {};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, P1_FIRST, input, output);
    }
    {
        TX_OUTPUT output = {};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, P1_MORE, PETER_VECTOR.bundle[1], output);
    }
    {
        TX_OUTPUT output = {};
        strncpy(output.bundle_hash, PETER_VECTOR.bundle_hash, 81);
        output.finalized = true;

        EXPECT_API_DATA_OK(tx, P1_MORE, PETER_VECTOR.bundle[2], output);
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {cmocka_unit_test(test_reset_initialized),
                                       cmocka_unit_test(test_reset_pubkey),
                                       cmocka_unit_test(test_reset_bundle)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
