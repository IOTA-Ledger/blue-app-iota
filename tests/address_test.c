#include <setjmp.h>
#include <stdarg.h>
#include <stddef.h>
#include <cmocka.h>
#include "hash_file.h"
#include "test_constants.h"
#include "iota/addresses.h"
#include "iota/conversion.h"

#define MAX_SECURITY 3

static void seed_address(const char *seed_chars, uint32_t idx, uint8_t security,
                         char *address_chars)
{
    if (security > MAX_SECURITY || strlen(seed_chars) != NUM_HASH_TRYTES) {
        address_chars = "";
        return;
    }

    unsigned char seed_bytes[NUM_HASH_BYTES];
    chars_to_bytes(seed_chars, seed_bytes, NUM_HASH_TRYTES);

    unsigned char address_bytes[NUM_HASH_BYTES];
    get_public_addr(seed_bytes, idx, security, address_bytes);

    bytes_to_chars(address_bytes, address_chars, NUM_HASH_BYTES);
}

static void test_address(const char *seed, uint32_t idx, const char *expected)
{
    char output[MAX_NUM_TRYTES + 1];
    seed_address(seed, idx, 2, output);

    assert_string_equal(output, expected);
}

static void test_peter_seed(void **state)
{
    const char *seed =
        "PETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETERPETER"
        "PETERPETERR";
    const char *address[] = {
        "GUIOZDLUNXIGC9DCV9ZIEDBWRHHPILAYOYRVPTFPRAUZWLWDIXBSPCZGENHWDFHMQGCTOK"
        "MXITVVDMEFB",
        "MTPYSBLSL9HENRQKP9IPYYZTHEOECLXGYMZIYYUCYAPZYFAECX9ZSFOSFMDNYQAPYHVMTV"
        "UX9HNNUKOB9",
        "RKPTFXPROTSKXBKXLNSLOPOQGWASCLAECQQRWOKCJPNYHIFBUJXE9GHQJPIZHKYXXHC9BZ"
        "JPHAROKBGSD",
        "JYJFIYFNTDPTPGSJWAKUFK9OLTISGIKSQPTLIVRVHLHRRCSJCEFQRTGWVTBUQFXHFRZICM"
        "FDTPDKNKDFW",
        "WPF9CTKYVMEWXHXL9NKR9XON9TPBP9UNM9FPWBUISVSHNULLVHSU9PMBNNR9FSZUPCNBXG"
        "JWLGRKKSLHW"};

    uint32_t idx = (uintptr_t)*state;
    assert_in_range(idx, 0, sizeof(address) / sizeof(address[0]) - 1);

    test_address(seed, idx, address[idx]);
}

static void test_242trits_overflow_seed(void **state)
{
    const char *seed =
        "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
        "MMMMMMMMMMD";
    const char *address[] = {
        "VSSIPYVZYLPSMIB9HFPIM9ONASKJHETXRMJNIBRBZNJRWIMD9WVITVUC9FZHIZHGLBKAY9"
        "HAPGIZVQOQA",
        "MDWYEJJHJDIUVPKDY9EACGDJUOP9TLYDWETUBOYCBLYXYYYJYUXYUTCTPTDGJYFKMQMCNZ"
        "DQPTBE9AFIW",
        "BRCRVAASDLAZPTSHELUSJGNEWQSCLY9WHEARHXSJBQFNSMTES9OQULMXNNLWSZDE9K9HOW"
        "QHPMTVNHEMD",
        "BVTCAAJ9KVBYCDXUATNBFOIOVALZZJCVEMWSWHHKBLCQ9BXRFZPN9ER9WXUROWIJVRWREW"
        "JNAWTOGH9OW",
        "BPBX9PPTMYXBYSELTKUJVROKMFLCSQMCGKMMYMXSFPQNDWRQ9RWJBEEERFAO9ZHWGTKTWE"
        "BMCDBRUUAHC"};

    uint32_t idx = (uintptr_t)*state;
    assert_in_range(idx, 0, sizeof(address) / sizeof(address[0]) - 1);

    test_address(seed, idx, address[idx]);
}

static void test_243trits_overflow_seed(void **state)
{
    const char *seed =
        "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
        "MMMMMMMMMMM";
    const char *address[] = {
        "VSSIPYVZYLPSMIB9HFPIM9ONASKJHETXRMJNIBRBZNJRWIMD9WVITVUC9FZHIZHGLBKAY9"
        "HAPGIZVQOQA",
        "MDWYEJJHJDIUVPKDY9EACGDJUOP9TLYDWETUBOYCBLYXYYYJYUXYUTCTPTDGJYFKMQMCNZ"
        "DQPTBE9AFIW",
        "BRCRVAASDLAZPTSHELUSJGNEWQSCLY9WHEARHXSJBQFNSMTES9OQULMXNNLWSZDE9K9HOW"
        "QHPMTVNHEMD",
        "BVTCAAJ9KVBYCDXUATNBFOIOVALZZJCVEMWSWHHKBLCQ9BXRFZPN9ER9WXUROWIJVRWREW"
        "JNAWTOGH9OW",
        "BPBX9PPTMYXBYSELTKUJVROKMFLCSQMCGKMMYMXSFPQNDWRQ9RWJBEEERFAO9ZHWGTKTWE"
        "BMCDBRUUAHC"};

    uint32_t idx = (uintptr_t)*state;
    assert_in_range(idx, 0, sizeof(address) / sizeof(address[0]) - 1);

    test_address(seed, idx, address[idx]);
}

static void test_n_addresses_for_seed(void **state)
{
    (void)state; // unused

    void test(char *hashes[])
    {
        for (uint32_t idx = 0; idx < 4; idx++) {
            test_address(hashes[0], idx, hashes[idx + 1]);
        }
    }

    test_for_each_line("generateNAddressesForSeed", test);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test_prestate(test_peter_seed, (uint32_t *)0),
        cmocka_unit_test_prestate(test_peter_seed, (uint32_t *)1),
        cmocka_unit_test_prestate(test_peter_seed, (uint32_t *)2),
        cmocka_unit_test_prestate(test_peter_seed, (uint32_t *)3),
        cmocka_unit_test_prestate(test_peter_seed, (uint32_t *)4),
        cmocka_unit_test_prestate(test_242trits_overflow_seed, (uint32_t *)0),
        cmocka_unit_test_prestate(test_242trits_overflow_seed, (uint32_t *)1),
        cmocka_unit_test_prestate(test_242trits_overflow_seed, (uint32_t *)2),
        cmocka_unit_test_prestate(test_242trits_overflow_seed, (uint32_t *)3),
        cmocka_unit_test_prestate(test_242trits_overflow_seed, (uint32_t *)4),
        cmocka_unit_test_prestate(test_243trits_overflow_seed, (uint32_t *)0),
        cmocka_unit_test_prestate(test_243trits_overflow_seed, (uint32_t *)1),
        cmocka_unit_test_prestate(test_243trits_overflow_seed, (uint32_t *)2),
        cmocka_unit_test_prestate(test_243trits_overflow_seed, (uint32_t *)3),
        cmocka_unit_test_prestate(test_243trits_overflow_seed, (uint32_t *)4),
        cmocka_unit_test(test_n_addresses_for_seed)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
