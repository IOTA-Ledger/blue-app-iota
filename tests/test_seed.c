#include "test_seed.h"
#include "iota/conversion.h"

void EXPECT_COMMAND_OK(const SET_SEED_FIXED_INPUT *seed_input);
void EXPECT_COMMAND_EXCEPTION(const SET_SEED_FIXED_INPUT *seed_input);

void test_valid_security_levels(void **state)
{
    UNUSED(state);

    static const unsigned int path[] = BIP32_PATH;

    api_initialize();

    // the seed should only be computed once
    expect_memory(seed_derive_from_bip32, path, path, sizeof(path));
    expect_value(seed_derive_from_bip32, pathLength, BIP32_PATH_LENGTH);

    will_return(seed_derive_from_bip32,
                cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

    for (unsigned int security = 1; security <= 3; security++) {
        SET_SEED_FIXED_INPUT input = {security, BIP32_PATH_LENGTH, BIP32_PATH};
        EXPECT_COMMAND_OK(&input);
    }
}

void test_security_level_zero(void **state)
{
    UNUSED(state);

    SET_SEED_FIXED_INPUT input = {0, BIP32_PATH_LENGTH, BIP32_PATH};

    api_initialize();
    EXPECT_COMMAND_EXCEPTION(&input);
}

void test_security_level_four(void **state)
{
    UNUSED(state);

    SET_SEED_FIXED_INPUT input = {4, BIP32_PATH_LENGTH, BIP32_PATH};

    api_initialize();
    EXPECT_COMMAND_EXCEPTION(&input);
}

void test_valid_path_lengths(void **state)
{
    UNUSED(state);

    SET_SEED_FIXED_INPUT input = {2, 0, BIP32_PATH};

    api_initialize();
    for (uint32_t length = 2; length <= 5; length++) {

        // the seed should be recomputed every time
        expect_value(seed_derive_from_bip32, pathLength, length);
        expect_memory(seed_derive_from_bip32, path, input.bip32_path,
                      length * sizeof(input.bip32_path[0]));

        will_return(seed_derive_from_bip32,
                    cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

        input.bip32_path_length = length;
        EXPECT_COMMAND_OK(&input);
    }
}

void test_path_length_zero(void **state)
{
    UNUSED(state);

    SET_SEED_FIXED_INPUT input = {1, 0, BIP32_PATH};

    api_initialize();
    EXPECT_COMMAND_EXCEPTION(&input);
}

void test_path_length_six(void **state)
{
    UNUSED(state);

    SET_SEED_FIXED_INPUT input = {1, 6, BIP32_PATH};

    api_initialize();
    EXPECT_COMMAND_EXCEPTION(&input);
}
