#include "ui_buttons.h"
#include <string.h>
#include "common.h"

#include "ui.h"
#include "ui_types.h"
#include "ui_misc.h"

#include "api.h"
#include "storage.h"
#include "iota/addresses.h"

uint8_t button_init(uint8_t button_mask)
{
    uint8_t array_sz = MENU_INIT_LEN - 1;

    if (button_mask == BUTTON_B && ui_state.menu_idx == MENU_INIT_LAST) {
        storage_initialize();
        state_go(STATE_MAIN_MENU, 0);
    }

    return array_sz;
}

uint8_t button_main_menu(uint8_t button_mask)
{
    uint8_t array_sz = MENU_MAIN_LEN - 1;

    if (button_mask == BUTTON_B) {
        switch (ui_state.menu_idx) {

        case MENU_MAIN_CONNECT:
            state_go(STATE_EXIT, 0);
            break;

        case MENU_MAIN_ABOUT:
            state_go(STATE_ABOUT, 0);
            break;

        case MENU_MAIN_EXIT:
            state_go(STATE_EXIT, 0);
            break;
        }
    }

    return array_sz;
}

uint8_t button_about(uint8_t button_mask)
{
    uint8_t array_sz = MENU_ABOUT_LEN - 1;

    if (button_mask == BUTTON_B) {
        switch (ui_state.menu_idx) {

        case MENU_ABOUT_VERSION:
            state_go(STATE_VERSION, 0);
            break;

        case MENU_ABOUT_MORE_INFO:
            state_go(STATE_MORE_INFO, 0);
            break;

        case MENU_ABOUT_BACK:
            state_go(STATE_MAIN_MENU, MENU_MAIN_ABOUT);
            break;
        }
    }

    return array_sz;
}

void button_version(uint8_t button_mask)
{
    if (button_mask == BUTTON_B) {
        // return to About -> Version
        state_go(STATE_ABOUT, MENU_ABOUT_VERSION);
    }
}

uint8_t button_more_info(uint8_t button_mask)
{
    uint8_t array_sz = MENU_MORE_INFO_LEN - 1;

    if (button_mask == BUTTON_B) {
        // return to About -> More Info
        state_go(STATE_ABOUT, MENU_ABOUT_MORE_INFO);
    }

    return array_sz;
}

void button_bip_path(uint8_t button_mask)
{
    if (button_mask == BUTTON_L) {
        // we came from tx
        if (ui_state.backup_state == STATE_PROMPT_TX)
            state_go(STATE_TX_ADDR, MENU_ADDR_LAST);
        else // we came from disp_addr
            state_go(STATE_DISP_ADDR, MENU_ADDR_LAST);
    }
    else if (button_mask == BUTTON_B) {
        restore_state();
    }
}

uint8_t button_disp_addr(uint8_t button_mask)
{
    uint8_t array_sz = MENU_ADDR_LEN - 1;

    if (button_mask == BUTTON_L && ui_state.menu_idx == 0) {
        state_go(STATE_DISP_ADDR_CHK, 0);
    }
    else if (button_mask == BUTTON_R && ui_state.menu_idx == MENU_ADDR_LAST) {
        state_go(STATE_BIP_PATH, 0);
    }
    else if (button_mask == BUTTON_B) {
        restore_state();
    }

    return array_sz;
}

void button_disp_addr_chk(uint8_t button_mask)
{
    if (button_mask == BUTTON_R)
        state_go(STATE_DISP_ADDR, 0);
    else if (button_mask == BUTTON_B)
        restore_state();
}

uint8_t button_tx_addr(uint8_t button_mask)
{
    uint8_t array_sz = MENU_ADDR_LEN - 1;

    // If the backup menu idx is 1, it's the output addr so don't go to bip path
    if (button_mask == BUTTON_R && ui_state.menu_idx == MENU_ADDR_LAST &&
        !(ui_state.backup_state == STATE_PROMPT_TX &&
          ui_state.backup_menu_idx == 1)) {
        state_go(STATE_BIP_PATH, 0);
    }
    else if (button_mask == BUTTON_B) {
        restore_state();
    }

    return array_sz;
}

void button_prompt_tx(uint8_t button_mask)
{
    const uint8_t tx_array_sz = get_tx_arr_sz();
    int64_t val;

    // manually handle increment/decrement
    if (button_mask == BUTTON_R) {

        // bypass displaying confirmations for meta-tx's
        do {
            ui_state.menu_idx++;
            val = api.bundle_ctx.values[menu_to_tx_idx()];
        } while (val == 0 && ui_state.menu_idx < MENU_TX_APPROVE);

        // loop back to 0 after last entry (deny)
        if (ui_state.menu_idx > MENU_TX_DENY)
            ui_state.menu_idx = 0;
    }
    else if (button_mask == BUTTON_L) {

        // if this is very first tx, left goes to last option (deny)
        if (ui_state.menu_idx == 0) {
            ui_state.menu_idx = MENU_TX_DENY;
            return;
        }

        // bypass displaying confirmations for meta-tx's
        do {
            ui_state.menu_idx--;
            val = api.bundle_ctx.values[menu_to_tx_idx()];
        } while (val == 0 && ui_state.menu_idx > 0 &&
                 ui_state.menu_idx < MENU_TX_APPROVE);
    }
    else if (button_mask == BUTTON_B) {

        // can't use switch statement because array sz isn't known
        if (ui_state.menu_idx == MENU_TX_DENY) {
            user_deny_tx();
            ui_state.display_full_value = false;
            state_go(STATE_MAIN_MENU, 0);
        }
        else if (ui_state.menu_idx == MENU_TX_APPROVE) {
            user_sign_tx();
            ui_state.display_full_value = false;
        }
        else {
            // all other options alternate between val/addr
            if (ui_state.menu_idx % 2 == 0) {
                // on a value screen
                if (ui_state.val >= 1000) {
                    value_convert_readability();
                }
            }
            else {
                // on an address screen
                backup_state();
                state_go(STATE_TX_ADDR, 0);
            }
        }
    }
}

void button_handle_menu_idx(uint8_t button_mask, uint8_t array_sz)
{
    // incr or decr ui_state.menu_idx
    if (button_mask == BUTTON_L)
        ui_state.menu_idx = MAX(0, ui_state.menu_idx - 1);
    else if (button_mask == BUTTON_R)
        ui_state.menu_idx = MIN(array_sz, ui_state.menu_idx + 1);
}
