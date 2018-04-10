#ifndef API_TESTS_H
#define API_TESTS_H

#include "test_vectors.h"

#define BIP32_PATH                                                             \
        {                                                                      \
                0x8000002C, 0x8000107A, 0x80000000, 0x00000000, 0x00000000     \
        }

#define EXPECT_API_OK(INS, input)                                              \
        ({                                                                     \
                expect_value(io_send, ptr, NULL);                              \
                expect_value(io_send, length, 0);                              \
                expect_value(io_send, sw, 0x9000);                             \
                api_ ## INS((unsigned char *)&input, sizeof(input));           \
        })

#define EXPECT_API_DATA_OK(INS, input, output)                                 \
        ({                                                                     \
                expect_memory(io_send, ptr, &output, sizeof(output));          \
                expect_value(io_send, length, sizeof(output));                 \
                expect_value(io_send, sw, 0x9000);                             \
                api_ ## INS((unsigned char *)&input, sizeof(input));           \
        })

#define EXPECT_API_EXCEPTION(INS, input)                                       \
        ({                                                                     \
                expect_assert_failure(api_ ## INS((unsigned char *)&input,     \
                                                  sizeof(input)));             \
        })

#define SEED_INIT(seed)                                                        \
        ({                                                                     \
                will_return (derive_seed_bip32,                                \
                            cast_ptr_to_largest_integral_type(seed));          \
        })

#endif
