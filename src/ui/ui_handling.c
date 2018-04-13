#include "ui_misc.h"
#include <string.h>
#include "common.h"
#include "iota/addresses.h"
#include "ui.h"


/* ----------------------------------------------------
 ------------------------------------------------------
        Default display options per state
        * Text menus have special handling
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_build_display()
{
    switch (ui_state.state) {
        /* ------------ INIT *MENU* -------------- */
    case STATE_MENU_INIT: {
        // write the actual menu
        char msg[MENU_INIT_LEN * 21];
        get_init_menu(msg);
        write_text_array(msg, MENU_INIT_LEN);

        // special override display states
        if (ui_state.menu_idx == 0)
            glyph_on(ui_glyphs.glyph_warn);
        if (ui_state.menu_idx == MENU_INIT_LEN - 1) {
            display_glyphs_confirm(ui_glyphs.glyph_up, NULL);
        }
    } break;
        /* ------------ WELCOME *MENU* -------------- */
    case STATE_MENU_WELCOME: {
        // write the actual menu
        char msg[MENU_WELCOME_LEN * 21];
        get_welcome_menu(msg);
        write_text_array(msg, MENU_WELCOME_LEN);

        // special override display states
        switch (ui_state.menu_idx) {
            // turn off BOT_H
        case 0:
            display_glyphs_confirm(NULL, ui_glyphs.glyph_down);
        case MENU_WELCOME_LEN - 2:
            write_display(NULL, TYPE_STR, BOT_H);
            break;
            // turn off TOP_H
        case MENU_WELCOME_LEN - 1:
            display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_dash);
        case 1:
            write_display(NULL, TYPE_STR, TOP_H);
            break;
        }
    } break;
        /* ------------ ADVANCED MODE *MENU* -------------- */
    case STATE_MENU_ADVANCED: {
        // write the actual menu
        char msg[MENU_ADVANCED_LEN * 21];
        get_advanced_menu(msg);
        write_text_array(msg, MENU_ADVANCED_LEN);

        // no special overrides
    } break;
        /* ------------ ADVANCED MODE WARNING *MENU* -------------- */
    case STATE_MENU_ADV_WARN: {
        // write the actual menu
        char msg[MENU_ADV_WARN_LEN * 21];
        get_adv_warn_menu(msg);
        write_text_array(msg, MENU_ADV_WARN_LEN);

        // special override display states
        switch (ui_state.menu_idx) {
        case MENU_ADV_WARN_LEN - 2: // Yes
            display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
            // turn off the half menus
            write_display(NULL, TYPE_STR, BOT_H);
            write_display(NULL, TYPE_STR, TOP_H);
            break;

        case MENU_ADV_WARN_LEN - 1: // No
            display_glyphs_confirm(ui_glyphs.glyph_up, NULL);
            // turn off the half text
            write_display(NULL, TYPE_STR, TOP_H);
            break;

        default:
            break;
        }
    } break;
        /* ------------ BROWSER SUPPORT *MENU* -------------- */
    case STATE_MENU_BROWSER: {
        // write the actual menu
        char msg[MENU_BROWSER_LEN * 21];
        get_browser_menu(msg);
        write_text_array(msg, MENU_BROWSER_LEN);

        // no special overrides
    } break;
        /* ------------ DISPLAY INDEXES *MENU* -------------- */
    case STATE_MENU_DISP_IDX: {
        // write the actual menu
        char msg[MENU_ACCOUNTS_LEN * 21];
        get_disp_idx_menu(msg);
        write_text_array(msg, MENU_ACCOUNTS_LEN);

        // special override display states
        switch (ui_state.menu_idx) {
            // turn off BOT_H
        case MENU_ACCOUNTS_LEN - 2:
            write_display(NULL, TYPE_STR, BOT_H);
            break;
            // turn off TOP_H
        case MENU_ACCOUNTS_LEN - 1:
            display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_dash);
            write_display(NULL, TYPE_STR, TOP_H);
            break;
        }
    } break;
        /* ------------ DISPLAY ADDRESS *MENU* -------------- */
    case STATE_MENU_TX_ADDR: // fall through - almost identical display
    case STATE_MENU_DISP_ADDR: {
        // write the actual menu
        char msg[MENU_ADDR_LEN * 21];
        get_address_menu(msg);
        write_text_array(msg, MENU_ADDR_LEN);

        glyph_on(ui_glyphs.glyph_bar_l);
        glyph_on(ui_glyphs.glyph_bar_r);

        // special overrides
        if (ui_state.menu_idx == 0 && ui_state.state == STATE_MENU_DISP_ADDR)
            glyph_on(ui_glyphs.glyph_up);
    } break;
        /* ------------ DISPLAY ADDRESS CHECKSUM -------------- */
    case STATE_DISP_ADDR_CHK: {
        clear_display();

        char abbrv[14];
        abbreviate_addr(abbrv, ui_state.addr, 81);

        write_display(abbrv, TYPE_STR, TOP);
        write_display("Chk: ", TYPE_STR, BOT);

        // copy the remaining 9 chars in the buffer
        memcpy(ui_text.bot_str + 5, ui_state.addr + 81, 9);

        display_glyphs_confirm(NULL, ui_glyphs.glyph_down);
    } break;
        /* ------------ TX BAL -------------- */
    case STATE_TX_BAL: {
        clear_display();
        write_display("Balance:", TYPE_STR, TOP);

        // display_value returns true if readable form is possible
        if (display_value(ui_state.bal, BOT))
            display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        else
            display_glyphs(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
    } break;
        /* ------------ TX PAY -------------- */
    case STATE_TX_PAY: {
        clear_display();
        write_display("Payment:", TYPE_STR, TOP);

        // display_value returns true if readable form is possible
        if (display_value(ui_state.pay, BOT))
            display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        else
            display_glyphs(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
    } break;
        /* ------------ TX ADDR -------------- */
    case STATE_TX_ADDR: {
        clear_display();

        char abbrv[14];
        abbreviate_addr(abbrv, ui_state.addr, 81);

        write_display(abbrv, TYPE_STR, TOP);
        write_display("Chk: ", TYPE_STR, BOT);

        // copy the remaining 9 chars in the buffer
        memcpy(ui_text.bot_str + 5, ui_state.addr + 81, 9);

        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
    } break;
        /* ------------ TX APPROVE -------------- */
    case STATE_TX_APPROVE: {
        clear_display();
        write_display("Approve TX", TYPE_STR, MID);

        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
    } break;
        /* ------------ TX DENY -------------- */
    case STATE_TX_DENY: {
        clear_display();
        write_display("Deny TX", TYPE_STR, MID);

        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
    } break;
        /* ------------ IGNORE STATE -------------- */
    case STATE_IGNORE: {
        return;
    }
        /* ------------ INIT LEDGER *MENU* -------------- */
    case STATE_MENU_INIT_LEDGER: {
        // write the actual menu
        char msg[MENU_INIT_LEDGER_LEN * 21];
        get_init_ledger_menu(msg);
        write_text_array(msg, MENU_ADDR_LEN);
        
        // special override display states
        switch (ui_state.menu_idx) {
            case 0:
                glyph_on(ui_glyphs.glyph_warn);
                break;
                // turn off BOT_H and TOP_H
            case MENU_INIT_LEDGER_LEN - 2:
                display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
                write_display(NULL, TYPE_STR, BOT_H);
                write_display(NULL, TYPE_STR, TOP_H);
                break;
                // turn off TOP_H
            case MENU_INIT_LEDGER_LEN - 1:
                display_glyphs_confirm(ui_glyphs.glyph_up, NULL);
                write_display(NULL, TYPE_STR, TOP_H);
                break;
        }
    } break;
        /* ------------ ADVANCED TX INFO *PSEUDO-MENU* -------------- */
    case STATE_TX_ADVANCED_INFO: {
        // custom function to handle advanced transaction display
        display_advanced_tx_info();
    } break;
        /* ------------ UNKNOWN STATE -------------- */
    default: {
        clear_display();
        write_display("UI ERROR", TYPE_STR, MID);

        display_glyphs_confirm(NULL, NULL);
    } break;
    }
}


/* ----------------------------------------------------
 ------------------------------------------------------
            Special handling of text menus
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_handle_menus(uint8_t state, uint8_t translated_mask)
{
    uint8_t array_sz = 0;

    switch (state) {
        /* ------------ STATE INIT -------------- */
    case STATE_MENU_INIT:
        array_sz = MENU_INIT_LEN - 1;

        if (translated_mask == BUTTON_B) {
            state_go(STATE_MENU_WELCOME, 0);
            return;
        }
        break;
        /* ------------ STATE OPTIONS -------------- */
    case STATE_MENU_WELCOME:
        array_sz = MENU_WELCOME_LEN - 1;

        if (translated_mask == BUTTON_B) {
            switch (ui_state.menu_idx) {
                // Welcome Message
            case 0:
                state_go(STATE_EXIT, 0);
                return;
                // Advanced Mode
            case 1:
                // get_adv_mode lines up with menu idx
                state_go(STATE_MENU_ADVANCED, get_advanced_mode());
                return;
                // Browser Mode
            case 2:
                // get_browser_mode lines up with menu idx
                state_go(STATE_MENU_BROWSER, get_browser_mode());
                return;
                // View Indexes
            case 3:
                state_go(STATE_MENU_DISP_IDX, 0);
                return;
                // Exit App
            case MENU_WELCOME_LEN - 1:
                state_go(STATE_EXIT, 0);
                return;
            }
        }
        break;
        /* ------------ STATE ADVANCED MODE -------------- */
    case STATE_MENU_ADVANCED:
        array_sz = MENU_ADVANCED_LEN - 1;

        if (translated_mask == BUTTON_B) {

            // warn if entering advanced mode
            if (ui_state.menu_idx == 1 && get_advanced_mode() == 0) {
                state_go(STATE_MENU_ADV_WARN, 0);

                return;
            }

            // menu idx entries line up with modes
            write_advanced_mode(ui_state.menu_idx);

            state_return(STATE_MENU_WELCOME, 1);
            return;
        }
        break;
        /* ------------ STATE ADVANCED MODE WARNING -------------- */
    case STATE_MENU_ADV_WARN:
        array_sz = MENU_ADV_WARN_LEN - 1;

        if (translated_mask == BUTTON_B) {

            switch (ui_state.menu_idx) {
            case 1: // Yes
                write_advanced_mode(1);
            case 2: // No
                state_return(STATE_MENU_WELCOME, 1);
                return;
            default: // "Are you sure?"
                break;
            }
        }
        break;
        /* ------------ STATE BROWSER MODE -------------- */
    case STATE_MENU_BROWSER:
        array_sz = MENU_BROWSER_LEN - 1;

        if (translated_mask == BUTTON_B) {
            // menu idx entries line up with modes
            write_browser_mode(ui_state.menu_idx);

            state_return(STATE_MENU_WELCOME, 2);
            return;
        }
        break;
        /* ------------ STATE DISPLAY_INDEXES -------------- */
    case STATE_MENU_DISP_IDX:
        array_sz = MENU_ACCOUNTS_LEN - 1;

        // Back
        if (translated_mask == BUTTON_B && ui_state.menu_idx == array_sz) {
            state_return(STATE_MENU_WELCOME, 3);
            return;
        }
        break;
        /* ------------ STATE DISPLAY_ADDRESS -------------- */
    case STATE_MENU_DISP_ADDR:
        array_sz = MENU_ADDR_LEN - 1;

        if (translated_mask == BUTTON_L && ui_state.menu_idx == 0) {
            state_go(STATE_DISP_ADDR_CHK, 0);
            return;
        }
        else if (translated_mask == BUTTON_B) {
            state_return(STATE_MENU_WELCOME, 0);
            return;
        }
        break;
        /* ------------ STATE MENU_TX_ADDRESS -------------- */
    case STATE_MENU_TX_ADDR:
        array_sz = MENU_ADDR_LEN - 1;

        if (translated_mask == BUTTON_B) {
            restore_state();
            //state_go(STATE_TX_ADDR, 0);
            return;
        }
        break;
    case STATE_IGNORE:
        return;
        /* ------------ STATE INIT LEDGER -------------- */
    case STATE_MENU_INIT_LEDGER:
        array_sz = MENU_INIT_LEDGER_LEN - 1;
        
        // Deny
        if (translated_mask == BUTTON_B && ui_state.menu_idx == array_sz) {
            init_ledger_deny();
            state_return(STATE_MENU_WELCOME, 0);
            ui_state.input = NULL;
            return;
        }
        else if(translated_mask == BUTTON_B) {// TODO } && ui_state.menu_idx == array_sz-1) {
            // Approve
            init_ledger_approve(ui_state.input);
            state_return(STATE_MENU_WELCOME, 0);
            ui_state.input = NULL;
            return;
        }
        break;
        /* ------------ ADVANCED TX INFO *PSEUDO-MENU* -------------- */
    case STATE_TX_ADVANCED_INFO:
        // Define a psuedo menu.
        // not a true menu, it's just a dynamic loop over the same
        // state until all transactions have been shown
        array_sz = ((ui_state.bundle_ctx->last_index + 1) * 2) - 1;
            
        // manually handle increment/decrement
        if(translated_mask == BUTTON_R) {
            ui_state.menu_idx++;
            
            int64_t val = ui_state.bundle_ctx->values[ui_state.menu_idx/2];
            
            // bypass displaying confirmations for meta-tx's
            while(val == 0 && ui_state.menu_idx <= array_sz) {
                ui_state.menu_idx += 2;
                val = ui_state.bundle_ctx->values[ui_state.menu_idx/2];
            }
            
            // if we've displayed all transactions, go to approve
            if(ui_state.menu_idx > array_sz) {
                backup_state();
                state_go(STATE_TX_APPROVE, 0);
            }
        }
        else if(translated_mask == BUTTON_L) {
            // if this is very first tx, left goes to deny
            if(ui_state.menu_idx == 0) {
                backup_state();
                state_go(STATE_TX_DENY, 0);
                return;
            }
            
            ui_state.menu_idx--;
            
            int64_t val = ui_state.bundle_ctx->values[ui_state.menu_idx/2];
            
            // bypass displaying confirmations for meta-tx's
            while(val == 0 && ui_state.menu_idx >= 2) {
                ui_state.menu_idx -= 2;
                val = ui_state.bundle_ctx->values[ui_state.menu_idx/2];
            }
        }
        
        return;
        /* ------------ DEFAULT -------------- */
    default:
        ui_state.menu_idx = 0;
        return;
    }

    // auto incr or decr ui_state.menu_idx
    if (translated_mask == BUTTON_L)
        ui_state.menu_idx = MAX(0, ui_state.menu_idx - 1);
    else if (translated_mask == BUTTON_R)
        ui_state.menu_idx = MIN(array_sz, ui_state.menu_idx + 1);
}

/* ----------------------------------------------------
 ------------------------------------------------------
                Special button actions
 ------------------------------------------------------
 --------------------------------------------------- */
void ui_handle_button(uint8_t state, uint8_t button_mask)
{/*
    // TODO restore_state will take you back to wrong actual value...
    if(button_mask == BUTTON_L) {
        switch(state) {
            case STATE_TX_BAL:
                set_backup(STATE_TX_BAL, 0);
                state_go(STATE_TX_APPROVE, 0);
                break;
            case STATE_TX_APPROVE:
                restore_state();
                break;
        }
    }
    else if(button_mask == BUTTON_R) {
        switch(state) {
            case STATE_TX_ADDR:
                set_backup(STATE_TX_ADDR, 0);
                state_go(STATE_TX_APPROVE, 0);
                break;
            case STATE_TX_DENY:
                restore_state();
                break;
        }
    }
    else */
    if (button_mask == BUTTON_B) {
        switch (state) {
            /* ------------- INIT --------------- */
        case STATE_MENU_INIT:
            // TODO ensure menu_idx is last (forcing user to read)
            init_flash();
            break;
            /* ------------- APPROVE TX --------------- */
        case STATE_TX_APPROVE:
            user_sign_tx();
            ui_state.display_full_value = false;
            break;
            /* ------------- DENY TX --------------- */
        case STATE_TX_DENY:
            user_deny_tx();
            ui_state.display_full_value = false;
            break;
            /* ------------- BAL/PAY SWAP READABLE --------------- */
        case STATE_TX_BAL:
            if (get_num_digits(ui_state.bal) > 3)
                value_convert_readability();
            break;
        case STATE_TX_PAY:
            if (get_num_digits(ui_state.pay) > 3)
                value_convert_readability();
            break;
        case STATE_TX_ADDR:
            set_backup(STATE_TX_ADDR, 0);
            break;
            /* ------------- BAL/PAY SWAP READABLE --------------- */
        case STATE_TX_ADVANCED_INFO:
                if(ui_state.menu_idx % 2 == 0) {
                    // on a value screen
                    if(get_num_digits(ui_state.bal) > 3)
                        // ui_state.bal always holds the value for advanced display
                        value_convert_readability();
                }
                else {
                    // on an address screen
                    backup_state();
                    state_go(STATE_MENU_TX_ADDR, 0);
                }
            break;
        }
    }
}
