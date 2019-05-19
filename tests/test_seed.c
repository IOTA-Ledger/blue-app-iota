#include <stdint.h>
#include <string.h>
#include "api_tests.h"
#include "test_common.h"
#include "test_vectors.h"
#include "os.h"

static const uint32_t FULL_PATH[BIP32_PATH_LENGTH] = BIP32_PATH;

void expect_command_with_seed_ok(const void *seed_input, size_t seed_size);
void expect_command_with_seed_exception(const void *seed_input,
                                        size_t seed_size);

static inline void test_valid_security_levels(void **state)
{
    UNUSED(state);

    // always return the same seed
    will_return_always(seed_derive_from_bip32,
                       cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

    for (unsigned int security = 1; security <= 3; security++) {
        api_initialize();

        const SET_SEED_FIXED_INPUT input = {security, BIP32_PATH_LENGTH,
                                            BIP32_PATH};

        expect_memory(seed_derive_from_bip32, path, FULL_PATH,
                      sizeof(FULL_PATH));
        expect_value(seed_derive_from_bip32, pathLength, BIP32_PATH_LENGTH);

        expect_command_with_seed_ok(&input, sizeof(input));
    }
}

static inline void test_security_level_zero(void **state)
{
    UNUSED(state);

    api_initialize();

    const SET_SEED_FIXED_INPUT input = {0, BIP32_PATH_LENGTH, BIP32_PATH};
    expect_command_with_seed_exception(&input, sizeof(input));
}

static inline void test_security_level_four(void **state)
{
    UNUSED(state);

    api_initialize();

    const SET_SEED_FIXED_INPUT input = {4, BIP32_PATH_LENGTH, BIP32_PATH};
    expect_command_with_seed_exception(&input, sizeof(input));
}

static inline void test_valid_path_lengths(void **state)
{
    UNUSED(state);

    // always return the same seed
    will_return_always(seed_derive_from_bip32,
                       cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

    for (uint32_t length = 2; length <= 5; length++) {
        api_initialize();

        IO_STRUCT
        {
            uint8_t security;
            uint32_t bip32_path_length;
            uint32_t bip32_path[5];
        }
        input;
        input.security = 2;
        input.bip32_path_length = length;
        memcpy(&input.bip32_path, FULL_PATH, length * sizeof(uint32_t));

        expect_value(seed_derive_from_bip32, pathLength, length);
        expect_memory(seed_derive_from_bip32, path, input.bip32_path,
                      length * sizeof(input.bip32_path[0]));

        expect_command_with_seed_ok(&input,
                                    sizeof(SET_SEED_INPUT) +
                                        length * sizeof(input.bip32_path[0]));
    }
}

static inline void test_seed_recompute_on_path_length_change(void **state)
{
    UNUSED(state);

    // always return the same seed
    will_return_always(seed_derive_from_bip32,
                       cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

    api_initialize();
    {
        IO_STRUCT
        {
            uint8_t security;
            uint32_t bip32_path_length;
            uint32_t bip32_path[BIP32_PATH_MIN_LEN];
        }
        input = {};
        input.security = 2;
        input.bip32_path_length = BIP32_PATH_MIN_LEN;
        memcpy(&input.bip32_path, FULL_PATH,
               BIP32_PATH_MIN_LEN * sizeof(uint32_t));

        expect_memory(seed_derive_from_bip32, path, input.bip32_path,
                      sizeof(input.bip32_path));
        expect_value(seed_derive_from_bip32, pathLength,
                     input.bip32_path_length);

        expect_command_with_seed_ok(&input, sizeof(input));
    }
    {
        IO_STRUCT
        {
            uint8_t security;
            uint32_t bip32_path_length;
            uint32_t bip32_path[BIP32_PATH_MAX_LEN];
        }
        input = {};
        input.security = 2;
        input.bip32_path_length = BIP32_PATH_MAX_LEN;
        memcpy(&input.bip32_path, FULL_PATH,
               BIP32_PATH_MAX_LEN * sizeof(uint32_t));

        expect_memory(seed_derive_from_bip32, path, input.bip32_path,
                      sizeof(input.bip32_path));
        expect_value(seed_derive_from_bip32, pathLength,
                     input.bip32_path_length);

        expect_command_with_seed_ok(&input, sizeof(input));
    }
}

static inline void test_path_length_zero(void **state)
{
    UNUSED(state);

    api_initialize();

    IO_STRUCT
    {
        uint8_t security;
        uint32_t bip32_path_length;
        uint32_t bip32_path[0];
    }
    input = {2, 0, {}};
    expect_command_with_seed_exception(&input, sizeof(input));
}

static inline void test_path_length_six(void **state)
{
    UNUSED(state);

    api_initialize();

    IO_STRUCT
    {
        uint8_t security;
        uint32_t bip32_path_length;
        uint32_t bip32_path[6];
    }
    input = {2, 6, BIP32_PATH};
    expect_command_with_seed_exception(&input, sizeof(input));
}

static inline void test_seed_recompute_on_path_change(void **state)
{
    UNUSED(state);

    // always return the same seed
    will_return_always(seed_derive_from_bip32,
                       cast_ptr_to_largest_integral_type(PETER_VECTOR.seed));

    api_initialize();
    {
        SET_SEED_FIXED_INPUT input = {2, BIP32_PATH_LENGTH, BIP32_PATH};
        input.bip32_path[BIP32_PATH_LENGTH - 1] = 1;

        expect_memory(seed_derive_from_bip32, path, input.bip32_path,
                      sizeof(input.bip32_path));
        expect_value(seed_derive_from_bip32, pathLength,
                     input.bip32_path_length);

        expect_command_with_seed_ok(&input, sizeof(input));
    }
    {
        SET_SEED_FIXED_INPUT input = {2, BIP32_PATH_LENGTH, BIP32_PATH};
        input.bip32_path[BIP32_PATH_LENGTH - 1] = 2;

        expect_memory(seed_derive_from_bip32, path, input.bip32_path,
                      sizeof(input.bip32_path));
        expect_value(seed_derive_from_bip32, pathLength,
                     input.bip32_path_length);

        expect_command_with_seed_ok(&input, sizeof(input));
    }
}
