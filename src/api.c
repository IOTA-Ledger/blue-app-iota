#include "api.h"
#include <string.h>
#include "iota/addresses.h"
#include "iota/bundle.h"
#include "iota/conversion.h"
#include "iota/iota_types.h"
#include "iota/seed.h"
#include "iota/signing.h"
#include "iota_io.h"
#include "macros.h"
#include "misc.h"
#include "os.h"
#include "ui/ui.h"

// ms until timeout; must not be > 1min to avoid locking before timeout
#define TIMEOUT_MS 3000               // 3 sec
#define TIMEOUT_USER_BUNDLE_MS 100000 // 100 sec

#define CHECK_STATE(state, INS)                                                \
    ((((state)&INS##_REQUIRED_STATE) != INS##_REQUIRED_STATE) ||               \
     ((state)&INS##_FORBIDDEN_STATE))

#define GET_INPUT(input_data, len, INS)                                        \
    ({                                                                         \
        if ((len) < sizeof(INS##_INPUT))                                       \
            THROW(SW_INCORRECT_LENGTH);                                        \
        if (CHECK_STATE(api.state_flags, INS))                                 \
            THROW(SW_COMMAND_NOT_ALLOWED);                                     \
        (INS##_INPUT *)(input_data);                                           \
    })

/// global variable storing all data needed across multiple api calls
API_CTX api;

void api_initialize()
{
    MEMCLEAR(api);
}

/** @brief Clear bundle and signature data and reset state. */
static void reset_bundle(void)
{
    MEMCLEAR(api.ctx.bundle);
    MEMCLEAR(api.ctx.signing);
    api.state_flags = 0;
}

/** @brief Checks whether the given path differes from the stored path. */
static bool bip32_path_changed(const SET_SEED_INPUT *seed)
{
    if (api.bip32_path_length != seed->bip32_path_length) {
        return true;
    }

    for (unsigned int i = 0; i < seed->bip32_path_length; i++) {
        if (api.bip32_path[i] != seed->bip32_path[i]) {
            return true;
        }
    }

    return false;
}

/** @brief Extracts the bip32 info from the input data and computes a new seed
 *  if the path differs from the previous one.
 *  @return the number bytes read as part of the bip path input. */
static unsigned int update_seed(const unsigned char *input_data,
                                unsigned int len)
{
    const SET_SEED_INPUT *input = GET_INPUT(input_data, len, SET_SEED);

    uint8_t bip32_path_length;
    if (!ASSIGN(bip32_path_length, input->bip32_path_length) ||
        !IN_RANGE(bip32_path_length, BIP32_PATH_MIN_LEN, BIP32_PATH_MAX_LEN)) {
        THROW(SW_COMMAND_INVALID_DATA);
    }

    const unsigned int seed_struct_len =
        sizeof(SET_SEED_INPUT) +
        (bip32_path_length * sizeof(input->bip32_path[0]));
    if (len < seed_struct_len) {
        THROW(SW_INCORRECT_LENGTH);
    }

    uint8_t security;
    if (!ASSIGN(security, input->security) ||
        !IN_RANGE(security, MIN_SECURITY_LEVEL, MAX_SECURITY_LEVEL)) {
        // invalid security
        THROW(SW_COMMAND_INVALID_DATA);
    }

    if (api.security != security) {
        // security level can be changed independently of the seed
        api.security = security;

        // if security does get changed, reset bundle
        reset_bundle();
    }

    if (bip32_path_changed(input)) {
        // only compute the seed if the path was changed
        api.bip32_path_length = bip32_path_length;
        for (unsigned int i = 0; i < api.bip32_path_length; i++) {
            if (!ASSIGN(api.bip32_path[i], input->bip32_path[i])) {
                // path overflow
                THROW(SW_COMMAND_INVALID_DATA);
            }
        }

        seed_derive_from_bip32(api.bip32_path, api.bip32_path_length,
                               api.seed_bytes);

        // if the path was changed, reset bundle
        reset_bundle();
    }

    return seed_struct_len;
}

static bool display_address(uint8_t p1)
{
    switch (p1) {
    case P1_PUBKEY_NO_DISPLAY:
        return false;
    case P1_PUBKEY_DISPLAY:
        return true;
    default:
        // invalid p1 value
        THROW(SW_INCORRECT_P1P2);
    }
}

NO_INLINE
static void io_send_address(const unsigned char *addr_bytes)
{
    PUBKEY_OUTPUT output;
    bytes_to_chars(addr_bytes, output.address, NUM_HASH_BYTES);

    io_send(&output, sizeof(output), SW_OK);
}

unsigned int api_pubkey(uint8_t p1, const unsigned char *input_data,
                        unsigned int len)
{
    const bool display = display_address(p1);

    const unsigned int offset = update_seed(input_data, len);
    const PUBKEY_INPUT *input =
        GET_INPUT(input_data + offset, len - offset, PUBKEY);


    ui_display_getting_addr();

    unsigned char addr_bytes[NUM_HASH_BYTES];
    get_public_addr(api.seed_bytes, input->address_idx, api.security,
                    addr_bytes);

    if (display) {
        ui_display_address(addr_bytes);
    }
    else {
        ui_restore();
    }

    io_send_address(addr_bytes);
    return 0;
}

static bool first_tx(uint8_t p1)
{
    switch (p1) {
    case P1_FIRST:
        return true;
    case P1_MORE:
        return false;
    default:
        // invalid p1 value
        THROW(SW_INCORRECT_P1P2);
    }
}

static bool has_reference_transaction(uint8_t current_index)
{
    for (uint8_t i = 1; i < api.security; i++) {
        if (current_index < i ||
            api.ctx.bundle.bundle.values[current_index - i] > 0) {
            return false;
        }
        if (bundle_is_input_tx(&api.ctx.bundle, current_index - i)) {
            return true;
        }
    }

    return false;
}

static bool validate_tx_order(const TX_INPUT *input)
{
    const uint8_t current_index = api.ctx.bundle.bundle.current_tx_index;

    // the receiving addresses are only allowed first or last
    if (input->value > 0 && current_index > 0 &&
        current_index < api.ctx.bundle.bundle.last_tx_index) {
        PRINTF("tx_order; output_tx_index=%u\n", current_index);
        return false;
    }

    // the output address must come first and have positive value
    if (input->value <= 0 && current_index == 0) {
        PRINTF("tx_order; no output_tx\n");
        return false;
    }

    // a meta transaction must have a valid reference input transaction
    if (input->value == 0 && current_index > 0 &&
        current_index < api.ctx.bundle.bundle.last_tx_index) {
        // this must be a meta transaction
        if (!has_reference_transaction(current_index)) {
            PRINTF("tx_order; meta_tx_index=%u\n", current_index);
            return false;
        }
    }

    return true;
}

NO_INLINE
static void add_tx(const TX_INPUT *input)
{
    if (!IN_RANGE(input->value, -MAX_IOTA_VALUE, MAX_IOTA_VALUE)) {
        // value out of bounds
        THROW(SW_COMMAND_INVALID_DATA);
    }

    char padded_tag[NUM_TAG_TRYTES];
    rpad_chars(padded_tag, input->tag, NUM_TAG_TRYTES);
    if (!validate_chars(padded_tag, NUM_TAG_TRYTES)) {
        // invalid tag
        THROW(SW_COMMAND_INVALID_DATA);
    }

    bundle_add_tx(&api.ctx.bundle, input->value, padded_tag, input->timestamp);
}

static unsigned int get_change_tx_index(const BUNDLE_CTX *ctx)
{
    // there only is a proper change transaction if the value is positive
    if (ctx->bundle.values[ctx->bundle.last_tx_index] > 0) {
        return ctx->bundle.last_tx_index;
    }
    // return something out of bounds
    return ctx->bundle.last_tx_index + 1;
}

NO_INLINE
static void io_send_unfinished_bundle(void)
{
    TX_OUTPUT output;
    MEMCLEAR(output);
    output.finalized = false;

    io_send(&output, sizeof(output), SW_OK);
}

unsigned int api_tx(uint8_t p1, const unsigned char *input_data,
                    unsigned int len)
{
    const bool first = first_tx(p1);

    const TX_INPUT *input;
    if (first) {
        // the bundle must not be initialized
        if (api.state_flags & BUNDLE_INITIALIZED) {
            THROW(SW_COMMAND_NOT_ALLOWED);
        }

        const unsigned int offset = update_seed(input_data, len);
        input = GET_INPUT(input_data + offset, len - offset, TX);
    }
    else {
        // the bundle must be initialized
        if ((api.state_flags & BUNDLE_INITIALIZED) == 0) {
            THROW(SW_COMMAND_NOT_ALLOWED);
        }

        input = GET_INPUT(input_data, len, TX);
    }

    ui_display_recv();

    if (first) {
        if (!IN_RANGE(input->last_index, 1, MAX_BUNDLE_SIZE - 1)) {
            // last index invalid range
            THROW(SW_COMMAND_INVALID_DATA);
        }
        bundle_initialize(&api.ctx.bundle, input->last_index);
        api.state_flags |= BUNDLE_INITIALIZED;
    }
    else if (input->last_index != api.ctx.bundle.bundle.last_tx_index) {
        THROW(SW_COMMAND_INVALID_DATA);
    }

    if (input->current_index != api.ctx.bundle.bundle.current_tx_index) {
        // current index not as expected
        THROW(SW_COMMAND_INVALID_DATA);
    }
    if (!validate_tx_order(input)) {
        // transactions not in the expected order
        THROW(SW_COMMAND_INVALID_DATA);
    }

    if (!validate_chars(input->address, NUM_HASH_TRYTES)) {
        // invalid address
        THROW(SW_COMMAND_INVALID_DATA);
    }

    // if input, or change address then set internal
    if (input->value < 0 || api.ctx.bundle.bundle.current_tx_index ==
                                api.ctx.bundle.bundle.last_tx_index) {
        bundle_set_internal_address(&api.ctx.bundle, input->address,
                                    input->address_idx);
    }
    else {
        // ignore index completely
        bundle_set_external_address(&api.ctx.bundle, input->address);
    }

    add_tx(input);

    // perfectly valid bundle
    if (!bundle_has_open_txs(&api.ctx.bundle)) {
        // start interactive timeout
        io_timeout_set(TIMEOUT_USER_BUNDLE_MS);
        ui_sign_tx();
        return IO_ASYNCH_REPLY;
    }

    // set timeout for the next tx to receive
    io_timeout_set(TIMEOUT_MS);
    // as the bundle is not yet complete, we cannot compute the hash yet
    io_send_unfinished_bundle();

    return 0;
}

NO_INLINE
static void initialize_signing(void)
{
    tryte_t normalized_hash[NUM_HASH_TRYTES];
    bundle_get_normalized_hash(&api.ctx.bundle, normalized_hash);

    signing_initialize(&api.ctx.signing, &api.ctx.bundle.bundle,
                       normalized_hash);
}

static bool next_signature_fragment(SIGNING_CTX *ctx, char *signature_fragment)
{
    unsigned char fragment_bytes[SIGNATURE_FRAGMENT_SIZE * NUM_HASH_BYTES];
    signing_next_fragment(ctx, fragment_bytes);

    bytes_to_chars(fragment_bytes, signature_fragment,
                   SIGNATURE_FRAGMENT_SIZE * NUM_HASH_BYTES);

    return signing_has_next_fragment(ctx);
}

unsigned int api_sign(uint8_t p1, const unsigned char *input_data,
                      unsigned int len)
{
    UNUSED(p1);
    const SIGN_INPUT *input = GET_INPUT(input_data, len, SIGN);

    uint8_t tx_idx;
    if (!ASSIGN(tx_idx, input->transaction_idx) ||
        tx_idx > api.ctx.signing.bundle.last_tx_index) {
        // index is out of bounds
        THROW(SW_COMMAND_INVALID_DATA);
    }

    // initialize signing if necessary
    if ((api.state_flags & SIGNING_INITIALIZED) == 0) {
        initialize_signing();
        api.state_flags |= SIGNING_INITIALIZED;
    }

    if ((api.state_flags & SIGNING_STARTED) == 0) {
        if (api.ctx.signing.bundle.values[tx_idx] >= 0) {
            // no input transaction
            THROW(SW_COMMAND_INVALID_DATA);
        }

        signing_start(&api.ctx.signing, tx_idx, api.seed_bytes, api.security);

        api.state_flags |= SIGNING_STARTED;
    }
    else if (tx_idx != api.ctx.signing.tx_index) {
        // transaction changed after initialization
        THROW(SW_COMMAND_INVALID_DATA);
    }

    // temporary screen during signing process
    ui_display_signing();

    SIGN_OUTPUT output;
    output.fragments_remaining =
        next_signature_fragment(&api.ctx.signing, output.signature_fragment);

    // set timeout for the next fragment to be querried
    if (output.fragments_remaining) {
        io_timeout_set(TIMEOUT_MS);
    }
    io_send(&output, sizeof(output), SW_OK);

    // signing is finished
    if (!output.fragments_remaining) {
        api.state_flags &= ~SIGNING_STARTED;
        io_timeout_reset();
        ui_display_main_menu();
    }

    return 0;
}

NO_INLINE
static void io_send_bundle_hash(const BUNDLE_CTX *ctx)
{
    TX_OUTPUT output;
    output.finalized = true;
    bytes_to_chars(bundle_get_hash(ctx), output.bundle_hash, NUM_HASH_BYTES);

    io_send(&output, sizeof(output), SW_OK);
}

void user_sign_tx()
{
    io_timeout_reset();
    ui_display_validating();

    const int retcode = bundle_validating_finalize(
        &api.ctx.bundle, get_change_tx_index(&api.ctx.bundle), api.seed_bytes,
        api.security);
    if (retcode != OK) {
        PRINTF("invalidBundle; retcode=%i\n", retcode);
        THROW(SW_INVALID_BUNDLE + retcode);
    }
    api.state_flags |= BUNDLE_FINALIZED;

    io_send_bundle_hash(&api.ctx.bundle);
}

// get application configuration (flags and version)
unsigned int api_get_app_config(uint8_t p1, const unsigned char *input_data,
                                unsigned int len)
{
    UNUSED(p1);
    UNUSED(input_data);
    UNUSED(len);

    if (CHECK_STATE(api.state_flags, GET_APP_CONFIG)) {
        THROW(SW_COMMAND_NOT_ALLOWED);
    }

    GET_APP_CONFIG_OUTPUT output;
    output.app_max_bundle_size = MAX_BUNDLE_SIZE;
    output.app_flags = APP_FLAGS;
    output.app_version_major = APPVERSION_MAJOR;
    output.app_version_minor = APPVERSION_MINOR;
    output.app_version_patch = APPVERSION_PATCH;

    io_send(&output, sizeof(output), SW_OK);
    return 0;
}

unsigned int api_reset(uint8_t p1, const unsigned char *input_data,
                       unsigned int len)
{
    UNUSED(p1);
    UNUSED(input_data);
    UNUSED(len);

    if (CHECK_STATE(api.state_flags, RESET)) {
        THROW(SW_COMMAND_NOT_ALLOWED);
    }

    reset_bundle();
    ui_reset();
    io_timeout_reset();

    io_send(NULL, 0, SW_OK);
    return 0;
}
