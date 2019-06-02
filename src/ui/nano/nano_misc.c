#include "ui/nano/nano_misc.h"
#include <stdbool.h>
#include <string.h>
#include "iota/bundle.h"
#include "iota/iota_types.h"
#include "macros.h"
#include "os.h"
#include "ui/ui_common.h"

// go to state with menu index
void nano_state_set(UI_STATES_NANO state, uint8_t idx)
{
    ui_state.state = state;
    ui_state.menu_idx = idx;
}

void nano_state_set_ignore()
{
    nano_state_backup();
    ui_state.state = STATE_IGNORE;
}

void nano_state_backup()
{
    ui_state.nano_state_backup = ui_state.state;
    ui_state.backup_menu_idx = ui_state.menu_idx;
}

void nano_state_restore()
{
    nano_state_set(ui_state.nano_state_backup, ui_state.backup_menu_idx);

    ui_state.nano_state_backup = STATE_MAIN_MENU;
    ui_state.backup_menu_idx = 0;
}

void nano_draw_screen(const UI_SCREENS_NANO screen)
{
    // reset all screen elements
    ui_state.flags.elements = 0;
    // reset all text
    MEMCLEAR(ui_text);

    // always draw the element to clear the screen
    NANO_DRAW_ELEMENTS(EL_CLEAR);

    switch (screen) {
    case SCREEN_TITLE:
        NANO_DRAW_ELEMENTS(EL_TITLE);
        break;
    case SCREEN_ICON:
        NANO_DRAW_ELEMENTS(EL_ICON);
        break;
    case SCREEN_ICON_MULTI:
        NANO_DRAW_ELEMENTS(EL_ICON_MULTI);
        break;
#ifdef TARGET_NANOS
    case SCREEN_MENU:
        NANO_DRAW_ELEMENTS(EL_MENU);
        break;
#else
    case SCREEN_BIP:
        NANO_DRAW_ELEMENTS(EL_BIP);
        break;
    case SCREEN_ADDR:
        NANO_DRAW_ELEMENTS(EL_ADDR);
        break;
#endif
    default:
        THROW_PARAMETER("screen");
    }
}

void nano_draw_text(const char *text, UI_TEXT_POS pos)
{
    char *msg = nano_get_text_buffer(pos);

    // NULL value sets line blank
    if (text == NULL) {
        msg[0] = '\0';
        return;
    }

    snprintf(msg, TEXT_LEN, "%s", text);
}

void nano_draw_menu_text(const char text[][TEXT_LEN], const unsigned int rows)
{
#ifdef TARGET_NANOS
    // display 1 full and 2 half rows on the Nano S
    int row = ui_state.menu_idx - 1;
    if (row >= 0) {
        nano_draw_text(text[row], TOP_H);
        NANO_DRAW_ELEMENTS(EL_UP);
    }

    row++;
    nano_draw_text(text[row], MID);

    row++;
    if ((unsigned int)row < rows) {
        nano_draw_text(text[row], BOT_H);
        NANO_DRAW_ELEMENTS(EL_DOWN);
    }
#else
    // display 4 full rows on the Nano X
    const UI_TEXT_POS text_pos[] = {TOP, MID, BOT, POS_X};
    const unsigned int num_pos = ARRAY_SIZE(text_pos);

    const unsigned int row = ui_state.menu_idx * num_pos;
    for (unsigned int i = 0; i < num_pos; i++) {
        if (row + i >= rows) {
            break;
        }
        nano_draw_text(text[row + i], text_pos[i]);
    }

    // only show up glyph if one row was left out
    if (row > 0) {
        NANO_DRAW_ELEMENTS(EL_UP);
    }
    // only show down glyph if one row is still remaining
    if (row + num_pos < rows) {
        NANO_DRAW_ELEMENTS(EL_DOWN);
    }
#endif
}

void format_value(int64_t val, char text[TEXT_LEN])
{
    // always display the absolute value
    val = ABS(val);

    if (ui_state.flags.full_value || val < 1000) {
        format_value_full(text, TEXT_LEN_VALUE + 1, val);
    }
    else {
        format_value_short(text, TEXT_LEN, val);
    }
}

void format_address_abbrev(const char *addr, char text[TEXT_LEN])
{
    const char sep[] = " ... ";
    const size_t sep_len = sizeof(sep) - 1; // don't count termination
    const size_t chunk_len =
        MIN(TEXT_LEN_ADDRESS_ABBREV - sep_len, NUM_HASH_TRYTES) / 2;

    strncpy(text, addr, chunk_len);
    strncpy(text + chunk_len, sep, sep_len);
    strncpy(text + chunk_len + sep_len, addr + NUM_HASH_TRYTES - chunk_len,
            chunk_len);

    const size_t abbrev_len = 2 * chunk_len + sep_len;
    if (abbrev_len < TEXT_LEN) {
        text[abbrev_len] = '\0';
    }
}

void format_address_checksum(const char *addr, char text[TEXT_LEN])
{
    char buffer[NUM_CHECKSUM_TRYTES + 1] = {};
    strncpy(buffer, addr + NUM_HASH_TRYTES, NUM_CHECKSUM_TRYTES);

    snprintf(text, TEXT_LEN, "Chk: %s", buffer);
}

void format_address_full(const char *addr, char text[][TEXT_LEN])
{
    const char *end = addr + NUM_ADDRESS_TRYTES;

    unsigned int row = 0;
    unsigned int pos = 0;
    while (addr < end) {
        // increase row, if next chunk does not fit
        if (pos + 1 + MENU_ADDR_CHUNK_LEN > TEXT_LEN_ADDRESS_FULL) {
            row++;
            pos = 0;
        }
        // print space to separate chunks
        if (pos > 0) {
            text[row][pos++] = ' ';
        }

        strncpy(text[row] + pos, addr, MIN(end - addr, MENU_ADDR_CHUNK_LEN));
        pos += MENU_ADDR_CHUNK_LEN;
        addr += MENU_ADDR_CHUNK_LEN;

        // assure zero termination
        text[row][pos] = '\0';
    }
}

void format_bip_path(const API_CTX *api, char text[2][TEXT_LEN])
{
    // the highest bit marks an hardened element
    const uint32_t hardened_bit = 1U << 31;

    // the longest possible path "2c'/107a'/ffffffff'/
    // ffffffff'/ffffffff'" fits exactly into two rows
    unsigned int row = 0;
    size_t chars_written = 0;
    for (unsigned int i = 0; i < api->bip32_path_length; i++) {
        const bool is_hardened = (api->bip32_path[i] & hardened_bit);
        const bool is_last = (i == api->bip32_path_length - 1);

        // increase row, if there might be not enough space for this element
        if (chars_written + 8 + (is_hardened ? 1 : 0) + (is_last ? 0 : 1) + 1 >
            TEXT_LEN) {
            // terminate the current line
            text[row][chars_written] = '\0';

            // this should not happen as two rows are enough to fit any bip path
            if (row > 0) {
                THROW(INVALID_STATE);
            }
            // move to first position of next row
            row++;
            chars_written = 0;
        }

        // write the element as hex
        snprintf(text[row] + chars_written, TEXT_LEN - chars_written, "%x",
                 api->bip32_path[i] & ~hardened_bit);
        chars_written = strnlen(text[row], TEXT_LEN);

        // write apostroph if hardened
        if (is_hardened) {
            text[row][chars_written++] = '\'';
        }
        // write the separator only if not last element
        if (!is_last) {
            text[row][chars_written++] = '|';
        }
    }

    // terminate the current line
    text[row][chars_written] = '\0';
}

uint8_t get_menu_bundle_len()
{
    const uint8_t num_value_txs = bundle_get_num_value_txs(&api.ctx.bundle);

    return (num_value_txs * 2) + 2;
}
