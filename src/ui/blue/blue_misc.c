#include "ui/blue/blue_misc.h"
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include "api.h"
#include "iota/addresses.h"
#include "iota/bundle.h"
#include "macros.h"
#include "os.h"
#include "ui/blue/blue_types.h"
#include "ui/ui_common.h"

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

static uint8_t last_non_meta_tx_idx()
{
    uint8_t tx_idx = api.ctx.bundle.bundle.last_tx_index;
    // there will always be 2+ non-metas (required output + input)
    while (api.ctx.bundle.bundle.values[tx_idx] == 0) {
        tx_idx--;
    }

    return tx_idx;
}

// 0 out - 1 in, 2 meta, 3 in, 4 meta, 5 change
bool second_last_tx()
{
    // increment menu_idx and check if it == change tx
    blue_ui_state.menu_idx++;

    bool retval = (ui_state_get_tx_index() == last_non_meta_tx_idx());
    // set menu_idx back
    blue_ui_state.menu_idx--;

    return retval;
}

void update_tx_type()
{
    blue_ui_state.val = api.ctx.bundle.bundle.values[ui_state_get_tx_index()];

    // first tx is output
    if (blue_ui_state.menu_idx == 0) {
        os_memcpy(blue_ui_state.tx_type, "Output:\0", TX_TYPE_SPLIT);
    }
    else {
        // Negative val is input, positive is change
        if (blue_ui_state.val < 0) {
            os_memcpy(blue_ui_state.tx_type, "Input: \0", TX_TYPE_SPLIT);
            snprintf(&blue_ui_state.tx_type[TX_TYPE_SPLIT],
                     TEXT_LEN_TX_TYPE - TX_TYPE_SPLIT, "Idx: %u",
                     (unsigned int)api.ctx.bundle.bundle
                         .indices[ui_state_get_tx_index()]);
        }
        else {
            os_memcpy(blue_ui_state.tx_type, "Change:\0", TX_TYPE_SPLIT);
            snprintf(&blue_ui_state.tx_type[TX_TYPE_SPLIT],
                     TEXT_LEN_TX_TYPE - TX_TYPE_SPLIT, "Idx: %u",
                     (unsigned int)api.ctx.bundle.bundle
                         .indices[ui_state_get_tx_index()]);
        }
    }
}

static void update_tx_val()
{
    format_value_short(blue_ui_state.abbrv_val, TEXT_LEN_VALUE_ABBREV,
                       ABS(blue_ui_state.val));
    format_value_full(blue_ui_state.full_val, TEXT_LEN_VALUE_FULL,
                      ABS(blue_ui_state.val));
}

static void update_tx_addr()
{
    const unsigned char *addr_bytes =
        bundle_get_address_bytes(&api.ctx.bundle, ui_state_get_tx_index());

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
                 TEXT_LEN_BIP_PATH - chars_written, "%x",
                 api.bip32_path[i] & 0x7fffffff);

        chars_written = strnlen(blue_ui_state.bip32_path, TEXT_LEN_BIP_PATH);

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
