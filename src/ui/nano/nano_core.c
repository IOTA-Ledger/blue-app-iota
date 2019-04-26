#include "iota/addresses.h"
#include "glyphs.h"
#include "ui.h"
#include "nano_misc.h"
#include "nano_display.h"
#include "nano_buttons.h"
#include "nano_types.h"

#if defined(TARGET_NANOS) || defined(TARGET_NANOX)
#define TARGET_NANO
#endif

#ifdef TARGET_NANO
#include "nano_screens.h"

#ifdef TARGET_NANOS
#include "s_elements.h"
#else // NANOX
#include "x_elements.h"
#endif

static void nano_transition_state(unsigned int button_mask);
static void nano_build_display();

UI_TEXT_CTX_NANO ui_text;
UI_STATE_CTX_NANO ui_state;

const bagl_element_t *ux_element_preprocessor(const bagl_element_t *element)
{
    if (!CHECK_BIT(element->component.userid) &&
        element->component.userid != EL_CLEAR)
        return NULL;
    else
        return element;
}

// macros for button function
BUTTON_FUNCTION(omega)

void nano_set_screen(UI_SCREENS_NANO s)
{
    ui_state.glyphs = 0;

    switch (s) {
#ifdef TARGET_NANOS
    case SCREEN_TITLE:
        FLAG_ON(EL_TITLE);
        break;
    case SCREEN_TITLE_BOLD:
        FLAG_ON(EL_TITLE_BOLD);
        break;
    case SCREEN_MENU:
    case SCREEN_IOTA:
    case SCREEN_BACK:
        FLAG_ON(EL_MENU);
        break;
#else // NANOX
    case SCREEN_TITLE:
        FLAG_ON(EL_TITLE);
        break;
    case SCREEN_BIP:
        FLAG_ON(EL_BIP);
        break;
    case SCREEN_ADDR:
        FLAG_ON(EL_ADDR);
        break;
    case SCREEN_ICON:
        FLAG_ON(EL_ICON);
        break;
    case SCREEN_ICON_MULTI:
        FLAG_ON(EL_ICON_MULTI);
        break;
#endif
    default:
        return;
    }
}

static void nano_render()
{
    UX_DISPLAY(bagl_ui_omega_screen, ux_element_preprocessor);
}

static void nano_ctx_initialize()
{
    MEMCLEAR(ui_text);
    MEMCLEAR(ui_state);
}

void ui_init()
{
    nano_ctx_initialize();
    ui_timeout_stop();

    ui_display_main_menu();
}

// Entry points for main to modify display
void ui_display_main_menu()
{
    clear_display();
    state_go(STATE_MAIN_MENU, 0);
    backup_state();

    nano_build_display();
    nano_render();
}

void ui_display_getting_addr()
{
    clear_display();

#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_TITLE_BOLD);
    write_display("    Generating", TOP);
    write_display("     Address...", BOT);
#else
    nano_set_screen(SCREEN_ICON_MULTI);
    write_display("Generating", TOP);
    write_display("Address...", BOT);
#endif

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;

    nano_render();
    ui_force_draw();
}

void ui_display_validating()
{
    clear_display();

#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_MENU);
    write_display("    Validating...", MID);
#else
    write_display("Validating...", MID);
#endif

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;

    nano_render();
    ui_force_draw();
}

void ui_display_recv()
{
    clear_display();

#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_TITLE_BOLD);
    write_display("    Receiving", TOP);
    write_display("      Transaction...", BOT);
#else
    nano_set_screen(SCREEN_ICON_MULTI);
    write_display("Receiving", TOP);
    write_display("Transaction...", BOT);
#endif

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;

    nano_render();
    ui_force_draw();
}

void ui_display_signing()
{
    clear_display();

#ifdef TARGET_NANOS
    nano_set_screen(SCREEN_TITLE_BOLD);
    write_display("    Signing", TOP);
    write_display("      Transaction...", BOT);
#else
    nano_set_screen(SCREEN_ICON_MULTI);
    write_display("Signing", TOP);
    write_display("Transaction...", BOT);
#endif

    display_glyphs(GLYPH_LOAD, GLYPH_NONE);

    backup_state();

    ui_state.state = STATE_IGNORE;

    nano_render();
    ui_force_draw();
}

void ui_display_address(const unsigned char *addr_bytes)
{
    get_address_with_checksum(addr_bytes, ui_state.addr);
    state_go(STATE_DISP_ADDR_CHK, 0);

    nano_build_display();
    nano_render();
    ui_force_draw();
}

void ui_sign_tx()
{
    state_go(STATE_PROMPT_TX, 0);

    nano_build_display();
    nano_render();
}

void ui_reset()
{
    state_go(STATE_MAIN_MENU, 0);

    nano_build_display();
    nano_render();
    ui_force_draw();
}

void ui_restore()
{
    restore_state();

    nano_build_display();
    nano_render();
    ui_force_draw();
}

bool ui_lock_forbidden(void)
{
    // forbid app from locking during transaction (rely on tx timeout)
    switch (ui_state.state) {
        // BIP Path could be in tx or disp_addr
        // (backup state will tell us which)
    case STATE_BIP_PATH:
        if (ui_state.backup_state != STATE_PROMPT_TX)
            return false;
    case STATE_PROMPT_TX:
    case STATE_TX_ADDR:
        return true;
    default:
        return false;
    }
}

/* -------------------- SCREEN BUTTON FUNCTIONS ---------------
 ---------------------------------------------------------------
 --------------------------------------------------------------- */
static uint8_t nano_translate_mask(unsigned int button_mask)
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

static void nano_handle_button(uint8_t button_mask)
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
#ifdef TARGET_NANOS
        /* ------------ STATE VERSION -------------- */
    case STATE_VERSION:
        button_version(button_mask);
        return;
        /* ------------ STATE MORE INFO -------------- */
    case STATE_MORE_INFO:
        array_sz = button_more_info(button_mask);
        break;
#endif
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
static void nano_build_display()
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
#ifdef TARGET_NANOS
        /* ------------ VERSION -------------- */
    case STATE_VERSION:
        display_version();
        break;
        /* ------------ MORE INFO -------------- */
    case STATE_MORE_INFO:
        display_more_info();
        break;
#endif
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
static void nano_transition_state(unsigned int button_mask)
{
    uint8_t translated_mask = nano_translate_mask(button_mask);

    // make sure we only transition on valid button presses
    if (translated_mask == BUTTON_BAD)
        return;

    nano_handle_button(translated_mask);

    nano_build_display();

    if (ui_state.state == STATE_EXIT)
        // Go back to the dashboard
        os_sched_exit(0);

    // render new display
    nano_render();
}

#endif // TARGET_NANO
