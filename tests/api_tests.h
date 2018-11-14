#ifndef API_TESTS_H
#define API_TESTS_H

#include "test_common.h"
#include "api.h"
#include "seed.h"

#define BIP32_PATH_LENGTH 5
#define BIP32_PATH                                                             \
    {                                                                          \
        0x8000002C, 0x8000107A, 0x80000000, 0x00000000, 0x00000000             \
    }

#define EXPECT_API_OK(INS, p1, input)                                          \
    ({                                                                         \
        expect_value(io_send, ptr, NULL);                                      \
        expect_value(io_send, length, 0);                                      \
        expect_value(io_send, sw, 0x9000);                                     \
        api_##INS(p1, (unsigned char *)&input, sizeof(input));                 \
    })

#define EXPECT_API_DATA_OK(INS, p1, input, output)                             \
    ({                                                                         \
        expect_memory(io_send, ptr, &output, sizeof(output));                  \
        expect_value(io_send, length, sizeof(output));                         \
        expect_value(io_send, sw, 0x9000);                                     \
        api_##INS(p1, (unsigned char *)&input, sizeof(input));                 \
    })

#define EXPECT_API_EXCEPTION(INS, p1, input)                                   \
    ({                                                                         \
        expect_assert_failure(                                                 \
            api_##INS(p1, (unsigned char *)&input, sizeof(input)));            \
    })

// Create struct with a fixed path length
typedef IO_STRUCT SET_SEED_FIXED_INPUT
{
    uint8_t security;
    uint32_t bip32_path_length;
    uint32_t bip32_path[BIP32_PATH_LENGTH];
}
SET_SEED_FIXED_INPUT;

// Pubkey input struct with seed input
typedef IO_STRUCT SET_SEED_PUBKEY_INPUT
{
    SET_SEED_FIXED_INPUT set_seed;
    PUBKEY_INPUT pubkey;
}
SET_SEED_PUBKEY_INPUT;

static inline void SET_SEED_IN_INPUT(const char *seed, int security,
                                     unsigned char *input)
{
    will_return(seed_derive_from_bip32,
                cast_ptr_to_largest_integral_type(seed));

    SET_SEED_FIXED_INPUT seed_input = {security, BIP32_PATH_LENGTH, BIP32_PATH};
    memcpy(input, &seed_input, sizeof(seed_input));
}

static inline void EXPECT_API_SET_BUNDLE_OK(const TX_INPUT *tx, int last_index,
                                            const char *bundle_hash)
{
    for (int i = 0; i < last_index; i++) {
        TX_OUTPUT output = {0};
        output.finalized = false;

        EXPECT_API_DATA_OK(tx, 0, tx[i], output);
    }
    {
        TX_OUTPUT output = {0};
        strncpy(output.bundle_hash, bundle_hash, 81);
        output.finalized = true;

        EXPECT_API_DATA_OK(tx, 0, tx[last_index], output);
    }
}

#endif
