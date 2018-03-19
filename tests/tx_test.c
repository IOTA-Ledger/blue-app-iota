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

static void test_valid_output_input_bundle(void **state)
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

        TX_OUTPUT output;
        output.finalized = true;
        strncpy(output.bundle_hash, PETER_VECTOR.bundle_hash, 81);

        EXPECT_API_DATA_OK(tx, input, output);
    }
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_valid_output_input_bundle)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
