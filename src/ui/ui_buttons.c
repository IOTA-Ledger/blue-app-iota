#include "ui_buttons.h"
#include <string.h>
#include "common.h"
#include "iota/addresses.h"
#include "ui.h"

uint8_t button_init(uint8_t button_mask)
{
    uint8_t array_sz = MENU_INIT_LEN - 1;

    if (button_mask == BUTTON_B && ui_state.menu_idx == array_sz) {
        init_flash();
        state_go(STATE_WELCOME, 0);
    }

    return array_sz;
}

uint8_t button_welcome(uint8_t button_mask)
{
    uint8_t array_sz = MENU_WELCOME_LEN - 1;

    if (button_mask == BUTTON_B) {
        switch (ui_state.menu_idx) {
            // Welcome to IOTA
        case 0:
            state_go(STATE_EXIT, 0);
            return array_sz;
            // Advanced Mode
        case 1:
            // get_adv_mode lines up with menu idx
            state_go(STATE_ADVANCED, get_advanced_mode());
            return array_sz;
            // View Indexes
        case 2:
            state_go(STATE_DISP_IDX, 0);
            return array_sz;
            // Exit App
        case MENU_WELCOME_LEN - 1:
            state_go(STATE_EXIT, 0);
            return array_sz;
        }
    }

    return array_sz;
}

uint8_t button_advanced(uint8_t button_mask)
{
    uint8_t array_sz = MENU_ADVANCED_LEN - 1;

    if (button_mask == BUTTON_B) {

        // warn if entering advanced mode
        if (ui_state.menu_idx == 1 && get_advanced_mode() == 0) {
            state_go(STATE_ADV_WARN, 0);

            return array_sz;
        }

        // menu idx entries line up with modes
        write_advanced_mode(ui_state.menu_idx);

        state_return(STATE_WELCOME, 1);
    }

    return array_sz;
}


uint8_t button_adv_warn(uint8_t button_mask)
{
    uint8_t array_sz = MENU_ADV_WARN_LEN - 1;

    if (button_mask == BUTTON_B) {

        switch (ui_state.menu_idx) {
        case 1: // Yes
            write_advanced_mode(1);
        case 2: // No
            state_return(STATE_WELCOME, 1);
            return array_sz;
        default: // "Are you sure?"
            break;
        }
    }

    return array_sz;
}

uint8_t button_disp_idx(uint8_t button_mask)
{
    uint8_t array_sz = MENU_DISP_IDX_LEN - 1;

    // no special interaction on any index, so always transition back
    if (button_mask == BUTTON_B) {
        state_return(STATE_WELCOME, 2);
        return array_sz;
    }

    return array_sz;
}

uint8_t button_disp_addr(uint8_t button_mask)
{
    uint8_t array_sz = MENU_ADDR_LEN - 1;

    if (button_mask == BUTTON_L && ui_state.menu_idx == 0) {
        state_go(STATE_DISP_ADDR_CHK, 0);
        return array_sz;
    }
    else if (button_mask == BUTTON_B) {
        restore_state();
        return array_sz;
    }

    return array_sz;
}

uint8_t button_disp_addr_chk(uint8_t button_mask)
{
    if (button_mask == BUTTON_R)
        state_go(STATE_DISP_ADDR, 0);
    else if (button_mask == BUTTON_B)
        restore_state();

    return 0;
}

uint8_t button_tx_addr(uint8_t button_mask)
{
    uint8_t array_sz = MENU_ADDR_LEN - 1;

    if (button_mask == BUTTON_B) {
        restore_state();
        return array_sz;
    }

    return array_sz;
}

uint8_t button_init_ledger(uint8_t button_mask)
{
    uint8_t array_sz = MENU_INIT_LEDGER_LEN - 1;

    if (button_mask == BUTTON_B) {
        // Deny
        if (ui_state.menu_idx == array_sz) {
            init_ledger_deny();
            ui_state.input = NULL;
            return array_sz;
        }
        else if (ui_state.menu_idx == array_sz - 1) {
            // Approve
            init_ledger_approve(ui_state.input);
            ui_state.input = NULL;
            return array_sz;
        }
    }

    return array_sz;
}

void button_prompt_tx(uint8_t button_mask)
{
    uint8_t array_sz = get_tx_arr_sz();
    int64_t val;

    // manually handle increment/decrement
    if (button_mask == BUTTON_R) {

        // bypass displaying confirmations for meta-tx's
        do {
            ui_state.menu_idx++;
            val = ui_state.bundle_ctx->values[menu_to_tx_idx()];
        } while (val == 0 && ui_state.menu_idx < array_sz - 2);

        // loop back to 0
        if (ui_state.menu_idx > array_sz - 1)
            ui_state.menu_idx = 0;
    }
    else if (button_mask == BUTTON_L) {

        // if this is very first tx, left goes to last option (deny)
        if (ui_state.menu_idx == 0) {
            ui_state.menu_idx = array_sz - 1;
            return;
        }

        // bypass displaying confirmations for meta-tx's
        do {
            ui_state.menu_idx--;
            val = ui_state.bundle_ctx->values[menu_to_tx_idx()];
        } while (val == 0 && ui_state.menu_idx > 0 &&
                 ui_state.menu_idx < array_sz - 2);
    }
    else if (button_mask == BUTTON_B) {
        // deny
        if (ui_state.menu_idx == array_sz - 1) {
            user_deny_tx();
            ui_state.display_full_value = false;
            state_go(STATE_WELCOME, 0);
        }
        else if (ui_state.menu_idx == array_sz - 2) {
            user_sign_tx();
            ui_state.display_full_value = false;
        }
        else { // all other options alternate between val/addr
            if (ui_state.menu_idx % 2 == 0) {
                // on a value screen
                if (get_num_digits(ui_state.val) > 3)
                    value_convert_readability();
            }
            else {
                // on an address screen
                backup_state();
                state_go(STATE_TX_ADDR, 0);
            }
        }
    }
}

uint8_t button_warn_change(uint8_t button_mask)
{
    uint8_t array_sz = MENU_WARN_CHANGE_LEN - 1;
    
    if (button_mask == BUTTON_B) {
        // Deny
        if (ui_state.menu_idx == array_sz) {
            user_deny_tx();
            //restore_state();
            state_go(STATE_WELCOME, 0);
            return array_sz;
        }
        else if (ui_state.menu_idx == array_sz - 1) {
            // Approve
            state_go(STATE_PROMPT_TX, 0);
            return array_sz;
        }
    }
    
    return array_sz;
}

void button_handle_menu_idx(uint8_t button_mask, uint8_t array_sz)
{
    // incr or decr ui_state.menu_idx
    if (button_mask == BUTTON_L)
        ui_state.menu_idx = MAX(0, ui_state.menu_idx - 1);
    else if (button_mask == BUTTON_R)
        ui_state.menu_idx = MIN(array_sz, ui_state.menu_idx + 1);
}
