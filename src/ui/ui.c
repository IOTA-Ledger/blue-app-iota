#include "ui.h"
#include <string.h>
#include "os_io_seproxyhal.h"
#include "ui_types.h"
#include "ui_misc.h"
#include "ui_buttons.h"
#include "ui_display.h"
#include "ui_elements.h"
#include "api.h"
#include "glyphs.h"
#include "iota/addresses.h"

UI_TEXT_CTX ui_text;
UI_GLYPH_CTX ui_glyphs;
UI_STATE_CTX ui_state;

UI_SCREENS current_screen;

// ----------- local function prototypes
static void ui_transition_state(unsigned int button_mask);
static void ui_build_display(void);

static unsigned int bagl_ui_title_screen_button(unsigned int, unsigned int);
static unsigned int bagl_ui_menu_screen_button(unsigned int, unsigned int);
static unsigned int bagl_ui_iota_screen_button(unsigned int, unsigned int);
static unsigned int bagl_ui_back_screen_button(unsigned int, unsigned int);
static unsigned int bagl_ui_title_bold_screen_button(unsigned int,
                                                     unsigned int);

// *************************
// Ledger Nano S specific UI
// *************************
// one dynamic screen that changes based on the ui state

// screen for title on top, info on bottom
static const bagl_element_t bagl_ui_title_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP, SCREEN_MSG_BOT, SCREEN_GLYPHS_ALL};

// screen for title on top info on bottom BOLD
static const bagl_element_t bagl_ui_title_bold_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_BOLD, SCREEN_MSG_BOT_BOLD, SCREEN_GLYPHS_ALL};

// screen for info in the middle, and half text elements above and below (menu
// effect)
static const bagl_element_t bagl_ui_menu_screen[] = {
    SCREEN_CLEAR, SCREEN_MSG_TOP_HALF, SCREEN_MSG_MID, SCREEN_MSG_BOT_HALF,
    SCREEN_GLYPHS_ALL};

// screen for displaying IOTA icon
static const bagl_element_t bagl_ui_iota_screen[] = {
    SCREEN_CLEAR,         SCREEN_MSG_MID,    SCREEN_UNDERLINE,
    SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_IOTA, SCREEN_GLYPH_DOWN};

// screen for displaying back icon
static const bagl_element_t bagl_ui_back_screen[] = {
    SCREEN_CLEAR,      SCREEN_MSG_TOP_HALF,  SCREEN_MSG_MID,
    SCREEN_GLYPH_BACK, SCREEN_GLYPH_CONFIRM, SCREEN_GLYPH_UP};

/* ------------------- DISPLAY UI FUNCTIONS -------------
 ---------------------------------------------------------
 --------------------------------------------------------- */
void ui_set_screen(UI_SCREENS s)
{
    current_screen = s;
}

void ui_render()
{
    switch (current_screen) {
    case SCREEN_TITLE:
        UX_DISPLAY(bagl_ui_title_screen, NULL);
        break;
    case SCREEN_TITLE_BOLD:
        UX_DISPLAY(bagl_ui_title_bold_screen, NULL);
        break;
    case SCREEN_MENU:
        UX_DISPLAY(bagl_ui_menu_screen, NULL);
        break;
    case SCREEN_IOTA:
        UX_DISPLAY(bagl_ui_iota_screen, NULL);
        break;
    case SCREEN_BACK:
        UX_DISPLAY(bagl_ui_back_screen, NULL);
        break;
    default:
        os_sched_exit(0);
    }
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
}

// Entry points for main to modify display
void ui_display_main_menu()
{
    state_go(STATE_MAIN_MENU, 0);
    backup_state();

    ui_build_display();
    ui_render();
}

void ui_init()
{
    ctx_initialize();

    ui_glyphs.glyph[TOTAL_GLYPHS] = '\0';

    ui_display_main_menu();
}

void ui_display_getting_addr()
{
    ui_set_screen(SCREEN_TITLE_BOLD);
    clear_display();

    write_display("    Generating", TOP);
    write_display("     Address...", BOT);

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;

    ui_render();
    ui_force_draw();
}

void ui_display_validating()
{
    ui_set_screen(SCREEN_MENU);
    clear_display();

    write_display("    Validating...", MID);

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;
    ui_state.ui_timer = 0;

    ui_render();
    ui_force_draw();
}

void ui_display_recv()
{
    ui_set_screen(SCREEN_TITLE_BOLD);
    clear_display();

    write_display("    Receiving", TOP);
    write_display("      Transaction...", BOT);

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;
    ui_state.ui_timer = 0;

    ui_render();
    ui_force_draw();
}

void ui_display_signing()
{
    ui_set_screen(SCREEN_TITLE_BOLD);
    clear_display();

    write_display("    Signing", TOP);
    write_display("      Transaction...", BOT);

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;
    ui_state.ui_timer = 0;

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

static void ui_display_timeout()
{
    state_go(STATE_UI_TIMEOUT, 0);

    ui_build_display();
    ui_render();
    ui_force_draw();
}

void ui_reset()
{
    ui_state.queued_ui_reset = false;

    state_go(STATE_MAIN_MENU, 0);

    ui_build_display();
    ui_render();
    ui_force_draw();
}

void ui_restore()
{
    restore_state();

    ui_build_display();
    ui_render();
    ui_force_draw();
}

void ui_queue_reset(bool islocked)
{
    // use a timer on state_ignore to reset if something goes wrong
    if (ui_state.state == STATE_IGNORE) {
        ui_state.ui_timer++;
        if (ui_state.ui_timer > STATE_IGNORE_TIMEOUT * 10) {
            ui_display_timeout();
        }
    }
    else {
        ui_state.ui_timer = 0;
    }

    if (islocked && in_tx_state()) {
        ui_state.queued_ui_reset = true;
    }
    else if (!islocked && ui_state.queued_ui_reset) {
        ui_state.queued_ui_reset = false;

        state_go(STATE_TX_CANCELLED, 0);

        ui_build_display();
        ui_render();
        ui_force_draw();
    }
}

/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
 ---------------------------------------------------------------
 --------------------------------------------------------------- */
// macros for button functions
BUTTON_FUNCTION(title)
BUTTON_FUNCTION(title_bold)
BUTTON_FUNCTION(menu)
BUTTON_FUNCTION(iota)
BUTTON_FUNCTION(back)

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
    int8_t array_sz;

    switch (ui_state.state) {
        /* ------------ STATE MAIN MENU -------------- */
    case STATE_MAIN_MENU:
        array_sz = button_main_menu(button_mask);
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
        array_sz = button_bip_path(button_mask);
        break;
        /* ------------ STATE DISPLAY_ADDRESS -------------- */
    case STATE_DISP_ADDR:
        array_sz = button_disp_addr(button_mask);
        break;
        /* ------------ STATE DISPLAY CHECKSUM -------------- */
    case STATE_DISP_ADDR_CHK:
        button_disp_addr_chk(button_mask);
        return;
        /* ------------ STATE MENU_TX_ADDRESS -------------- */
    case STATE_TX_ADDR:
        array_sz = button_tx_addr(button_mask);
        break;
        /* ------------ PROMPT TX INFO *DYNAMIC-MENU* -------------- */
    case STATE_PROMPT_TX:
        button_prompt_tx(button_mask);
        return;
        /* ------------ STATE TX CANCELLED -------------- */
    case STATE_TX_CANCELLED:
        button_tx_cancelled(button_mask);
        return;
    /* ------------ STATE UI TIMEOUT -------------- */
    case STATE_UI_TIMEOUT:
        button_ui_timeout(button_mask);
        return;
    case STATE_IGNORE:
        return;
        /* ------------ DEFAULT -------------- */
    default: // this would be an unkown state/error
        ui_state.menu_idx = 0;
        return;
    }

    // incr/decr menu index
    if (array_sz >= 0)
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
        /* ------------ MAIN MENU -------------- */
    case STATE_MAIN_MENU:
        display_main_menu();
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
        /* ------------ STATE TX CANCELLED -------------- */
    case STATE_TX_CANCELLED:
        display_tx_cancelled();
        break;
    /* ------------ STATE UI TIMEOUT -------------- */
    case STATE_UI_TIMEOUT:
        display_ui_timeout();
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
