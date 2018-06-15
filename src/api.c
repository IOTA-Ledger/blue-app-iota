#include "api.h"
#include "common.h"
#include "aux.h"
#include "iota_io.h"
#include "storage.h"
#include "ui/ui.h"
#include <string.h>

// iota-related stuff
#include "iota/conversion.h"
#include "iota/addresses.h"
#include "iota/bundle.h"
#include "iota/seed.h"
#include "iota/signing.h"

#define CHECK_STATE(state, INS)                                                \
    ((((state)&INS##_REQUIRED_STATE) != INS##_REQUIRED_STATE) ||               \
     ((state)&INS##_FORBIDDEN_STATE))

#define GET_INPUT(input_data, len, INS)                                        \
    ({                                                                         \
        if (!storage_is_initialized())                                         \
            THROW(SW_APP_NOT_INITIALIZED);                                     \
        if (CHECK_STATE(api.state_flags, INS))                                 \
            THROW(SW_COMMAND_INVALID_STATE);                                   \
        if (len < sizeof(INS##_INPUT))                                         \
            THROW(SW_INCORRECT_LENGTH);                                        \
        (INS##_INPUT *)(input_data);                                           \
    })

typedef struct API_CTX {

    unsigned char seed_bytes[NUM_HASH_BYTES];
    uint8_t security;

    unsigned int active_account; // currently active account number

    BUNDLE_CTX bundle_ctx;
    SIGNING_CTX signing_ctx;

    unsigned int state_flags;
} API_CTX;

// global variable storing all data needed across multiple api callss
API_CTX api;

void api_initialize()
{
    os_memset(&api, 0, sizeof(api));
}

/**
 *  Returns the account number corresponding to the path, or ACCOUNT_NUM
 *  if there is no corresponding account.
 */
static unsigned int get_path_account(unsigned int *path,
                                     unsigned int path_length)
{
    const unsigned int size = sizeof(ACCOUNT_BIP44_PATH) / sizeof(path[0]);
    if (path_length < size) {
        return ACCOUNT_NUM;
    }

    if (memcmp(path, ACCOUNT_BIP44_PATH, size * sizeof(path[0])) != 0) {
        return ACCOUNT_NUM;
    }

    // the last level of the path corresponds to the account
    return MIN(path[path_length - 1], ACCOUNT_NUM);
}

unsigned int api_set_seed(const unsigned char *input_data, unsigned int len)
{
    const SET_SEED_INPUT *input = GET_INPUT(input_data, len, SET_SEED);

    // setting the seed resets everything
    api_initialize();

    unsigned int path[BIP44_PATH_LEN];
    for (unsigned int i = 0; i < BIP44_PATH_LEN; i++) {
        if (!ASSIGN(path[i], input->bip44_path[i])) {
            // path overflow
            THROW(SW_COMMAND_INVALID_DATA);
        }
    }

    // save our currently active account
    api.active_account = get_path_account(path, BIP44_PATH_LEN);

    if (!ASSIGN(api.security, input->security) ||
        !IN_RANGE(api.security, MIN_SECURITY_LEVEL, MAX_SECURITY_LEVEL)) {
        // invalid security
        THROW(SW_COMMAND_INVALID_DATA);
    }

    derive_seed_bip32(path, BIP44_PATH_LEN, api.seed_bytes);

    api.state_flags |= SEED_SET;

    io_send(NULL, 0, SW_OK);
    return 0;
}

unsigned int api_pubkey(const unsigned char *input_data, unsigned int len)
{
    const PUBKEY_INPUT *input = GET_INPUT(input_data, len, PUBKEY);

    ui_display_calc();

    uint32_t address_idx;
    if (!ASSIGN(address_idx, input->address_idx)) {
        // address index overflow
        THROW(SW_COMMAND_INVALID_DATA);
    }

    unsigned char addr_bytes[48];
    get_public_addr(api.seed_bytes, address_idx, api.security, addr_bytes);

    PUBKEY_OUTPUT output;
    bytes_to_chars(addr_bytes, output.address, 48);

    ui_restore();

    io_send(&output, sizeof(output), SW_OK);
    return 0;
}

static void validate_tx_indices(const TX_INPUT *input)
{
    if (input->last_index != api.bundle_ctx.last_tx_index) {
        THROW(SW_TX_INVALID_INDEX);
    }
    if (input->current_index != api.bundle_ctx.current_tx_index) {
        THROW(SW_TX_INVALID_INDEX);
    }
}

static bool has_reference_transaction(uint8_t current_index)
{
    for (uint8_t i = 1; i < api.security; i++) {
        if (current_index < i || api.bundle_ctx.values[current_index - i] > 0) {
            return false;
        }
        if (bundle_is_input_tx(&api.bundle_ctx, current_index - i)) {
            return true;
        }
    }

    return false;
}

static void validate_tx_order(const TX_INPUT *input)
{
    const uint8_t current_index = api.bundle_ctx.current_tx_index;

    // the receiving addresses are only allowed first or last
    if (input->value > 0 && current_index > 0 &&
        current_index < api.bundle_ctx.last_tx_index) {
        THROW(SW_TX_INVALID_ORDER);
    }

    // a meta transaction must have a valid reference input transaction
    if (input->value == 0 && current_index > 0 &&
        current_index < api.bundle_ctx.last_tx_index) {
        // this must be a meta transaction
        if (!has_reference_transaction(current_index)) {
            THROW(SW_TX_INVALID_META);
        }
    }

    // the output address must come first and have positive value
    if (input->value <= 0 && current_index == 0) {
        THROW(SW_TX_INVALID_OUTPUT);
    }
}

NO_INLINE
static void add_tx(const TX_INPUT *input)
{
    if (!IN_RANGE(input->value, -MAX_IOTA_VALUE, MAX_IOTA_VALUE)) {
        // value out of bounds
        THROW(SW_COMMAND_INVALID_DATA);
    }

    char padded_tag[27];
    rpad_chars(padded_tag, input->tag, 27);
    if (!validate_chars(padded_tag, 27)) {
        // invalid tag
        THROW(SW_COMMAND_INVALID_DATA);
    }

    uint32_t timestamp;
    if (!ASSIGN(timestamp, input->timestamp)) {
        // timestamp overflow
        THROW(SW_COMMAND_INVALID_DATA);
    }

    bundle_add_tx(&api.bundle_ctx, input->value, padded_tag, timestamp);
}

static unsigned int get_change_tx_index(const BUNDLE_CTX *ctx)
{
    // there only is a proper change transaction if the value is positive
    if (ctx->values[ctx->last_tx_index] > 0) {
        return ctx->last_tx_index;
    }
    // return something out of bounds
    return ctx->last_tx_index + 1;
}

static bool change_index_ok(const BUNDLE_CTX *bundle)
{
    const unsigned int change_tx_index = get_change_tx_index(bundle);
    if (change_tx_index > bundle->last_tx_index) {
        return true;
    }

    unsigned int largest_index = bundle->indices[change_tx_index];

    // get the largest input index
    for (uint8_t i = 0; i <= bundle->last_tx_index; i++) {
        if (bundle_is_input_tx(bundle, i)) {
            largest_index = MAX(largest_index, bundle->indices[i]);
        }
    }

    // if we are on a valid account, take that seed index into account
    if (api.active_account < ACCOUNT_NUM) {
        // TODO: should there be a warning, if we are on an untracked account
        largest_index =
            MAX(largest_index, storage_get_seed_index(api.active_account));
    }

    // if change index is the largest index found, report it as ok
    return bundle->indices[change_tx_index] == largest_index;
}

NO_INLINE
static void io_send_unfinished_bundle()
{
    TX_OUTPUT output;
    os_memset(&output, 0, sizeof(TX_OUTPUT));
    output.finalized = false;

    io_send(&output, sizeof(output), SW_OK);
}

unsigned int api_tx(const unsigned char *input_data, unsigned int len)
{
    const TX_INPUT *input = GET_INPUT(input_data, len, TX);

    // TODO handle not receiving complete tx
    ui_display_recv();

    if ((api.state_flags & BUNDLE_INITIALIZED) == 0) {
        if (!IN_RANGE(input->last_index, 1, MAX_BUNDLE_INDEX_SZ - 1)) {
            // last index invalid range
            THROW(SW_COMMAND_INVALID_DATA);
        }
        bundle_initialize(&api.bundle_ctx, input->last_index);
        api.state_flags |= BUNDLE_INITIALIZED;
    }

    validate_tx_indices(input);
    validate_tx_order(input);

    if (!validate_chars(input->address, 81)) {
        // invalid address
        THROW(SW_COMMAND_INVALID_DATA);
    }

    // if input, or change address then set internal
    if (input->value < 0 ||
        api.bundle_ctx.current_tx_index == api.bundle_ctx.last_tx_index) {
        uint32_t address_idx;
        if (!ASSIGN(address_idx, input->address_idx)) {
            // index overflow
            THROW(SW_COMMAND_INVALID_DATA);
        }
        bundle_set_internal_address(&api.bundle_ctx, input->address,
                                    address_idx);
    }
    else {
        // ignore index completely
        bundle_set_external_address(&api.bundle_ctx, input->address);
    }

    add_tx(input);
    if (!bundle_has_open_txs(&api.bundle_ctx)) {

        // warn if the change index seems strange
        if (!change_index_ok(&api.bundle_ctx)) {
            ui_warn_change(&api.bundle_ctx);
            return IO_ASYNCH_REPLY;
        }

        // perfectly valid bundle
        ui_sign_tx(&api.bundle_ctx);
        return IO_ASYNCH_REPLY;
    }

    // as the bundle is not yet complete, we cannot compute the hash yet
    io_send_unfinished_bundle();
    return 0;
}

static bool next_signature_fragment(SIGNING_CTX *ctx, char *signature_fragment)
{
    unsigned char fragment_bytes[SIGNATURE_FRAGMENT_SIZE * 48];
    signing_next_fragment(ctx, fragment_bytes);

    bytes_to_chars(fragment_bytes, signature_fragment,
                   SIGNATURE_FRAGMENT_SIZE * 48);

    return signing_has_next_fragment(ctx);
}

static void update_seed_index(const BUNDLE_CTX *bundle)
{
    // this is only relevant if we are on a valid account
    if (api.active_account >= ACCOUNT_NUM) {
        return;
    }

    const unsigned int change_tx_index = get_change_tx_index(bundle);
    if (change_tx_index <= bundle->last_tx_index) {

        // only store the thee index, if it is larger
        const uint32_t change_key_index = bundle->indices[change_tx_index];
        if (change_key_index > storage_get_seed_index(api.active_account)) {
            storage_write_seed_index(api.active_account, change_key_index);
        }
    }
}

unsigned int api_sign(const unsigned char *input_data, unsigned int len)
{
    const SIGN_INPUT *input = GET_INPUT(input_data, len, SIGN);

    uint8_t tx_idx;
    if (!ASSIGN(tx_idx, input->transaction_idx) ||
        tx_idx > api.bundle_ctx.last_tx_index) {
        // index is out of bounds
        THROW(SW_COMMAND_INVALID_DATA);
    }

    if ((api.state_flags & SIGNING_STARTED) == 0) {
        // temporary screen during signing process
        ui_display_signing();

        if (api.bundle_ctx.values[tx_idx] >= 0) {
            // no input transaction
            THROW(SW_COMMAND_INVALID_DATA);
        }

        tryte_t normalized_hash[81];
        bundle_get_normalized_hash(&api.bundle_ctx, normalized_hash);

        signing_initialize(&api.signing_ctx, tx_idx, api.seed_bytes,
                           api.bundle_ctx.indices[tx_idx], api.security,
                           normalized_hash);

        api.state_flags |= SIGNING_STARTED;
    }
    else if (tx_idx != api.signing_ctx.tx_index) {
        // transaction changed after initialization
        THROW(SW_COMMAND_INVALID_DATA);
    }

    SIGN_OUTPUT output;
    output.fragments_remaining =
        next_signature_fragment(&api.signing_ctx, output.signature_fragment);

    io_send(&output, sizeof(output), SW_OK);

    if (!output.fragments_remaining) {

        // signing is finished
        api.state_flags &= ~SIGNING_STARTED;

        update_seed_index(&api.bundle_ctx);
        ui_display_welcome();
    }

    return 0;
}

unsigned int api_display_pubkey(const unsigned char *input_data,
                                unsigned int len)
{
    const PUBKEY_INPUT *input = GET_INPUT(input_data, len, PUBKEY);

    ui_display_calc();

    uint32_t address_idx;
    if (!ASSIGN(address_idx, input->address_idx)) {
        // address index overflow
        THROW(SW_COMMAND_INVALID_DATA);
    }

    unsigned char addr_bytes[48];
    get_public_addr(api.seed_bytes, address_idx, api.security, addr_bytes);

    ui_display_address(addr_bytes);

    io_send(NULL, 0, SW_OK);
    return 0;
}

NO_INLINE
static void io_send_bundle_hash(const BUNDLE_CTX *ctx)
{
    TX_OUTPUT output;
    output.finalized = true;
    bytes_to_chars(bundle_get_hash(ctx), output.bundle_hash, 48);

    io_send(&output, sizeof(output), SW_OK);
}

/** @brief This functions gets called, when bundle is accepted. */
void user_sign_tx()
{
    ui_display_calc();

    int retcode = bundle_validating_finalize(
        &api.bundle_ctx, get_change_tx_index(&api.bundle_ctx), api.seed_bytes,
        api.security);
    if (retcode != OK) {
        THROW(SW_BUNDLE_ERROR + retcode);
    }
    api.state_flags |= BUNDLE_FINALIZED;

    io_send_bundle_hash(&api.bundle_ctx);
}

/** @brief This functions gets called, when bundle is denied. */
void user_deny_tx()
{
    // reset the bundle
    os_memset(&api.bundle_ctx, 0, sizeof(BUNDLE_CTX));
    api.state_flags &= ~BUNDLE_INITIALIZED;

    io_send(NULL, 0, SW_SECURITY_STATUS_NOT_SATISFIED);
}

// get index of a given account
unsigned int api_read_indexes()
{
    if (!storage_is_initialized()) {
        THROW(SW_APP_NOT_INITIALIZED);
    }
    if (CHECK_STATE(api.state_flags, READ_INDEXES)) {
        THROW(SW_COMMAND_INVALID_STATE);
    }

    READ_INDEXES_OUTPUT output;
    for (unsigned int i = 0; i < ACCOUNT_NUM; i++) {
        output.seed_idx[i] = storage_get_seed_index(i);
    }

    io_send(&output, sizeof(output), SW_OK);
    return 0;
}

// the bundle indices are repurposed to temporarly store acount indices
// as UI is handled via callbacks, this info cannot be a stack variable
#if (MAX_BUNDLE_INDEX_SZ < ACCOUNT_NUM)
#error "Account seed indices must fit in the bundle indices"
#endif

// receive list of account indexes to write to ledger
unsigned int api_write_indexes(unsigned char *input_data, unsigned int len)
{
    const WRITE_INDEXES_INPUT *input =
        GET_INPUT(input_data, len, WRITE_INDEXES);

    // use a global variable to store the indices until they have been approved
    uint32_t *seed_indexes = api.bundle_ctx.indices;

    for (unsigned int i = 0; i < ACCOUNT_NUM; i++) {
        if (!ASSIGN(seed_indexes[i], input->seed_indexes[i])) {
            // seed index overflow
            THROW(SW_COMMAND_INVALID_DATA);
        }
    }

    ui_display_write_indexes(seed_indexes);
    return IO_ASYNCH_REPLY;
}

void write_indexes_approve(const uint32_t *seed_indexes)
{
    // write all seed indexes
    for (unsigned int i = 0; i < ACCOUNT_NUM; i++) {
        storage_write_seed_index(i, seed_indexes[i]);
    }

    ui_restore();
    io_send(NULL, 0, SW_OK);
}

void write_indexes_deny()
{
    ui_restore();
    io_send(NULL, 0, SW_SECURITY_STATUS_NOT_SATISFIED);
}

// get application configuration (flags and version)
unsigned int api_get_app_config()
{
    if (!storage_is_initialized()) {
        THROW(SW_APP_NOT_INITIALIZED);
    }
    if (CHECK_STATE(api.state_flags, GET_APP_CONFIG)) {
        THROW(SW_COMMAND_INVALID_STATE);
    }

	GET_APP_CONFIG_OUTPUT output;
    output.app_flags = 0; // no additional features supported
    output.app_version_major = APPVERSION_MAJOR;
    output.app_version_minor = APPVERSION_MINOR;
    output.app_version_patch = APPVERSION_PATCH;

    io_send(&output, sizeof(output), SW_OK);
    return 0;
}
