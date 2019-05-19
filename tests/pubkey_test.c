#include <stddef.h>
#include <string.h>
#include "api_tests.h"
#include "test_common.h"
#include "test_vectors.h"
#include "api.h"
#include "iota/conversion.h"
#include "iota/iota_types.h"
// include the c-file to be able to test static functions
#include "test_seed.c"

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

void expect_command_with_seed_ok(const void *seed_input, size_t seed_size)
{
    unsigned char input[seed_size + sizeof(PUBKEY_INPUT)];
    memcpy(input, seed_input, seed_size);

    const PUBKEY_INPUT pubkey_input = {0};
    memcpy(input + seed_size, &pubkey_input, sizeof(pubkey_input));

    EXPECT_API_OK_ANY_OUTPUT(pubkey, 0, input);
}

void expect_command_with_seed_exception(const void *seed_input,
                                        size_t seed_size)
{
    unsigned char input[seed_size + sizeof(PUBKEY_INPUT)];
    memcpy(input, seed_input, seed_size);

    const PUBKEY_INPUT pubkey_input = {0};
    memcpy(input + seed_size, &pubkey_input, sizeof(pubkey_input));

    EXPECT_API_EXCEPTION(pubkey, 0, input);
}

static void test_valid_index_level_one(void **state)
{
    UNUSED(state);
    static const int security = 1;

    for (unsigned idx = 0; idx <= MAX_ADDRESS_INDEX; idx++) {

        api_initialize();
        {
            SET_SEED_PUBKEY_INPUT input;
            SET_SEED_IN_INPUT(PETER_VECTOR.seed, security, &input);
            input.pubkey.address_idx = idx;

            PUBKEY_OUTPUT output;
            strncpy(output.address, PETER_VECTOR.addresses[security][idx],
                    NUM_HASH_TRYTES);

            EXPECT_API_DATA_OK(pubkey, 0, input, output);
        }
    }
}

static void test_valid_index_level_two(void **state)
{
    UNUSED(state);
    static const int security = 2;

    for (unsigned idx = 0; idx <= MAX_ADDRESS_INDEX; idx++) {

        api_initialize();
        {
            SET_SEED_PUBKEY_INPUT input;
            SET_SEED_IN_INPUT(PETER_VECTOR.seed, security, &input);
            input.pubkey.address_idx = idx;

            PUBKEY_OUTPUT output;
            strncpy(output.address, PETER_VECTOR.addresses[security][idx],
                    NUM_HASH_TRYTES);

            EXPECT_API_DATA_OK(pubkey, 0, input, output);
        }
    }
}

static void test_valid_index_level_three(void **state)
{
    UNUSED(state);
    static const int security = 3;

    for (unsigned idx = 0; idx <= MAX_ADDRESS_INDEX; idx++) {

        api_initialize();
        {
            SET_SEED_PUBKEY_INPUT input;
            SET_SEED_IN_INPUT(PETER_VECTOR.seed, security, &input);
            input.pubkey.address_idx = idx;

            PUBKEY_OUTPUT output;
            strncpy(output.address, PETER_VECTOR.addresses[security][idx],
                    NUM_HASH_TRYTES);

            EXPECT_API_DATA_OK(pubkey, 0, input, output);
        }
    }
}

static void test_invalid_p1(void **state)
{
    UNUSED(state);
    const SET_SEED_FIXED_INPUT seed_input = {2, BIP32_PATH_LENGTH, BIP32_PATH};

    api_initialize();

    SET_SEED_PUBKEY_INPUT input;
    memcpy(&input.set_seed, &seed_input, sizeof(seed_input));
    input.pubkey.address_idx = 0;

    EXPECT_API_EXCEPTION(pubkey, 0xFF, input);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        // seed tests
        cmocka_unit_test(test_valid_security_levels),
        cmocka_unit_test(test_security_level_zero),
        cmocka_unit_test(test_security_level_four),
        cmocka_unit_test(test_valid_path_lengths),
        cmocka_unit_test(test_path_length_zero),
        cmocka_unit_test(test_path_length_six),
        cmocka_unit_test(test_seed_recompute_on_path_change),
        // pubkey tests
        cmocka_unit_test(test_valid_index_level_one),
        cmocka_unit_test(test_valid_index_level_two),
        cmocka_unit_test(test_valid_index_level_three),
        cmocka_unit_test(test_invalid_p1)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
