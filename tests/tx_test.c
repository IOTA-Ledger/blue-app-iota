#include "test_common.h"
#include <string.h>
#include "transaction_file.h"
#include "api_tests.h"
#include "api.h"
#include "aux.h"
#include "iota/bundle.h"
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

    void test(char *seed, TX_INPUT *txs, char *bundle_hash,
              char signatures[][SIGNATURE_LENGTH])
    {
        UNUSED(signatures);

        test_valid_bundle(seed, 2, txs, 5, bundle_hash);
    }

    test_for_each_bundle("generateBundlesForSeed", test);
}

static void finalize_bundle(TX_INPUT *tx, int last_index)
{
    BUNDLE_CTX bundle;
    bundle_initialize(&bundle, last_index);

    for (int i = 0; i <= last_index; i++) {
        tx[i].current_index = i;
        tx[i].last_index = last_index;
        rpad_chars(tx[i].tag, tx[i].tag, 27);

        bundle_set_internal_address(&bundle, tx[i].address, tx[i].address_idx);
        bundle_add_tx(&bundle, tx[i].value, tx[i].tag, tx[i].timestamp);
    }

    uint32_t tag_increment = bundle_finalize(&bundle);

    char extended_tag[NUM_HASH_TRYTES];
    unsigned char tag_bytes[NUM_HASH_BYTES];
    rpad_chars(extended_tag, tx[0].tag, NUM_HASH_TRYTES);
    chars_to_bytes(extended_tag, tag_bytes, NUM_HASH_TRYTES);

    bytes_add_u32_mem(tag_bytes, tag_increment);
    bytes_to_chars(tag_bytes, extended_tag, NUM_HASH_BYTES);

    memcpy(tx[0].tag, extended_tag, 27);
}

/** Test that the bundle finalization above is correct. */
static void test_refinalize_valid_bundle(void **state)
{
    UNUSED(state);
    static const int security = 2;

    TX_INPUT txs[8];
    // output transaction
    memcpy(&txs[0], &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));
    txs[0].tag[0] = '\0';
    // input transaction
    memcpy(&txs[1], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));
    // meta transaction
    memcpy(&txs[2], &PETER_VECTOR.bundle[2], sizeof(TX_INPUT));

    // create a valid bundle
    finalize_bundle(txs, 2);

    test_valid_bundle(PETER_VECTOR.seed, security, txs, 2,
                      PETER_VECTOR.bundle_hash);
}

static void test_invalid_input_address_index(void **state)
{
    UNUSED(state);
    static const int security = 2;

    TX_INPUT txs[8];
    // output transaction
    memcpy(&txs[0], &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));
    // input transaction
    memcpy(&txs[1], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));
    txs[1].address_idx += 1;
    // meta transaction
    memcpy(&txs[2], &PETER_VECTOR.bundle[2], sizeof(TX_INPUT));
    txs[2].address_idx += 1;

    // create a valid bundle
    finalize_bundle(txs, 2);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[0], output);
    }
    { // input transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[1], output);
    }
    { // meta transaction
        EXPECT_API_EXCEPTION(tx, txs[2]);
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

    TX_INPUT txs[8];
    // output transaction
    memcpy(&txs[0], &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));
    // input transaction
    memcpy(&txs[1], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));

    // create a valid bundle
    finalize_bundle(txs, 1);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[0], output);
    }
    { // input transaction
        EXPECT_API_EXCEPTION(tx, txs[1]);
    }
}

static void test_missing_meta_tx_with_change(void **state)
{
    UNUSED(state);
    static const int security = 2;

    TX_INPUT txs[8];
    // output transaction
    memcpy(&txs[0], &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));
    // input transaction
    memcpy(&txs[1], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));
    // 0-value change transaction
    memcpy(&txs[2], &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));
    txs[2].value = 0;

    // create a valid bundle
    finalize_bundle(txs, 2);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[0], output);
    }
    { // input transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[1], output);
    }
    { // 0-value change transaction
        EXPECT_API_EXCEPTION(tx, txs[2]);
    }
}

static void test_meta_tx_without_reference(void **state)
{
    UNUSED(state);
    static const int security = 2;

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }

    int tx_index = 0;
    const int last_index = 2;
    { // output transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[0], sizeof(input));
        input.current_index = tx_index++;
        input.last_index = last_index;

        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, input, output);
    }
    { // meta transaction
        TX_INPUT input;
        memcpy(&input, &PETER_VECTOR.bundle[2], sizeof(input));
        input.current_index = tx_index++;
        input.last_index = last_index;

        EXPECT_API_EXCEPTION(tx, input);
    }
}

static void test_invalid_change_index(void **state)
{
    UNUSED(state);
    static const int security = 2;

    TX_INPUT txs[8];
    // output transaction
    memcpy(&txs[0], &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));
    txs[0].value -= 1;
    // input transaction
    memcpy(&txs[1], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));
    // meta transaction
    memcpy(&txs[2], &PETER_VECTOR.bundle[2], sizeof(TX_INPUT));
    // valued change transaction
    memcpy(&txs[3], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));
    memcpy(txs[3].address, PETER_VECTOR.addresses[security][3],
           NUM_HASH_TRYTES);
    txs[3].value = 1;
    txs[3].address_idx = 9999;

    // create a valid bundle
    finalize_bundle(txs, 3);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[0], output);
    }
    { // input transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[1], output);
    }
    { // meta transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[2], output);
    }
    { // 0-value change transaction
        EXPECT_API_EXCEPTION(tx, txs[3]);
    }
}

static void test_change_address_reuses_input(void **state)
{
    UNUSED(state);
    static const int security = 2;

    TX_INPUT txs[8];
    // output transaction
    memcpy(&txs[0], &PETER_VECTOR.bundle[0], sizeof(TX_INPUT));
    txs[0].value -= 1;
    // input transaction
    memcpy(&txs[1], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));
    // meta transaction
    memcpy(&txs[2], &PETER_VECTOR.bundle[2], sizeof(TX_INPUT));
    // valued change transaction to input address
    memcpy(&txs[3], &PETER_VECTOR.bundle[1], sizeof(TX_INPUT));
    txs[3].value = 1;

    // create a valid bundle
    finalize_bundle(txs, 3);

    SEED_INIT(PETER_VECTOR.seed);
    api_initialize();
    {
        SET_SEED_INPUT input = {BIP32_PATH, security};
        EXPECT_API_OK(set_seed, input);
    }
    { // output transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[0], output);
    }
    { // input transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[1], output);
    }
    { // meta transaction
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, txs[2], output);
    }
    { // 0-value change transaction
        EXPECT_API_EXCEPTION(tx, txs[3]);
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
        cmocka_unit_test(test_refinalize_valid_bundle),
        cmocka_unit_test(test_invalid_input_address_index),
        cmocka_unit_test(test_invalid_tx_order),
        cmocka_unit_test(test_tx_index_twice),
        cmocka_unit_test(test_missing_meta_tx),
        cmocka_unit_test(test_missing_meta_tx_with_change),
        cmocka_unit_test(test_meta_tx_without_reference),
        cmocka_unit_test(test_invalid_change_index),
        cmocka_unit_test(test_change_address_reuses_input),
        cmocka_unit_test(test_invalid_value_transaction),
        cmocka_unit_test(test_not_set_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
