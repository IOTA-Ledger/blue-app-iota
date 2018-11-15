#include "test_common.h"
#include <string.h>
#include "test_seed.h"
#include "api_tests.h"
#include "api.h"
#include "iota/conversion.h"

void EXPECT_COMMAND_OK(const SET_SEED_FIXED_INPUT *seed_input);
void EXPECT_COMMAND_EXCEPTION(const SET_SEED_FIXED_INPUT *seed_input);

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

void EXPECT_COMMAND_OK(const SET_SEED_FIXED_INPUT *seed_input)
{

    SET_SEED_PUBKEY_INPUT input;
    memcpy(&input.set_seed, seed_input, sizeof(SET_SEED_FIXED_INPUT));
    input.pubkey.address_idx = 0;

    EXPECT_API_OK_ANY_OUTPUT(pubkey, 0, input);
}

void EXPECT_COMMAND_EXCEPTION(const SET_SEED_FIXED_INPUT *seed_input)
{

    SET_SEED_PUBKEY_INPUT input;
    memcpy(&input.set_seed, seed_input, sizeof(SET_SEED_FIXED_INPUT));
    input.pubkey.address_idx = 0;

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

    api_initialize();

    unsigned char input[0]; // no input
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
        // pubkey tests
        cmocka_unit_test(test_valid_index_level_one),
        cmocka_unit_test(test_valid_index_level_two),
        cmocka_unit_test(test_valid_index_level_three),
        cmocka_unit_test(test_invalid_p1)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
