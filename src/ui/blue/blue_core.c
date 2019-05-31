#include <stddef.h>
#include "iota/addresses.h"
#include "macros.h"
#include "os_io_seproxyhal.h"
#include "ui/blue/blue_buttons.h"
#include "ui/blue/blue_elements.h"
#include "ui/blue/blue_misc.h"
#include "ui/blue/blue_screens.h"
#include "ui/blue/blue_types.h"
#include "ui/ui.h"

#ifdef TARGET_BLUE

UI_STATE_CTX_BLUE blue_ui_state;

static void blue_ctx_initialize()
{
    MEMCLEAR(blue_ui_state);
}

void ui_init()
{
    blue_ctx_initialize();

    UX_SET_STATUS_BAR_COLOR(COLOUR_WHITE, COLOUR_GREEN);
    ui_display_main_menu();
}

// Entry points for main to modify display
void ui_display_main_menu()
{
    UX_DISPLAY(bagl_ui_main, NULL);
    blue_ui_state.state = STATE_MAIN;
    blue_ui_state.menu_idx = 0;
}

void ui_display_getting_addr()
{
    UX_DISPLAY(bagl_ui_generating_addr, NULL);
    ui_force_draw();
}

void ui_display_validating()
{
    UX_DISPLAY(bagl_ui_validating, NULL);
    ui_force_draw();
}

void ui_display_recv()
{
    if (blue_ui_state.state != STATE_RECV) {
        blue_ui_state.state = STATE_RECV;
        UX_DISPLAY(bagl_ui_receiving_tx, NULL);
        ui_force_draw();
    }
}

void ui_display_signing()
{
    if (blue_ui_state.state != STATE_SIGN) {
        blue_ui_state.state = STATE_SIGN;
        UX_DISPLAY(bagl_ui_signing_tx, NULL);
        ui_force_draw();
    }
}

void ui_display_address(const unsigned char *addr_bytes)
{
    get_address_with_checksum(addr_bytes, blue_ui_state.addr);
    break_address();
    UX_DISPLAY(bagl_ui_disp_addr, NULL);
    ui_force_draw();
}

void ui_sign_tx()
{
    write_bip_path();
    update_tx_info();

    UX_DISPLAY(bagl_ui_transaction_first, NULL);

    blue_ui_state.state = STATE_TX;
    blue_ui_state.menu_idx = 0;
}

void ui_reset()
{
    ui_display_main_menu();
    ui_force_draw();
}

void ui_restore()
{
    // ui gets reset on seed_seed (if seed has changed)
    switch (blue_ui_state.state) {
    // if they were in settings, take them there
    // everything else go to main menu
    case STATE_SETTINGS:
        UX_DISPLAY(bagl_ui_settings, NULL);
        break;
    default:
        ui_display_main_menu();
        break;
    }
    ui_force_draw();
}

#endif // TARGET_BLUE
