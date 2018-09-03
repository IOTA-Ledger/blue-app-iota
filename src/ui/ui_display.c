#include "ui_display.h"
#include <string.h>
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
        write_display_str(NULL, BOT_H);
        break;
        // turn off TOP_H
    case MENU_WELCOME_LEN - 1:
        write_display_str(NULL, TOP_H);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_dash);
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
        write_display_str(NULL, BOT_H);
        break;
        // turn off TOP_H
    case MENU_ABOUT_LEN - 1:
        write_display_str(NULL, TOP_H);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_dash);
    }
}

void display_version()
{
    clear_display();
    write_display_str(APPVERSION, MID);

    display_glyphs_confirm(ui_glyphs.glyph_dash, NULL);
}

void display_more_info()
{
    // write the actual menu
    char msg[MENU_MORE_INFO_LEN * 21];
    get_more_info_menu(msg);
    write_text_array(msg, MENU_MORE_INFO_LEN);
}

void display_bip_path()
{
    clear_display();

    char *msg[] = {ui_text.top_str, ui_text.bot_str};

    int row = 0;
    size_t chars_written = 0;
    for (unsigned int i = 0; i < api.bip32_path_length; i++) {

        // this cannot happen, as "2c'/107a'/ffffffff'/\nffffffff'/ffffffff'"
        // fits exactly into two rows
        if (row > 1) {
            THROW(INVALID_STATE);
        }

        snprintf(msg[row] + chars_written, 21 - chars_written, "%x",
                 api.bip32_path[i] & 0x7fffffff);
        chars_written = strnlen(msg[row], 21);

        // write apostroph if hardnend
        if (api.bip32_path[i] & (1u << 31)) {
            msg[row][chars_written++] = '\'';
        }

        // write the separator only if not last element
        if (i < api.bip32_path_length - 1) {
            msg[row][chars_written++] = '|';
        }

        // inc row, if there might be not enough space for the next level
        if (chars_written > 20 - 10) {
            msg[row++][chars_written] = '\0';
            chars_written = 0;
        }
    }

    // make sure that the current row is terminated
    if (row <= 1) {
        msg[row][chars_written] = '\0';
    }

    display_glyphs_confirm(ui_glyphs.glyph_up, NULL);
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

    // add down arrow to show bip path, don't show
    // bip path on output addr of a tx
    if (ui_state.menu_idx == MENU_ADDR_LEN - 1 &&
        !(ui_state.backup_state == STATE_PROMPT_TX &&
          ui_state.backup_menu_idx == 1)) {
        glyph_on(ui_glyphs.glyph_down);
    }
}

void display_addr_chk()
{
    clear_display();

    char abbrv[14];
    abbreviate_addr(abbrv, ui_state.addr, 81);

    write_display_str(abbrv, TOP);
    write_display_str("Chk: ", BOT);

    // copy the remaining 9 chars in the buffer
    os_memcpy(ui_text.bot_str + 5, ui_state.addr + 81, 9);

    display_glyphs_confirm(NULL, ui_glyphs.glyph_down);
}

void display_tx_addr()
{
    // piggyback off identical display
    display_addr();
}

void display_prompt_tx()
{
    clear_display();

    if (ui_state.menu_idx == get_tx_arr_sz() - 2) {
        write_display_str("Approve", MID);
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
        return;
    }
    else if (ui_state.menu_idx == get_tx_arr_sz() - 1) {
        write_display_str("Deny", MID);
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

void display_unknown_state()
{
    clear_display();
    write_display_str("UI ERROR", MID);

    display_glyphs_confirm(NULL, NULL);
}
