#include "test_common.h"
#include "iota/conversion.h"
// include the c-file to be able to test static functions
#include "iota/bundle.c"

static void test_increment_tag(void **state)
{
    UNUSED(state);

    const int64_t value = -1;
    const uint32_t timestamp = 0;
    const uint32_t current_index = 0;
    const uint32_t last_index = 1;
    char tag[] = "999999999999999999999999999";

    unsigned char bytes[NUM_HASH_BYTES];
    create_bundle_bytes(value, tag, timestamp, current_index, last_index,
                        bytes);
    bytes_increment_trit_area_81(bytes);

    // incrementing the 82nd trit should be equivalent to incrementing the tag
    tag[0] = 'A';

    unsigned char exp_bytes[NUM_HASH_BYTES];
    create_bundle_bytes(value, tag, timestamp, current_index, last_index,
                        exp_bytes);

    assert_memory_equal(bytes, exp_bytes, NUM_HASH_BYTES);
}

static void test_normalize_hash(void **state)
{
    UNUSED(state);

    tryte_t hash_trytes[NUM_HASH_TRYTES] = {0};

    // test_hash is randomly generated using KeePass. Not an actual hash (but
    // shoudln't matter).
    char test_hash[] = "IGSCBIJOFWHFLSXJV9ZENNTNWTEWGFMZKT9UBWRHVOJRLULQELXWS9Z"
                       "HPGVBUTAVMCPHIMRWSHWMSYAKP";
    chars_to_trytes(test_hash, hash_trytes, NUM_HASH_TRYTES);
    normalize_hash(hash_trytes);

    // exp_trytes is taken directly from iota.lib.js
    tryte_t exp_trytes[NUM_HASH_TRYTES] = {
        13,  9,  -8, 3,  2,  9,   10,  -12, 6,  -4,  8,   6,  12, -8,
        -3,  10, -5, 0,  -1, 5,   -13, -13, -7, -13, -4,  -7, 5,  -13,
        6,   6,  13, -1, 11, -7,  0,   -6,  2,  -4,  -9,  8,  -5, -12,
        10,  -9, 12, -6, 12, -10, 5,   12,  -3, -4,  -8,  0,  -6, 8,
        -11, 7,  -5, 2,  -6, -7,  1,   -5,  13, 3,   -11, 8,  9,  13,
        -9,  -4, -8, 8,  -4, 13,  -8,  -2,  1,  11,  -11};
    assert_memory_equal(hash_trytes, exp_trytes, NUM_HASH_TRYTES);
}

static void test_normalize_hash_zero(void **state)
{
    UNUSED(state);

    tryte_t hash_trytes[NUM_HASH_TRYTES] = {0};
    normalize_hash(hash_trytes);

    // all zero hash is already normalized
    static const tryte_t exp_trytes[NUM_HASH_TRYTES] = {0};
    assert_memory_equal(hash_trytes, exp_trytes, NUM_HASH_TRYTES);
}

static void test_normalize_hash_one(void **state)
{
    UNUSED(state);

    tryte_t hash_trytes[NUM_HASH_TRYTES] = {MAX_TRYTE_VALUE, MAX_TRYTE_VALUE};
    normalize_hash(hash_trytes);

    // in the normalized hash the first tryte will be reduced to lowest value
    static const tryte_t exp_trytes[NUM_HASH_TRYTES] = {MIN_TRYTE_VALUE,
                                                        MAX_TRYTE_VALUE};
    assert_memory_equal(hash_trytes, exp_trytes, NUM_HASH_TRYTES);
}

static void test_normalize_hash_neg_one(void **state)
{
    UNUSED(state);

    tryte_t hash_trytes[NUM_HASH_TRYTES] = {MIN_TRYTE_VALUE, MIN_TRYTE_VALUE};
    normalize_hash(hash_trytes);

    // in the normalized hash the first tryte will be reduced to highest value
    static const tryte_t exp_trytes[NUM_HASH_TRYTES] = {MAX_TRYTE_VALUE,
                                                        MIN_TRYTE_VALUE};
    assert_memory_equal(hash_trytes, exp_trytes, NUM_HASH_TRYTES);
}

// Hash relevant content of one transaction
typedef struct TX_ENTRY {
    const char *address;
    const int64_t value;
    const char *tag;
    const uint32_t timestamp;
} TX_ENTRY;

static void construct_bundle(const TX_ENTRY *txs, unsigned int num_txs,
                             BUNDLE_CTX *bundle_ctx)
{
    bundle_initialize(bundle_ctx, num_txs - 1);

    for (unsigned int i = 0; i < num_txs; i++) {
        assert_int_equal(strlen(txs[i].address), 81);
        bundle_set_external_address(bundle_ctx, txs[i].address);

        assert_int_equal(strlen(txs[i].tag), 27);
        bundle_add_tx(bundle_ctx, txs[i].value, txs[i].tag, txs[i].timestamp);
    }
}

static void test_empty_bundle(void **state)
{
    UNUSED(state);

    BUNDLE_CTX bundle_ctx;
    expect_assert_failure(construct_bundle(NULL, 0, &bundle_ctx));
}

static void test_one_tx_bundle(void **state)
{
    UNUSED(state);

    const TX_ENTRY txs[] = {
        {"LHWIEGUADQXNMRKQSBDJOAFMBIFKHHZXYEFOU9WFRMBGODSNJAPGFHOUOSGDICSFVA9K"
         "OUPPCMLAHPHAW",
         10, "999999999999999999999999999", 0}};

    BUNDLE_CTX bundle_ctx;
    expect_assert_failure(
        construct_bundle(txs, sizeof(txs) / sizeof(TX_ENTRY), &bundle_ctx));
}

static void test_bundle_hash(void **state)
{
    UNUSED(state);

    const TX_ENTRY txs[] = {
        {"LHWIEGUADQXNMRKQSBDJOAFMBIFKHHZXYEFOU9WFRMBGODSNJAPGFHOUOSGDICSFVA9K"
         "OUPPCMLAHPHAW",
         10, "ZOA999999999999999999999999", 0},
        {"WLRSPFNMBJRWS9DFXCGIROJCZCPJQG9PMOO9CUZNQXTLLQAYXGXT9LECGEQ9MQIWIBGQ"
         "REFHULPOETHNZ",
         -5, "999999999999999999999999999", 0},
        {"UMDTJXHIFVYVCHXKZNMQWMDHNLVQNMJMRULXUFRLNFVVUMKYZOAETVQOWSDUAKTXVNDS"
         "VAJCASTRQNV9D",
         -5, "999999999999999999999999999", 0}};
    const char exp_hash[] = "VMSEGGHKOUYTE9JNZEQIZWFUYHATWEVXAIJNPG9EDPCQRFAFWP"
                            "CVGHYJDJWXAFNWRGUUPULXOCEJDBUVD";

    BUNDLE_CTX bundle_ctx;
    construct_bundle(txs, sizeof(txs) / sizeof(TX_ENTRY), &bundle_ctx);

    compute_hash(&bundle_ctx);

    char hash_chars[NUM_HASH_TRYTES + 1];
    bytes_to_chars(bundle_get_hash(&bundle_ctx), hash_chars, NUM_HASH_BYTES);
    // make null-terminated
    hash_chars[NUM_HASH_TRYTES] = '\0';

    assert_string_equal(hash_chars, exp_hash);
}

static void test_bundle_finalize(void **state)
{
    UNUSED(state);

    const TX_ENTRY txs[] = {
        {"LHWIEGUADQXNMRKQSBDJOAFMBIFKHHZXYEFOU9WFRMBGODSNJAPGFHOUOSGDICSFVA9K"
         "OUPPCMLAHPHAW",
         10, "999999999999999999999999999", 0},
        {"WLRSPFNMBJRWS9DFXCGIROJCZCPJQG9PMOO9CUZNQXTLLQAYXGXT9LECGEQ9MQIWIBGQ"
         "REFHULPOETHNZ",
         -5, "999999999999999999999999999", 0},
        {"UMDTJXHIFVYVCHXKZNMQWMDHNLVQNMJMRULXUFRLNFVVUMKYZOAETVQOWSDUAKTXVNDS"
         "VAJCASTRQNV9D",
         -5, "999999999999999999999999999", 0}};
    const char exp_hash[] = "VMSEGGHKOUYTE9JNZEQIZWFUYHATWEVXAIJNPG9EDPCQRFAFWP"
                            "CVGHYJDJWXAFNWRGUUPULXOCEJDBUVD";
    const unsigned int exp_tag_increment = 404;

    BUNDLE_CTX bundle_ctx;
    construct_bundle(txs, sizeof(txs) / sizeof(TX_ENTRY), &bundle_ctx);

    const uint32_t tag_increment = bundle_finalize(&bundle_ctx);
    assert_int_equal(tag_increment, exp_tag_increment);

    char hash_chars[NUM_HASH_TRYTES + 1];
    bytes_to_chars(bundle_get_hash(&bundle_ctx), hash_chars, NUM_HASH_BYTES);
    // make null-terminated
    hash_chars[NUM_HASH_TRYTES] = '\0';

    assert_string_equal(hash_chars, exp_hash);
}

static void test_max_value_txs_bundle_finalize(void **state)
{
    UNUSED(state);

    const TX_ENTRY txs[] = {
        {"UMDTJXHIFVYVCHXKZNMQWMDHNLVQNMJMRULXUFRLNFVVUMKYZOAETVQOWSDUAKTXVNDSV"
         "AJCASTRQNV9D",
         MAX_IOTA_VALUE, "MMMMMMMMMMMMMMMMMMMMMMMMMMM", 0xFFFFFFFF},
        {"WLRSPFNMBJRWS9DFXCGIROJCZCPJQG9PMOO9CUZNQXTLLQAYXGXT9LECGEQ9MQIWIBGQR"
         "EFHULPOETHNZ",
         -MAX_IOTA_VALUE, "MMMMMMMMMMMMMMMMMMMMMMMMMMM", 0xFFFFFFFF}};
    const char exp_hash[] = "9ZARQDSKQGVYEKJGVILRTTLBGCTYITLIYBDBGSFDUKWINXSHCP"
                            "AWNXSCIPVVDDFWYEHQITKGOUYGYAPRD";
    const unsigned int exp_tag_increment = 79;

    BUNDLE_CTX bundle_ctx;
    construct_bundle(txs, sizeof(txs) / sizeof(TX_ENTRY), &bundle_ctx);

    const uint32_t tag_increment = bundle_finalize(&bundle_ctx);
    assert_int_equal(tag_increment, exp_tag_increment);

    char hash_chars[NUM_HASH_TRYTES + 1];
    bytes_to_chars(bundle_get_hash(&bundle_ctx), hash_chars, NUM_HASH_BYTES);
    // make null-terminated
    hash_chars[NUM_HASH_TRYTES] = '\0';

    assert_string_equal(hash_chars, exp_hash);
}

int main(void)
{
    const struct CMUnitTest tests[] = {
        cmocka_unit_test(test_increment_tag),
        cmocka_unit_test(test_normalize_hash),
        cmocka_unit_test(test_normalize_hash_zero),
        cmocka_unit_test(test_normalize_hash_one),
        cmocka_unit_test(test_normalize_hash_neg_one),
        cmocka_unit_test(test_empty_bundle),
        cmocka_unit_test(test_one_tx_bundle),
        cmocka_unit_test(test_bundle_hash),
        cmocka_unit_test(test_bundle_finalize),
        cmocka_unit_test(test_max_value_txs_bundle_finalize)};

    return cmocka_run_group_tests(tests, NULL, NULL);
}
