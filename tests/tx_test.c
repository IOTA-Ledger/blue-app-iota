#include "test_common.h"
#include <string.h>
#include "transaction_file.h"
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

static void test_valid_bundle(const char *seed, int security,
                              const TX_INPUT *tx, int last_index,
                              const char *bundle_hash)
{
    SEED_INIT(seed);
    api_initialize();
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

static void test_bundles_for_seed_from_file(void **state)
{
    UNUSED(state);

    void test(char *seed, TX_INPUT *tx, char *bundle_hash)
    {
        test_valid_bundle(seed, 2, tx, 5, bundle_hash);
    }

    test_for_each_bundle("generateBundlesForSeed", test);
}

static void test_invalid_input_address_index(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    { // input transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[1], sizeof(input));
        input.address_idx += 1;
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    { // meta transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[2], sizeof(input));
        input.address_idx += 1;

        EXPECT_API_EXCEPTION(tx, input);
    }
}

static void test_invalid_tx_order(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // input transaction as the first transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[1], sizeof(input));
        input.current_index = 0;

        EXPECT_API_EXCEPTION(tx, input);
    }
}

static void test_tx_index_twice(void **state)
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
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    {
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[1], sizeof(input));
        input.current_index = 0;

        EXPECT_API_EXCEPTION(tx, input);
    }
}

static void test_missing_meta_tx(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        input.current_index = 0;
        input.last_index = 1;

        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    { // input transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[1], sizeof(input));
        input.current_index = 1;
        input.last_index = 1;

        EXPECT_API_EXCEPTION(tx, input);
    }
}

static void test_missing_meta_tx_with_change(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        input.current_index = 0;
        input.last_index = 2;

        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    { // input transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[1], sizeof(input));
        input.current_index = 1;
        input.last_index = 2;

        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    { // 0-value change transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        input.value = 0;
        input.current_index = 2;
        input.last_index = 2;

        EXPECT_API_EXCEPTION(tx, input);
    }
}

static void test_invalid_value_transaction(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        input.value = MAX_IOTA_VALUE + 1;

        EXPECT_API_EXCEPTION(tx, input);
    }
}

static void test_not_set_seed(void **state)
{
    UNUSED(state);

    api_initialize();
    {
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));

        EXPECT_API_EXCEPTION(tx, input);
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_bundles_for_seed_from_file),
        cmocka_unit_test(test_invalid_input_address_index),
        cmocka_unit_test(test_invalid_tx_order),
        cmocka_unit_test(test_tx_index_twice),
        cmocka_unit_test(test_missing_meta_tx),
        cmocka_unit_test(test_missing_meta_tx_with_change),
        cmocka_unit_test(test_invalid_value_transaction),
        cmocka_unit_test(test_not_set_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
