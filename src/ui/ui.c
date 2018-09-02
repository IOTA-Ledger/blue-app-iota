#include "ui.h"
#include <string.h>
#include "os_io_seproxyhal.h"

#include "ui_types.h"
#include "ui_misc.h"
#include "ui_buttons.h"
#include "ui_display.h"

#include "iota/addresses.h"

UI_TEXT_CTX ui_text;
UI_GLYPH_CTX ui_glyphs;
UI_STATE_CTX ui_state;

// ----------- local function prototypes
static void ui_transition_state(unsigned int button_mask);
static void ui_build_display(void);

static unsigned int bagl_ui_nanos_screen_button(unsigned int, unsigned int);

// *************************
// Ledger Nano S specific UI
// *************************
// one dynamic screen that changes based on the ui state

// clang-format off
static const bagl_element_t bagl_ui_nanos_screen[] = {
    // {type, userid, x, y, width, height, stroke, radius, fill,
    // fgcolor, bgcolor, fontid, iconid}, text .....
    {{BAGL_RECTANGLE, 0x00, 0, 0, 128, 32, 0, 0, BAGL_FILL, 0x000000, 0xFFFFFF,
        0, 0}, NULL, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 3, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.half_top, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 13, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.top_str, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 19, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_EXTRABOLD_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.mid_str, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 25, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.bot_str, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_LABELINE, 0x01, 0, 36, 128, 32, 0, 0, 0, 0xFFFFFF, 0x000000,
        BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        ui_text.half_bot, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 3, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, ui_glyphs.glyph_bar_l, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 117, -3, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LESS}, ui_glyphs.glyph_bar_r, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
        BAGL_GLYPH_ICON_CROSS}, ui_glyphs.glyph_cross, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_CHECK}, ui_glyphs.glyph_check, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0x000000, 0x000000, 0,
        BAGL_GLYPH_ICON_UP}, ui_glyphs.glyph_up, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_DOWN}, ui_glyphs.glyph_down, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_WARNING_BADGE}, ui_glyphs.glyph_warn, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 9, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_LOADING_BADGE}, ui_glyphs.glyph_load, 0, 0, 0, NULL, NULL, NULL},

    {{BAGL_ICON, 0x00, 24, 12, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
        BAGL_GLYPH_ICON_DASHBOARD_BADGE}, ui_glyphs.glyph_dash, 0, 0, 0, NULL, NULL, NULL}};
// clang-format on

/* ------------------- DISPLAY UI FUNCTIONS -------------
 ---------------------------------------------------------
 --------------------------------------------------------- */
void ui_render()
{
    UX_DISPLAY(bagl_ui_nanos_screen, NULL);
}

void ui_force_draw()
{
    bool ux_done = false;
    while (!ux_done) {
        io_seproxyhal_general_status();
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,
                               sizeof(G_io_seproxyhal_spi_buffer), 0);

        // manually handle events
        switch (G_io_seproxyhal_spi_buffer[0]) {
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            if (UX_DISPLAYED()) {
                ux_done = true;
                break;
            }
            else {
                UX_DISPLAYED_EVENT();
            }
            break;
        default:
            // ignore any other event
            break;
        }
    }

    // now everything is in the buffer, the next general status renders it
    io_seproxyhal_general_status();
    io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer,
                           sizeof(G_io_seproxyhal_spi_buffer), 0);
}

static void ctx_initialize()
{
    os_memset(&ui_text, 0, sizeof(ui_text));
    os_memset(&ui_glyphs, 0, sizeof(ui_glyphs));
    os_memset(&ui_state, 0, sizeof(ui_state));

    ui_state.menu_idx = 0;
    ui_state.backup_menu_idx = 0;
    ui_state.display_full_value = false;
}

void ui_init(bool flash_is_init)
{
    ctx_initialize();

    if (flash_is_init) {
        ui_state.state = STATE_WELCOME;
        ui_state.backup_state = STATE_WELCOME;
    }
    else {
        ui_state.state = STATE_INIT;
        ui_state.backup_state = STATE_INIT;
    }

    ui_build_display();
    ui_render();
}

// Entry points for main to modify display
void ui_display_welcome()
{
    state_go(STATE_WELCOME, 0);
    backup_state();

    ui_build_display();
    ui_render();
}

void ui_display_getting_addr()
{
    clear_display();
    write_display("Getting Addr...", TYPE_STR, MID);

    display_glyphs(ui_glyphs.glyph_load, NULL);

    backup_state();

    ui_state.state = STATE_IGNORE;

    ui_render();
    ui_force_draw();
}

void ui_display_validating()
{
    clear_display();
    write_display("Validating...", TYPE_STR, MID);

    display_glyphs(ui_glyphs.glyph_load, NULL);

    backup_state();

    ui_state.state = STATE_IGNORE;

    ui_render();
    ui_force_draw();
}

void ui_display_recv()
{
    clear_display();
    write_display("Receiving TX...", TYPE_STR, MID);

    display_glyphs(ui_glyphs.glyph_load, NULL);

    backup_state();

    ui_state.state = STATE_IGNORE;

    ui_render();
    ui_force_draw();
}

void ui_display_signing()
{
    clear_display();
    write_display("Signing TX...", TYPE_STR, MID);

    display_glyphs(ui_glyphs.glyph_load, NULL);

    backup_state();

    ui_state.state = STATE_IGNORE;

    ui_render();
    ui_force_draw();
}

void ui_display_address(const unsigned char *addr_bytes)
{
    get_address_with_checksum(addr_bytes, ui_state.addr);
    state_go(STATE_DISP_ADDR_CHK, 0);

    ui_build_display();
    ui_render();
    ui_force_draw();
}

void ui_sign_tx()
{
    state_go(STATE_PROMPT_TX, 0);

    ui_build_display();
    ui_render();
}

void ui_reset()
{
    state_go(STATE_WELCOME, 0);

    ui_build_display();
    ui_render();
    ui_force_draw();
}

// external function for main to restore previous state
// ui_reset generally used instead though
void ui_restore()
{
    restore_state();

    ui_build_display();
    ui_render();
    ui_force_draw();
}


/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
 ---------------------------------------------------------------
 --------------------------------------------------------------- */
static unsigned int
bagl_ui_nanos_screen_button(unsigned int button_mask,
                            unsigned int button_mask_counter)
{
    ui_transition_state(button_mask);

    return 0;
}

static uint8_t ui_translate_mask(unsigned int button_mask)
{
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        return BUTTON_L;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        return BUTTON_R;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT | BUTTON_LEFT:
        return BUTTON_B;
    default:
        return BUTTON_BAD;
    }
}

/* ----------------------------------------------------
 ------------------------------------------------------
            Special button actions
 ------------------------------------------------------
 --------------------------------------------------- */
static void ui_handle_button(uint8_t button_mask)
{
    uint8_t array_sz;

    switch (ui_state.state) {
        /* ------------ STATE INIT -------------- */
    case STATE_INIT:
        array_sz = button_init(button_mask);
        break;
        /* ------------ STATE OPTIONS -------------- */
    case STATE_WELCOME:
        array_sz = button_welcome(button_mask);
        break;
        /* ------------ STATE ABOUT -------------- */
    case STATE_ABOUT:
        array_sz = button_about(button_mask);
        break;
        /* ------------ STATE VERSION -------------- */
    case STATE_VERSION:
        button_version(button_mask);
        return;
        /* ------------ STATE MORE INFO -------------- */
    case STATE_MORE_INFO:
        array_sz = button_more_info(button_mask);
        break;
        /* ------------ STATE BIP PATH -------------- */
    case STATE_BIP_PATH:
        button_bip_path(button_mask);
        return;
        /* ------------ STATE DISPLAY_ADDRESS -------------- */
    case STATE_DISP_ADDR:
        array_sz = button_disp_addr(button_mask);
        break;
        /* ------------ STATE DISPLAY CHECKSUM -------------- */
    case STATE_DISP_ADDR_CHK:
        array_sz = button_disp_addr_chk(button_mask);
        break;
        /* ------------ STATE MENU_TX_ADDRESS -------------- */
    case STATE_TX_ADDR:
        array_sz = button_tx_addr(button_mask);
        break;
        /* ------------ PROMPT TX INFO *DYNAMIC-MENU* -------------- */
    case STATE_PROMPT_TX:
        button_prompt_tx(button_mask);
        return;
    case STATE_IGNORE:
        return;
        /* ------------ DEFAULT -------------- */
    default: // fall through and return
        ui_state.menu_idx = 0;
        return;
    }

    button_handle_menu_idx(button_mask, array_sz);
}

/* ----------------------------------------------------
 ------------------------------------------------------
         Default display options per state
 ------------------------------------------------------
 --------------------------------------------------- */
static void ui_build_display()
{
    switch (ui_state.state) {
        /* ------------ INIT MENU -------------- */
    case STATE_INIT:
        display_init();
        break;
        /* ------------ WELCOME MENU -------------- */
    case STATE_WELCOME:
        display_welcome();
        break;
        /* ------------ ABOUT -------------- */
    case STATE_ABOUT:
        display_about();
        break;
        /* ------------ VERSION -------------- */
    case STATE_VERSION:
        display_version();
        break;
        /* ------------ MORE INFO -------------- */
    case STATE_MORE_INFO:
        display_more_info();
        break;
        /* ------------ BIP PATH ------------ */
    case STATE_BIP_PATH:
        display_bip_path();
        break;
        /* ------------ DISPLAY TX ADDRESS -------------- */
    case STATE_TX_ADDR:
        display_tx_addr();
        break;
        /* ------------ DISPLAY ADDRESS MENU -------------- */
    case STATE_DISP_ADDR:
        display_addr();
        break;
        /* ------------ DISPLAY ADDRESS CHECKSUM -------------- */
    case STATE_DISP_ADDR_CHK:
        display_addr_chk();
        break;
        /* ------------ PROMPT TX *DNYMANIC-MENU -------------- */
    case STATE_PROMPT_TX:
        display_prompt_tx();
        break;
        /* ------------ IGNORE STATE -------------- */
    case STATE_IGNORE:
        return;
        /* ------------ UNKNOWN STATE -------------- */
    default:
        display_unknown_state();
        break;
    }
}

/* ----------------------------------------------------
 ------------------------------------------------------
            ------- MAIN BUTTON LOGIC -------
        Every button press calls transition_state
 ------------------------------------------------------
 --------------------------------------------------- */
static void ui_transition_state(unsigned int button_mask)
{
    uint8_t translated_mask = ui_translate_mask(button_mask);

    // make sure we only transition on valid button presses
    if (translated_mask == BUTTON_BAD)
        return;

    ui_handle_button(translated_mask);

    ui_build_display();

    if (ui_state.state == STATE_EXIT)
        // Go back to the dashboard
        os_sched_exit(0);

    // render new display
    ui_render();
}
