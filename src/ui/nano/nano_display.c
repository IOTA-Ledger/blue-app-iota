#include <string.h>
#include "api.h"
#include "ui.h"
#include "nano_display.h"
#include "nano_text.h"
#include "nano_misc.h"
#include "nano_core.h"
#include "nano_types.h"

void display_main_menu()
{
#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);
#else
    nano_set_screen(SCREEN_ICON);
#endif

    // write the actual menu
    char msg[MENU_MAIN_LEN * TEXT_LEN];
    get_main_menu(msg);
    write_text_array(msg, MENU_MAIN_LEN);

    // Turn off menu effect
    write_display(NULL, TOP_H);
    write_display(NULL, BOT_H);

    // special override display states
    switch (ui_state.menu_idx) {

    case MENU_MAIN_IOTA:
#ifdef TARGET_NANOS
        display_glyphs_confirm(GLYPH_IOTA, GLYPH_DOWN);
#else
        display_glyphs_confirm(GLYPH_IOTA, GLYPH_NONE);
#endif
        write_display("IOTA", MID);
        break;

#ifdef TARGET_NANOX
    case MENU_MAIN_ABOUT:
        display_glyphs(GLYPH_INFO, GLYPH_UP);
        glyph_on(GLYPH_DOWN);
        break;
#endif

    case MENU_MAIN_EXIT:
        display_glyphs_confirm(GLYPH_UP, GLYPH_DASH);
        break;
    }
}

void display_about()
{
#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);
#else
    nano_set_screen(SCREEN_TITLE);
#endif

    // write the actual menu
    char msg[MENU_ABOUT_LEN * TEXT_LEN];
    get_about_menu(msg);
    write_text_array(msg, MENU_ABOUT_LEN);

    // special override display states
    switch (ui_state.menu_idx) {
#ifdef TARGET_NANOS
    case MENU_ABOUT_MORE_INFO:
        // turn off BOT_H
        write_display(NULL, BOT_H);
        break;

    case MENU_ABOUT_BACK:
        // turn off TOP_H
        write_display(NULL, TOP_H);
        display_glyphs_confirm(GLYPH_UP, GLYPH_BACK);
        break;
#else  // NANOX
    case MENU_ABOUT_VERSION:
        write_display("Version", TOP);
        write_display(APPVERSION, BOT);
        display_glyphs_confirm(GLYPH_DOWN, GLYPH_NONE);
        break;

    case MENU_ABOUT_MORE_INFO:
        write_display("More Info:", TOP);
        write_display("iota.org/sec", BOT);
        break;

    case MENU_ABOUT_BACK:
        nano_set_screen(SCREEN_ICON);
        display_glyphs_confirm(GLYPH_UP, GLYPH_BACK);
        break;
#endif // TARGET_NANOS/X
    }
}

void display_version()
{
#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);

    clear_display();

    write_display(APPVERSION, MID);
    display_glyphs_confirm(GLYPH_BACK, GLYPH_NONE);
#endif // TARGET_NANOS
}

void display_more_info()
{
#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);

    // write the actual menu
    char msg[MENU_MORE_INFO_LEN * TEXT_LEN];
    get_more_info_menu(msg);
    write_text_array(msg, MENU_MORE_INFO_LEN);

    glyph_on(GLYPH_CONFIRM);
#endif // TARGET_NANOS
}

static void display_bip_path_string()
{
    clear_display();

#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_TITLE);

    // start the string in the top row
    char *msg = ui_text.top_str;
#else
    nano_set_screen(SCREEN_BIP);
    write_display("BIP32 Path:", TOP);

    // start the string in the middle row
    char *msg = ui_text.mid_str;
#endif

    // the longest possible path "2c'/107a'/ffffffff'/
    // ffffffff'/ffffffff'" fits exactly into two rows
    size_t chars_written = 0;
    for (unsigned int i = 0; i < api.bip32_path_length; i++) {
        snprintf(msg + chars_written, TEXT_LEN - chars_written, "%x",
                 api.bip32_path[i] & 0x7fffffff);
        chars_written = strnlen(msg, TEXT_LEN);

        // write apostroph if hardnend
        if (api.bip32_path[i] & (1u << 31)) {
            msg[chars_written++] = '\'';
        }

        // write the separator only if not last element
        if (i < api.bip32_path_length - 1) {
            msg[chars_written++] = '|';
        }

        // inc row, if there might be not enough space for the next level
        if (chars_written > TEXT_LEN - 11 && msg != ui_text.bot_str) {
            // terminate the current line
            if (chars_written < TEXT_LEN) {
                msg[chars_written] = '\0';
            }

            // move to first position of bottom row
            msg = ui_text.bot_str;
            chars_written = 0;
        }
    }

    // terminate the current line
    if (chars_written < TEXT_LEN) {
        msg[chars_written] = '\0';
    }

    display_glyphs_confirm(GLYPH_UP, GLYPH_NONE);
}

void display_bip_path()
{
#ifdef TARGET_NANOS
    if (ui_state.menu_idx == 0) {
        clear_display();
        nano_set_screen(SCREEN_MENU);

        write_display("BIP32 Path:", MID);
        display_glyphs_confirm(GLYPH_UP, GLYPH_DOWN);
    }
    else {
        display_bip_path_string();
    }
#else
    // display the path directly
    display_bip_path_string();
#endif
}

void display_addr()
{
    // write the actual menu
    char msg[MENU_ADDR_LEN * TEXT_LEN];
    get_address_menu(msg);
#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);
    write_text_array(msg, MENU_ADDR_LEN);

    // glyph on to avoid overwriting write_text_array
    glyph_on(GLYPH_CONFIRM);
#else
    nano_set_screen(SCREEN_ADDR);
    // Write whole addr on 2 screens
    if (ui_state.menu_idx == 0) {
        display_glyphs_confirm(GLYPH_NONE, GLYPH_DOWN);
        write_display(msg, TOP);
        write_display(msg + 21, MID);
        write_display(msg + 42, BOT);
        write_display(msg + 63, POS_X);
    }
    else {
        display_glyphs_confirm(GLYPH_UP, GLYPH_NONE);
        write_display(msg + 84, TOP);
        write_display(msg + 105, MID);
        write_display(msg + 126, BOT);
        write_display(msg + 147, POS_X);
    }
#endif

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
    // both X and S use SCREEN_TITLE here
    nano_set_screen(SCREEN_TITLE);

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
    // for approve/deny, rest get set to title
#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);
#else
    nano_set_screen(SCREEN_ICON);
#endif

    clear_display();

    const uint8_t tx_array_sz = get_tx_arr_sz();

    // can't use switch statement because array sz isn't known
    if (ui_state.menu_idx == MENU_TX_APPROVE) {
        write_display("Approve", MID);
        display_glyphs_confirm(GLYPH_UP, GLYPH_DOWN);
#ifdef TARGET_NANOX
        glyph_on(GLYPH_CHECK);
#endif
        return;
    }
    else if (ui_state.menu_idx == MENU_TX_DENY) {
        write_display("Deny", MID);
        display_glyphs_confirm(GLYPH_UP, GLYPH_DOWN);
#ifdef TARGET_NANOX
        glyph_on(GLYPH_CROSS);
#endif
        return;
    }

    // if not approve/deny, it will be a title screen (top/bottom)
    nano_set_screen(SCREEN_TITLE);

    // even indices (not include approve/deny)
    // will be amounts, odd will be addr
    if (ui_state.menu_idx % 2 == 0)
        display_advanced_tx_value();
    else
        display_advanced_tx_address();
}

void display_unknown_state()
{
#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);
#else
    nano_set_screen(SCREEN_ICON);
#endif

    clear_display();
    write_display("UI ERROR", MID);

    display_glyphs_confirm(GLYPH_NONE, GLYPH_NONE);
}
