#include "ui_display.h"
#include "common.h"
#include "ui.h"
#include "ui_types.h"
#include "ui_misc.h"

void display_init()
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

void display_welcome()
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

void display_about()
{
    // write the actual menu
    char msg[MENU_ABOUT_LEN * 21];
    get_about_menu(msg);
    write_text_array(msg, MENU_ABOUT_LEN);

    // special override display states
    switch (ui_state.menu_idx) {
    case MENU_ABOUT_LEN - 2:
        write_display(NULL, TYPE_STR, BOT_H);
        break;
        // turn off TOP_H
    case MENU_ABOUT_LEN - 1:
        write_display(NULL, TYPE_STR, TOP_H);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_dash);
    }
}

void display_version()
{
    clear_display();
    char msg[10];

    for (uint8_t i = 0; i < 8; i++) {
        msg[i] = app_version[i];
    }

    write_display(msg, TYPE_STR, MID);

    display_glyphs_confirm(ui_glyphs.glyph_dash, NULL);
}

void display_more_info()
{
    // write the actual menu
    char msg[MENU_MORE_INFO_LEN * 21];
    get_more_info_menu(msg);
    write_text_array(msg, MENU_MORE_INFO_LEN);

    // no special overrides
}

void display_idxs()
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

void display_addr()
{
    // write the actual menu
    char msg[MENU_ADDR_LEN * 21];
    get_address_menu(msg);
    write_text_array(msg, MENU_ADDR_LEN);

    glyph_on(ui_glyphs.glyph_bar_l);
    glyph_on(ui_glyphs.glyph_bar_r);

    // special overrides
    if (ui_state.menu_idx == 0 && ui_state.state == STATE_DISP_ADDR)
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
    os_memcpy(ui_text.bot_str + 5, ui_state.addr + 81, 9);

    display_glyphs_confirm(NULL, ui_glyphs.glyph_down);
}

void display_tx_addr()
{
    // piggyback off identical display
    display_addr();
}

void display_write_indexes()
{
    // write the actual menu
    char msg[MENU_WRITE_INDEXES_LEN * 21];
    get_write_indexes_menu(msg);
    write_text_array(msg, MENU_WRITE_INDEXES_LEN);

    // special override display states
    switch (ui_state.menu_idx) {
    case 0:
        glyph_on(ui_glyphs.glyph_warn);
        break;
    case MENU_WRITE_INDEXES_LEN - 3: // [5]
        write_display(NULL, TYPE_STR, BOT_H);
        break;
    case MENU_WRITE_INDEXES_LEN - 2: // Approve
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        write_display(NULL, TYPE_STR, BOT_H);
        write_display(NULL, TYPE_STR, TOP_H);
        break;
        // turn off TOP_H
    case MENU_WRITE_INDEXES_LEN - 1: // Deny
        display_glyphs_confirm(ui_glyphs.glyph_up, NULL);
        write_display(NULL, TYPE_STR, TOP_H);
        break;
    }
}

void display_prompt_tx()
{
    clear_display();

    if (ui_state.menu_idx == get_tx_arr_sz() - 2) {
        write_display("Approve", TYPE_STR, MID);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        return;
    }
    else if (ui_state.menu_idx == get_tx_arr_sz() - 1) {
        write_display("Deny", TYPE_STR, MID);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        return;
    }

    // even indices (not include approve/deny)
    // will be amounts, odd will be addr
    if (ui_state.menu_idx % 2 == 0)
        display_advanced_tx_value();
    else
        display_advanced_tx_address();
}

void display_warn_change()
{
    // write the actual menu
    char msg[MENU_WARN_CHANGE_LEN * 21];
    get_warn_change_menu(msg);
    write_text_array(msg, MENU_WARN_CHANGE_LEN);

    // special override display states
    switch (ui_state.menu_idx) {
    case 0:
        glyph_on(ui_glyphs.glyph_warn);
        break;
    case MENU_WARN_CHANGE_LEN - 3: // Are you sure?
        write_display(NULL, TYPE_STR, BOT_H);
        break;
    case MENU_WARN_CHANGE_LEN - 2: // Yes
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        write_display(NULL, TYPE_STR, BOT_H);
        write_display(NULL, TYPE_STR, TOP_H);
        break;
        // turn off TOP_H
    case MENU_WARN_CHANGE_LEN - 1: // No
        display_glyphs_confirm(ui_glyphs.glyph_up, NULL);
        write_display(NULL, TYPE_STR, TOP_H);
        break;
    }
}

void display_unknown_state()
{
    clear_display();
    write_display("UI ERROR", TYPE_STR, MID);

    display_glyphs_confirm(NULL, NULL);
}
