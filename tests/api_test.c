#include "test_common.h"
#include "api.h"
#include "iota/conversion.h"

#define BIP32_PATH                                                             \
    {                                                                          \
        0x8000002C, 0x8000107A, 0x80000000, 0x00000000, 0x00000000             \
    }

void derive_seed_bip32(const unsigned int *path, unsigned int pathLength,
                       unsigned char *seed_bytes)
{
    check_expected(path);
    check_expected(pathLength);

    chars_to_bytes(mock_ptr_type(char *), seed_bytes, 81);
}

void io_send(const void *ptr, unsigned int length, unsigned short sw)
{
    check_expected(ptr);
    check_expected(length);
    check_expected(sw);
}

static void test_set_seed(void **state)
{
    UNUSED(state);

    static const unsigned int path[] = BIP32_PATH;

    expect_memory(derive_seed_bip32, path, path, sizeof(path));
    expect_value(derive_seed_bip32, pathLength, sizeof(path) / sizeof(path[0]));

    will_return_always(derive_seed_bip32,
                       cast_ptr_to_largest_integral_type(DEBUG_SEED));

    expect_value(io_send, ptr, NULL);
    expect_value(io_send, length, 0);
    expect_value(io_send, sw, 0x9000);

    SET_SEED_INPUT input = {BIP32_PATH, 2};

    api_initialize();
    api_set_seed((unsigned char *)&input, sizeof(input));
}

int main(void)
{
    const struct CMUnitTest tests[] = {cmocka_unit_test(test_set_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
