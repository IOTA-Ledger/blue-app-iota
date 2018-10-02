#include "ui_misc.h"
#include <string.h>
#include "common.h"
#include "iota/addresses.h"
#include "ui.h"

/// the largest power of 10 that still fits into int32
#define MAX_INT_DEC INT64_C(1000000000)

/// the different IOTA units
static const char IOTA_UNITS[][3] = {"i", "Ki", "Mi", "Gi", "Ti", "Pi"};

// go to state with menu index
void state_go(uint8_t state, uint8_t idx)
{
    ui_state.state = state;
    ui_state.menu_idx = idx;
}

void state_return(uint8_t state, uint8_t idx)
{
    state_go(state, idx);
}

void backup_state()
{
    ui_state.backup_state = ui_state.state;
    ui_state.backup_menu_idx = ui_state.menu_idx;
}

void restore_state()
{
    state_return(ui_state.backup_state, ui_state.backup_menu_idx);

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
static void clear_text()
{
    write_display(NULL, TOP);
    write_display(NULL, MID);
    write_display(NULL, BOT);
}

// Checks for custom glyphs that require their own screen
void check_special_glyph(UI_GLYPH_TYPES g)
{
    switch (g) {
    case GLYPH_IOTA:
        ui_set_screen(SCREEN_IOTA);
        break;
    case GLYPH_BACK:
        ui_set_screen(SCREEN_BACK);
        break;
    default:
        return;
    }
}

// Turns a single glyph on or off
void glyph_on(UI_GLYPH_TYPES g)
{
    if (g < TOTAL_GLYPHS)
        ui_glyphs.glyph[g] = '\0';
    else
        check_special_glyph(g);
}

void glyph_off(UI_GLYPH_TYPES g)
{
    if (g < TOTAL_GLYPHS)
        ui_glyphs.glyph[g] = '.';
}

void clear_glyphs()
{
    // turn off all glyphs
    glyph_off(GLYPH_CONFIRM);
    glyph_off(GLYPH_UP);
    glyph_off(GLYPH_DOWN);
    glyph_off(GLYPH_WARN);
    glyph_off(GLYPH_LOAD);
    glyph_off(GLYPH_DASH);
}

void clear_display()
{
    clear_text();
    clear_glyphs();
}

// turns on 2 glyphs (often glyph on left + right)
void display_glyphs(UI_GLYPH_TYPES g1, UI_GLYPH_TYPES g2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(g1);
    glyph_on(g2);
}

// combine glyphs with bars along top for confirm
void display_glyphs_confirm(UI_GLYPH_TYPES g1, UI_GLYPH_TYPES g2)
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

static size_t snprint_int64(char *s, size_t n, int64_t val)
{
    // we cannot display the full range of int64 with this function
    if (ABS(val) >= MAX_INT_DEC * MAX_INT_DEC) {
        THROW(INVALID_PARAMETER);
    }

    if (ABS(val) < MAX_INT_DEC) {
        snprintf(s, n, "%d", (int)val);
    }
    else {
        // emulate printing of integers larger than 32 bit
        snprintf(s, n, "%d%09d", (int)(val / MAX_INT_DEC),
                 (int)(ABS(val) % MAX_INT_DEC));
    }
    return strnlen(s, n);
}

/// groups the string by adding a comma every 3 chars from the right
static size_t str_add_commas(char *dst, const char *src, size_t num_len)
{
    char *p_dst = dst;
    const char *p_src = src;

    // ignore leading minus
    if (*p_src == '-') {
        *p_dst++ = *p_src++;
        num_len--;
    }
    for (int commas = 2 - num_len % 3; *p_src; commas = (commas + 1) % 3) {
        *p_dst++ = *p_src++;
        if (commas == 1) {
            *p_dst++ = ',';
        }
    }
    // remove the last comma and zero-terminate
    *--p_dst = '\0';

    return (p_dst - dst);
}

// display full amount in base iotas without commas Ex. 3040981551 i
static void write_full_val(int64_t val, UI_TEXT_POS pos)
{
    char buffer[TEXT_LEN];
    char *msg = get_str_buffer(pos);

    const size_t num_len = snprint_int64(buffer, sizeof buffer, val);

    // numbers shorter will have at most 3 commas and fit the text length
    if (num_len > 13) {
        snprintf(msg, TEXT_LEN, "%s %s", buffer, IOTA_UNITS[0]);
    }
    else {
        const size_t chars_written = str_add_commas(msg, buffer, num_len);
        snprintf(msg + chars_written, TEXT_LEN - chars_written, " %s",
                 IOTA_UNITS[0]);
    }
}

// displays brief amount with units Ex. 3.040 Gi
static void write_readable_val(int64_t val, UI_TEXT_POS pos)
{
    char *msg = get_str_buffer(pos);

    if (ABS(val) < 1000) {
        snprintf(msg, TEXT_LEN, "%d %s", (int)(val), IOTA_UNITS[0]);
        return;
    }

    unsigned int base = 1;
    while (ABS(val) >= 1000 * 1000) {
        val /= 1000;
        base++;
    }
    if (base >= sizeof(IOTA_UNITS) / sizeof(IOTA_UNITS[0])) {
        THROW(INVALID_PARAMETER);
    }

    snprintf(msg, TEXT_LEN, "%d.%03d %s", (int)(val / 1000),
             (int)(ABS(val) % 1000), IOTA_UNITS[base]);
}

// displays full/readable value based on the ui_state
static bool display_value(int64_t val, UI_TEXT_POS pos)
{
    if (ui_state.display_full_value || ABS(val) < 1000) {
        write_full_val(val, pos);
    }
    else {
        write_readable_val(val, pos);
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
    uint8_t i = 0, counter = 0;

    while (i <= api.bundle_ctx.last_tx_index) {
        if (api.bundle_ctx.values[i] != 0)
            counter++;

        i++;
    }

    return (counter * 2) + 2;
}

uint8_t menu_to_tx_idx()
{
    // each non-meta tx prompt will have 2 screens
    // i counts number of non-meta tx's, j just iterates
    uint8_t i = 0, j = 0;

    while (j <= api.bundle_ctx.last_tx_index && i <= ui_state.menu_idx / 2) {
        if (api.bundle_ctx.values[j] != 0) {
            i++;
        }
        j++;
    }

    // j cannot be 0, because <=, so even if last_idx and menu_idx are 0,
    // it will still execute once (incrementing j in the process).

    // j will be incremented one beyond our desired index
    return j - 1;
}
