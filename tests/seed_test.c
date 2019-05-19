#include <stddef.h>
#include "test_common.h"
#include "os.h"
#include "iota/iota_types.h"
#include "iota/conversion.h"
// include the c-file to be able to test static functions
#include "iota/seed.c"

static const char SEED_48_ZERO[] = "9NGBYIGJTUTYPACOHYWUGLWO9OASWBNWCIADXRWRSZP"
                                   "OSRYJTHDANSCVG9KULYERRBPBPLZHA9BEONKZW";
static const char SEED_64_ZERO[] = "NTFCXUIESZN9CYFGUQBVE9ZEGEA9IBKZNMISENTIFV9"
                                   "ILMDZJ9OTEEAKQJSNOUUBMHE9HQFBVRMGLRMGX";

static void assert_derived_seed_equal(const unsigned char *entropy,
                                      const unsigned int n,
                                      const char *expected_seed_chars)
{
    unsigned char seed_bytes[NUM_HASH_BYTES] = {};
    derive_seed_entropy(entropy, n, seed_bytes);

    char seed_chars[NUM_HASH_TRYTES + 1] = {};
    bytes_to_chars(seed_bytes, seed_chars, NUM_HASH_BYTES);
    seed_chars[NUM_HASH_TRYTES] = '\0';

    assert_string_equal(seed_chars, expected_seed_chars);
}

static void test_32_zero_entropy(void **state)
{
    UNUSED(state);

    unsigned char entropy[32] = {};
    unsigned char seed_bytes[NUM_HASH_BYTES] = {};
    expect_assert_failure(
        derive_seed_entropy(entropy, sizeof(entropy), seed_bytes));
}

static void test_48_zero_entropy(void **state)
{
    UNUSED(state);

    unsigned char entropy[48] = {};
    assert_derived_seed_equal(entropy, sizeof(entropy), SEED_48_ZERO);
}

static void test_64_zero_entropy(void **state)
{
    UNUSED(state);

    unsigned char entropy[64] = {};
    assert_derived_seed_equal(entropy, sizeof(entropy), SEED_64_ZERO);
}

int main(void)
{
    const struct CMUnitTest tests[] = {cmocka_unit_test(test_32_zero_entropy),
                                       cmocka_unit_test(test_48_zero_entropy),
                                       cmocka_unit_test(test_64_zero_entropy)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
