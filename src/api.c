#include "api.h"
#include "common.h"
#include "ui.h"
#include "aux.h"
#include "iota_io.h"

// iota-related stuff
#include "iota/conversion.h"
#include "iota/addresses.h"
#include "iota/bundle.h"
#include "iota/signing.h"

#define CHECK_STATE(state, INS)                                                \
    ((((state)&INS##_REQUIRED_STATE) != INS##_REQUIRED_STATE) ||               \
     ((state)&INS##_FORBIDDEN_STATE))

typedef struct API_CTX {

    unsigned char seed_bytes[48];
    uint8_t security; // use hard-coded security for now

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

unsigned int api_set_seed(unsigned char *input_data, unsigned int len)
{
    if(!flash_is_init()) {
        THROW(SW_APP_NOT_INITIALIZED);
    }
    if (CHECK_STATE(api.state_flags, SET_SEED)) {
        THROW(SW_COMMAND_INVALID_STATE);
    }
    if (len < sizeof(SET_SEED_INPUT)) {
        THROW(SW_WRONG_LENGTH);
    }
    const SET_SEED_INPUT *input = (SET_SEED_INPUT *)(input_data);

    // setting the seed resets everything
    api_initialize();

    unsigned int path[BIP44_PATH_LEN];
    for (unsigned int i = 0; i < BIP44_PATH_LEN; i++) {
        if (!ASSIGN(path[i], input->bip44_path[i])) {
            // path overflow
            THROW(INVALID_PARAMETER);
        }
    }

    if (!ASSIGN(api.security, input->security) ||
        !IN_RANGE(api.security, MIN_SECURITY_LEVEL, MAX_SECURITY_LEVEL)) {
        // invalid security
        THROW(INVALID_PARAMETER);
    }

    // we only care about privateKeyData and using this to
    // generate our iota seed
    unsigned char entropy[64];
    os_perso_derive_node_bip32(CX_CURVE_256K1, path, BIP44_PATH_LEN, entropy,
                               entropy + 32);
    get_seed(entropy, sizeof(entropy), api.seed_bytes);

    api.state_flags |= SEED_SET;

    io_send(NULL, 0, SW_OK);
    return 0;
}

unsigned int api_pubkey(unsigned char *input_data, unsigned int len)
{
    if(!flash_is_init()) {
        THROW(SW_APP_NOT_INITIALIZED);
    }
    if (CHECK_STATE(api.state_flags, PUBKEY)) {
        THROW(SW_COMMAND_INVALID_STATE);
    }
    if (len < sizeof(PUBKEY_INPUT)) {
        THROW(SW_WRONG_LENGTH);
    }
    
    ui_display_calc();
    
    const PUBKEY_INPUT *input = (PUBKEY_INPUT *)(input_data);

    uint32_t address_idx;
    if (!ASSIGN(address_idx, input->address_idx)) {
        // address index overflow
        THROW(INVALID_PARAMETER);
    }

    unsigned char addr_bytes[48];
    get_public_addr(api.seed_bytes, address_idx, api.security, addr_bytes);

    PUBKEY_OUTPUT output;
    bytes_to_chars(addr_bytes, output.address, 48);
    
    ui_restore();

    io_send(&output, sizeof(output), SW_OK);
    return 0;
}

unsigned int api_tx(unsigned char *input_data, unsigned int len)
{
    if(!flash_is_init()) {
        THROW(SW_APP_NOT_INITIALIZED);
    }
    if (CHECK_STATE(api.state_flags, TX)) {
        THROW(SW_COMMAND_INVALID_STATE);
    }
    if (len < sizeof(TX_INPUT)) {
        THROW(SW_WRONG_LENGTH);
    }
    
    // TODO handle not receiving complete tx
    ui_display_recv();
    
    TX_INPUT *input = (TX_INPUT *)(input_data);

    if ((api.state_flags & BUNDLE_INITIALIZED) == 0) {
        uint32_t last_index;
        if (!ASSIGN(last_index, input->last_index)) {
            // last index overflow
            THROW(INVALID_PARAMETER);
        }
        bundle_initialize(&api.bundle_ctx, last_index);
        api.state_flags |= BUNDLE_INITIALIZED;
    }

    // validate transaction indices
    if (input->last_index != api.bundle_ctx.last_index) {
        THROW(INVALID_STATE);
    }
    if (input->current_index != api.bundle_ctx.current_index) {
        THROW(INVALID_STATE);
    }

    if (!validate_chars(input->address, 81, false)) {
        // invalid address
        THROW(INVALID_PARAMETER);
    }
    if (input->value < 0) {
        uint32_t address_idx;
        if (!ASSIGN(address_idx, input->address_idx)) {
            // index overflow
            THROW(INVALID_PARAMETER);
        }
        bundle_set_internal_address(&api.bundle_ctx, input->address,
                                    address_idx);
    }
    else {
        // ignore index completely
        bundle_set_external_address(&api.bundle_ctx, input->address);
    }

    if (!IN_RANGE(input->value, -MAX_IOTA_VALUE, MAX_IOTA_VALUE)) {
        // value out of bounds
        THROW(INVALID_PARAMETER);
    }
    if (!validate_chars(input->tag, 27, true)) {
        // invalid tag
        THROW(INVALID_PARAMETER);
    }
    uint32_t timestamp;
    if (!ASSIGN(timestamp, input->timestamp)) {
        // timestamp overflow
        THROW(INVALID_PARAMETER);
    }
    bundle_add_tx(&api.bundle_ctx, input->value, input->tag, timestamp);

    if (input->value < 0) {
        // create meta tx for input
        bundle_set_external_address(&api.bundle_ctx, input->address);
        bundle_add_tx(&api.bundle_ctx, 0, input->tag, timestamp);
    }

    if (!bundle_has_open_txs(&api.bundle_ctx)) {
        ui_sign_tx(&api.bundle_ctx);

        return IO_ASYNCH_REPLY;
    }

    TX_OUTPUT output;
    output.finalized = false;

    io_send(&output, sizeof(output), SW_OK);
    return 0;
}

static bool next_signatrue_fragment(SIGNING_CTX *ctx, char *signature_fragment)
{
    unsigned char fragment_bytes[SIGNATURE_FRAGMENT_SIZE * 48];
    signing_next_fragment(ctx, fragment_bytes);

    bytes_to_chars(fragment_bytes, signature_fragment,
                   SIGNATURE_FRAGMENT_SIZE * 48);

    return signing_has_next_fragment(ctx);
}

unsigned int api_sign(unsigned char *input_data, unsigned int len)
{
    if(!flash_is_init()) {
        THROW(SW_APP_NOT_INITIALIZED);
    }
    if (CHECK_STATE(api.state_flags, SIGN)) {
        THROW(SW_COMMAND_INVALID_STATE);
    }
    if (len < sizeof(SIGN_INPUT)) {
        THROW(SW_WRONG_LENGTH);
    }
    const SIGN_INPUT *input = (SIGN_INPUT *)(input_data);

    unsigned int idx;
    if (!ASSIGN(idx, input->transaction_idx) ||
        idx > api.bundle_ctx.last_index) {
        // index is out of bounds
        THROW(INVALID_PARAMETER);
    }

    if ((api.state_flags & SIGNING_STARTED) == 0) {
        // temporary screen during signing process
        ui_display_signing();

        if (api.bundle_ctx.values[idx] >= 0) {
            // no input transaction
            THROW(INVALID_PARAMETER);
        }

        tryte_t normalized_hash[81];
        bundle_get_normalized_hash(&api.bundle_ctx, normalized_hash);

        signing_initialize(&api.signing_ctx, api.seed_bytes,
                           api.bundle_ctx.indices[idx], api.security,
                           normalized_hash);

        api.state_flags |= SIGNING_STARTED;
    }

    // TODO: check that the transaction idx has not changed

    SIGN_OUTPUT output;
    output.fragments_remaining =
        next_signatrue_fragment(&api.signing_ctx, output.signature_fragment);

    io_send(&output, sizeof(output), SW_OK);

    if (!output.fragments_remaining) {

        // signing is finished
        api.state_flags &= ~SIGNING_STARTED;
        ui_display_welcome();
    }

    return 0;
}

unsigned int api_display_pubkey(unsigned char *input_data, unsigned int len)
{
    if(!flash_is_init()) {
        THROW(SW_APP_NOT_INITIALIZED);
    }
    if (len < sizeof(PUBKEY_INPUT)) {
        THROW(SW_WRONG_LENGTH);
    }
    
    ui_display_calc();
    
    const PUBKEY_INPUT *input = (PUBKEY_INPUT *)(input_data);
    
    uint32_t address_idx;
    if (!ASSIGN(address_idx, input->address_idx)) {
        // address index overflow
        THROW(INVALID_PARAMETER);
    }
    
    unsigned char addr_bytes[48];
    get_public_addr(api.seed_bytes, address_idx, api.security, addr_bytes);
    
    char address[81];
    bytes_to_chars(addr_bytes, address, 48);
    
    ui_display_address(address, sizeof(address));
    
    io_send(NULL, 0, SW_OK);
    return 0;
}

/** @brief This functions gets called, when bundle is denied. */
void user_deny()
{
    // reset the bundle
    os_memset(&api.bundle_ctx, 0, sizeof(BUNDLE_CTX));
    api.state_flags &= ~BUNDLE_INITIALIZED;
    
    io_send(NULL, 0, SW_SECURITY_STATUS_NOT_SATISFIED);
}

/** @brief This functions gets called, when bundle is accepted. */
void user_sign()
{
    ui_display_calc();
    
    if (!bundle_validating_finalize(&api.bundle_ctx, api.seed_bytes,
                                    api.security)) {
        THROW(SW_SECURITY_STATUS_NOT_SATISFIED);
    }
    api.state_flags |= BUNDLE_FINALIZED;
    
    TX_OUTPUT output;
    output.finalized = true;
    bytes_to_chars(bundle_get_hash(&api.bundle_ctx), output.bundle_hash, 48);
    
    io_send(&output, sizeof(output), SW_OK);
}
