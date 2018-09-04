#include "ui_misc.h"
#include <string.h>
#include "common.h"
#include "api.h"
#include "storage.h"
#include "iota/addresses.h"

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

void set_backup(uint8_t state, uint8_t menu_idx)
{
    ui_state.backup_state = state;
    ui_state.backup_menu_idx = menu_idx;
}

void restore_state()
{
    state_return(ui_state.backup_state, ui_state.backup_menu_idx);

    ui_state.backup_state = STATE_WELCOME;
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

/** @brief Returns buffer for corresponding position). */
static char *get_str_buffer(UI_TEXT_POS pos)
{
    switch (pos) {
    case TOP_H:
        return ui_text.half_top;
    case TOP:
        return ui_text.top_str;
    case BOT:
        return ui_text.bot_str;
    case BOT_H:
        return ui_text.half_bot;
    case MID:
        return ui_text.mid_str;
    default:
        THROW(INVALID_PARAMETER);
    }
}

void write_display(const char *string, UI_TEXT_POS pos)
{
    char *c_ptr = get_str_buffer(pos);

    // NULL value sets line blank
    if (string == NULL) {
        c_ptr[0] = '\0';
        return;
    }
    snprintf(c_ptr, TEXT_LEN, "%s", string);
}

/* --------- STATE RELATED FUNCTIONS ----------- */
static void clear_text()
{
    write_display(NULL, TOP_H);
    write_display(NULL, TOP);
    write_display(NULL, MID);
    write_display(NULL, BOT);
    write_display(NULL, BOT_H);
}

// Turns a single glyph on or off
void glyph_on(char *c)
{
    if (c != NULL)
        c[0] = '\0';
}

void glyph_off(char *c)
{
    if (c != NULL) {
        c[0] = '.';
        c[1] = '\0';
    }
}

void clear_glyphs()
{
    // turn off all glyphs
    glyph_off(ui_glyphs.glyph_bar_l);
    glyph_off(ui_glyphs.glyph_bar_r);
    glyph_off(ui_glyphs.glyph_cross);
    glyph_off(ui_glyphs.glyph_check);
    glyph_off(ui_glyphs.glyph_up);
    glyph_off(ui_glyphs.glyph_down);
    glyph_off(ui_glyphs.glyph_warn);
    glyph_off(ui_glyphs.glyph_load);
    glyph_off(ui_glyphs.glyph_dash);
}

void clear_display()
{
    clear_text();
    clear_glyphs();
}

// turns on 2 glyphs (often glyph on left + right)
void display_glyphs(char *c1, char *c2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(c1);
    glyph_on(c2);
}

// combine glyphs with bars along top for confirm
void display_glyphs_confirm(char *c1, char *c2)
{
    clear_glyphs();

    // turn on ones we want
    glyph_on(ui_glyphs.glyph_bar_l);
    glyph_on(ui_glyphs.glyph_bar_r);
    glyph_on(c1);
    glyph_on(c2);
}


void write_text_array(const char *array, uint8_t len)
{
    clear_display();
    clear_glyphs();

    if (ui_state.menu_idx > 0) {
        write_display(array + (TEXT_LEN * (ui_state.menu_idx - 1)), TOP_H);
        glyph_on(ui_glyphs.glyph_up);
    }

    write_display(array + (TEXT_LEN * ui_state.menu_idx), MID);

    if (ui_state.menu_idx < len - 1) {
        write_display(array + (TEXT_LEN * (ui_state.menu_idx + 1)), BOT_H);
        glyph_on(ui_glyphs.glyph_down);
    }
}

/* --------- FUNCTIONS FOR DISPLAYING BALANCE ----------- */

uint8_t get_num_digits(int64_t val)
{
    uint8_t i = 0;

    while (val > 0) {
        val /= 10;
        i++;
    }

    return i;
}

// display full amount in base iotas without commas Ex. 3040981551 i
static void write_full_val(int64_t val, UI_TEXT_POS pos)
{
    // we cannot display the full range of int64 with this function
    if (ABS(val) >= MAX_INT_DEC * MAX_INT_DEC) {
        THROW(INVALID_PARAMETER);
    }

    char *msg = get_str_buffer(pos);

    if (ABS(val) < MAX_INT_DEC) {
        snprintf(msg, TEXT_LEN, "%d %s", (int)val, IOTA_UNITS[0]);
    }
    else {
        snprintf(msg, TEXT_LEN, "%d%09d %s", (int)(val / MAX_INT_DEC),
                 (int)(ABS(val) % MAX_INT_DEC), IOTA_UNITS[0]);
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
        THROW(INVALID_STATE);
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
        display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
    else
        display_glyphs(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
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

    display_glyphs_confirm(ui_glyphs.glyph_up, ui_glyphs.glyph_down);
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

/* ----------- BUILDING MENU / TEXT ARRAY ------------- */
void get_init_menu(char *msg)
{
    memset(msg, '\0', MENU_INIT_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "WARNING!");
    strcpy(msg + (i++ * TEXT_LEN), "IOTA is not like");
    strcpy(msg + (i++ * TEXT_LEN), "other cryptos!");
    strcpy(msg + (i++ * TEXT_LEN), "Please visit");
    strcpy(msg + (i++ * TEXT_LEN), "iotasec.info");
    strcpy(msg + (i++ * TEXT_LEN), "for more info.");
}

void get_welcome_menu(char *msg)
{
    memset(msg, '\0', MENU_WELCOME_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "IOTA");
    strcpy(msg + (i++ * TEXT_LEN), "About");
    strcpy(msg + (i++ * TEXT_LEN), "Exit App");
}

void get_about_menu(char *msg)
{
    memset(msg, '\0', MENU_ABOUT_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "Version");
    strcpy(msg + (i++ * TEXT_LEN), "More Info");
    strcpy(msg + (i++ * TEXT_LEN), "Back");
}

void get_more_info_menu(char *msg)
{
    memset(msg, '\0', MENU_MORE_INFO_LEN * TEXT_LEN);

    uint8_t i = 0;

    strcpy(msg + (i++ * TEXT_LEN), "Please visit");
    strcpy(msg + (i++ * TEXT_LEN), "iotasec.info");
    strcpy(msg + (i++ * TEXT_LEN), "for more info.");
}

void get_address_menu(char *msg)
{
    // address is 81 characters long
    memset(msg, '\0', MENU_ADDR_LEN * TEXT_LEN);

    uint8_t i = 0, j = 0, c_cpy = 6;

    // 13 chunks of 6 characters
    for (; i < MENU_ADDR_LEN; i++) {
        strncpy(msg + (i * TEXT_LEN), ui_state.addr + (j++ * 6), c_cpy);
        msg[i * TEXT_LEN + 6] = ' ';

        if (i == MENU_ADDR_LEN - 1)
            c_cpy = 3;

        strncpy(msg + (i * TEXT_LEN) + 7, ui_state.addr + (j++ * 6), c_cpy);
    }
}
