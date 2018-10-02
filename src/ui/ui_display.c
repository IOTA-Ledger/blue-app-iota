#include "ui_display.h"
#include <string.h>
#include "common.h"
#include "ui.h"
#include "ui_types.h"
#include "ui_text.h"
#include "ui_misc.h"

void display_init()
{
    ui_set_screen(SCREEN_MENU);

    // write the actual menu
    char msg[MENU_INIT_LEN * TEXT_LEN];
    get_init_menu(msg);
    write_text_array(msg, MENU_INIT_LEN);

    // special override display states
    switch (ui_state.menu_idx) {

    case 0: // first menu entry
        glyph_on(GLYPH_WARN);
        break;
    case MENU_INIT_LAST:
        display_glyphs_confirm(GLYPH_UP, GLYPH_NONE);
        break;
    }
}

void display_main_menu()
{
    ui_set_screen(SCREEN_MENU);

    // write the actual menu
    char msg[MENU_MAIN_LEN * TEXT_LEN];
    get_main_menu(msg);
    write_text_array(msg, MENU_MAIN_LEN);

    // Turn off menu effect
    write_display(NULL, TOP_H);
    write_display(NULL, BOT_H);

    // special override display states
    switch (ui_state.menu_idx) {

    case MENU_MAIN_CONNECT:
        display_glyphs_confirm(GLYPH_IOTA, GLYPH_DOWN);

        write_display("IOTA", MID);
        break;

    case MENU_MAIN_EXIT:
        display_glyphs_confirm(GLYPH_UP, GLYPH_DASH);
        break;
    }
}

void display_about()
{
    ui_set_screen(SCREEN_MENU);

    // write the actual menu
    char msg[MENU_ABOUT_LEN * TEXT_LEN];
    get_about_menu(msg);
    write_text_array(msg, MENU_ABOUT_LEN);

    // special override display states
    switch (ui_state.menu_idx) {

    case MENU_ABOUT_MORE_INFO:
        // turn off BOT_H
        write_display(NULL, BOT_H);
        break;

    case MENU_ABOUT_BACK:
        // turn off TOP_H
        write_display(NULL, TOP_H);
        display_glyphs_confirm(GLYPH_UP, GLYPH_BACK);
    }
}

void display_version()
{
    ui_set_screen(SCREEN_MENU);

    clear_display();
    write_display(APPVERSION, MID);

    display_glyphs_confirm(GLYPH_BACK, GLYPH_NONE);
}

void display_more_info()
{
    ui_set_screen(SCREEN_MENU);

    // write the actual menu
    char msg[MENU_MORE_INFO_LEN * TEXT_LEN];
    get_more_info_menu(msg);
    write_text_array(msg, MENU_MORE_INFO_LEN);

    glyph_on(GLYPH_CONFIRM);
}

void display_bip_path()
{
    ui_set_screen(SCREEN_TITLE);

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

        snprintf(msg[row] + chars_written, TEXT_LEN - chars_written, "%x",
                 api.bip32_path[i] & 0x7fffffff);
        chars_written = strnlen(msg[row], TEXT_LEN);

        // write apostroph if hardnend
        if (api.bip32_path[i] & (1u << 31)) {
            msg[row][chars_written++] = '\'';
        }

        // write the separator only if not last element
        if (i < api.bip32_path_length - 1) {
            msg[row][chars_written++] = '|';
        }

        // inc row, if there might be not enough space for the next level
        if (chars_written > TEXT_LEN - 11) {
            msg[row++][chars_written] = '\0';
            chars_written = 0;
        }
    }

    // make sure that the current row is terminated
    if (row <= 1) {
        msg[row][chars_written] = '\0';
    }

    display_glyphs_confirm(GLYPH_UP, GLYPH_NONE);
}

void display_addr()
{
    ui_set_screen(SCREEN_MENU);

    // write the actual menu
    char msg[MENU_ADDR_LEN * TEXT_LEN];
    get_address_menu(msg);
    write_text_array(msg, MENU_ADDR_LEN);

    glyph_on(GLYPH_CONFIRM);

    // special overrides

    // if DISP_ADDR then above is actually checksum screen
    if (ui_state.menu_idx == 0 && ui_state.state == STATE_DISP_ADDR)
        glyph_on(GLYPH_UP);

    // add down arrow to show bip path, don't show
    // bip path on output addr of a tx
    if (ui_state.menu_idx == MENU_ADDR_LAST &&
        !(ui_state.backup_state == STATE_PROMPT_TX &&
          ui_state.backup_menu_idx == 1)) {
        glyph_on(GLYPH_DOWN);
    }
}

void display_addr_chk()
{
    ui_set_screen(SCREEN_TITLE);

    clear_display();

    char abbrv[14];
    abbreviate_addr(abbrv, ui_state.addr);

    write_display(abbrv, TOP);
    write_display("Chk: ", BOT);

    // copy the remaining 9 chars in the buffer
    os_memcpy(ui_text.bot_str + 5, ui_state.addr + 81, 9);

    display_glyphs_confirm(GLYPH_NONE, GLYPH_DOWN);
}

void display_tx_addr()
{
    // piggyback off identical display
    display_addr();
}

void display_prompt_tx()
{
    // for approve/deny
    ui_set_screen(SCREEN_MENU);

    clear_display();

    const uint8_t tx_array_sz = get_tx_arr_sz();

    // can't use switch statement because array sz isn't known
    if (ui_state.menu_idx == MENU_TX_APPROVE) {
        write_display("Approve", MID);
        display_glyphs_confirm(GLYPH_UP, GLYPH_DOWN);
        return;
    }
    else if (ui_state.menu_idx == MENU_TX_DENY) {
        write_display("Deny", MID);
        display_glyphs_confirm(GLYPH_UP, GLYPH_DOWN);
        return;
    }

    // if not approve/deny, it will be a title screen (top/bottom)
    ui_set_screen(SCREEN_TITLE);

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
    write_display("UI ERROR", MID);

    display_glyphs_confirm(GLYPH_NONE, GLYPH_NONE);
}
