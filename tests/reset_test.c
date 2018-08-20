#include "test_common.h"
#include "api_tests.h"
#include "iota/conversion.h"
// include the c-file to be able to test static functions
#include "api.c"

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

static void assert_chars_equals_bytes(const char *a, const unsigned char *b)
{
    unsigned char bytes[NUM_HASH_BYTES] = {0};
    chars_to_bytes(a, bytes, NUM_HASH_TRYTES);
    assert_memory_equal(b, bytes, NUM_HASH_BYTES);
}

static void test_reset_initialized(void **state)
{
    UNUSED(state);

    api_initialize();

    unsigned char input[0]; // no input
    EXPECT_API_OK(reset, P1_RESET_EVERYTHING, input);

    assert_all_zero(&api, sizeof(api));
}

static void test_reset_seed(void **state)
{
    UNUSED(state);
    static const int security = 2;
    static const int idx = 0;

    api_initialize();
    EXPECT_API_SET_SEED_OK(PETER_VECTOR.seed, security);
    {
        unsigned char input[0]; // no input
        EXPECT_API_OK(reset, P1_RESET_EVERYTHING, input);
    }

    // internally everything should be zero
    assert_all_zero(&api, sizeof(api));

    {
        PUBKEY_INPUT input = {idx};
        EXPECT_API_EXCEPTION(pubkey, 0, input);
    }
}

static void test_reset_partial_path(void **state)
{
    UNUSED(state);
    static const int security = 2;

    api_initialize();
    EXPECT_API_SET_SEED_OK(PETER_VECTOR.seed, security);
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.bundle, 2, PETER_VECTOR.bundle_hash);
    {
        unsigned char input[0]; // no input
        EXPECT_API_OK(reset, P1_RESET_PARTIAL, input);
    }

    // internally the path should not have changed
    static const unsigned int path[BIP32_PATH_LENGTH] = BIP32_PATH;
    assert_memory_equal(api.bip32_path, path, sizeof(path));
}

static void test_reset_partial_pubkey(void **state)
{
    UNUSED(state);
    static const int security = 2;

    api_initialize();
    EXPECT_API_SET_SEED_OK(PETER_VECTOR.seed, security);
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.bundle, 2, PETER_VECTOR.bundle_hash);
    {
        unsigned char input[0]; // no input
        EXPECT_API_OK(reset, P1_RESET_PARTIAL, input);
    }

    // same address should be returned
    {
        PUBKEY_INPUT input = {0};
        PUBKEY_OUTPUT output;
        strncpy(output.address, PETER_VECTOR.addresses[security][0],
                NUM_HASH_TRYTES);

        EXPECT_API_DATA_OK(pubkey, 0, input, output);
    }
}

static void test_reset_partial_bundle(void **state)
{
    UNUSED(state);
    static const int security = 2;

    api_initialize();
    EXPECT_API_SET_SEED_OK(PETER_VECTOR.seed, security);
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.bundle, 2, PETER_VECTOR.bundle_hash);
    {
        unsigned char input[0]; // no input
        EXPECT_API_OK(reset, P1_RESET_PARTIAL, input);
    }

    // internally the seed should not have changed
    assert_chars_equals_bytes(PETER_VECTOR.seed, api.seed_bytes);

    // we can set a new bundle
    EXPECT_API_SET_BUNDLE_OK(PETER_VECTOR.bundle, 2, PETER_VECTOR.bundle_hash);
}

static void test_reset_partial_no_seed(void **state)
{
    UNUSED(state);

    api_initialize();

    unsigned char input[0]; // no input
    EXPECT_API_EXCEPTION(reset, P1_RESET_PARTIAL, input);
}

static void test_invalid_p1(void **state)
{
    UNUSED(state);

    api_initialize();

    unsigned char input[0]; // no input
    EXPECT_API_EXCEPTION(reset, 0xFF, input);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_reset_initialized),
        cmocka_unit_test(test_reset_seed),
        cmocka_unit_test(test_reset_partial_path),
        cmocka_unit_test(test_reset_partial_pubkey),
        cmocka_unit_test(test_reset_partial_bundle),
        cmocka_unit_test(test_reset_partial_no_seed),
        cmocka_unit_test(test_invalid_p1)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
