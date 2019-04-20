#include "nanos_misc.h"
#include <string.h>
#include "ui.h"
#include "api.h"
#include "s_core.h"
#include "ui_common.h"
#include "iota/addresses.h"

// go to state with menu index
void state_go(uint8_t state, uint8_t idx)
{
    ui_state.state = state;
    ui_state.menu_idx = idx;
}

void backup_state()
{
    ui_state.backup_state = ui_state.state;
    ui_state.backup_menu_idx = ui_state.menu_idx;
}

void restore_state()
{
    state_go(ui_state.backup_state, ui_state.backup_menu_idx);

    ui_state.backup_state = STATE_MAIN_MENU;
    ui_state.backup_menu_idx = 0;
}

void abbreviate_addr(char *dest, const char *src)
{
    // copy the abbreviated address over
    strncpy(dest, src, 4);
    strncpy(dest + 4, " ... ", 5);
    strncpy(dest + 9, src + 77, 4);
    dest[13] = '\0';
}

/** @brief Returns buffer for corresponding position. */
static char *get_str_buffer(UI_TEXT_POS pos)
{
    switch (pos) {
    case TOP_H:
    case TOP:
        return ui_text.top_str;
    case BOT:
    case BOT_H:
        return ui_text.bot_str;
    case MID:
        return ui_text.mid_str;
    default:
        THROW(INVALID_PARAMETER);
    }
}

void write_display(const char *string, UI_TEXT_POS pos)
{
    char *msg = get_str_buffer(pos);

    // NULL value sets line blank
    if (string == NULL) {
        msg[0] = '\0';
        return;
    }
    snprintf(msg, TEXT_LEN, "%s", string);
}

/* --------- STATE RELATED FUNCTIONS ----------- */

// Checks for custom glyphs that require their own screen
static void check_special_glyph(UI_GLYPH_TYPES_NANOS g)
{
    switch (g) {
    case GLYPH_IOTA:
        nanos_set_screen(SCREEN_IOTA);
        break;
    case GLYPH_BACK:
        nanos_set_screen(SCREEN_BACK);
        break;
    default:
        return;
    }
}

// Turns a single glyph on or off
void glyph_on(UI_GLYPH_TYPES_NANOS g)
{
    if (g < TOTAL_GLYPHS)
        ui_glyphs.glyph[g] = '\0';
    else
        check_special_glyph(g);
}

static void clear_text()
{
    write_display(NULL, TOP);
    write_display(NULL, MID);
    write_display(NULL, BOT);
}

static void glyph_off(UI_GLYPH_TYPES_NANOS g)
{
    if (g < TOTAL_GLYPHS) {
        ui_glyphs.glyph[g] = '.';
    }
}

static void clear_glyphs()
{
    // turn off all glyphs
    glyph_off(GLYPH_CONFIRM);
    glyph_off(GLYPH_UP);
    glyph_off(GLYPH_DOWN);
    glyph_off(GLYPH_LOAD);
    glyph_off(GLYPH_DASH);
}

void clear_display()
{
    clear_text();
    clear_glyphs();
}

// turns on 2 glyphs (often glyph on left + right)
void display_glyphs(UI_GLYPH_TYPES_NANOS g1, UI_GLYPH_TYPES_NANOS g2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(g1);
    glyph_on(g2);
}

// combine glyphs with bars along top for confirm
void display_glyphs_confirm(UI_GLYPH_TYPES_NANOS g1, UI_GLYPH_TYPES_NANOS g2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(GLYPH_CONFIRM);
    glyph_on(g1);
    glyph_on(g2);
}

void write_text_array(const char *array, uint8_t len)
{
    clear_display();
    clear_glyphs();

    if (ui_state.menu_idx > 0) {
        write_display(array + (TEXT_LEN * (ui_state.menu_idx - 1)), TOP_H);
        glyph_on(GLYPH_UP);
    }

    write_display(array + (TEXT_LEN * ui_state.menu_idx), MID);

    if (ui_state.menu_idx < len - 1) {
        write_display(array + (TEXT_LEN * (ui_state.menu_idx + 1)), BOT_H);
        glyph_on(GLYPH_DOWN);
    }
}

/* --------- FUNCTIONS FOR DISPLAYING BALANCE ----------- */

// displays full/readable value based on the ui_state
static bool display_value(int64_t val, UI_TEXT_POS pos)
{
    if (ui_state.display_full_value || ABS(val) < 1000) {
        write_full_val(val, get_str_buffer(pos), TEXT_LEN);
    }
    else {
        write_readable_val(val, get_str_buffer(pos), TEXT_LEN);
    }

    // return whether a shortened version is possible
    return ABS(val) >= 1000;
}

// swap between full value and readable value
void value_convert_readability()
{
    ui_state.display_full_value = !ui_state.display_full_value;
}

void display_advanced_tx_value()
{
    ui_state.val = api.bundle_ctx.values[menu_to_tx_idx()];

    if (ui_state.val > 0) { // outgoing tx
        // -1 is deny, -2 approve, -3 addr, -4 val of change
        if (ui_state.menu_idx == get_tx_arr_sz() - 4) {
            char msg[TEXT_LEN];
            // write the index along with Change
            snprintf(msg, sizeof msg, "Change: [%u]",
                     (unsigned int)
                         api.bundle_ctx.indices[api.bundle_ctx.last_tx_index]);

            write_display(msg, TOP);
        }
        else
            write_display("Output:", TOP);
    }
    else {
        // input tx (skip meta)
        char msg[TEXT_LEN];
        snprintf(msg, sizeof msg, "Input: [%u]",
                 (unsigned int)api.bundle_ctx.indices[menu_to_tx_idx()]);

        write_display(msg, TOP);
        ui_state.val = -ui_state.val;
    }

    // display_value returns true if readable form is possible
    if (display_value(ui_state.val, BOT))
        display_glyphs_confirm(GLYPH_UP, GLYPH_DOWN);
    else
        display_glyphs(GLYPH_UP, GLYPH_DOWN);
}

void display_advanced_tx_address()
{
    const unsigned char *addr_bytes =
        bundle_get_address_bytes(&api.bundle_ctx, menu_to_tx_idx());

    get_address_with_checksum(addr_bytes, ui_state.addr);

    char abbrv[14];
    abbreviate_addr(abbrv, ui_state.addr);

    write_display(abbrv, TOP);
    write_display("Chk: ", BOT);

    // copy the remaining 9 chars in the buffer
    memcpy(ui_text.bot_str + 5, ui_state.addr + 81, 9);

    display_glyphs_confirm(GLYPH_UP, GLYPH_DOWN);
}

uint8_t get_tx_arr_sz()
{
    uint8_t counter = 0;

    for (unsigned int i = 0; i <= api.bundle_ctx.last_tx_index; i++) {
        if (api.bundle_ctx.values[i] != 0) {
            counter++;
        }
    }

    return (counter * 2) + 2;
}
