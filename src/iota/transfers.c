#include "transfers.h"

#include <string.h>
#include <assert.h>
// iota-related stuff
#include "conversion.h"
#include "addresses.h"
#include "bundle.h"
#include "signing.h"
#include "../aux.h"

#define ZERO_HASH                                                              \
    "999999999999999999999999999999999999999999999999999999999999999999999999" \
    "999999999"
#define ZERO_TAG "999999999999999999999999999"

typedef struct TX_OBJECT {
    char signatureMessageFragment[2187];
    char address[81];
    int64_t value;
    char obsoleteTag[27];
    uint32_t timestamp;
    uint32_t currentIndex;
    uint32_t lastIndex;
    char bundle[81];
    char trunkTransaction[81];
    char branchTransaction[81];
    char tag[27];
    uint32_t attachmentTimestamp;
    uint32_t attachmentTimestampLowerBound;
    uint32_t attachmentTimestampUpperBound;
    char nonce[27];
} TX_OBJECT;

static const TX_OBJECT DEFAULT_TX = {
    {0},       ZERO_HASH, 0,        ZERO_TAG, 0, 0, 0,       ZERO_HASH,
    ZERO_HASH, ZERO_HASH, ZERO_TAG, 0,        0, 0, ZERO_TAG};

static char *int64_to_chars(int64_t value, char *chars, unsigned int num_trytes)
{
    trit_t trits[num_trytes * 3];
    int64_to_trits(value, trits, num_trytes * 3);
    trits_to_chars(trits, chars, num_trytes * 3);

    return chars + num_trytes;
}

static void get_address(const unsigned char *seed_bytes, uint32_t idx,
                        unsigned int security, char *address)
{
    unsigned char bytes[48];
    get_public_addr(seed_bytes, idx, security, bytes);
    bytes_to_chars(bytes, address, 48);
}

static char *char_copy(char *destination, const char *source, unsigned int len)
{
    assert(strnlen(source, len) == len);
    memcpy(destination, source, len);

    return destination + len;
}

static void get_transaction_chars(const TX_OBJECT tx, char *transaction_chars)
{
    // just to make sure
    memset(transaction_chars, '\0', 2673);

    char *c = transaction_chars;

    c = char_copy(c, tx.signatureMessageFragment, 2187);
    c = char_copy(c, tx.address, 81);
    c = int64_to_chars(tx.value, c, 27);
    c = char_copy(c, tx.obsoleteTag, 27);
    c = int64_to_chars(tx.timestamp, c, 9);
    c = int64_to_chars(tx.currentIndex, c, 9);
    c = int64_to_chars(tx.lastIndex, c, 9);
    c = char_copy(c, tx.bundle, 81);
    c = char_copy(c, tx.trunkTransaction, 81);
    c = char_copy(c, tx.branchTransaction, 81);
    c = char_copy(c, tx.tag, 27);
    c = int64_to_chars(tx.attachmentTimestamp, c, 9);
    c = int64_to_chars(tx.attachmentTimestampLowerBound, c, 9);
    c = int64_to_chars(tx.attachmentTimestampUpperBound, c, 9);
    char_copy(c, tx.nonce, 27);
}

static void increment_obsolete_tag(unsigned int tag_increment, TX_OBJECT *tx)
{
    char extended_tag[81];
    unsigned char tag_bytes[48];
    rpad_chars(extended_tag, tx->obsoleteTag, NUM_HASH_TRYTES);
    chars_to_bytes(extended_tag, tag_bytes, NUM_HASH_TRYTES);

    bytes_add_u32_mem(tag_bytes, tag_increment);
    bytes_to_chars(tag_bytes, extended_tag, 48);

    // TODO: do we need to increment both? Probably only obsoleteTag...
    memcpy(tx->obsoleteTag, extended_tag, 27);
    memcpy(tx->tag, extended_tag, 27);
}

static void set_bundle_hash(const BUNDLE_CTX *bundle_ctx, TX_OBJECT *txs,
                            unsigned int num_txs)
{
    char bundle[81];
    bytes_to_chars(bundle_get_hash(bundle_ctx), bundle, 48);

    for (unsigned int i = 0; i < num_txs; i++) {
        memcpy(txs[i].bundle, bundle, 81);
    }
}

void prepare_transfers(char *seed, uint8_t security, TX_OUTPUT *outputs,
                       int num_outputs, TX_INPUT *inputs, int num_inputs,
                       char transaction_chars[][2673])
{
    // TODO use a proper timestamp
    const uint32_t timestamp = 0;
    const unsigned int num_txs = num_outputs + num_inputs * security;
    const unsigned int last_tx_index = num_txs - 1;

    unsigned char seed_bytes[48];
    chars_to_bytes(seed, seed_bytes, 81);

    // first create the transaction objects
    TX_OBJECT txs[num_txs];

    int idx = 0;
    for (unsigned int i = 0; i < num_outputs; i++) {

        // initialize with defaults
        memcpy(&txs[idx], &DEFAULT_TX, sizeof(TX_OBJECT));

        rpad_chars(txs[idx].signatureMessageFragment, outputs[i].message, 2187);
        memcpy(txs[idx].address, outputs[i].address, 81);
        txs[idx].value = outputs[i].value;
        rpad_chars(txs[idx].obsoleteTag, outputs[i].tag, 27);
        txs[idx].timestamp = timestamp;
        txs[idx].currentIndex = idx;
        txs[idx].lastIndex = last_tx_index;
        rpad_chars(txs[idx].tag, outputs[i].tag, 27);
        idx++;
    }

    for (unsigned int i = 0; i < num_inputs; i++) {

        // initialize with defaults
        memcpy(&txs[idx], &DEFAULT_TX, sizeof(TX_OBJECT));

        char *address = txs[idx].address;
        get_address(seed_bytes, inputs[i].key_index, security, address);
        txs[idx].value = -inputs[i].balance;
        txs[idx].timestamp = timestamp;
        txs[idx].currentIndex = idx;
        txs[idx].lastIndex = last_tx_index;
        idx++;

        // add meta transactions
        for (unsigned int j = 1; j < security; j++) {

            // initialize with defaults
            memcpy(&txs[idx], &DEFAULT_TX, sizeof(TX_OBJECT));

            memcpy(txs[idx].address, address, 81);
            txs[idx].value = 0;
            txs[idx].timestamp = timestamp;
            txs[idx].currentIndex = idx;
            txs[idx].lastIndex = last_tx_index;
            idx++;
        }
    }

    // create a secure bundle
    BUNDLE_CTX bundle_ctx;
    bundle_initialize(&bundle_ctx, last_tx_index);

    for (unsigned int i = 0; i < num_txs; i++) {
        bundle_set_external_address(&bundle_ctx, txs[i].address);
        bundle_add_tx(&bundle_ctx, txs[i].value, txs[i].tag, txs[i].timestamp);
    }

    uint32_t tag_increment = bundle_finalize(&bundle_ctx);

    // increment the tag in the first transaction object
    increment_obsolete_tag(tag_increment, &txs[0]);

    // set the bundle hash in all transaction objects
    set_bundle_hash(&bundle_ctx, txs, num_txs);

    // sign the inputs
    tryte_t normalized_bundle_hash[81];
    bundle_get_normalized_hash(&bundle_ctx, normalized_bundle_hash);

    for (unsigned int i = 0; i < num_inputs; i++) {
        SIGNING_CTX signing_ctx;
        signing_initialize(&signing_ctx, seed_bytes, inputs[i].key_index,
                           security, normalized_bundle_hash);
        unsigned int idx = num_outputs + i * security;

        // exactly one fragment for transaction including meta transactions
        for (unsigned int j = 0; j < security; j++) {

            unsigned char signature_bytes[27 * 48];
            signing_next_fragment(&signing_ctx, signature_bytes);
            bytes_to_chars(signature_bytes, txs[idx++].signatureMessageFragment,
                           27 * 48);
        }
    }

    // convert everything into trytes
    for (unsigned int i = 0; i < num_txs; i++) {
        get_transaction_chars(txs[i], transaction_chars[last_tx_index - i]);
    }
}
