#include "blue_core.h"
#include "blue_screens.h"
#include "blue_types.h"
#include "blue_misc.h"
#include "glyphs.h"
#include "os.h"
#include "ui.h"

#include "iota/addresses.h"

#include "os_io_seproxyhal.h"

UI_STATE_CTX_BLUE blue_ui_state;

void blue_ctx_initialize()
{
    MEMCLEAR(blue_ui_state);
}

// Entry points for main to modify display
void blue_display_main_menu()
{
    UX_DISPLAY(bagl_ui_main, NULL);
    blue_ui_state.state = STATE_MAIN;
    blue_ui_state.menu_idx = 0;
}

void blue_ui_init()
{
    blue_ctx_initialize();

    UX_SET_STATUS_BAR_COLOR(COLOUR_WHITE, COLOUR_GREEN);
    blue_display_main_menu();
}

void blue_display_getting_addr()
{
    UX_DISPLAY(bagl_ui_generating_addr, NULL);
    ui_force_draw();
}

void blue_display_validating()
{
    UX_DISPLAY(bagl_ui_validating, NULL);
    ui_force_draw();
}

void blue_display_recv()
{
    if (blue_ui_state.state != STATE_RECV) {
        blue_ui_state.state = STATE_RECV;
        UX_DISPLAY(bagl_ui_receiving_tx, NULL);
        ui_force_draw();
    }
}

void blue_display_signing()
{
    if (blue_ui_state.state != STATE_SIGN) {
        blue_ui_state.state = STATE_SIGN;
        UX_DISPLAY(bagl_ui_signing_tx, NULL);
        ui_force_draw();
    }
}

// TODO CREATE DISP ADDR
void blue_display_address(const unsigned char *addr_bytes)
{
    get_address_with_checksum(addr_bytes, blue_ui_state.addr);

    ui_force_draw();
}

void blue_sign_tx()
{
    write_bip_path();
    update_tx_info();

    UX_DISPLAY(bagl_ui_transaction_first, NULL);

    blue_ui_state.state = STATE_TX;
    blue_ui_state.menu_idx = 0;
}

void blue_ui_reset()
{
    blue_display_main_menu();
    ui_force_draw();
}

void blue_ui_restore()
{
    switch (blue_ui_state.state) {
    // if they were in settings, take them there
    // everything else go to main menu
    case STATE_SETTINGS:
        UX_DISPLAY(bagl_ui_settings, NULL);
        break;
    default:
        blue_display_main_menu();
        break;
    }
    ui_force_draw();
}

bool blue_ui_lock_forbidden()
{
    if (blue_ui_state.state == STATE_TX)
        return true;
    else
        return false;
}
