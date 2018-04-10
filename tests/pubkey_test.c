#include "test_common.h"
#include <string.h>
#include "api_tests.h"
#include "api.h"
#include "iota/conversion.h"

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

static void test_valid_index_level_one(void **state)
{
    UNUSED(state);
    static const int security = 1;

    for (unsigned idx = 0; idx <= MAX_ADDRESS_INDEX; idx++) {

        SEED_INIT(PETER_VECTOR.seed);
        api_initialize();
        {
            SET_SEED_INPUT input = {BIP32_PATH, security};
            EXPECT_API_OK(set_seed, input);
        }
        {
            PUBKEY_INPUT input = {idx};
            PUBKEY_OUTPUT output;
            strncpy(output.address, PETER_VECTOR.addresses[security][idx],
                    NUM_HASH_TRYTES);

            EXPECT_API_DATA_OK(pubkey, input, output);
        }
    }
}

static void test_valid_index_level_two(void **state)
{
    UNUSED(state);
    static const int security = 2;

    for (unsigned idx = 0; idx <= MAX_ADDRESS_INDEX; idx++) {

        SEED_INIT(PETER_VECTOR.seed);
        api_initialize();
        {
            SET_SEED_INPUT input = {BIP32_PATH, security};
            EXPECT_API_OK(set_seed, input);
        }
        {
            PUBKEY_INPUT input = {idx};
            PUBKEY_OUTPUT output;
            strncpy(output.address, PETER_VECTOR.addresses[security][idx],
                    NUM_HASH_TRYTES);

            EXPECT_API_DATA_OK(pubkey, input, output);
        }
    }
}

static void test_valid_index_level_three(void **state)
{
    UNUSED(state);
    static const int security = 3;

    for (unsigned idx = 0; idx <= MAX_ADDRESS_INDEX; idx++) {

        SEED_INIT(PETER_VECTOR.seed);
        api_initialize();
        {
            SET_SEED_INPUT input = {BIP32_PATH, security};
            EXPECT_API_OK(set_seed, input);
        }
        {
            PUBKEY_INPUT input = {idx};
            PUBKEY_OUTPUT output;
            strncpy(output.address, PETER_VECTOR.addresses[security][idx],
                    NUM_HASH_TRYTES);

            EXPECT_API_DATA_OK(pubkey, input, output);
        }
    }
}

static void test_change_security(void **state)
{
    UNUSED(state);

    api_initialize();
    {
        SEED_INIT(PETER_VECTOR.seed);
        SET_SEED_INPUT input = {BIP32_PATH, 1};
        EXPECT_API_OK(set_seed, input);
    }
    {
        SEED_INIT(PETER_VECTOR.seed);
        SET_SEED_INPUT input = {BIP32_PATH, 2};
        EXPECT_API_OK(set_seed, input);
    }
    {
        PUBKEY_INPUT input = {0};
        PUBKEY_OUTPUT output;
        strncpy(output.address, PETER_VECTOR.addresses[2][0], NUM_HASH_TRYTES);

        EXPECT_API_DATA_OK(pubkey, input, output);
    }
}

static void test_negative_index(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    {
        PUBKEY_INPUT input = {-1};

        EXPECT_API_EXCEPTION(pubkey, input);
    }
}

static void test_index_overflow(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    {
        PUBKEY_INPUT input = {(UINT32_MAX + INT64_C(1))};

        EXPECT_API_EXCEPTION(pubkey, input);
    }
}

static void test_not_set_seed(void **state)
{
    UNUSED(state);

    api_initialize();
    {
        PUBKEY_INPUT input = {0};

        EXPECT_API_EXCEPTION(pubkey, input);
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_valid_index_level_one),
        cmocka_unit_test(test_valid_index_level_two),
        cmocka_unit_test(test_valid_index_level_three),
        cmocka_unit_test(test_change_security),
        cmocka_unit_test(test_negative_index),
        cmocka_unit_test(test_index_overflow),
        cmocka_unit_test(test_not_set_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
