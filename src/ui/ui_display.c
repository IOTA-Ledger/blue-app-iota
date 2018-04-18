#include "ui_display.h"
#include <string.h>
#include "common.h"
#include "iota/addresses.h"
#include "ui.h"


void display_menu_init()
{
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
}

void display_menu_welcome()
{
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
}

void display_menu_advanced()
{
    // write the actual menu
    char msg[MENU_ADVANCED_LEN * 21];
    get_advanced_menu(msg);
    write_text_array(msg, MENU_ADVANCED_LEN);
    
    // no special overrides
}

void display_menu_adv_warn()
{
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
}

void display_menu_disp_idx()
{
    // write the actual menu
    char msg[MENU_DISP_IDX_LEN * 21];
    get_disp_idx_menu(msg);
    write_text_array(msg, MENU_DISP_IDX_LEN);
    
    // special override display states
    switch (ui_state.menu_idx) {
            // turn off BOT_H
        case MENU_DISP_IDX_LEN - 2:
            write_display(NULL, TYPE_STR, BOT_H);
            break;
            // turn off TOP_H
        case MENU_DISP_IDX_LEN - 1:
            display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_dash);
            write_display(NULL, TYPE_STR, TOP_H);
            break;
    }
}

void display_menu_disp_addr()
{
    // write the actual menu
    char msg[MENU_ADDR_LEN * 21];
    get_address_menu(msg);
    write_text_array(msg, MENU_ADDR_LEN);
    
    glyph_on(ui_glyphs.glyph_bar_l);
    glyph_on(ui_glyphs.glyph_bar_r);
    
    // special overrides
    if (ui_state.menu_idx == 0 && ui_state.state == STATE_MENU_DISP_ADDR)
        glyph_on(ui_glyphs.glyph_up);
}

void display_addr_chk()
{
    clear_display();
    
    char abbrv[14];
    abbreviate_addr(abbrv, ui_state.addr, 81);
    
    write_display(abbrv, TYPE_STR, TOP);
    write_display("Chk: ", TYPE_STR, BOT);
    
    // copy the remaining 9 chars in the buffer
    memcpy(ui_text.bot_str + 5, ui_state.addr + 81, 9);
    
    display_glyphs_confirm(NULL, ui_glyphs.glyph_down);
}

void display_menu_tx_addr()
{
    // piggyback off identical display
    display_menu_disp_addr();
}

void display_init_ledger()
{
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
}

void display_prompt_tx()
{
    clear_display();
    
    if(ui_state.menu_idx == get_tx_arr_sz()-1) {
        write_display("Approve", TYPE_STR, MID);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        return;
    }
    else if(ui_state.menu_idx == get_tx_arr_sz()) {
        write_display("Deny", TYPE_STR, MID);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        return;
    }
    
    // TODO (final tx if change notify it's change address)
    
    // even indices (not include approve/deny)
    // will be amounts, odd will be addr
    if(ui_state.menu_idx % 2 == 0)
        display_advanced_tx_value();
    else
        display_advanced_tx_address();
}

void display_unknown_state()
{
    clear_display();
    write_display("UI ERROR", TYPE_STR, MID);
    
    display_glyphs_confirm(NULL, NULL);
}
