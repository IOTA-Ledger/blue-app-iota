#include <stdint.h>
#include "test_common.h"
#include "os.h"
#include "iota/iota_types.h"
// include the c-file to be able to test static functions
#include "iota/conversion.c"
#include "iota/bundle.c"

// Hash relevant content of one transaction
typedef struct TX_ENTRY {
    char address[81];
    int64_t value;
    char tag[27];
    uint32_t timestamp;
} TX_ENTRY;

static void bytes_to_trits(const unsigned char *bytes, trit_t *trits)
{
    tryte_t trytes[NUM_HASH_TRYTES];
    bytes_to_trytes(bytes, trytes);
    trytes_to_trits(trytes, trits, NUM_HASH_TRYTES);
}

static void increment_trit_aera(trit_t *trits, unsigned int start_trit,
                                unsigned int num_trits)
{
    trit_t *trit = trits + start_trit;

    for (unsigned int i = 0; i < num_trits; i++, trit++) {
        if (*trit < MAX_TRIT_VALUE) {
            *trit += 1;
            break;
        }
        *trit = MIN_TRIT_VALUE;
    }
}

static void bytes_increment_trit_area_81(unsigned char *bytes)
{
    trit_t trits[NUM_HASH_TRITS];
    bytes_to_trits(bytes, trits);
    increment_trit_aera(trits, 81, 81);
    trits_to_bytes(trits, bytes);
}

/** @brief Creates a bundle based on transaction provided the simplified
 * TX_ENTRY structure.
 *  @param txs all transactions
 *  @param num_txs number of elements in the transaction array
 *  @param bundle_ctx target bundle
 */
static void bundle_create(const TX_ENTRY *txs, unsigned int num_txs,
                          BUNDLE_CTX *bundle_ctx)
{
    bundle_initialize(bundle_ctx, num_txs - 1);

    for (unsigned int i = 0; i < num_txs; i++) {
        assert_int_equal(strnlen(txs[i].address, 81), 81);
        bundle_set_external_address(bundle_ctx, txs[i].address);

        assert_int_equal(strnlen(txs[i].tag, 27), 27);
        bundle_add_tx(bundle_ctx, txs[i].value, txs[i].tag, txs[i].timestamp);
    }
}

/** @brief Finalizes the bundle by computing the valid bundle hash.
 *  @param ctx the bundle context used.
 *  @return tag increment of the first transaction that was necessary to
 *          generate a valid bundle
 */
static unsigned int bundle_finalize(BUNDLE_CTX *ctx)
{
    unsigned int tag_increment = 0;

    if (bundle_has_open_txs(ctx)) {
        THROW(INVALID_STATE);
    }

    compute_hash(ctx);
    while (!validate_hash(ctx)) {
        // increment the tag of the first transaction
        bytes_increment_trit_area_81(ctx->bytes + NUM_HASH_BYTES);
        compute_hash(ctx);
        tag_increment++;
    }

    // the not normalized hash is already in the result pointer
    return tag_increment;
}
