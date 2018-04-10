#include "test_common.h"
#include <string.h>
#include "api_tests.h"
#include "api.h"
#include "iota/conversion.h"

void derive_seed_bip32(const unsigned int *path, unsigned int pathLength,
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

static void test_valid_security_levels(void **state)
{
    UNUSED(state);

    static const unsigned int path[] = BIP32_PATH;

    for (unsigned int security = 1; security <= 3; security++) {

        expect_memory(derive_seed_bip32, path, path, sizeof(path));
        expect_value(derive_seed_bip32, pathLength,
                     sizeof(path) / sizeof(path[0]));

        will_return(derive_seed_bip32,
                    cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

        SET_SEED_INPUT input = {BIP32_PATH, security};

        api_initialize();
        EXPECT_API_OK(set_seed, input);
    }
}

static void test_security_level_zero(void **state)
{
    UNUSED(state);

    SET_SEED_INPUT input = {BIP32_PATH, 0};

    api_initialize();
    EXPECT_API_EXCEPTION(set_seed, input);
}

static void test_security_level_four(void **state)
{
    UNUSED(state);

    SET_SEED_INPUT input = {BIP32_PATH, 4};

    api_initialize();
    EXPECT_API_EXCEPTION(set_seed, input);
}

static void test_invalid_negative_path(void **state)
{
    UNUSED(state);

    int64_t path[] = BIP32_PATH;
    path[4] = -1;

    SET_SEED_INPUT input;
    input.security = 1;
    memcpy(input.bip44_path, path, sizeof(path));

    api_initialize();
    EXPECT_API_EXCEPTION(set_seed, input);
}

static void test_path_overflow(void **state)
{
    UNUSED(state);

    int64_t path[] = BIP32_PATH;
    path[4] = UINT32_MAX + INT64_C(1);

    SET_SEED_INPUT input;
    input.security = 1;
    memcpy(input.bip44_path, path, sizeof(path));

    api_initialize();
    EXPECT_API_EXCEPTION(set_seed, input);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_valid_security_levels),
        cmocka_unit_test(test_security_level_zero),
        cmocka_unit_test(test_security_level_four),
        cmocka_unit_test(test_invalid_negative_path),
        cmocka_unit_test(test_path_overflow)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
