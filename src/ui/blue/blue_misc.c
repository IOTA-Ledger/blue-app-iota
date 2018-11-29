#include "blue_misc.h"
#include "blue_types.h"
#include "ui_common.h"
#include "api.h"
#include "iota/addresses.h"

// address stored is continuous chunk,
// break it up to display on separate lines
void break_address()
{
    os_memmove(&blue_ui_state.addr[CHUNK_CHK], blue_ui_state.addr + 81, 9);
    os_memmove(&blue_ui_state.addr[CHUNK3], blue_ui_state.addr + 60, 21);
    os_memmove(&blue_ui_state.addr[CHUNK2], blue_ui_state.addr + 30, 30);

    blue_ui_state.addr[30] = '\0';
    blue_ui_state.addr[61] = '\0';
    blue_ui_state.addr[83] = '\0';
    blue_ui_state.addr[93] = '\0';
}

void update_tx_type()
{
    blue_ui_state.val = api.bundle_ctx.values[menu_to_tx_idx()];

    // first tx is output
    if (blue_ui_state.menu_idx == 0) {
        os_memcpy(blue_ui_state.tx_type, "Output:", 7);
    }
    else {
        // Negative val is input, positive is change
        if (blue_ui_state.val < 0) {
            snprintf(blue_ui_state.tx_type, TX_TYPE_TEXT_LEN, "Input: [%u]",
                     (unsigned int)api.bundle_ctx.indices[menu_to_tx_idx()]);
        }
        else {
            snprintf(blue_ui_state.tx_type, TX_TYPE_TEXT_LEN, "Change: [%u]",
                     (unsigned int)
                         api.bundle_ctx.indices[api.bundle_ctx.last_tx_index]);
        }
    }
}

void update_tx_val()
{
    write_readable_val(blue_ui_state.val, blue_ui_state.abbrv_val,
                       ABBRV_VAL_TEXT_LEN);
    write_full_val(blue_ui_state.val, blue_ui_state.full_val,
                   FULL_VAL_TEXT_LEN);
}

void update_tx_addr()
{
    const unsigned char *addr_bytes =
        bundle_get_address_bytes(&api.bundle_ctx, menu_to_tx_idx());

    get_address_with_checksum(addr_bytes, blue_ui_state.addr);
    // break up the address for use on separate lines
    break_address();
}

void update_tx_info()
{
    // update tx type writes api tx val to blue_ui_state.val
    update_tx_type();
    update_tx_val();
    update_tx_addr();
    // bip path already written when tx was created
}

void write_bip_path()
{
    uint8_t chars_written = 0;

    for (unsigned int i = 0; i < api.bip32_path_length; i++) {

        snprintf(blue_ui_state.bip32_path + chars_written,
                 BIP_TEXT_LEN - chars_written, "%x",
                 api.bip32_path[i] & 0x7fffffff);

        chars_written = strnlen(blue_ui_state.bip32_path, BIP_TEXT_LEN);

        // write apostroph if hardnend
        if (api.bip32_path[i] & (1u << 31)) {
            blue_ui_state.bip32_path[chars_written++] = '\'';
        }

        // write the separator only if not last element
        if (i < api.bip32_path_length - 1) {
            blue_ui_state.bip32_path[chars_written++] = '|';
        }
    }
}
