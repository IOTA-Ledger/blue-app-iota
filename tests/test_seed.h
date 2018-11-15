#ifndef TEST_SEED_H
#define TEST_SEED_H

#include "test_common.h"
#include <string.h>
#include "api_tests.h"

void test_valid_security_levels(void **state);
void test_security_level_zero(void **state);
void test_security_level_four(void **state);
void test_valid_path_lengths(void **state);
void test_path_length_zero(void **state);
void test_path_length_six(void **state);

static inline void SET_SEED_IN_INPUT(const char *seed, int security,
                                     void *input)
{
    const SET_SEED_FIXED_INPUT seed_input = {security, BIP32_PATH_LENGTH,
                                             BIP32_PATH};

    expect_memory(seed_derive_from_bip32, path, seed_input.bip32_path,
                  sizeof(seed_input.bip32_path));
    expect_value(seed_derive_from_bip32, pathLength,
                 seed_input.bip32_path_length);

    will_return(seed_derive_from_bip32,
                cast_ptr_to_largest_integral_type(seed));

    memcpy(input, &seed_input, sizeof(seed_input));
}

#endif // TEST_SEED_H